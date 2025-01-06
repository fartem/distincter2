# distincter2

[![GitHubActions](https://github.com/fartem/distincter2/workflows/Build/badge.svg)](https://github.com/fartem/distincter2/actions?branch=master)
[![codebeat badge](https://codebeat.co/badges/69d6a564-ddda-495b-9e10-107bf7691fb0)](https://codebeat.co/projects/github-com-fartem-distincter2-master)
[![Gem Version](https://badge.fury.io/rb/distincter2.svg)](https://badge.fury.io/rb/distincter2)

## About

A tool that can check lists in Markdown files and find duplicates.

## How to use

You need to install `distincter2` from [RubyGems](https://rubygems.org/gems/distincter2) by next command:

```shell
$ gem i distincter2
```
After that, run `distincter2` from any place with a path to your markdown files as parameter:

```shell
$ distincter2 ./path_to_directory_with_markdown_files
```

### Config

Add `.d2_config.d2c` to root of your project and add excluded files line by line. Below you can find examples.

#### v1

Provides basic list for excluding files by names (without directories).

Add `v1`:

```text
v1

BOOKS.md
DONE.md
```

Or without `v1`:

```text
BOOKS.md
DONE.md
```

## Documentation

You can generate documentation locally by next command from root of the project:

```shell
$ rdoc
```

## How to contribute

Read [Commit Convention](./COMMIT_CONVENTION.md). Make sure your build is green before you contribute your pull request.
Then:

```shell
$ bundle exec rake
```

If you don't see any error messages, submit your pull request.

## Contributors

* [@fartem](https://github.com/fartem) as Artem Fomchenkov
