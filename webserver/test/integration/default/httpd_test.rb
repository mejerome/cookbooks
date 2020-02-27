# InSpec test for recipe webserver::httpd

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

control 'apache2' do
  if os.family == 'redhat'
    describe service('httpd') do
      it { should be_installed }
      it { should be_running }
      it { should be_enabled }
    end
  elsif os.family == 'debian'
    describe service('apache2') do
      it { should be_installed }
      it { should be_running }
      it { should be_enabled }
    end
  else
    describe service('apache') do
      skip 'This OS is not supported.'
    end
  end
end

describe port(443) do
  it { should be_listening }
end

describe port(80) do
  it { should be_listening }
end

app_dir = '/var/www/basic_site'

describe file("#{app_dir}/index.html") do
  it { should exist }
  its('content') { should match 'electrician' }
end
