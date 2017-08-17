DEIN_INSTALL_URL      = 'https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh'
DEIN_INSTALL_LOCATION = '/Users/nclark/.dein/'

unless File.directory?(DEIN_INSTALL_LOCATION)
  remote_file "#{Chef::Config[:file_cache_path]}/dein_installer.sh" do
    source DEIN_INSTALL_URL

    mode '0755'
  end

  bash 'install dein' do
    cwd Chef::Config[:file_cache_path]

    code "bash dein_installer.sh #{DEIN_INSTALL_LOCATION}"
  end
end
