# InSpec test for recipe mynginx::netwire-website

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end


describe directory('/opt/html/netwire-website') do
  it { should exist }
end

describe file('/etc/nginx/sites-enabled/netwiregh.com.conf') do
  it { should exist }
  its('content') { should match 'netwiregh.com' }
end