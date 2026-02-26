class Symbol
  def underscore    = to_s.underscore.to_sym
  def camelize(...) = to_s.camelize(...).to_sym
  def chomp(...)    = to_s.chomp(...).to_sym
end
