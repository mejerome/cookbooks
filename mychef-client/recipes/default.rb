#
# Cookbook:: mychef-client
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
node.default['chef_client']['interval'] = '300'
node.default['chef_client']['splay'] = '60'
# node.default['chef_client']['config']['chef_server_url'] = 'https://api.chef.io/organizations/jerome19_lab'
# node.default['chef_client']['config']['validation_client_name'] = ''

include_recipe 'chef-client::default'
