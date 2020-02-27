# InSpec test for recipe loadbalancer::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe package('haproxy') do
  it { should be_installed }
end

describe port(80) do
  it { should be_listening }
end

describe service('haproxy') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/haproxy/haproxy.cfg') do
  it { should exist }
  its('content') { should match /web1/ || /web2/ }
end
