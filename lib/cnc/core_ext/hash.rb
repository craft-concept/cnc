# frozen_string_literal: true

class Hash
  # Removes and returns a hash containing the key/value pairs for which the
  # block returns a true value given the key.
  #
  #   hash = {:a => 1, "b" => 2, :c => 3}
  #   hash.extract_if! { _1.is_a? Symbol } #=> {a: 1, c: 3}
  #   hash                                 #=> {"b" => 2 }
  def extract_if!
    each_with_object(self.class.new) do |(key, value), result|
      result[key] = delete(key) if yield(key, value)
    end
  end

  # Destructively converts all values at the given keys using the given block.
  #
  #   hash = {a: 1, b: 2, c: 3}
  #   hash.transform!(:c, &:succ)
  #   hash #=> {a: 1, b: 2, c: 4}
  #
  def transform!(*keys)
    keys.each do |k|
      self[k] = yield self[k] if key?(k)
    end
    self
  end

  # Returns a new hash with all values at the given keys converted using the
  # given block.
  #
  #   hash = {a: 1, b: 2, c: 3}
  #   hash.transform(:a, :b, &:succ) #=> {a: 2, b: 3, c: 3}
  def transform(...) = dup.transform!(...)
end
