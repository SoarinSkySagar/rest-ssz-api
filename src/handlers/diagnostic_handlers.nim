import presto

const
  JsonMediaType = "application/json"

  CapabilitiesJson = """{
  "supported_forks": ["paris", "shanghai", "cancun", "prague", "osaka", "amsterdam"],
  "fork_scoped_endpoints": ["payloads", "forkchoice", "bodies"],
  "independently_versioned": { "blobs": ["v1", "v2", "v3", "v4"] },
  "unscoped_endpoints": ["capabilities", "identity"],
  "limits": {
    "bodies.max_count": 32,
    "blobs.max_versioned_hashes": 128,
    "payload.max_bytes": 67108864
  }
}"""

  IdentityJson = """[
  {
    "code": "NB",
    "name": "rest_ssz_api",
    "version": "0.1.0",
    "commit": "0x00000000"
  }
]"""

proc handleCapabilities*(): RestApiResponse =
  RestApiResponse.response(CapabilitiesJson, Http200, JsonMediaType)

proc handleIdentity*(): RestApiResponse =
  RestApiResponse.response(IdentityJson, Http200, JsonMediaType)
