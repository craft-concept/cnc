require "test_helper"
require "cnc/core_ext/module"

class ModuleTest < ActiveSupport::TestCase
  module Foo
  end

  class Animal
    def self.legs(n = @legs) = @legs = n
  end

  test "const_cache" do
    Foo.const_cache(:BAR) { 1 }

    assert_equal 1, Foo::BAR

    Foo.const_cache(:BAR) { 2 }

    assert_equal 1, Foo::BAR
  end

  test "define_class simple" do
    Foo.define_class(:bar)

    assert Foo::Bar
  end

  test "define_class macros" do
    Foo.define_class(:baz, attr_reader: :x)

    assert Foo::Baz.instance_method(:x)
  end

  test "define_class parent" do
    Foo.define_class("cat", Animal, legs: 4)

    assert_equal 4, Foo::Cat.legs
  end

  test "define_class block" do
    Foo.define_class(:Bird, Animal, legs: 2) do
      def self.beak = true
    end

    assert_equal 2, Foo::Bird.legs
    assert Foo::Bird.beak
  end

  test "define_class repeat" do
    Foo.define_class(:repeat)

    assert_raise NameError do
      Foo.define_class(:repeat)
    end
  end
end
