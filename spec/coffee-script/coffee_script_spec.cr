require "../spec_helper"

describe CoffeeScript do
  describe "compile" do
    it "compiles hello world" do
      code = CoffeeScript.compile("puts 'Hello, World!'")

      code.should eq("(function() {\n  puts('Hello, World!');\n\n}).call(this);\n")
    end

    context "with { bare: false }" do
      it "compiles hello world" do
        code = CoffeeScript.compile("puts 'Hello, World!'", {bare: false})

        code.should eq("(function() {\n  puts('Hello, World!');\n\n}).call(this);\n")
      end
    end

    context "with { bare: true }" do
      it "compiles hello world" do
        code = CoffeeScript.compile("puts 'Hello, World!'\n", {bare: true})

        code.should eq("puts('Hello, World!');\n")
      end
    end

    context "with { sourceMap: true }" do
      it "returns a hash containing the code and source map" do
        src = <<-COFFEE
          # Assignment:
          number   = 42
          opposite = true

          # Conditions:
          number = -42 if opposite

          # Functions:
          square = (x) -> x * x

          # Arrays:
          list = [1, 2, 3, 4, 5]

          # Objects:
          math =
            root:   Math.sqrt
            square: square
            cube:   (x) -> x * square x

          # Splats:
          race = (winner, runners...) ->
            print winner, runners

          # Existence:
          alert "I knew it!" if elvis?

          # Array comprehensions:
          cubes = (math.cube num for num in list)
        COFFEE

        hash = CoffeeScript.compile(src, {sourceMap: true}) as Hash
        code = hash["js"] as String
        map = hash["sourceMap"] as Hash

        code.should be_a(String)
        code.size.should_not eq(0)
        map.should be_a(Hash(String, Duktape::JSPrimitive))
        map.size.should eq(1)
      end
    end

    it "displays compilation errors" do
      src = <<-EOS
        sayHello = ->
          console.log "hello, world"
          unless
      EOS

      expect_raises(Duktape::SyntaxError, /unexpected unless/) do
        CoffeeScript.compile(src)
      end
    end
  end
end
