#!/usr/bin/env golosh

----
# chmod +x spark.2.golo
----
module play_with_spark_java_2

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

  get("/hi", |request, response| ->
    response: textPayLoad("Hi :earth_africa: at JDD 2016")
  )

  get("/hello", |request, response| ->
    response: jsonPayLoad(
      DynamicObject(): message("Hello :earth_africa: at JDD 2016")
    )
  )
}
