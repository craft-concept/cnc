class Object
  def instance_variable_values
    instance_variables.map { instance_variable_get _1 }
  end

  def system_echo(src)
    puts src
    system(src)
  end

  def rubymine(file, line = 0)
    system_echo("rubymine --line #{line || 0} #{file}")
  end

  def vscode(file, line = 0)
    system_echo("code #{file}:#{line || 0}")
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
    return vscode(file, line || 0) if file

    puts 'Source not available. Is this a C extension?'
  end
end
