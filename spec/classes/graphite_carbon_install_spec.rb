require 'spec_helper'

describe 'graphite::carbon::install', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should contain_package('python-txAMQP') }
  it { should contain_package('carbon') }

end
