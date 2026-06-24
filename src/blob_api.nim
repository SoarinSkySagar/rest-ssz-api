import presto
import handlers/blob_handlers

proc installBlobApihandlers*(router: var RestRouter) =

  # replaces `engine_getBlobsV1`
  router.api2(MethodPost, "/engine/v2/blobs/v1") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    handleGetBlobsV1(contentBody)

  # replaces `engine_getBlobsV2`
  router.api2(MethodPost, "/engine/v2/blobs/v2") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    handleGetBlobsV2(contentBody)

  # replaces `engine_getBlobsV3`
  router.api2(MethodPost, "/engine/v2/blobs/v3") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    handleGetBlobsV3(contentBody)

  # replaces `engine_getBlobsV4`
  router.api2(MethodPost, "/engine/v2/blobs/v4") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    handleGetBlobsV4(contentBody)
