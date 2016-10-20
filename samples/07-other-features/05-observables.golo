#!/usr/bin/env golosh
module fringedivision

function main = |args| {

  let olivia = Observable("Olivia")

  # Observer
  let december = |value| {
    println("December: I 👁 you " + value)
  }

  # Observer
  let november = |value| {
    println("November: I 👁 you " + value)
  }

  olivia: onChange(december): onChange(november)

  olivia: set("Olivia")

}
