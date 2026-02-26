require "thor"

module CNC
  class CLI < Thor
    desc "version", "Print version"
    def version
      puts VERSION
    end
  end
end
