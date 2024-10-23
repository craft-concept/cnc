module CNC
  class Engine < ::Rails::Engine
    isolate_namespace CNC

    initializer "cnc.inflections" do
      ActiveSupport::Inflector.inflections { _1.acronym "CNC" }
    end
  end
end
