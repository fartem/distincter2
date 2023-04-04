require_relative './distincter2/checker'

module Distincter2
  # distincter2 runner. Just an entrypoint.
  class Distincter2
    # distincter2 starter.
    # You need a project path to run validation.
    def start(path)
      checker = ::Distincter2::D2Checker.new
      checker.check(path)
    end
  end
end
