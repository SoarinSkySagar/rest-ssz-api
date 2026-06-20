import chronos
import presto

proc init*(
  T: type RestServerRef,
  ip: IpAddress,
  port: Port,
  allowedOrigin: Option[string],
  validateFn: PatternCallback,
  ident: string,
  config: auto
): T = 
  let
    address = initTAddress(ip, port)
    serverFlags = {HttpServerFlags.QueryCommaSeparatedArray, HttpServerFlags.NotifyDisconnect}

  let
    headersTimeout =
      if config.restRequestTimeout == 0:
        chronos.InfiniteDuration
      else:
        seconds(int64(config.restRequestTimeout))
    maxHeadersSize = config.restMaxRequestHeadersSize * 1024
    maxRequestBodySize = config.restMaxRequestBodySize * 1024

  let res = RestServerRef.new(
    RestRouter.init(validateFn, allowedOrigin),
    address, serverFlags = serverFlags,
    serverIdent = ident,
    httpHeadersTimeout = headersTimeout,
    maxHeadersSize = maxHeadersSize,
    maxRequestBodySize = maxRequestBodySize,
    errorType = string
  )

  if res.isErr():
    notice "REST HTTP server could not be started", address = $address, reason = res.error()
    nil
  else: 
    let server = res.get()
    notice "Starting REST HTTP server ", url = "http://" & $server.localAddress()
    server