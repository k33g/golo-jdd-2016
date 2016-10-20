#!/usr/bin/env golosh
module demoKebab_2

function main = |args| {

  let noChips = |food| -> food isnt "🍟" # return true if it's not chips
  let noOnion = |food| -> food isnt "😭"

  let cutFood = |food| -> "piece of " + food

  let Food = list[
      "🍞"
    , "🍃"
    , "🍅"
    , "🍖"
    , "🍟"
    , "😭"  # 😡 can't find onion emoji
  ]

  println(noChips("🍞") == true)
  println(noChips("🍟") == false)

  println(Food)
  println(Food: filter(noChips))
  println(Food: filter(noChips): filter(noOnion))
  println(Food: filter(noChips): filter(noOnion): map(cutFood))


  let myKebabRecipe = Food
        : filter(noChips)
        : filter(noOnion)
        : map(cutFood)

  println("MyRecipe: ")
  println(myKebabRecipe)

  # ⚡️ preparing kebab with myKebabRecipe
  let mix = |accFood, nextFood| -> accFood + nextFood + " "

  let kebab = myKebabRecipe
        : reduce("🌮 with: ", mix)

  println("Your Kebab: ")
  println(kebab)
}
