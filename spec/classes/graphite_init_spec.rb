require 'spec_helper'

describe 'graphite', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should contain_class('graphite::whisper') }
  it { should contain_class('graphite::carbon') }
  it { should contain_class('graphite::web') }

end

