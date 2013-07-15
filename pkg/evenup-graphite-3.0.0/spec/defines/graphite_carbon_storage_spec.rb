require 'spec_helper'

describe 'graphite::carbon::storage', :type => :define do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }
  let(:title) { '10s_for_30s' }
  let(:params) { { :pattern => '.*', :retentions => '10s:30s'}}

  it { should contain_concat__fragment('10s_for_30s') }

end
