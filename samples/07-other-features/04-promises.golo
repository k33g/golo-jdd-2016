#!/usr/bin/env golosh
module demo_async

import gololang.Async


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

  let getAsyncContent = |uri| -> promise(): initializeWithinThread(|resolve, reject| {
    try {
      resolve(getContent(uri))
    } catch(error) {
      reject(error)
    }
  })

  getAsyncContent("http://www.google.com")
    : onSet(|result| { # if success
      println(result)
    })
    : onFail(|error| { # if failed
      println(error: message())
    })

}
