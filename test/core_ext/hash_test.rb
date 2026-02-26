require "test_helper"
require "cnc/core_ext/hash"

class HashTest < ActiveSupport::TestCase
  def test_extract_if!
    hash = {:a => 1, "b" => 2, :c => 3}

    assert_equal({a: 1, c: 3}, hash.extract_if! { _1.is_a? Symbol })
    assert_equal({"b" => 2}, hash)
  end

  def test_transform!
    hash = {a: 1, b: 2, c: 3}
    hash.transform!(:c, &:succ)

    assert_equal({a: 1, b: 2, c: 4}, hash)
  end

  def test_transform
    hash = {a: 1, b: 2, c: 3}

    assert_equal({a: 2, b: 3, c: 3}, hash.transform(:a, :b, &:succ))
  end
end
