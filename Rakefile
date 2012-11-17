desc 'setup my public dotfiles'
task :setup do
  system("chef-solo -c config/solo.rb -j config/node.json")
end

namespace :setup do
  desc 'setup my private dotfiles'
  task :private do
    unless File.directory?(File.dirname(__FILE__) + '/cookbooks/private')
      system "git submodule add git@github.com:nclark/dotfiles-private.git cookbooks/private"
    end

    system "git submodule foreach git pull origin master"

    if system("git status | grep cookbooks/private")
      # todo - check for dirty tree first

      system "git add cookbooks/private"
      system "git commit -m 'update submodule cookbooks/private'"
    end
  end
end

desc 'create new cookbook'
task :cookbook, :name do |t, args|
  %x|knife cookbook create #{args[:name]} -c config/solo.rb|
end

task :default => ['setup:private', 'setup']

