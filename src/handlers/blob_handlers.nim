import presto
import ../types/blobs/[v1, v2, v3, v4]
import decode_ssz
import request_log

proc handleGetBlobsV1*(contentBody: Option[ContentBody]): RestApiResponse =
  let request = decodeSszBody(contentBody, BlobsV1Request).valueOr:
    return error
  recordRequest(request)

  var blobs: BlobsV1Response
  for _ in 0 ..< request.versioned_hashes.len:
    discard blobs.entries.add(default(BlobV1Entry))
  encodeSszResponse(blobs)

proc handleGetBlobsV2*(contentBody: Option[ContentBody]): RestApiResponse =
  let request = decodeSszBody(contentBody, BlobsV2Request).valueOr:
    return error
  recordRequest(request)

  if request.versioned_hashes.len > 0:
    return noContentResponse()

  var blobs: BlobsV2Response
  encodeSszResponse(blobs)

proc handleGetBlobsV3*(contentBody: Option[ContentBody]): RestApiResponse =
  # /blobs/v3 reuses the /blobs/v2 request shape and BlobV2Entry.
  let request = decodeSszBody(contentBody, BlobsV2Request).valueOr:
    return error
  recordRequest(request)

  var blobs: BlobsV3Response
  for _ in 0 ..< request.versioned_hashes.len:
    discard blobs.entries.add(default(BlobV2Entry))
  encodeSszResponse(blobs)

proc handleGetBlobsV4*(contentBody: Option[ContentBody]): RestApiResponse =
  let request = decodeSszBody(contentBody, BlobsV4Request).valueOr:
    return error
  recordRequest(request)

  var blobs: BlobsV4Response
  for _ in 0 ..< request.versioned_hashes.len:
    discard blobs.entries.add(default(BlobV4Entry))
  encodeSszResponse(blobs)
