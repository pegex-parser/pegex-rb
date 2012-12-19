# Load gem constants from the gemspec
load FileList['*.gemspec'][0] ||
  fail('No *.gemspec file found')
Name = $gemspec.name
Version = $gemspec.version
Gemname = "#{Name}-#{Version}"
Gemfile = "#{Gemname}.gem"
Devnull = '2>/dev/null'

# Require the Rake libraries
require 'rake'
require 'rake/testtask'
require 'rake/clean'

task :default => 'help'

CLEAN.include Gemname, Gemfile, 'data.tar.gz', 'metadata.gz'

desc 'Run the tests'
task :test do
  Rake::TestTask.new do |t|
    t.verbose = true
    t.test_files = FileList['test/*.rb']
  end
end

desc 'Build the gem'
task :build => [:clean, :test] do
  sh 'gem build *.gemspec'
end

desc 'Build, unpack and inspect the gem'
task :dir => [:build] do
  sh "tar xf #{Gemfile} #{Devnull}"
  Dir.mkdir Gemname
  Dir.chdir Gemname
  sh "tar xzf ../data.tar.gz #{Devnull}"
  puts "\n>>> Entering sub-shell for #{Gemname}..."
  system ENV['SHELL']
end

desc 'Build and push the gem'
task :release => [:build] do
  puts "gem push #{Gemfile}"
end

desc 'Print a description of the gem'
task :desc do
  puts "#{Name}-#{Version}"
  puts
  puts $gemspec.description.gsub /^/, '  '
end

desc 'List the Rakefile tasks'
task :help do
  puts 'The following rake tasks are available:'
  puts
  puts `rake -T`.gsub /^/, '  '
end
