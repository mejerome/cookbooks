package 'vim'
package 'nano'
package 'tree'
package 'git' do
  action :install
end
package 'ntp'

template '/etc/motd' do
  source 'motd.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables(:name => 'Jerome Tabiri')
  action :create
end

user 'user1' do
  comment 'user1'
  uid '123'
  home '/home/user1'
  shell '/bin/bash'
end

group 'admins' do
  members 'user1'
end
