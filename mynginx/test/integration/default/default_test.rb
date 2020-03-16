# InSpec test for recipe mynginx::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe directory('/opt/html/syslog-website') do
  it { should exist }
end

describe file('/etc/nginx/sites-enabled/sysloggh.com.conf') do
  it { should exist }
  its('content') { should match 'sysloggh.com' }
end