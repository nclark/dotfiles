%w(keymap.cson).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.atom/#{file_name}" do
    owner ENV['USER']
    source file_name
  end
end
