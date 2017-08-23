NVIM_CONFIG_PATH = "#{ENV['HOME']}/.config/nvim"

# include_recipe 'nvim::dein'

directory "#{NVIM_CONFIG_PATH}/bundle" do # will the bundle directory create itself
  recursive true
end

%w[init.vim bundles.vim plugin-config.vim keymap.vim].each do |config_file_name|
  cookbook_file "#{NVIM_CONFIG_PATH}/#{config_file_name}" do
    source config_file_name
  end
end

# install vim-plug

directory "#{ENV['HOME']}/.local/share/nvim/site/autoload" do
  recursive true
  action :create
end

remote_file "#{ENV['HOME']}/.local/share/nvim/site/autoload/plug.vim" do
  source 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  mode '0600'
  action :create
end

cookbook_file "#{ENV['HOME']}/bin/vim-update-dotfiles" do
  source 'update-dotfiles.sh'
  mode '0755'
end
