require "bump/tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

Bump.tag_by_default = true

namespace :release do
  task :git_push do
    `git push origin`
    `git push origin v#{::Bump::Bump.current}`
  end

  %w[major minor patch].each do |part|
    desc "Bump #{part} of gem version and release"
    task part => ["bump:#{part}", "release:git_push"]
  end
end
