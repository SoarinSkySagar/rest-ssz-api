import presto


proc handleCapabilities*(): RestApiResponse =
  RestApiResponse.response("capabilities: ok", Http200, "text/plain")

proc handleIdentity*(): RestApiResponse =
  RestApiResponse.response("identity: ok", Http200, "text/plain")
