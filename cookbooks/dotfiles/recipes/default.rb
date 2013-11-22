%w(dir_colors gitconfig.example gitignore inputrc screenrc sqliterc).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.#{file_name}" do
    owner ENV['USER']
    source file_name
  end
end

directory "#{ENV['HOME']}/.js" do
  owner ENV['USER']
end

cookbook_file "#{ENV['HOME']}/.js/default.js" do
  owner ENV['USER']
  source 'js/default.js'
end

