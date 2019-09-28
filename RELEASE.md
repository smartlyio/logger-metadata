## Release process

logger-metadata uses [Semantic Versioning](https://semver.org).

Use `bundle exec rake release:major`, `bundle exec rake release:minor`, or `bundle exec release bump:patch` to change the version (in master branch). This will make a commit to bump version, and push it back to GitHub. Github actions then publishes the gem to rubygems.org.
