require "bundler/gem_tasks"

task :test do
  $: << './lib' << './test'
  Dir['./test/**/*_test.rb'].each do |file|
    require file
  end
end
task :default => :test

