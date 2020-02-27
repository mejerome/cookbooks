#
# Cookbook:: webserver
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
apt_update 'update'
include_recipe 'webserver::httpd'
