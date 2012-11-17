directory "#{ENV['HOME']}/bin" do
  user ENV['USER']
end

commands = %w(bssh git-archive-branch git-cor git-create-archive git-fuckit) +
           %w(git-gist-diff git-pop git-psh git-reset-branch git-reset-remote-branch) + 
           %w(git-tracker-branch git-x jigsaw mk_remote_repo pom tcd)


commands.each do |command_name|
  cookbook_file "#{ENV['HOME']}/bin/#{command_name}" do
    owner ENV['USER']
    source command_name
    mode 0755
  end
end