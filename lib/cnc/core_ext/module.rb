class Module
  # Shorthand for `const_set(name.camelize, Class.new(parent) { ... })`.
  # Useful when defining classes in macros.
  def define_class(name, parent = nil, &)
    name = name.to_s.camelize
    raise NameError, "class exists: #{name}" if const_defined?(name, false)
    const_set name, Class.new(parent, &)
  end

  # Defines a constant of the given name using the given block if it doesn't
  # already exist.
  def const_cache(name)
    name = name.to_s.gsub('::', ?_)
    const_defined?(name, false) ? const_get(name) : const_set(name, yield(name))
  end
end
