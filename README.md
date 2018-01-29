# Cookie Box

[![CircleCI](https://circleci.com/gh/davydovanton/cookie_box.svg?style=svg)](https://circleci.com/gh/davydovanton/cookie_box)

See and manage all issues for specific repos in one place.

## Setup

How to run tests:

```
% bundle exec rspec
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```
