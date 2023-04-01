module Distincter2
  # disctinter2 checker.
  # Handles a file and operate them.
  class D2Checker
    # Check entrypoint.
    def check(path)
      lines = []
      ::File.open(path, 'r') do |file|
        file.each_line do |line|
          lines << line if !line.empty? && line.start_with?('-')
        end
      end
      duplicates = lines.select { |line| lines.count(line) > 1 }
                        .uniq
      duplicates.each { |duplicate| puts(duplicate) }
      exit(duplicates.empty? ? 0 : 1)
    end
  end
end
