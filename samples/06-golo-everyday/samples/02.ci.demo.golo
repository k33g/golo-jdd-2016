#!/usr/bin/env golosh

module ci_server

import spark.Spark

import gololang.Errors
import gololang.Async
import goloctokit

function log = |txt, args...| -> println(java.text.MessageFormat.format(txt, args))

function main = |args| {
  setPort(8888)

  let statuses = map[["error","😡"],["success","😃"],["failure","💀"],["pending","🤔"]]

  let ciBot = GitHubClient(
    uri= "http://github.at.home/api/v3",
    token=  System.getenv("TOKEN_GHE_27_BOBTHEBOT")
  )

  # when event
  post("/ci", |request, response| {
    response: type("application/json")

    let eventName = request: headers("X-GitHub-Event")
    let data =  JSON.toDynamicObjectTreeFromString(request: body())

    if eventName: equals("push") {
      let owner = data: repository(): owner(): name()
      let repositoryName = data: repository(): name()

      let ref = data: ref()
      let sha = data: head_commit(): id()

      log("GitHub Event: {0} on {1}/{2}", eventName, owner, repositoryName)

      log("Committer: {0}", data: head_commit(): committer(): username())
      log("Message: {0}", data: head_commit(): message())

      let statuses_url = "/repos/" + owner + "/" + repositoryName + "/statuses/" + sha

      let getStatus = -> match {
        when data: head_commit(): message(): contains("error") then "error"
        when data: head_commit(): message(): contains("success") then "success"
        when data: head_commit(): message(): contains("failure") then "failure"
        otherwise "pending"
      }

      # display status of the pull request
      log("PR Status {0}", statuses: get(getStatus()))

      # do something, install, test, ...

      # Change a Status:
      let result = ciBot: postData(statuses_url, map[
        ["state", getStatus()],
        ["description", "Hi, I'm Bob, the CIBot :wink:"],
        ["context", "CIFaker"],
        ["target_url", "http://zeiracorp.local:8888/ci"]
      ]): data()
    } # end of push

    return JSON.stringify(DynamicObject(): message("Hello from Golo-CI"))
  })

  # Say Hello
  get("/ci", |request, response| {
    response: type("application/json")
    return JSON.stringify(DynamicObject(): message("Hello from Golo-CI"))
  })
}
