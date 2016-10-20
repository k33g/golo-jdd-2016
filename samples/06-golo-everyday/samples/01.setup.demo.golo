#!/usr/bin/env golosh

module repository

import gololang.Errors

import goloctokit

function main = |args| {

  let TOKEN_GITHUB_ENTERPRISE = System.getenv("TOKEN_GHE_27_K33G")
  let organizationName = "JDD2016"
  let repositoryName = "demo"

  let ghCli = GitHubClient(
    uri= "http://github.at.home/api/v3",
    token= TOKEN_GITHUB_ENTERPRISE
  )

  let babs = GitHubClient(
    uri= "http://github.at.home/api/v3",
    token= System.getenv("TOKEN_GHE_27_BABS")
  )

  let buster = GitHubClient(
    uri= "http://github.at.home/api/v3",
    token= System.getenv("TOKEN_GHE_27_BUSTER")
  )

  # Create an organization
  trying({
    ghCli: createOrganization(
      login=organizationName,
      admin="k33g",
      profile_name="Java Event"
    )
  })


  trying({

    ghCli: addOrganizationMembership(
      org=organizationName, userName="babs", role="member"
    )
    ghCli: addOrganizationMembership(
      org=organizationName, userName="buster", role="member"
    )
    ghCli: addOrganizationMembership(
      org=organizationName, userName="k33g", role="admin"
    )
    ghCli: addOrganizationMembership(
      org=organizationName, userName="bob", role="admin"
    )

  })

  # Create a repository for the JDD organization
  trying({
    ghCli: createRepository(
      name=repositoryName,
      description="this is my "+repositoryName+" repository",
      organization=organizationName,
      private=false,
      hasIssues=true
    )
  })

  # create a Team for JDD
  trying({
    ghCli: createTeam(
      org=organizationName,
      name="speakers",
      description="the dream team",
      repo_names=[organizationName+"/"+repositoryName],
      privacy="closed",
      permission="admin"
    )
  })

  # Add members to the team
  trying({
    let team = ghCli: getTeamByName(
      organization=organizationName,
      name="speakers"
    )
    println(JSON.stringify(team: id()))
    # Update Team rights
    ghCli: updateTeamRepository(
      id=team: id(),
      organization=organizationName,
      repository=repositoryName,
      permission="admin"
    )

    ghCli: addTeamMembership(
      teamId=team: id(), userName="babs", role="maintener"
    )
    ghCli: addTeamMembership(
      teamId=team: id(), userName="buster", role="maintener"
    )
    ghCli: addTeamMembership(
      teamId=team: id(), userName="k33g", role="maintener"
    )

  })


  trying({
    let label = |name, color|-> DynamicObject(): name(name): color(color)

    let res = ghCli: createLabels(labels=list[
      label("point: 1", "bfdadc"),
      label("point: 2", "d4c5f9"),
      label("point: 3", "c5def5"),
      label("point: 5", "1d76db"),
      label("point: 8", "006b75"),
      label("point: 13", "0e8a16"),
      label("point: 21", "5319e7"),
      label("priority: high", "d93f0b"),
      label("priority: highest", "b60205"),
      label("priority: low", "fbca04"),
      label("priority: lowest", "fef2c0"),
      label("priority: medium", "f9d0c4"),
      label("type: bug", "d93f0b"),
      label("type: chore", "fbca04"),
      label("type: feature", "1d76db"),
      label("type: infrastructure", "5319e7"),
      label("type: performance", "006b75"),
      label("type: refactor", "c2e0c6"),
      label("type: test", "e99695"),
      label("type: implementation", "000000")
    ], owner="JDD2015", repository=repositoryName)

  }): either(|payload|{}, |error|{ println("Error: " + error: message()) })

  # create Milestones of the project
  trying({

    let milestone = |title, state, description, dueOn|->
      DynamicObject()
        : title(title)
        : state(state)
        : description(description)
        : due_on(dueOn)


    return  ghCli: createMilestones(milestones=list[
      milestone("Inception", "open",
                "A discover phase, where an initial problem statement and functional requirements are created.",
                "2016-10-15T09:00:00Z"
      ),
      milestone("Elaboration", "open",
                "The product vision and architecture are defined, construction cycles are planned.",
                "2016-11-01T09:00:00Z"
      ),
      milestone("Construction", "open",
                "The software is taken from an architectural baseline to the point where it is ready to make the transition to the user community.",
                "2016-12-01T09:00:00Z"
      ),
      milestone("Transition", "open",
                "The software is turned into the hands of the user's community.",
                "2017-02-01T09:00:00Z"
      )
    ], owner=organizationName, repository=repositoryName)

  }): either(
    |value| -> println(value),
    |error| -> println(error)
  )

  #-------------------------
  # Create some issues
  #-------------------------
let SPEC_1 = """
### All start from here

I need something like that:

```javascript
let bob = Container.of('Bob Morane');
bob.value == 'Bob Morane'; // is true
```

@babs, @buster what do you think about that :question:
"""
  # Specifications
  trying({
    return ghCli: createIssue(
      title="Container specification",
      body=SPEC_1,
      milestone=1,
      labels=["priority: high", "type: feature"],
      assignees=["babs"],
      owner=organizationName,
      repository=repositoryName
    )
  }): either(
    |issue| {
      # issue is a DynamicObject()
      # issueNumber, body, owner, repository
      babs: addCommentToIssue(
        issueNumber= issue: number(),
        body = "Hi @k33g, I' happy to :memo: on this project :octocat: :heart:",
        owner=organizationName,
        repository=repositoryName
      )
    },
    |error| -> println(error)
  )

  #-------------------------
  # Create some code
  #-------------------------
  let SOURCE_CODE_OF_CONTAINER = """
  /* Container */

  class Container {
    constructor(x) {
      const value = x;
      Object.defineProperty(this, 'value', { get: () => value })
    }

    static of(x) {
      return new Container(x);
    }
  }
  """

  let PR_BODY = """
  Hello :earth_africa: @ACME/toons

  Can you :eyes: my proposal please :question:

  ```javascript
  // Container
  let bob = Container.of('Bob Morane');
  ```
  """
  trying({
    # Create branch and pull request
    babs: createBranch(
      name="wip-container",
      from="master",
      owner=organizationName,
      repository=repositoryName
    )

    # commit file
    babs: createCommit(
      fileName="container.js",
      message="First Container version :octocat: :heart:",
      content= SOURCE_CODE_OF_CONTAINER,
      branch="wip-container",
      owner=organizationName,
      repository=repositoryName
    )

    # propose pull request
    babs: createPullRequest(
      title="Functor implementation proposal",
      body=PR_BODY,
      head="wip-container",
      base="master",
      owner=organizationName,
      repository=repositoryName
    )
  })


}
