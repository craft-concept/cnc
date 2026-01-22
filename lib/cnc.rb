require "zeitwerk"
require "cnc/core_ext"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("cnc" => "CNC")
loader.setup

require "cnc/version"
require "cnc/engine" if defined? Rails

module CNC
end
