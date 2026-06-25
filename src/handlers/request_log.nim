import std/strutils
import ssz_serialization
import stew/byteutils

const
  RequestsLogFile = "requests.txt"

proc toLogStr[T](val: T): string =
  when val is array:
    when typeof(val[0]) is byte:
      "0x" & toHex(val)
    else:
      (when compiles($val): $val else: repr(val))
  elif val is List:
    let s = val.asSeq
    when s is seq[byte]:
      "0x" & toHex(s)
    elif (typeof(s[0]) is array) or (typeof(s[0]) is List):
      var parts: seq[string]
      for item in s:
        parts.add toLogStr(item)
      "[" & parts.join(", ") & "]"
    else:
      $val
  else:
    when compiles($val): $val else: repr(val)

proc recordRequest*[T](value: T) =
  var s = $typeof(value) & "\n"
  for name, val in value.fieldPairs:
    s.add name & ": " & toLogStr(val) & "\n"
  s.add "\n"

  try:
    let f = open(RequestsLogFile, fmAppend)
    defer: f.close()
    f.write(s)
  except CatchableError:
    discard
