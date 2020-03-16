#
# Cookbook:: mynginx
# Recipe:: netwire-website
#
# Copyright:: 2020, The Authors, All Rights Reserved.
app_dir = '/var/www/html'

nginx_dir = '/etc/nginx/sites-available'

# Netwire Website & config file
git "#{app_dir}/netwire-website" do
  repository 'https://github.com/mejerome/netwire.github.io.git'
  revision 'master'
  action :sync
end

template "#{nginx_dir}/netwiregh.com.conf" do
  source 'config.conf.erb'
  variables(
    port: '80',
    default_root: "#{app_dir}/netwire-website"
  )
  notifies :run, 'execute[enable virtual host]', :immediately
end

execute 'enable virtual host' do
  command "ln -s #{nginx_dir}/netwiregh.com.conf /etc/nginx/sites-enabled/"
  action  :nothing
  notifies :reload, 'service[nginx]', :delayed
end

service 'nginx' do
  action :nothing
end
