import presto

func decodeString(t: typedesc[string], value: string): Result[string, cstring] =
  ok(value)

proc installForkApihandlers*(router: var RestRouter) =

  # replaces `engine_newPayload`
  router.api2(MethodPost, "/engine/v2/{fork}/payloads") do (
                    fork: string,
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    RestApiResponse.response("newPayload: ok", Http200, "text/plain")

  # replaces `engine_getPayload`
  router.api2(MethodGet, "/engine/v2/{fork}/payloads/{payloadId}") do (
                    fork: string,
                    payloadId: string) -> RestApiResponse:
    RestApiResponse.response("getPayload: ok", Http200, "text/plain")

  # replaces `engine_forkchoiceUpdated`
  router.api2(MethodPost, "/engine/v2/{fork}/forkchoice") do (
                    fork: string,
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    RestApiResponse.response("forkchoiceUpdated: ok", Http200, "text/plain")

  # replaces `engine_getPayloadBodiesByHash`
  router.api2(MethodPost, "/engine/v2/{fork}/bodies/hash") do (
                    fork: string,
                    contentBody: Option[ContentBody]) -> RestApiResponse:
    RestApiResponse.response("getPayloadBodiesByHash: ok", Http200, "text/plain")

  # replaces `engine_getPayloadBodiesByRange`
  router.api2(MethodGet, "/engine/v2/{fork}/bodies") do (
                    fork: string,
                    `from`: Option[string],
                    count: Option[string]) -> RestApiResponse:
    RestApiResponse.response("getPayloadBodiesByRange: ok", Http200, "text/plain")
