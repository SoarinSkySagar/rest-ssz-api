import presto
import ../types/containers
import decode_ssz


proc handleNewPayload*(fork: Result[string, cstring],
                       contentBody: Option[ContentBody]): RestApiResponse =
  let envelope = decodeSszBody(contentBody, ExecutionPayloadEnvelopeAmsterdam).valueOr:
    return RestApiResponse.response(
      "{ \"type\": \"/engine-api/errors/ssz-decode-error\" }",
      Http400, "application/problem+json")
  # TODO: process the decoded `envelope`
  discard envelope

  RestApiResponse.response("newPayload: ok", Http200, "text/plain")

proc handleGetPayload*(fork: Result[string, cstring],
                       payloadId: Result[string, cstring]): RestApiResponse =
  RestApiResponse.response("getPayload: ok", Http200, "text/plain")

proc handleForkchoiceUpdated*(fork: Result[string, cstring],
                              contentBody: Option[ContentBody]): RestApiResponse =
  let update = decodeSszBody(contentBody, ForkchoiceUpdateAmsterdam).valueOr:
    return RestApiResponse.response(
      "{ \"type\": \"/engine-api/errors/ssz-decode-error\" }",
      Http400, "application/problem+json")
  # TODO: process the decoded `update`
  discard update

  RestApiResponse.response("forkchoiceUpdated: ok", Http200, "text/plain")

proc handleGetPayloadBodiesByHash*(fork: Result[string, cstring],
                                   contentBody: Option[ContentBody]): RestApiResponse =
  RestApiResponse.response("getPayloadBodiesByHash: ok", Http200, "text/plain")

proc handleGetPayloadBodiesByRange*(fork: Result[string, cstring],
                                    `from`: Option[Result[string, cstring]],
                                    count: Option[Result[string, cstring]]): RestApiResponse =
  RestApiResponse.response("getPayloadBodiesByRange: ok", Http200, "text/plain")
