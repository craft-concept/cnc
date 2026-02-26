require "zeitwerk"
require "active_support/all"
require "cnc/core_ext"
require "cnc/version"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("cnc" => "CNC", "cli" => "CLI")
loader.ignore("#{__dir__}/cnc/core_ext.rb")
loader.ignore("#{__dir__}/cnc/core_ext")
loader.setup

ActiveSupport::Inflector.inflections do |i|
  i.acronym "CNC"
end

module CNC
end
