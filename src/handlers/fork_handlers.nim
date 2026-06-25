import presto
import ../types/containers
import decode_ssz
import request_log

func validFork(fork: Result[string, cstring]): Result[Fork, RestApiResponse] =
  let name = fork.valueOr:
    return err(unsupportedForkResponse())
  let parsed = parseFork(name).valueOr:
    return err(unsupportedForkResponse("unknown fork '" & name & "'"))
  ok(parsed)

func isHexPayloadId(s: string): bool =
  if s.len != 18 or s[0] != '0' or (s[1] != 'x' and s[1] != 'X'):
    return false
  for c in s[2 .. ^1]:
    if c notin {'0'..'9', 'a'..'f', 'A'..'F'}:
      return false
  true

func isZeroPayloadId(s: string): bool =
  for c in s[2 .. ^1]:
    if c != '0':
      return false
  true

proc handleNewPayload*(fork: Result[string, cstring],
                       contentBody: Option[ContentBody]): RestApiResponse =
  discard validFork(fork).valueOr:
    return error

  let envelope = decodeSszBody(contentBody, ExecutionPayloadEnvelopeAmsterdam).valueOr:
    return error
  recordRequest(envelope)
  # TODO: validate `envelope`; invalid field values -> invalidBodyResponse() (422).

  # Hardcoded VALID
  var status: PayloadStatus
  encodeSszResponse(status)

proc handleGetPayload*(fork: Result[string, cstring],
                       payloadId: Result[string, cstring]): RestApiResponse =
  discard validFork(fork).valueOr:
    return error

  let id = payloadId.valueOr:
    return invalidRequestResponse("missing payloadId")
  if not isHexPayloadId(id):
    return invalidRequestResponse("payloadId must be 8 hex-encoded bytes")
  # TODO: real lookup
  if isZeroPayloadId(id):
    return unknownPayloadResponse()

  var payload: BuiltPayloadAmsterdam
  encodeSszResponse(payload, @[("Cache-Control", "no-store")])

proc handleForkchoiceUpdated*(fork: Result[string, cstring],
                              contentBody: Option[ContentBody]): RestApiResponse =
  discard validFork(fork).valueOr:
    return error

  let update = decodeSszBody(contentBody, ForkchoiceUpdateAmsterdam).valueOr:
    return error
  recordRequest(update)
  # TODO: process `update`

  var fcuResponse: ForkchoiceUpdateResponse
  encodeSszResponse(fcuResponse)

proc handleGetPayloadBodiesByHash*(fork: Result[string, cstring],
                                   contentBody: Option[ContentBody]): RestApiResponse =
  discard validFork(fork).valueOr:
    return error

  let request = decodeSszBody(contentBody, BodiesByHashRequest).valueOr:
    return error
  recordRequest(request)

  var bodies: BodiesResponse[ExecutionPayloadBodyAmsterdam]
  for _ in 0 ..< request.block_hashes.len:
    discard bodies.entries.add(default(BodyEntry[ExecutionPayloadBodyAmsterdam]))
  encodeSszResponse(bodies)

proc handleGetPayloadBodiesByRange*(fork: Result[string, cstring],
                                    `from`: Option[Result[string, cstring]],
                                    count: Option[Result[string, cstring]]): RestApiResponse =
  discard validFork(fork).valueOr:
    return error

  var bodies: BodiesResponse[ExecutionPayloadBodyAmsterdam]
  encodeSszResponse(bodies)
