#!/usr/bin/env golosh
module demo11

function addition = |a, b| {
  return a + b
}

function main = |args| {
  # function as output
  let add = |a| {
    return |b| {
      return addition(a,b)
    }
  }
  # let add = |a| -> |b| -> addition(a,b)

  let add1 = add(1)

  println(add1(41)) # 42

  println(
    list[1, 2, 3, 4, 5]: map(add1) # [2, 3, 4, 5, 6]
  )

}
