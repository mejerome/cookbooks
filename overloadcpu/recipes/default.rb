#
# Cookbook:: overloadcpu
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

bash 'overload cpu' do
  user 'root'
  code <<-EOH
  yes > /dev/null &
  EOH
  action :run
end
