require "zeitwerk"
require "active_support/all"
require "cnc/core_ext"
require "cnc/version"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("cnc" => "CNC")
loader.ignore("#{__dir__}/cnc/core_ext")
loader.setup

ActiveSupport::Inflector.inflections { _1.acronym "CNC" }

module CNC
end
