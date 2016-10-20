module toons3

import gololang.Adapters
import acme

# Finally we do not encourage you to use adapters as part of Golo code outside of providing bridges to third-party APIs.

function main = |args| {
  let buster = Toon("Buster") # no new
  let elmira = Toon("Elmira")

  elmira: hug(buster)

  let toonAdapter = Adapter(): extends("acme.Toon")
    : implements("hi", |this| {
        println("HI!, I'M " + this: name())
      })
    : overrides("hug", |super, this, toon| {
        println("before")
        super(this, toon)
        println("after")
      })



  let babs = toonAdapter: newInstance("Babs")
  babs: hi()
  babs: hug(buster)
}
