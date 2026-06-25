import presto
import ssz_serialization
import ../types/primitives
import errors

export results
export ssz_serialization
export errors

const
  OctetStreamMediaType* = MediaType.init("application/octet-stream")

proc decodeSszBody*(contentBody: Option[ContentBody],
                    T: typedesc,
                    maxBodyBytes: int = MAX_REQUEST_BODY_SIZE): Result[T, RestApiResponse] =
  if contentBody.isNone():
    return err(invalidRequestResponse("missing request body"))

  let body = contentBody.get()
  if body.contentType != OctetStreamMediaType:
    return err(unsupportedMediaTypeResponse())
  if body.data.len > maxBodyBytes:
    return err(requestTooLargeResponse())

  var value: T
  try:
    readSszBytes(body.data, value)
  except SszError:
    return err(sszDecodeErrorResponse())

  ok(value)

proc encodeSszResponse*[T](value: T,
                           headers: openArray[RestKeyValueTuple] = []): RestApiResponse =
  ## SSZ-encodes `value` into an `application/octet-stream` `200 OK` response.
  RestApiResponse.response(
    SSZ.encode(value), Http200, $OctetStreamMediaType, headers)
