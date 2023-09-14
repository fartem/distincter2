# frozen_string_literal: true

require 'set'

module Distincter2
  # Distincter2 config.
  class D2Config
    # @param {String[]} exclude_paths
    # @param {String} version
    def initialize(exclude_paths, version = 'v1')
      @exclude_paths = exclude_paths.to_set
      @version = version
    end

    attr_accessor :exclude_paths, :version
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
    # rubocop:disable Metrics/MethodLength
    def parse
      exclude_paths = []
      version = 'v1'
      ::File.open(@config_path, 'r') do |file|
        file.readlines.each do |line|
          l = line.strip

          next if l == 'v1'

          next if l.empty?

          exclude_paths << l
        end
      end
      ::Distincter2::D2Config.new(exclude_paths, version)
    end
    # rubocop:enable Metrics/MethodLength
  end
end
