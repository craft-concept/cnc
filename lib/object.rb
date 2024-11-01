Object.class_eval do
  def rubymine(file, line = 0)
    puts "rubymine --line #{line || 0} #{file} "
    system("rubymine --line #{line || 0} #{file} ")
  end

  def locate_method(name)
    method(name)
  rescue NameError
    instance_method(name)
  end

  def vim(method_name = nil)
    if method_name
      file, line = locate_method(method_name).source_location
    elsif is_a?(Method)
      file, line = source_location
    elsif is_a?(Module)
      file, line = module_parent.const_source_location(name)
    else
      raise "What is this? I can't edit this..."
    end

    # return system("tmux split-window -h \"vim #{file} +#{line}\"") if file
    # return system("$VISUAL --goto #{file}:#{line || 0}") if file
    return rubymine(file, line || 0) if file

    puts 'Source not available. Is this a C extension?'
  end
end
