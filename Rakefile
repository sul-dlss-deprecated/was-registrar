# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

# Include rake tasks from lib/tasks directory
Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each {|f| load f }

task default: :ci

desc "run continuous integration suite (tests, coverage)"
task ci: :spec

begin
  require 'rspec/core/rake_task'
rescue LoadError
  STDERR.puts "Please install the rspec gem to run tests."
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.fail_on_error = true
  end
rescue LoadError
  STDERR.puts "Please install the rubocop gem to run rubocop."
end

# Use yard to build docs
begin
  require 'yard'
  require 'yard/rake/yardoc_task'
  project_root = File.expand_path(File.dirname(__FILE__))
  doc_dest_dir = File.join(project_root, 'doc')

  YARD::Rake::YardocTask.new(:doc) do |yt|
    yt.files = Dir.glob(File.join(project_root, 'lib', '**', '*.rb'))
    yt.options = ['--output-dir', doc_dest_dir, '--readme', 'README.rdoc', '--title', 'WAS Registrar Documentation']
  end
rescue LoadError
  STDERR.puts "Please install the YARD gem to generate rdoc."
end
