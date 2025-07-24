# Contributing to FusionAuth Homebrew Tap
<!--
tag::forDocSiteContributing[]
-->
Thank you for your interest in contributing to FusionAuth Homebrew! This document provides guidelines and instructions for contributing to this project.

Please only report issues for the FusionAuth Homebrew itself if you have an issue with documentation, a client library or fusionauth itself follow [these instructions.](https://github.com/FusionAuth/fusionauth-issues)

## About This Project

This repository contains Homebrew formulae for installing FusionAuth on macOS systems. The goal is to make it easy for macOS users to install, configure, and update FusionAuth using the Homebrew package manager.

## Community Guidelines

As part of the FusionAuth community, please abide by [the Code of Conduct](https://fusionauth.io/community/forum/topic/1000/code-of-conduct).

## Reporting Issues

If you encounter any problems with the Homebrew formulae or have suggestions for improvements:

Before reporting an issue, please search through the already open issues to see if you could contribute.

To report an issue, please follow the instructions of the bug, feature and general issue templates.

## Contributing Features and Fixes

Before starting with contributing, you'll want to look at and choose an issue to work on. Here is a basic workflow you want to work from:

1. Search the issue tracker for an issue that you want to work on. If your issue does not exist, please create a new one.
2. Search GitHub for an open or closed Pull Request that relates to the issue you want to work on. You may find that someone else is already working on it, or that the issue is already resolved in a different branch.

You can find all the open issues [here](https://github.com/fusionauth/homebrew-fusionauth/issues).

Once you have found an issue you want to work on, we suggest to:

1. Fork the repository to your personal account.
2. Create a new branch with the name fix/issue-id or feat/issue-id.
3. And start working on that branch on the issue.

### Pull Requests

We welcome contributions via pull requests. Here's how to submit a PR:

1. Fork the repository
2. Create a new branch for your changes
3. Make your changes
4. Test your changes thoroughly (see Testing section below)
5. Submit a pull request to the `develop` branch
6. Describe your changes in detail in the PR description

When you are ready to submit your pull request, visit the main repository on GitHub and click the "Compare & pull request" button. Here you can select the branch you have been working on and create a pull request.

If you're creating a pull request for an issue, please include `Closes #XXX` in the message body where `#XXX` is the issue you're fixing. For example, `Closes #42` would close issue #42.

After you have submitted your pull request, several checks will be run to ensure the changes meet the project's guidelines. If they do, the pull request will be reviewed by a maintainer and subsequently merged.

### Code Style

- Follow the existing code style in the repository
- Keep formula definitions clean and minimal
- Include comments where necessary to explain complex operations

## Testing

Before submitting a pull request, please test your changes:

1. Install the formula locally using `brew install --formula ./Formula/fusionauth-app.rb`
2. Verify that the installation completes successfully
3. Start the service using `brew services start fusionauth-app`
4. Verify that the service starts correctly and is accessible at http://localhost:9011
5. Check the logs for any errors using `cat $(brew --prefix)/var/log/fusionauth/fusionauth-app.log`
5. Stop the service using `brew services stop fusionauth-app`

For more comprehensive testing, you can refer to the workflow defined in `.github/workflows/e2e-test.yml`, which tests the formula on different macOS versions and PostgreSQL versions.

## Questions?

If you have any questions about contributing, feel free to open an issue asking for clarification.

Thank you for helping to improve FusionAuth's Homebrew.
<!--
end::forDocSiteContributing[]
-->

# Release
<!--
tag::forDocSiteRelease[]
-->
The maintainers manage the release process. If you have questions about the release process, please open an issue.

## Release Process

If you're a maintainer, you can release a new version using:

Using Savant
```bash
sb publish
```

Without using Savant
```bash
./publish.sh <version>
```
<!--
end::forDocSiteRelease[]
-->