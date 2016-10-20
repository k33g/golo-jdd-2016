#!/usr/bin/env golosh
module SomeThing

union SomeThing = {
  Yum = { value }   # good
  Yuck = { value }  # bad
}
# you're good or bad, but not good and bad

function main = |args| {

  let banana = SomeThing.Yum("🍌")
  let hotPepper = SomeThing.Yuck("🌶")

  #banana: value("🍊")

  println(banana)
  println(banana: value())

  #banana: value("🍊")

  println(hotPepper)
  println(hotPepper: value())

  # you can do that:
  println(banana: isYum())
  println(hotPepper: isYuck())

  let onlyBananas = |value| {
    if value is "🍌" { return SomeThing.Yum(value)}
    return SomeThing.Yuck("🌶")
  }

  if onlyBananas("🍋"): isYum() {
    println("I 💙 bananas")
  } else {
    println("💔")
  }

}
