#!/usr/bin/env golosh
module demo1

function addition = |a, b| {
  return a + b
}

function main = |args| {
  # function as output
  let add = |a| -> |b| -> addition(a,b)

  let add1 = add(1)

  println(add1(41))

  println(
    list[1, 2, 3, 4, 5]: map(add1): map(add1)
  )

}
