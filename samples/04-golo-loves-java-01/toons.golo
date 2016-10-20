#!/usr/bin/env golosh
module toons
# # golo golo --classpath jars/*.jar --files toons.golo
# or
# chmod +x toons.golo
# ./toons.golo

import acme

function main = |args| {
  let buster = Toon("Buster") # no new
  buster: hi()

  buster: nickName("busty")

  println(buster: nickName())

  let elmira = Toon.getInstance("elmira")
  println(elmira: name())
  elmira: name("Elmira")
  println(elmira: name())
  elmira: hug(buster)

}
