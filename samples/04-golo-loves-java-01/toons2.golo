#!/usr/bin/env golosh
module toons2
# chmod +x toons2.golo

import acme

augment acme.Toon {
  function hi = |this, message| {
    this: hi()
    println("my message: " + message)
  }
}

function main = |args| {
  let buster = Toon("Buster") # no new
  buster: hi("where is babs")

}
