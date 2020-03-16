#
# Cookbook:: mynginx
# Recipe:: syslog-website
#
# Copyright:: 2020, The Authors, All Rights Reserved.

app_dir = '/var/www/html'

nginx_dir = '/etc/nginx/sites-available'

# Syslog Website & config file
git "#{app_dir}/syslog-website" do
  repository 'https://github.com/mejerome/syslog-website.git'
  revision 'master'
  action :sync
end

template "#{nginx_dir}/sysloggh.com.conf" do
  source 'config.conf.erb'
  variables(
    port: '80',
    default_root: "#{app_dir}/syslog-website"
  )
  notifies :run, 'execute[enable sysloggh.com]', :immediately
end

execute 'enable sysloggh.com' do
  command "ln -s #{nginx_dir}/sysloggh.com.conf /etc/nginx/sites-enabled/"
  action  :nothing
  notifies :reload, 'service[nginx]', :delayed
end

service 'nginx' do
  action :nothing
end
