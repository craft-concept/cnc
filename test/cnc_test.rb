require "test_helper"

class CNCTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert CNC::VERSION
  end

  test "eager load" do
    assert Zeitwerk::Loader.eager_load_all
  end
end
