import presto
import ssz_serialization

export results
export ssz_serialization

const
  OctetStreamMediaType* = MediaType.init("application/octet-stream")

proc decodeSszBody*(contentBody: Option[ContentBody],
                    T: typedesc): Result[T, string] =
  if contentBody.isNone():
    return err("missing request body")

  let body = contentBody.get()
  if body.contentType != OctetStreamMediaType:
    return err("unsupported content type, expected application/octet-stream")

  var value: T
  try:
    readSszBytes(body.data, value)
  except SszError as exc:
    return err(exc.msg)

  ok(value)
