import presto
import handlers/diagnostic_handlers

proc installDiagnosticApiHandlers*(router: var RestRouter) =

  # replaces `engine_exchangeCapabilities`
  router.api2(MethodGet, "/engine/v2/capabilities") do () -> RestApiResponse:
    handleCapabilities()

  # replaces `engine_getClientVersion`
  router.api2(MethodGet, "/engine/v2/identity") do () -> RestApiResponse:
    handleIdentity()
