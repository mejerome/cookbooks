#
# Cookbook:: webserver
# Recipe:: httpd
#
# Copyright:: 2020, The Authors, All Rights Reserved.

apache2_install 'default'

service 'apache2' do
  extend Apache2::Cookbook::Helpers
  service_name lazy { apache_platform_service_name }
  supports restart: true, status: true, reload: true
  action [:start, :enable]
end

apache2_module 'deflate'
apache2_module 'headers'

app_dir = '/var/www/basic_site'

directory app_dir do
  recursive true
end

template "#{app_dir}/index.html" do
  extend Apache2::Cookbook::Helpers
  source 'index.html.erb'
  owner lazy { default_apache_user }
  group lazy { default_apache_group }
  variables(
    hostname: node['hostname']
  )
  action :create
end

template 'basic_site' do
  extend  Apache2::Cookbook::Helpers
  source 'basic_site.conf.erb'
  path "#{apache_dir}/sites-available/basic_site.conf"
  variables(
    server_name: '127.0.0.1',
    document_root: app_dir,
    log_dir: lazy { default_log_dir },
    site_name: 'basic_site'
  )
end

apache2_site 'basic_site'

apache2_site '000-default' do
  action :disable
end

# reboot 'now' do
#   action :reboot_now
#   reason 'Reboot required after webserver configuration'
# end
