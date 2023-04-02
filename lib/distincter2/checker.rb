module Distincter2
  # disctinter2 checker.
  # Handles a file and operate them.
  class D2Checker
    # Check entrypoint.
    def check(path)
      duplicates = analyze_dir(path)
      exit(duplicates.empty? ? 0 : 1)
    end

    # Analyze given directory with resursion.
    # rubocop:disable Metrics/MethodLength
    def analyze_dir(path)
      duplicates = []
      ::Dir.foreach(path).each do |entry|
        next if entry.start_with?('.')

        file = "#{::File.absolute_path(path)}/#{::File.basename(entry)}"
        if ::File.directory?(file)
          duplicates << analyze_dir(file)
        else
          next unless entry.end_with?('.md')

          duplicates << analyze_file(file)
        end
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
      duplicates.each do |duplicate|
        output = "#{path} : #{duplicate}"
        puts(output)
      end
      duplicates
    end
    # rubocop:enable Metrics/MethodLength
  end
end
