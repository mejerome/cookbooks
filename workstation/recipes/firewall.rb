#
# Cookbook:: workstation
# Recipe:: firewall
#
# Copyright:: 2020, The Authors, All Rights Reserved.
# enable platform default firewall
firewall 'default' do
  action :install
end

# open standard ssh port
firewall_rule 'ssh' do
  port     22
  command  :allow
end

# open standard http port to tcp traffic only; insert as first rule
firewall_rule 'open http port' do
  port     80
  protocol :tcp
  position 1
  command  :allow
end
