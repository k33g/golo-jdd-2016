#!/usr/bin/env golosh
module demo_json
import gololang.JSON

function main = |args| {
  let bob = """
  {
    "id": "bob_morane", "firstName": "Bob", "lastName": "Morane",
    "things": {
      "id": "001",
      "message": {
        "text": "this is a box"
      },
      "bidules": [
        42,
        "42",
        {
          "trucs":[
            1,
            2,
            3,
            {
              "tools": [
                "hammer",
                "fork",
                "knife",
                {
                  "yo":"HELLO"
                }
              ]
            }
          ]
        }
      ],
      "id": "ping"
    },
    "remark": "nothing"
  }
  """

  let dyno = JSON.toDynamicObjectTreeFromString(bob)

  println(dyno: things(): bidules(): get(0))
  println(dyno: things(): message(): text())



}
