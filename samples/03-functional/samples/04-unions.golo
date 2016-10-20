#!/usr/bin/env golosh
module SomeThingSo

union SomeThing = {
  Yum = { value }   # good
  Yuck = { value }  # bad
}

augment SomeThing$Yum {
  function so = |this, ifYum, ifYuck| -> ifYum(this: value())
}

augment SomeThing$Yuck {
  function so = |this, ifYum, ifYuck| -> ifYuck(this: value())
}

function main = |args| {

  let onlyBananas = |value| {
    if value is "🍌" { return SomeThing.Yum(value)}
    return SomeThing.Yuck(value)
  }

  onlyBananas("🍋"): so(
    |value| {
      println("I 💙 " + value)
    },
    |value| {
      println("I 💔 " + value)
    })

}
