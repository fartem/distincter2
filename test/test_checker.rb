require 'simplecov' # These two lines must go first
SimpleCov.start

require_relative '../lib/distincter2/checker'
require_relative '../lib/distincter2/config'

require 'minitest/autorun'

class D2CheckerTest < Minitest::Test
  def test_valid_file
    checker = ::Distincter2::D2Checker.new(::Distincter2::D2ConfigEmpty.new)
    duplicates = checker.analyze_file("#{Dir.pwd}/test_assets/valid/valid_list.md")

    assert duplicates.empty?
  end

  def test_invalid_file
    checker = ::Distincter2::D2Checker.new(::Distincter2::D2ConfigEmpty.new)
    duplicates = checker.analyze_file("#{Dir.pwd}/test_assets/invalid/invalid_list.md")

    assert !duplicates.empty?
  end

  def test_checker_with_config
    path = "#{Dir.pwd}/test_assets/config"
    checker = ::Distincter2::D2Checker.new(
      ::Distincter2::D2ConfigParser.new("#{path}/distincter2_config.d2c").parse,
    )
    duplicates = checker.analyze_dir(path)

    assert duplicates.empty?
  end

  def test_checker_with_inner_dirs
    path = "#{Dir.pwd}/test_assets/dirs"
    checker = ::Distincter2::D2Checker.new(::Distincter2::D2ConfigEmpty.new)
    duplicates = checker.analyze_dir(path)

    assert duplicates.empty?
  end
end
