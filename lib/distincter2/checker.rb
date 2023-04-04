module Distincter2
  # distincter2 checker.
  # Handles a file and operate them.
  class D2Checker
    # Mute if you don't want to see errors in output
    def initialize(mute: false)
      @mute = mute
    end

    # Check entrypoint.
    def check(path)
      duplicates = analyze_dir(path)
      exit(duplicates.empty? ? 0 : 1)
    end

    # Analyze given directory with recursion.
    # rubocop:disable Metrics/MethodLength
    def analyze_dir(path)
      duplicates = []
      ::Dir.foreach(path).each do |entry|
        next if entry.start_with?('.')

        file = "#{::File.absolute_path(path)}/#{::File.basename(entry)}"
        analyze_result = []
        if ::File.directory?(file)
          analyze_result = analyze_dir(file)
        else
          next unless entry.end_with?('.md')

          analyze_result = analyze_file(file)
        end
        duplicates += analyze_result unless analyze_result.empty?
      end
      duplicates
    end

    # rubocop:enable Metrics/MethodLength

    # Analyze given file.
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
