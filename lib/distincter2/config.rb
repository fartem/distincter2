# frozen_string_literal: true

require 'set'

module Distincter2
  # Class representing the configuration for Distincter2.
  class D2Config
    # Initializes a new instance of D2Config.
    #
    # @param exclude_paths [Array<String>] An array of paths to be excluded.
    # @param version [String] The version of the configuration. Default is 'v1'.
    def initialize(exclude_paths, version = 'v1')
      @exclude_paths = exclude_paths.to_set
      @version = version
    end

    # Accessor for the exclude_paths attribute.
    #
    # @return [Set<String>] The set of paths to be excluded.
    attr_accessor :exclude_paths

    # Accessor for the version attribute.
    #
    # @return [String] The version of the configuration.
    attr_accessor :version
  end

  # Class representing an empty configuration for Distincter2.
  # This class inherits from D2Config and initializes with an empty array of exclude_paths.
  class D2EmptyConfig < ::Distincter2::D2Config
    # Constructor without paths.
    #
    # @return [void]
    def initialize
      # Calls the parent class's initialize method with an empty array of exclude_paths.
      super([])
    end
  end

  # Class representing a parser for Distincter2 configuration files.
  class D2ConfigParser
    # Initializes a new instance of D2ConfigParser.
    #
    # @param config_path [String] The path to the configuration file.
    def initialize(config_path)
      @config_path = config_path
    end

    # Parses the configuration file and returns a D2Config object.
    #
    # @return [Distincter2::D2Config] A D2Config object representing the parsed configuration.
    def parse
      exclude_paths = []
      version = 'v1'

      # Open the configuration file and read its lines.
      ::File.open(@config_path, 'r') do |file|
        file.readlines.each do |line|
          l = line.strip

          # Skip lines that contain the version number or are empty.
          next if l == 'v1' || l.empty?

          # Add the non-empty, non-version lines to the exclude_paths array.
          exclude_paths << l
        end
      end

      # Create a new D2Config object with the parsed exclude_paths and version.
      ::Distincter2::D2Config.new(exclude_paths, version)
    end
  end
end
