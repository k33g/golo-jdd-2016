#!/usr/bin/env golosh

----
# chmod +x spark.3.golo
----
module play_with_spark_java_3

import gololang.Errors
import spark.Spark

augment spark.Response {
  function jsonPayLoad = |this, content| {
    this: type("application/json")
    return JSON.stringify(content)
  }
  function textPayLoad = |this, content| {
    this: type("text/plain")
    return content
  }
}

function main = |args| {

  setPort(8888)
  externalStaticFileLocation("public")

  get("/hi", |request, response| -> trying({
    return "Hi :earth_africa: at JDD 2016"
  })
  : either(
    |message| -> response: textPayLoad(message),
    |error| -> response: textPayLoad(error: message())
  ))

  get("/hello", |request, response| -> trying({
    #let r = 42 / 0
    return DynamicObject(): message("Hello :earth_africa: at JDD 2016")
  })
  : either(
    |content| -> response: jsonPayLoad(content),
    |error| -> response: jsonPayLoad(DynamicObject(): message(error: message()))
  ))

}
