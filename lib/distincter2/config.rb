# frozen_string_literal: true

require 'set'

module Distincter2
  # Distincter2 config.
  class D2Config
    # @param {String[]} exclude_paths
    def initialize(exclude_paths)
      @exclude_paths = exclude_paths.to_set
    end

    attr_accessor :exclude_paths
  end

  # D2Config with empty arguments.
  class D2ConfigEmpty < ::Distincter2::D2Config
    # Constructor without paths.
    def initialize
      super([])
    end
  end

  # D2Config parser.
  class D2ConfigParser
    # @param {String} config_path
    def initialize(config_path)
      @config_path = config_path
    end

    # @return {D2Config}
    def parse
      exclude_paths = []
      ::File.open(@config_path, 'r') do |file|
        exclude_paths += file.readlines.map(&:strip)
      end
      ::Distincter2::D2Config.new(exclude_paths)
    end
  end
end
