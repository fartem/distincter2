require 'rake/clean'

task default: %i[clean rubocop]

desc 'Run RuboCop'
require 'rubocop/rake_task'
::RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end
