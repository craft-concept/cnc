module CNC
  class Engine < ::Rails::Engine
    isolate_namespace CNC

    initializer 'setup_inflections' do
      ActiveSupport::Inflector.inflections {|inflect| inflect.acronym 'CNC' }
    end
  end
end
