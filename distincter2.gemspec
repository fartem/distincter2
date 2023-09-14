# frozen_string_literal: true

require 'English'

::Gem::Specification.new do |s|
  s.required_ruby_version = '>= 3.0'
  s.name = 'distincter2'
  s.version = '1.3.1'
  s.license = 'MIT'
  s.files = ::Dir['lib/**/*.rb'] + %w[bin/distincter2 README.md LICENSE]
  s.executable = 'distincter2'
  s.require_paths << 'lib'
  s.summary = 'A tool that can check lists in Markdown files and find duplicates'
  s.authors = ['Artem Fomchenkov']
  s.email = 'artem.fomchenkov@outlook.com'
  s.homepage = 'https://github.com/fartem/distincter2'
  s.test_files = s.files.grep(%r{^(test)/})
  s.extra_rdoc_files = ['README.md']

  s.add_runtime_dependency('colorize', '0.8.1')

  s.add_development_dependency('minitest', '5.18.0')
  s.add_development_dependency('rake', '12.3.3')
  s.add_development_dependency('rubocop', '1.7.0')
  s.add_development_dependency('simplecov', '0.22.0')
end
