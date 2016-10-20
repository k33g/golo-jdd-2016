#!/usr/bin/env golosh
module demo_decorator

import gololang.Errors

# This is a decorator
function checkIntegers = |fun| {
    return |args...| {  # return decorated function
      if not (args: get(0) oftype Integer.class) or not (args: get(1) oftype Integer.class) {
        return Error("Hey 👋 😡 only Integers❗️")
      }
      return Result(fun: invoke(args))
    }
}

@checkIntegers
function addition = |a, b| {
  return a + b
}

function main = |args| {
   println(addition(12,32))     # Result.value[44]
   println(addition(12.3, 32))  # Result.error[java.lang.RuntimeException: Hey 👋 😡 only Integers❗️]
}
