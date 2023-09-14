# distincter2

[![GitHubActions](https://github.com/fartem/distincter2/workflows/Build/badge.svg)](https://github.com/fartem/distincter2/actions?branch=master)
[![codebeat badge](https://codebeat.co/badges/69d6a564-ddda-495b-9e10-107bf7691fb0)](https://codebeat.co/projects/github-com-fartem-distincter2-master)
[![Gem Version](https://badge.fury.io/rb/distincter2.svg)](https://badge.fury.io/rb/distincter2)

## About

A tool that can check lists in Markdown files and find duplicates.

## How to use

### Global installation

```shell
$ gem i distincter2
$ distincter2 ./path_to_directory_with_markdown_files
```

### Local installation

```shell
$ ./bin/local_distincter2 ./path_to_directory_with_markdown_files
```

### Config

Add `distincter2_config.d2c` to root of your project and add excluded files line by line. Below you can find examples.

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

## Contributors

* [@fartem](https://github.com/fartem) as Artem Fomchenkov
