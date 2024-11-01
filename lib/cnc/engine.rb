require "active_support"

module CNC
  class Engine < ::Rails::Engine
    isolate_namespace CNC
    config.autoload_paths += paths["lib"].to_a

    initializer "cnc.inflections" do
      ActiveSupport::Inflector.inflections { _1.acronym "CNC" }
    end
  end
end
