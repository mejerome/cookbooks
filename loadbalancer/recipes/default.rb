#
# Cookbook:: loadbalancer
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
# run yum update
apt_update 'update'

haproxy_install 'package'

haproxy_frontend 'http-in' do
  bind '*:80'
  default_backend 'servers'
end

haproxy_backend 'servers' do
  server ['web1 web1:80 maxconn 32', 'web2 web2:80 maxconn 32']
end

haproxy_service 'haproxy' do
  action [:start, :enable]
end
