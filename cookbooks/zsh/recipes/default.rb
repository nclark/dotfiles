%w(.zsh .zsh/misc .zsh/support .zsh/vendor).each do |dir|
  directory "#{ENV['HOME']}/#{dir}"
end

%w(zshrc zshenv zlogin).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.#{file_name}" do
    owner ENV['USER']
    source file_name
  end
end

%w(aliases autocomplete compinstall env functions).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.zsh/#{file_name}" do
    owner ENV['USER']
    source file_name
  end
end

cookbook_file "#{ENV['HOME']}/.zsh/misc/ec2" do
  owner ENV['USER']
  source 'misc/ec2'
end

%w(db.rb projects.rb).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.zsh/support/#{file_name}" do
    owner ENV['USER']
    source "support/#{file_name}"
  end
end

%w(S55_git S60_prompt zgitinit).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.zsh/vendor/#{file_name}" do
    owner ENV['USER']
    source "vendor/#{file_name}"
  end
end
