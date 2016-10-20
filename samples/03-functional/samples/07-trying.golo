#!/usr/bin/env golosh
module ResultError

import gololang.Errors

function main = |args| {

  # get a Result or an Error
  trying({
    return Integer.parseInt("Quarante-deux")
  })
  : either(
    |value| {
      println("Succeed!")
    },
    |err| {
      println("Failed!" + err: message())
    })

}
