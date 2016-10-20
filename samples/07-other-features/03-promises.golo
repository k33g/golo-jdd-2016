#!/usr/bin/env golosh
module demo_sync

function getContent = |uri| {
  let obj = java.net.URL(uri) # URL obj
  let connection = obj: openConnection() # HttpURLConnection
  connection: setRequestMethod("GET")
  let responseCode = connection: getResponseCode()
  let responseMessage = connection: getResponseMessage()
  let responseText = java.util.Scanner(
    connection: getInputStream(),
    "UTF-8"
  ): useDelimiter("\\A"): next() # String responseText
  return responseText
}

function main = |args| {
  println(getContent("http://www.google.com"))
}
