import presto

proc installDiagnosticApiHandlers*(router: var RestRouter) =

  # replaces `engine_exchangeCapabilities`
  router.api2(MethodGet, "/engine/v2/capabilities") do () -> RestApiResponse:
    RestApiResponse.response("capabilities: ok", Http200, "text/plain")

  # replaces `engine_getClientVersion`
  router.api2(MethodGet, "/engine/v2/identity") do () -> RestApiResponse:
    RestApiResponse.response("identity: ok", Http200, "text/plain")
