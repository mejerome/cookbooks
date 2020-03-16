#
# Cookbook:: mynginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# run update on distro
apt_update 'update'

# install nginx package
package 'nginx' do
  action :install
end

# start and enable nginx service
service 'nginx' do
  action [:start, :enable]
  notifies :run, 'bash[cleanup]', :before
end

# ensure web folder exists
directory '/var/www/html' do
  owner 'www-data'
  group 'www-data'
  mode '0755'
  action :create
end

# a bit of house cleaning before configurations
bash 'cleanup' do
  code <<-EOH
  #! bin/bash
  sudo rm /etc/nginx/sites-available/*.conf && sudo rm /etc/nginx/sites-enabled/*.conf
  EOH
  action :nothing
end

include_recipe 'mynginx::syslog-website'
include_recipe 'mynginx::netwire-website'
