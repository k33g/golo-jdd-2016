#!/usr/bin/env golosh
module demo_deco_result

import gololang.Errors

@result
function toInt = |value| -> Integer.parseInt(value)

function main = |args| {

  let result = toInt("Fourty-two"): either(
    |value| {
      println("Succeed!")
      return value
    },
    |err| {
      println("Failed!" + err: message())
      return 42
    })

  println(toInt("Hello"): orElse(42))

}
