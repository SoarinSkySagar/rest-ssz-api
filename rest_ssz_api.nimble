# Package

version       = "0.1.0"
author        = "Sagar Rana"
description   = "REST + SSZ Engine API"
license       = "MIT"
srcDir        = "src"
bin           = @["rest_ssz_api"]


# Dependencies

requires "nim >= 2.2.10"
requires "presto"
requires "ssz_serialization"
requires "serialization"