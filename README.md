# Crystal CoffeeScript

[![GitHub version](https://badge.fury.io/gh/jessedoyle%2Fcoffee-script.svg)](https://badge.fury.io/gh/jessedoyle%2Fcoffee-script)
[![Build Status](https://travis-ci.org/jessedoyle/coffee-script.svg)](https://travis-ci.org/jessedoyle/coffee-script)

This shard is a Crystal bridge to the official CoffeeScript compiler.

```crystal
require "coffee-script"

CoffeeScript.compile(File.read("script.coffee")) # => compiled code
```

The code in this library is a direct port of Ruby's [coffee-script](https://github.com/rails/ruby-coffee-script) gem.

## Installation

Add this to your project's `shard.yml`:

```yaml
dependencies:
  coffee-script:
    github: jessedoyle/coffee-script
    version: ~> 1.0
```

then execute `shards install`.

## Configuration

You can use an alternate CoffeeScript compiler version by setting the `COFFEESCRIPT_SOURCE_PATH` environment variable:

```bash
export COFFEESCRIPT_SOURCE_PATH=/my/custom/path/coffee-script.js
```

The `compile` method also accepts additional arguments that may be passed to the runtime:

```crystal
src = File.read("script.coffee")

CoffeeScript.compile(src, { bare: true }) # => compiled code
```

## Dependencies

This library depends on the [coffee-script-source](https://github.com/jessedoyle/coffee-script-source) shard, please see the [releases page](https://github.com/jessedoyle/coffee-script-source/releases) for compiler versions.

This library uses [duktape.cr](https://github.com/jessedoyle/duktape.cr) as the javascript runtime.

## License

Distributed under the MIT License. See `LICENSE` for details.
