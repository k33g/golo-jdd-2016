#!/usr/bin/env golosh
module demo_workers

import gololang.concurrent.workers.WorkerEnvironment

#  jack 🎃  felix 🐱

function main = |args| {
  let env = WorkerEnvironment.builder(): withCachedThreadPool()

  let jack = env: spawn(|message| {
    5: times({ println(message + " 🎃") })
    sleep(200_L)
    if message:equals("kill") {env: shutdown()}
  })

  let felix = env: spawn(|message| {
    5: times({ println(message + " 🐱") })
    sleep(200_L)
    if message:equals("kill") {env: shutdown()}
  })

  jack: send("hello")
  felix: send("hi"): send("yo"): send("kill")

}
