require 'rubygems'
require 'rspec'
require 'rspec/core/rake_task'

desc "Run all examples"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w[--color]
end

desc "Tag"
task :tag do
  gem_name = Glued::NAME
  gem_version = Glued::VERSION

  puts ""
  print "Are you sure you want to tag #{gem_name} #{gem_version}? [y/N] "
  exit unless STDIN.gets.index(/y/i) == 0

  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end

  sh "git tag v#{gem_version}"
  sh "git push origin v#{gem_version}"
end

task :t => [:spec]
task :default => [:spec]
