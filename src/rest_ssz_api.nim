import 
  engine_server, blob_api, diagnostic_api, fork_api

import 
  chronos, presto

proc installApiHandlers(restServer: RestServerRef) =
  restServer.router.installForkApihandlers()
  restServer.router.installBlobApihandlers()
  restServer.router.installDiagnosticApiHandlers()

when isMainModule:

  type ServerConfig = object
    restRequestTimeout: int
    restMaxRequestHeadersSize: int
    restMaxRequestBodySize: int

  let config = ServerConfig(
    restRequestTimeout: 0,
    restMaxRequestHeadersSize: 64,
    restMaxRequestBodySize: 1024
  )

  proc validate(pattern: string, value: string): int {.gcsafe, raises: [].} = 0

  let server = RestServerRef.init(
    ip = initTAddress("127.0.0.1:0").address,
    port = Port(9000),
    allowedOrigin = none(string),
    validateFn = validate,
    ident = "rest_ssz_api",
    config = config
  )

  doAssert not isNil(server), "REST server failed to start"

  server.installApiHandlers()

  server.start()
  runForever()