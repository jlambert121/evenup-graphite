require 'spec_helper'

describe 'graphite::carbon::config', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should contain_file('/var/lib/carbon/') }
  it { should contain_file('/var/lib/carbon/whisper/') }
  it { should contain_file('/var/lib/carbon/lists/') }
  it { should contain_file('/etc/carbon/') }
  it { should contain_file('/var/log/carbon-cache') }
  it { should contain_file('/var/log/carbon-relay') }
  it { should contain_file('/var/log/carbon-aggregator') }
  it { should contain_file('/etc/carbon/carbon.conf') }
  it { should contain_file('/etc/carbon/storage-schemas.conf') }
  it { should contain_file('/etc/carbon/storage-aggregation.conf') }
  it { should contain_file('/etc/sysconfig/carbon-cache') }
  it { should contain_file('/etc/sysconfig/carbon-aggregator') }
  it { should contain_file('/etc/sysconfig/carbon-relay') }

end
