NVIM_CONFIG_PATH = "#{ENV['HOME']}/.config/nvim"

include_recipe 'nvim::dein'

directory "#{NVIM_CONFIG_PATH}/bundle" do # will the bundle directory create itself
  recursive true
end

%w[init.vim bundles.vim plugin-config.vim keymap.vim].each do |config_file_name|
  cookbook_file "#{NVIM_CONFIG_PATH}/#{config_file_name}" do
    source config_file_name
  end
end

bash 'install dein plugins' do
  # starting and quitting nvim will install missing dein plugins 

  code "echo ':q'|nvim"
end

cookbook_file "#{ENV['HOME']}/bin/vim-update-dotfiles" do
  source 'update-dotfiles.sh'
  mode '0755
end
