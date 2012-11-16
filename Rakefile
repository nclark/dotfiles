desc 'setup my public dotfiles'
task :setup do

end

namespace :setup do
  desc 'setup my private dotfiles'
  task :private do

  end
end

desc 'create new cookbook'
task :cookbook, :name do |t, args|
  %x|knife cookbook create #{args[:name]} -c config/solo.rb|
end

task :default => ['setup', 'setup:private']

