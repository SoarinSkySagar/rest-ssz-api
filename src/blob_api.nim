import presto

proc installBlobApihandlers*(router: var RestRouter) =

  # replaces `engine_getBlobsV1` 
  router.api2(MethodPost, "/engine/v2/blobs/v1") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    RestApiResponse.response("getBlobsV1: ok", Http200, "text/plain")

  # replaces `engine_getBlobsV2`
  router.api2(MethodPost, "/engine/v2/blobs/v2") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    RestApiResponse.response("getBlobsV2: ok", Http200, "text/plain")

  # replaces `engine_getBlobsV3` 
  router.api2(MethodPost, "/engine/v2/blobs/v3") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    RestApiResponse.response("getBlobsV3: ok", Http200, "text/plain")

  # replaces `engine_getBlobsV4` 
  router.api2(MethodPost, "/engine/v2/blobs/v4") do (
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    RestApiResponse.response("getBlobsV4: ok", Http200, "text/plain")