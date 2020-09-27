# memc : A developers Memcached CLI

A memcached CLI for developers trying to debug caching issues.

### Status

Functional but super raw. I knocked this together quickly to help me debug issues on a project. YMMV

### Background

* A single Ruby script. Designed to be easy to copy & paste onto whatever server/container can reach the memcached server you care about.
* Ruby core & standard lib only - no gems required.
* Runs under Ruby 2.0.0 or later so should run on old Linux distros
* Designed to play nicely with other unix tools e.g. `memc` does not implement filtering because `grep`/`sed`/`awk` already provide more features there than I care to implement.
* MIT licensed

### Installation

```bash
$ cd path/to/where/you/want/to/put/this
$ curl -O https://raw.githubusercontent.com/eoinkelly/memc/main/memc
$ chmod u+x ./memc
$ ./memc
```

### Usage

```bash
memc SERVER_URL help        # show help
memc SERVER_URL ls          # list all keys
memc SERVER_URL get KEYNAME # get the value associated with KEYNAME
memc SERVER_URL stats       # show human readable stats
memc SERVER_URL all-stats   # show all stats
```

### Examples

```bash
$ memc localhost:11211 stats
$ memc localhost:11211 ls
$ memc localhost:11211 ls | grep "interesting-thing"
$ memc localhost:11211 get some-key-name
```
