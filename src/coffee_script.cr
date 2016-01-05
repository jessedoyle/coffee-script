require "duktape/runtime"
require "coffee-script-source"

module CoffeeScript
  module Source
    COMPILE_FUNCTION = <<-JS
      ;function compile(script, options) {
        try {
          return CoffeeScript.compile(script, options);
        } catch (err) {
          if (err instanceof SyntaxError && err.location) {
            throw new SyntaxError([
              err.filename || "[stdin]",
              err.location.first_line + 1,
              err.location.first_column + 1
            ].join(":") + ": " + err.message)
          } else {
            throw err;
          }
        }
      }
    JS

    def self.contents
      @@contents ||= File.read(path) + COMPILE_FUNCTION
    end

    def self.context
      @@context ||= Duktape::Runtime.new &.eval!(Source.contents)
    end

    def self.path
      @@path ||= ENV["COFFEESCRIPT_SOURCE_PATH"]? || bundled_path
    end

    def self.path=(path : String)
      @@content = nil
      @@version = nil
      @@context = nil
      @@path = path
    end

    def self.version
      @@version ||= contents[/CoffeeScript Compiler v([\d.]+)/, 1]
    end
  end

  def self.compile(script : String, *opts)
    Source.context.call("compile", script, *opts)
  end
end
