require 'simplecov'            # These two lines must go first
SimpleCov.start

require_relative '../lib/distincter2/checker.rb'
require 'minitest/autorun'

class D2CheckerTest < Minitest::Test
  def test_valid_file
    checker = ::Distincter2::D2Checker.new
    duplicates = checker.analyze_file("#{Dir.pwd}/test_assets/valid_list.md")

    assert duplicates.empty?
  end

  def test_invalid_file
    checker = ::Distincter2::D2Checker.new
    duplicates = checker.analyze_file("#{Dir.pwd}/test_assets/invalid_list.md")

    assert !duplicates.empty?
  end
end
