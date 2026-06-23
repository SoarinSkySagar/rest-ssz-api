## SSZ primitive aliases, generic wrapper types and `MAX_*` constants
## from refactor-ssz.md (Engine API v2 -- SSZ Container Sketches).
## Type definitions only.

const
  MAX_BYTES_PER_TX* = 1 shl 30                 # 2**30 (1,073,741,824)
  MAX_TXS_PER_PAYLOAD* = 1 shl 20              # 2**20 (1,048,576)
  MAX_WITHDRAWALS_PER_PAYLOAD* = 1 shl 4       # 2**4 (16)
  BYTES_PER_LOGS_BLOOM* = 256
  MAX_EXTRA_DATA_BYTES* = 1 shl 5              # 2**5 (32)
  MAX_BLOB_COMMITMENTS_PER_BLOCK* = 1 shl 12   # 2**12 (4,096)
  FIELD_ELEMENTS_PER_BLOB* = 4096
  BYTES_PER_FIELD_ELEMENT* = 32
  BYTES_PER_BLOB* = FIELD_ELEMENTS_PER_BLOB * BYTES_PER_FIELD_ELEMENT  # 131,072
  CELLS_PER_EXT_BLOB* = 128
  FIELD_ELEMENTS_PER_CELL* = 64
  BYTES_PER_CELL* = FIELD_ELEMENTS_PER_CELL * BYTES_PER_FIELD_ELEMENT  # 2,048
  MAX_BAL_BYTES* = MAX_BYTES_PER_TX            # placeholder until EIP-7928 pins a bound
  MAX_EXECUTION_REQUESTS_PER_PAYLOAD* = 1 shl 8  # 2**8 (256)
  MAX_BYTES_PER_EXECUTION_REQUEST* = MAX_BYTES_PER_TX  # placeholder; reuse the tx bound
  MAX_VERSIONED_HASHES_PER_REQUEST* = 128
  MAX_BLOBS_REQUEST* = MAX_VERSIONED_HASHES_PER_REQUEST  # 128
  MAX_BODIES_REQUEST* = 1 shl 5                # 2**5 (32)
  MAX_REQUEST_BODY_SIZE* = 1 shl 26            # 2**26 (67,108,864)
  MAX_ERROR_BYTES* = 1024
  MAX_CLIENT_CODE_LENGTH* = 2
  MAX_CLIENT_NAME_LENGTH* = 64
  MAX_CLIENT_VERSION_LENGTH* = 64
  MAX_CLIENT_VERSIONS* = 4
  MAX_CAPABILITY_NAME_LENGTH* = 64
  MAX_CAPABILITIES* = 64

type
  # --- generic SSZ wrapper types ---
  List*[T; N: static int] = object
    ## SSZ `List[T, N]`: variable-length, at most N elements.
    data*: seq[T]

  ByteList*[N: static int] = object
    ## SSZ `ByteList[N]` ≡ `List[byte, N]`.
    data*: seq[byte]

  ByteVector*[N: static int] = array[N, byte]
    ## SSZ fixed-size byte vector.

  Optional*[T] = object
    ## SSZ `Optional[T]` ≡ `List[T, 1]` (len 0 = absent, len 1 = present).
    data*: seq[T]

  Bitvector*[N: static int] = object
    ## SSZ `Bitvector[N]`: N bits packed into ceil(N/8) bytes.
    bits*: array[(N + 7) div 8, byte]

  # --- primitive aliases ---
  Hash32* = ByteVector[32]          ## block / payload hashes
  Root* = ByteVector[32]            ## beacon-block roots, merkle roots
  Address* = ByteVector[20]         ## execution-layer 160-bit address
  Bloom* = ByteVector[256]          ## logs bloom filter
  VersionedHash* = ByteVector[32]   ## EIP-4844 versioned blob hash
  Bytes4* = ByteVector[4]
  Bytes8* = ByteVector[8]           ## payload_id
  Bytes32* = ByteVector[32]         ## prevRandao, generic 32-byte values
  Bytes48* = ByteVector[48]         ## KZG commitments and proofs
  Uint64* = uint64                  ## LE on the wire
  Uint256* = ByteVector[32]         ## LE 256-bit unsigned (block_value, base_fee_per_gas)
  Boolean* = bool                   ## one byte, 0x00 / 0x01
  String* = ByteList[MAX_ERROR_BYTES]  ## ≡ List[byte, MAX_ERROR_BYTES]
