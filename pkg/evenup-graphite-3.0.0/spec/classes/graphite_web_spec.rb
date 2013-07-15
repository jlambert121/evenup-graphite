require 'spec_helper'

describe 'graphite::web', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should contain_class('graphite::web::config') }
  it { should contain_class('graphite::web::install') }

end
