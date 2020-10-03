# memc : A minimal Memcached CLI for scripting and debugging

A memcached CLI for developers trying to debug caching issues.

![CI](https://github.com/eoinkelly/memc/workflows/CI/badge.svg)

## Overview

* A single Ruby script.
* Uses Ruby core & standard library only - no gems required!
* Designed to be easy to "install" (via `curl`) onto whatever server/container can reach the memcached server you care about.
* Runs under Ruby 2.0.0 or later so should run on old Linux distros
* Designed to lean on, and play nicely with standard unix tools e.g. `memc` does not implement filtering because `grep`/`sed`/`awk` already provide that.
* MIT licensed

## Installation

`memc` is designed to be easy to install for "casual" use e.g. you need it in your VM/container to debug some issues but you don't want the hassle of installing it "properly". Of course, you are welcome to install it "properly" if you wish :smile:

```bash
$ cd path/to/where/you/want/to/put/this
$ curl -O https://raw.githubusercontent.com/eoinkelly/memc/main/memc
$ chmod u+x ./memc
$ ./memc
```

## Usage

```plain
memc SERVER_HOST:SERVER_PORT help        # show help
memc SERVER_HOST:SERVER_PORT ls          # list all keys
memc SERVER_HOST:SERVER_PORT ls-l        # list all keys and their sizes (in bytes)
memc SERVER_HOST:SERVER_PORT get KEYNAME # get the value associated with KEYNAME
memc SERVER_HOST:SERVER_PORT stats       # show human readable stats
memc SERVER_HOST:SERVER_PORT all-stats   # show all stats (raw format)
```

## Examples

```bash
# See human readable stats about the server
$ memc localhost:11211 stats

# See a list of all keys on the server
$ memc localhost:11211 ls

# Find all keys which contain 'aaa' and do not contain 'bbb'
$ memc localhost:11211 ls | grep "aaa" | grep -v "bbb"

# List key names and their size in bytes (separated by whitespace)
$ memc localhost:11211 ls-l

# show 10 largest keys
$ memc localhost:11211 ls-l | sort -n -k 2,2 | tail

# show 10 smallest keys
$ memc localhost:11211 ls-l | sort -n -k 2,2 | head

# Get the value associated with a key
$ memc localhost:11211 get some-key-name

# Save the value associated with a key into the 'output.txt' file
$ memc localhost:11211 get some-key-name > output.txt
```

## Alternatives

Memcached has client libraries for almost every programming stack but not many clients designed for use on the command line. I was able to find the following:

* [memcached-cli](https://www.npmjs.com/package/memcached-cli)
    * Interactive use only
    * Written in JS, install via `npm`
    * Has more features than this script
* [memclient](https://github.com/jorisroovers/memclient)
    * Written in Go
    * Install binary via `curl`/`wget`
    * Has more features than this script
    * As of 2020-10-03 it doesn't seem to be under active development/maintenance

This script is functional and meets my needs but you may prefer to use one of those, especially if your environments don't already have Ruby installed.
