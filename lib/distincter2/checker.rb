# frozen_string_literal: true

module Distincter2
  # Class to check for duplicate lines in markdown files
  class D2Checker
    # Initialize the D2Checker with a configuration object and an optional mute flag
    #
    # @param config [Object] The configuration object containing settings for the checker
    # @param mute [Boolean] A flag indicating whether to mute the output of duplicate lines (default: false)
    def initialize(config, mute: false)
      @config = config
      @mute = mute
    end

    # Check for duplicate lines in markdown files within a given directory
    #
    # @param path [String] The path to the directory to check
    # @return [Array] An array of duplicate lines found in the markdown files
    def check(path)
      duplicates = analyze_dir(path)

      exit(duplicates.empty? ? 0 : 1)
    end

    # Recursively analyze a directory for duplicate lines in markdown files
    #
    # @param path [String] The path to the directory to analyze
    # @return [Array] An array of duplicate lines found in the markdown files
    def analyze_dir(path)
      duplicates = []
      ::Dir.foreach(path).each do |entry|
        next if entry.start_with?('.')

        entry_name = ::File.basename(entry)

        file = "#{::File.absolute_path(path)}/#{entry_name}"
        if ::File.directory?(file)
          analyze_result = analyze_dir(file)
        else
          next unless entry.end_with?('.md')

          next unless can_analyze(entry_name)

          analyze_result = analyze_file(file)
        end

        duplicates += analyze_result unless analyze_result.empty?
      end

      duplicates
    end

    # Check if a file can be analyzed based on the configuration settings
    #
    # @param entry [String] The name of the file to check
    # @return [Boolean] True if the file can be analyzed, false otherwise
    def can_analyze(entry)
      return false unless @config.version == 'v1'

      @config.exclude_paths.none?(entry)
    end

    # Analyze a markdown file for duplicate lines
    #
    # @param path [String] The path to the markdown file to analyze
    # @return [Array] An array of duplicate lines found in the markdown file
    def analyze_file(path)
      lines = []
      ::File.open(path, 'r') do |file|
        file.each_line do |line|
          lines << line if !line.empty? && line.start_with?('-')
        end
      end

      duplicates = lines.select { |line| lines.count(line) > 1 }
                        .uniq
      unless @mute
        duplicates.each do |duplicate|
          puts("#{path} : #{duplicate}")
        end
      end

      duplicates
    end
  end
end
