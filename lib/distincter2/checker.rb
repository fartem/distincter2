# frozen_string_literal: true

module Distincter2
  # distincter2 checker.
  # Handles a file and operate them.
  class D2Checker
    # @param {D2Config} config
    # @param {Boolean} mute
    def initialize(config, mute: false)
      @config = config
      @mute = mute
    end

    # @param {String} path
    def check(path)
      duplicates = analyze_dir(path)

      exit(duplicates.empty? ? 0 : 1)
    end

    # @param {String} path
    # @return {String[]}
    # rubocop:disable Metrics/MethodLength
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

          next if @config.exclude_paths.include?(entry_name)

          analyze_result = analyze_file(file)
        end

        duplicates += analyze_result unless analyze_result.empty?
      end

      duplicates
    end

    # rubocop:enable Metrics/MethodLength

    # @param {String} path
    # @return {String[]}
    # rubocop:disable Metrics/MethodLength
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

    # rubocop:enable Metrics/MethodLength
  end
end
