require "test_helper"
require "cnc/core_ext/uri"

class UriTest < ActiveSupport::TestCase
  def test_params
    uri = URI("?a=b&c")

    assert_equal({}, URI("").params)
    assert_equal({"a" => "b", "c" => nil}, uri.params)
  end

  def test_compare_path_less
    assert_operator URI("/foo"), :<=, URI("/foo")
    assert_operator URI("/foo"), :<=, URI("/foo/bar")
    assert_operator URI("/foo"), :<, URI("/foo/bar")
    assert_operator URI("/foo/bar"), :>=, URI("/foo")
    assert_operator URI("/foo/bar"), :>, URI("/foo")
  end

  def test_compare_params
    assert_operator URI("/foo?a=1"), :<=, URI("/foo?a=1")
    assert_operator URI("/foo"), :<, URI("/foo?a=1")
  end
end
