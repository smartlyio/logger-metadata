## Release process

logger-metadata uses [Semantic Versioning](https://semver.org).

The repository uses Github Actions to automatically release new versions of the appropriate packages when labeled PRs get merged to master. For triggering an automatic release, you can add the `major`, `minor` or `patch` label to the PR in Github. The publish action will bump the package versions and publish a new release accordingly upon merge to master. You can follow the publish process on the Github `Actions` tab. The packages are published to rubygems.org.

If you want to merge a PR without a new release use a `norelease` label.