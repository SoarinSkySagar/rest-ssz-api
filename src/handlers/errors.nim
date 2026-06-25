import presto

const
  ProblemMediaType = "application/problem+json"

proc problem(status: HttpCode, problemType: string,
             detail = ""): RestApiResponse =
  let body =
    if detail.len == 0:
      "{ \"type\": \"" & problemType & "\" }"
    else:
      "{ \"type\": \"" & problemType & "\", \"detail\": \"" & detail & "\" }"
  RestApiResponse.response(body, status, ProblemMediaType)

# 400 Bad Request
proc parseErrorResponse*(detail = ""): RestApiResponse =
  problem(Http400, "/engine-api/errors/parse-error", detail)

proc invalidRequestResponse*(detail = ""): RestApiResponse =
  problem(Http400, "/engine-api/errors/invalid-request", detail)

proc sszDecodeErrorResponse*(): RestApiResponse =
  problem(Http400, "/engine-api/errors/ssz-decode-error")

proc unsupportedForkResponse*(detail = ""): RestApiResponse =
  problem(Http400, "/engine-api/errors/unsupported-fork", detail)

# 404 Not Found
proc methodNotFoundResponse*(): RestApiResponse =
  problem(Http404, "/engine-api/errors/method-not-found")

proc unknownPayloadResponse*(): RestApiResponse =
  problem(Http404, "/engine-api/errors/unknown-payload")

# 409 Conflict
proc invalidForkchoiceResponse*(detail = ""): RestApiResponse =
  problem(Http409, "/engine-api/errors/invalid-forkchoice", detail)

proc reorgTooDeepResponse*(detail = ""): RestApiResponse =
  problem(Http409, "/engine-api/errors/reorg-too-deep", detail)

# 413 Payload Too Large
proc requestTooLargeResponse*(detail = ""): RestApiResponse =
  problem(Http413, "/engine-api/errors/request-too-large", detail)

# 415 Unsupported Media Type
proc unsupportedMediaTypeResponse*(): RestApiResponse =
  problem(Http415, "/engine-api/errors/unsupported-media-type")

# 422 Unprocessable Entity
proc invalidBodyResponse*(detail = ""): RestApiResponse =
  problem(Http422, "/engine-api/errors/invalid-body", detail)

proc invalidAttributesResponse*(detail = ""): RestApiResponse =
  problem(Http422, "/engine-api/errors/invalid-attributes", detail)

# 500 Internal Server Error
proc internalErrorResponse*(detail = ""): RestApiResponse =
  problem(Http500, "/engine-api/errors/internal", detail)

# 204 No Content — null result (not an error; e.g. blob pool cannot serve).
proc noContentResponse*(): RestApiResponse =
  RestApiResponse.response(Http204)
