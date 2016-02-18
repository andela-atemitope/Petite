require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task :test do
  Dir.glob("./test/*/*_test.rb").each { |file| require file }
  Dir.glob("./test/*/*_spec.rb").each { |file| require file }
end

# Rake::TestTask.new(:test) do |t|
#   t.libs << 'test'
#   t.libs << 'lib'
#   t.test_files = FileList['test/**/*_test.rb']
# end
