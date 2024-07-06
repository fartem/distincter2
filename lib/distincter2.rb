# frozen_string_literal: true

require_relative './distincter2/checker'
require_relative './distincter2/config'

module Distincter2
  # distincter2 runner. Just an entrypoint.
  # This class represents the main entry point for the Distincter2 runner.
  class Distincter2
    # This method starts the validation process for a given project path.
    #
    # @param path [String] The path to the project directory.
    # @return [void]
    #
    # @example
    #   # Create an instance of Distincter2
    #   distincter = Distincter2.new
    #
    #   # Start the validation process for a project located at '/path/to/project'
    #   distincter.start('/path/to/project')
    def start(path)
      # Construct the path to the distincter2_config.d2c file
      config_path = "#{path}/distincter2_config.d2c"

      # Create a new D2Checker instance with the appropriate configuration
      checker = ::Distincter2::D2Checker.new(
        if ::File.exist?(config_path)
          # If the config file exists, parse it and use the parsed configuration
          ::Distincter2::D2ConfigParser.new(config_path).parse
        else
          # If the config file does not exist, use an empty configuration
          ::Distincter2::D2EmptyConfig.new
        end
      )

      # Run the validation process using the checker
      checker.check(path)
    end
  end
end
