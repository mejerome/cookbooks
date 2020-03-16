#
# Cookbook:: mynginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
# run update 
apt_update 'update'

package 'nginx' do
  action :install
end

service 'nginx' do
  action [:start, :enable]
end

directory '/var/www/html' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

app_dir = '/var/www/html'

nginx_dir = '/etc/nginx/sites-available'

# Syslog Website & config file
git "#{app_dir}/syslog-website" do
  repository 'https://github.com/mejerome/syslog-website.git'
  revision 'master'
  action :sync
end

file '/etc/nginx/sites-enabled/sysloggh.com.log' do
  action :delete
end

file '/etc/nginx/sites-available/sysloggh.com.log' do
  action :delete
end

template "#{nginx_dir}/sysloggh.com.conf" do
  source 'config.conf.erb'
  variables(
    port: '80',
    default_root: "#{app_dir}/syslog-website"
  )
  notifies :run, 'execute[enable virtual host]', :immediately
end

execute 'enable virtual host' do
  command "ln -s #{nginx_dir}/sysloggh.com.conf /etc/nginx/sites-enabled/"
  action  :nothing
  notifies :reload, 'service[nginx]', :delayed
end


# Netwire Website & config file
git "#{app_dir}/netwire-website" do
  repository 'https://github.com/mejerome/netwire.github.io.git'
  revision 'master'
  action :sync
end

file '/etc/nginx/sites-enabled/netwiregh.com.log' do
  action :delete
end

file '/etc/nginx/sites-available/netwiregh.com.log' do
  action :delete
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
