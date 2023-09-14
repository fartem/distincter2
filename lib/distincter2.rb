# frozen_string_literal: true

require_relative './distincter2/checker'
require_relative './distincter2/config'

module Distincter2
  # distincter2 runner. Just an entrypoint.
  class Distincter2
    #
    # You need a project path to run validation.
    def start(path)
      config_path = "#{path}/distincter2_config.d2c"
      checker = ::Distincter2::D2Checker.new(
        if ::File.exist?(config_path)
          ::Distincter2::D2ConfigParser.new(config_path).parse
        else
          ::Distincter2::D2ConfigEmpty.new
        end
      )
      checker.check(path)
    end
  end
end
