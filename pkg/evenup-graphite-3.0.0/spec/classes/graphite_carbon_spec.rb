require 'spec_helper'

describe 'graphite::carbon', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should contain_class('graphite::carbon::install') }
  it { should contain_class('graphite::carbon::config') }
  it { should contain_class('graphite::carbon::service') }

end
