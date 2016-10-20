#!/usr/bin/env golosh

----
# chmod +x spark.1.golo
----
module play_with_spark_java_1

import spark.Spark

function main = |args| {

  setPort(8888)
  externalStaticFileLocation("public")

  get("/hi", |request, response| {
    response: type("text/plain")
    return "Hi :earth_africa: at JDD 2016"
  })

  get("/hello", |request, response| {
    response: type("application/json")
    return JSON.stringify(
      DynamicObject(): message("Hello :earth_africa: at JDD 2016")
    )
  })
}
