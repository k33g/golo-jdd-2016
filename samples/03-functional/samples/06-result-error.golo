#!/usr/bin/env golosh
module demoTrying

import gololang.Errors

function main = |args| {

  let toInt = |value| {
    try {
      return Result(Integer.parseInt(value))
    } catch(e) {
      return Error(e: getMessage())
    }
  }

  let result = toInt("Quarante-deux"): either(
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
