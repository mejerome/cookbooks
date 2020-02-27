# # encoding: utf-8

# Inspec test for recipe workstation::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe port(8080) do
  it { should be_listening }
end
