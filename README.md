# GitMotor App

GitMotor is an app for getting information from a GitHub account.
It uses the official GitHub GraphQL endpoint.

# Features of the App

- List all of the available repositories to the authenticated user
- Ability to Star a repository
- Ability to Watch & Unwatch a Repository
- Select a repo to see more details about
  - Code Tab
    - View the most recent commits
    - List all of the collaborators
    - View the most recent releases
  - Issues Tab to see the most recent Open & Closed Issues
  - Pull Requests to see the most recent Open & Closed Issues

# List of Requirements

- Xcode 11 or later
- Access to a GitHub account

# Quick instructions to run the app

- If you don't have a personal access token;
  - Go to [Tokens page](https://github.com/settings/tokens)
  - Make sure to select the needed options [View Image](https://cln.sh/jOr3Bl)
- Edit the "Schema" of the app target; make sure to set the Personal Access token to the Environment Variable. [Image example](https://cln.sh/KI8iYH)
- Run the app; enjoy

# Notes

- This is only an MVP and the app can contain bugs and not be stable :)
