# memc : A Memcached CLI for Developers

A memcached CLI for developers trying to debug caching issues.

### Status

Functional but super raw. I knocked this together quickly to help me debug issues on a project. YMMV

### Background

* A single Ruby script. Designed to be easy to "install" (via `curl`) onto whatever server/container can reach the memcached server you care about.
* Uses Ruby core & standard library only - no gems required!
* Runs under Ruby 2.0.0 or later so should run on old Linux distros
* Designed to lean on and play nicely with other unix tools e.g. `memc` does not implement filtering because `grep`/`sed`/`awk` already provide more features there than I care to implement.
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
memc SERVER_HOST:SERVER_PORT help        # show help
memc SERVER_HOST:SERVER_PORT ls          # list all keys
memc SERVER_HOST:SERVER_PORT ls-l        # list all keys and their sizes (in bytes)
memc SERVER_HOST:SERVER_PORT get KEYNAME # get the value associated with KEYNAME
memc SERVER_HOST:SERVER_PORT stats       # show human readable stats
memc SERVER_HOST:SERVER_PORT all-stats   # show all stats (raw format)
```

### Examples

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
