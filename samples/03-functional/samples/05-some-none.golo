#!/usr/bin/env golosh
module SomeNone

import gololang.Errors

function main = |args| {

  let toInt = |value| {
    try {
      return Some(Integer.parseInt(value))
    } catch(e) {
      return None()
    }
  }

  let result = toInt("42"): either(|value| {
    println("Succeed!")
    return value
  }, {
    println("Failed!")
    return 42
  })

  println(toInt("Hello"): orElse(42))

}
