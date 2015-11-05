%w(.vim .vim/after/ftplugin .vim/autoload .vim/bundle).each do |dir|
  directory "#{ENV['HOME']}/#{dir}" do
    recursive true
  end
end

%w(vimrc gvimrc).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.#{file_name}" do
    owner ENV['USER']
    source file_name
  end
end

cookbook_file "#{ENV['HOME']}/.vim/.netrwhist" do
  owner ENV['USER']
  source "vim/netrwhist"
end

cookbook_file "#{ENV['HOME']}/.vim/after/ftplugin/ruby.vim" do
  owner ENV['USER']
  source "vim/after/ftplugin/ruby.vim"
end

cookbook_file "#{ENV['HOME']}/.vim/autoload/pathogen.vim" do
  owner ENV['USER']
  source "vim/autoload/pathogen.vim"
end

execute "make bundle path a git repository" do
  cwd "#{ENV['HOME']}/.vim/bundle"
  command <<-EOS
    git init
    touch .gitignore
    git add .
    git commit -m 'initial commit'
  EOS

  not_if { File.directory?("#{ENV['HOME']}/.vim/bundle/.git") }
end

plugins = data_bag_item("vim", "plugins")['plugins']

plugins.each do |name, url|
  execute "add #{name} vim plugin" do
    cwd "#{ENV['HOME']}/.vim/bundle"
    command %Q|git submodule add #{url} #{name} --force ; git commit -m "added #{name} plugin"|

    not_if { File.directory?("#{ENV['HOME']}/.vim/bundle/#{name}") }
  end
end

execute "build YouCompleteMe" do
  cwd ENV['HOME']
  command <<-EOS
    mkdir ycm_build
    cd ycm_build
    cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/cpp
    make ycm_core
    cd ..
    rm -rf ycm_core
  EOS

  not_if { File.exist?("#{ENV['HOME']}/.vim/bundle/YouCompleteMe/python/ycm_core.so") }
end



