require 'spec_helper'

describe 'graphite::carbon::service', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  context 'default' do
    it { should contain_service('carbon-cache').with(
      :ensure => 'running',
      :enable => true
    ) }

    it { should contain_service('carbon-relay').with(
      :ensure => 'stopped',
      :enable => false
    ) }

    it { should contain_service('carbon-aggregator').with(
      :ensure => 'stopped',
      :enable => false
    ) }
  end

  context 'switched services' do
    let(:params) { {
      :cache_enabled      => false,
      :relay_enabled      => true,
      :aggregator_enabled => true,
    } }

    it { should contain_service('carbon-cache').with(
      :ensure => 'stopped',
      :enable => false
    ) }

    it { should contain_service('carbon-relay').with(
      :ensure => 'running',
      :enable => true
    ) }

    it { should contain_service('carbon-aggregator').with(
      :ensure => 'running',
      :enable => true
    ) }

  end

end
