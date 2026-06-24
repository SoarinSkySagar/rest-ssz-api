import presto


proc handleGetBlobsV1*(contentBody: Option[ContentBody]): RestApiResponse =
  RestApiResponse.response("getBlobsV1: ok", Http200, "text/plain")

proc handleGetBlobsV2*(contentBody: Option[ContentBody]): RestApiResponse =
  RestApiResponse.response("getBlobsV2: ok", Http200, "text/plain")

proc handleGetBlobsV3*(contentBody: Option[ContentBody]): RestApiResponse =
  RestApiResponse.response("getBlobsV3: ok", Http200, "text/plain")

proc handleGetBlobsV4*(contentBody: Option[ContentBody]): RestApiResponse =
  RestApiResponse.response("getBlobsV4: ok", Http200, "text/plain")
