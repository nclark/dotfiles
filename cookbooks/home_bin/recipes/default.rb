directory "#{ENV['HOME']}/bin" do
  user ENV['USER']
end

commands = %w(bssh git-archive-branch git-cor git-create-archive git-fuckit) +
           %w(git-gist-diff git-pop git-psh git-put git-reset-branch git-reset-remote-branch) + 
           %w(git-tracker-branch git-x git-force-amend git-rally-branch git-cmp git-hub) +
           %w(git-backup git-archive-branches git-upstream-self mk_remote_repo pom tcd scrabble springspec)

commands.each do |command_name|
  cookbook_file "#{ENV['HOME']}/bin/#{command_name}" do
    owner ENV['USER']
    source command_name
    mode 0755
  end
end
