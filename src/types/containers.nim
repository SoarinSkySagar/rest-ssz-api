## Engine API v2 SSZ container definitions from refactor-ssz.md.
## Type definitions only — fields are in normative (positional) order.

import primitives

type
  # ----------------------------------------------------------------------
  # Shared structures
  # ----------------------------------------------------------------------

  Withdrawal* = object
    index*: Uint64
    validator_index*: Uint64
    address*: Address
    amount*: Uint64                 # gwei

  # ----------------------------------------------------------------------
  # ExecutionPayload per fork
  # ----------------------------------------------------------------------

  ExecutionPayloadParis* = object
    parent_hash*: Hash32
    fee_recipient*: Address
    state_root*: Hash32
    receipts_root*: Hash32
    logs_bloom*: Bloom
    prev_randao*: Bytes32
    block_number*: Uint64
    gas_limit*: Uint64
    gas_used*: Uint64
    timestamp*: Uint64
    extra_data*: ByteList[MAX_EXTRA_DATA_BYTES]
    base_fee_per_gas*: Uint256
    block_hash*: Hash32
    transactions*: List[ByteList[MAX_BYTES_PER_TX], MAX_TXS_PER_PAYLOAD]

  ExecutionPayloadShanghai* = object  # Paris + withdrawals
    parent_hash*: Hash32
    fee_recipient*: Address
    state_root*: Hash32
    receipts_root*: Hash32
    logs_bloom*: Bloom
    prev_randao*: Bytes32
    block_number*: Uint64
    gas_limit*: Uint64
    gas_used*: Uint64
    timestamp*: Uint64
    extra_data*: ByteList[MAX_EXTRA_DATA_BYTES]
    base_fee_per_gas*: Uint256
    block_hash*: Hash32
    transactions*: List[ByteList[MAX_BYTES_PER_TX], MAX_TXS_PER_PAYLOAD]
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]

  ExecutionPayloadCancun* = object  # Shanghai + blob_gas_used + excess_blob_gas
    parent_hash*: Hash32
    fee_recipient*: Address
    state_root*: Hash32
    receipts_root*: Hash32
    logs_bloom*: Bloom
    prev_randao*: Bytes32
    block_number*: Uint64
    gas_limit*: Uint64
    gas_used*: Uint64
    timestamp*: Uint64
    extra_data*: ByteList[MAX_EXTRA_DATA_BYTES]
    base_fee_per_gas*: Uint256
    block_hash*: Hash32
    transactions*: List[ByteList[MAX_BYTES_PER_TX], MAX_TXS_PER_PAYLOAD]
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]
    blob_gas_used*: Uint64
    excess_blob_gas*: Uint64

  ExecutionPayloadPrague* = ExecutionPayloadCancun   # no payload-shape change
  ExecutionPayloadOsaka* = ExecutionPayloadPrague    # no payload-shape change

  ExecutionPayloadAmsterdam* = object  # Cancun + block_access_list + slot_number
    parent_hash*: Hash32
    fee_recipient*: Address
    state_root*: Hash32
    receipts_root*: Hash32
    logs_bloom*: Bloom
    prev_randao*: Bytes32
    block_number*: Uint64
    gas_limit*: Uint64
    gas_used*: Uint64
    timestamp*: Uint64
    extra_data*: ByteList[MAX_EXTRA_DATA_BYTES]
    base_fee_per_gas*: Uint256
    block_hash*: Hash32
    transactions*: List[ByteList[MAX_BYTES_PER_TX], MAX_TXS_PER_PAYLOAD]
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]
    blob_gas_used*: Uint64
    excess_blob_gas*: Uint64
    block_access_list*: ByteList[MAX_BAL_BYTES]   # RLP-encoded EIP-7928 BAL
    slot_number*: Uint64

  ExecutionPayload* = ExecutionPayloadAmsterdam      # shared "ExecutionPayload (Amsterdam)"

  # ----------------------------------------------------------------------
  # PayloadAttributes per fork
  # ----------------------------------------------------------------------

  PayloadAttributesParis* = object
    timestamp*: Uint64
    prev_randao*: Bytes32
    suggested_fee_recipient*: Address

  PayloadAttributesShanghai* = object  # Paris + withdrawals
    timestamp*: Uint64
    prev_randao*: Bytes32
    suggested_fee_recipient*: Address
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]

  PayloadAttributesCancun* = object  # Shanghai + parent_beacon_block_root
    timestamp*: Uint64
    prev_randao*: Bytes32
    suggested_fee_recipient*: Address
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]
    parent_beacon_block_root*: Root

  PayloadAttributesPrague* = PayloadAttributesCancun  # no shape change
  PayloadAttributesOsaka* = PayloadAttributesCancun   # no shape change

  PayloadAttributesAmsterdam* = object  # Cancun + slot_number + target_gas_limit
    timestamp*: Uint64
    prev_randao*: Bytes32
    suggested_fee_recipient*: Address
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]
    parent_beacon_block_root*: Root
    slot_number*: Uint64
    target_gas_limit*: Uint64

  PayloadAttributes* = PayloadAttributesAmsterdam    # shared "PayloadAttributes (Amsterdam)"

  # ----------------------------------------------------------------------
  # ForkchoiceState / PayloadStatus
  # ----------------------------------------------------------------------

  ForkchoiceState* = object
    head_block_hash*: Hash32
    safe_block_hash*: Hash32
    finalized_block_hash*: Hash32

  PayloadStatus* = object
    status*: uint8                  # 0=VALID 1=INVALID 2=SYNCING 3=ACCEPTED
    latest_valid_hash*: Optional[Hash32]
    validation_error*: Optional[String]

  # ----------------------------------------------------------------------
  # ExecutionPayloadBody per fork
  # ----------------------------------------------------------------------

  ExecutionPayloadBodyParis* = object
    transactions*: List[ByteList[MAX_BYTES_PER_TX], MAX_TXS_PER_PAYLOAD]

  ExecutionPayloadBodyShanghai* = object  # Paris + withdrawals
    transactions*: List[ByteList[MAX_BYTES_PER_TX], MAX_TXS_PER_PAYLOAD]
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]

  ExecutionPayloadBodyCancun* = ExecutionPayloadBodyShanghai
  ExecutionPayloadBodyPrague* = ExecutionPayloadBodyShanghai
  ExecutionPayloadBodyOsaka* = ExecutionPayloadBodyShanghai

  ExecutionPayloadBodyAmsterdam* = object  # Shanghai + block_access_list
    transactions*: List[ByteList[MAX_BYTES_PER_TX], MAX_TXS_PER_PAYLOAD]
    withdrawals*: List[Withdrawal, MAX_WITHDRAWALS_PER_PAYLOAD]
    block_access_list*: ByteList[MAX_BAL_BYTES]

  ExecutionPayloadBody* = ExecutionPayloadBodyAmsterdam  # shared Amsterdam body

  # ----------------------------------------------------------------------
  # BlobsBundle per revision
  # ----------------------------------------------------------------------

  BlobsBundleV1* = object  # one proof per blob
    commitments*: List[Bytes48, MAX_BLOB_COMMITMENTS_PER_BLOCK]
    proofs*: List[Bytes48, MAX_BLOB_COMMITMENTS_PER_BLOCK]
    blobs*: List[ByteVector[BYTES_PER_BLOB], MAX_BLOB_COMMITMENTS_PER_BLOCK]

  BlobsBundleV2* = object  # CELLS_PER_EXT_BLOB cell proofs per blob
    commitments*: List[Bytes48, MAX_BLOB_COMMITMENTS_PER_BLOCK]
    proofs*: List[Bytes48, MAX_BLOB_COMMITMENTS_PER_BLOCK * CELLS_PER_EXT_BLOB]
    blobs*: List[ByteVector[BYTES_PER_BLOB], MAX_BLOB_COMMITMENTS_PER_BLOCK]

  # ----------------------------------------------------------------------
  # BuiltPayload per fork
  # ----------------------------------------------------------------------

  BuiltPayloadParis* = object
    payload*: ExecutionPayloadParis
    block_value*: Uint256

  BuiltPayloadShanghai* = object
    payload*: ExecutionPayloadShanghai
    block_value*: Uint256

  BuiltPayloadCancun* = object  # Shanghai + blobs_bundle (V1) + should_override_builder
    payload*: ExecutionPayloadCancun
    block_value*: Uint256
    blobs_bundle*: BlobsBundleV1
    should_override_builder*: Boolean

  BuiltPayloadPrague* = object  # Cancun + execution_requests (before should_override_builder)
    payload*: ExecutionPayloadPrague
    block_value*: Uint256
    blobs_bundle*: BlobsBundleV1
    execution_requests*: List[ByteList[MAX_BYTES_PER_EXECUTION_REQUEST], MAX_EXECUTION_REQUESTS_PER_PAYLOAD]
    should_override_builder*: Boolean

  BuiltPayloadOsaka* = object  # Prague but blobs_bundle is V2
    payload*: ExecutionPayloadOsaka
    block_value*: Uint256
    blobs_bundle*: BlobsBundleV2
    execution_requests*: List[ByteList[MAX_BYTES_PER_EXECUTION_REQUEST], MAX_EXECUTION_REQUESTS_PER_PAYLOAD]
    should_override_builder*: Boolean

  BuiltPayloadAmsterdam* = object  # Osaka with the Amsterdam ExecutionPayload
    payload*: ExecutionPayloadAmsterdam
    block_value*: Uint256
    blobs_bundle*: BlobsBundleV2
    execution_requests*: List[ByteList[MAX_BYTES_PER_EXECUTION_REQUEST], MAX_EXECUTION_REQUESTS_PER_PAYLOAD]
    should_override_builder*: Boolean

  # ----------------------------------------------------------------------
  # ExecutionPayloadEnvelope per fork
  # ----------------------------------------------------------------------

  ExecutionPayloadEnvelopeParis* = object
    payload*: ExecutionPayloadParis

  ExecutionPayloadEnvelopeShanghai* = object
    payload*: ExecutionPayloadShanghai

  ExecutionPayloadEnvelopeCancun* = object  # + parent_beacon_block_root
    payload*: ExecutionPayloadCancun
    parent_beacon_block_root*: Root

  ExecutionPayloadEnvelopePrague* = object  # Cancun + execution_requests
    payload*: ExecutionPayloadPrague
    parent_beacon_block_root*: Root
    execution_requests*: List[ByteList[MAX_BYTES_PER_EXECUTION_REQUEST], MAX_EXECUTION_REQUESTS_PER_PAYLOAD]

  ExecutionPayloadEnvelopeOsaka* = object  # Prague shape, Osaka inner
    payload*: ExecutionPayloadOsaka
    parent_beacon_block_root*: Root
    execution_requests*: List[ByteList[MAX_BYTES_PER_EXECUTION_REQUEST], MAX_EXECUTION_REQUESTS_PER_PAYLOAD]

  ExecutionPayloadEnvelopeAmsterdam* = object  # Prague shape, Amsterdam inner
    payload*: ExecutionPayloadAmsterdam
    parent_beacon_block_root*: Root
    execution_requests*: List[ByteList[MAX_BYTES_PER_EXECUTION_REQUEST], MAX_EXECUTION_REQUESTS_PER_PAYLOAD]

  # ----------------------------------------------------------------------
  # ForkchoiceUpdate per fork
  # ----------------------------------------------------------------------

  ForkchoiceUpdate*[A] = object  # Paris .. Osaka (A = the fork's PayloadAttributes)
    forkchoice_state*: ForkchoiceState
    payload_attributes*: Optional[A]

  ForkchoiceUpdateAmsterdam* = object  # + custody_columns
    forkchoice_state*: ForkchoiceState
    payload_attributes*: Optional[PayloadAttributesAmsterdam]
    custody_columns*: Optional[Bitvector[CELLS_PER_EXT_BLOB]]

  ForkchoiceUpdateResponse* = object
    payload_status*: PayloadStatus  # restricted: VALID | INVALID | SYNCING
    payload_id*: Optional[Bytes8]

  # ----------------------------------------------------------------------
  # BlobAndProof per revision
  # ----------------------------------------------------------------------

  BlobAndProofV1* = object  # Cancun whole-blob, single proof
    blob*: ByteVector[BYTES_PER_BLOB]
    proof*: Bytes48

  BlobAndProofV2* = object  # Osaka cell proofs
    blob*: ByteVector[BYTES_PER_BLOB]
    proofs*: List[Bytes48, CELLS_PER_EXT_BLOB]

  BlobCellsAndProofs* = object  # Amsterdam cell-range selection (per-cell nullable)
    blob_cells*: List[Optional[ByteVector[BYTES_PER_CELL]], CELLS_PER_EXT_BLOB]
    proofs*: List[Optional[Bytes48], CELLS_PER_EXT_BLOB]

  # ----------------------------------------------------------------------
  # Identification & capabilities
  # ----------------------------------------------------------------------

  ClientVersion* = object
    code*: ByteList[MAX_CLIENT_CODE_LENGTH]
    name*: ByteList[MAX_CLIENT_NAME_LENGTH]
    version*: ByteList[MAX_CLIENT_VERSION_LENGTH]
    commit*: Bytes4

  IdentityResponse* = object
    versions*: List[ClientVersion, MAX_CLIENT_VERSIONS]

  CapabilitiesResponse* = object
    capabilities*: List[ByteList[MAX_CAPABILITY_NAME_LENGTH], MAX_CAPABILITIES]

  # ----------------------------------------------------------------------
  # Endpoint containers — bodies
  # ----------------------------------------------------------------------

  BodiesByHashRequest* = object
    block_hashes*: List[Hash32, MAX_BODIES_REQUEST]

  BodyEntry*[B] = object  # B = the fork's ExecutionPayloadBody
    available*: Boolean
    body*: B

  BodiesResponse*[B] = object
    entries*: List[BodyEntry[B], MAX_BODIES_REQUEST]

  # ----------------------------------------------------------------------
  # Endpoint containers — blobs
  # ----------------------------------------------------------------------

  BlobsV1Request* = object
    versioned_hashes*: List[VersionedHash, MAX_BLOBS_REQUEST]

  BlobV1Entry* = object
    available*: Boolean
    contents*: BlobAndProofV1

  BlobsV1Response* = object
    entries*: List[BlobV1Entry, MAX_BLOBS_REQUEST]

  BlobsV2Request* = object
    versioned_hashes*: List[VersionedHash, MAX_BLOBS_REQUEST]

  BlobV2Entry* = object  # also reused verbatim by /v3
    available*: Boolean
    contents*: BlobAndProofV2

  BlobsV2Response* = object
    entries*: List[BlobV2Entry, MAX_BLOBS_REQUEST]

  BlobsV3Response* = object  # reuses BlobV2Entry; no separate BlobV3Entry
    entries*: List[BlobV2Entry, MAX_BLOBS_REQUEST]

  BlobsV4Request* = object
    versioned_hashes*: List[VersionedHash, MAX_BLOBS_REQUEST]
    indices_bitarray*: Bitvector[CELLS_PER_EXT_BLOB]

  BlobV4Entry* = object
    available*: Boolean
    contents*: BlobCellsAndProofs

  BlobsV4Response* = object
    entries*: List[BlobV4Entry, MAX_BLOBS_REQUEST]
