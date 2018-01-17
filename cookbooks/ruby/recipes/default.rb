%w(gemrc pryrc irbrc).each do |file_name|
  cookbook_file "#{ENV['HOME']}/.#{file_name}" do
    owner ENV['USER']
    source file_name
  end
end

