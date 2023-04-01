module Distincter2
  # disctinter2 checker.
  # Handles a file and operate them.
  class D2Checker
    # Check entrypoint.
    def check(path)
      ::File.open(path, 'r') do |file|
        file.each_line do |line|
          puts(line)
        end
      end
    end
  end
end
