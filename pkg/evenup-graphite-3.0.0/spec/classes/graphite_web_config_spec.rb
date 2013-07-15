require 'spec_helper'

describe 'graphite::web::config', :type => :class do
  let(:facts) { { :concat_basedir => '/var/lib/puppet/concat' } }

  it { should contain_file('/etc/graphite-web/dashboard.conf') }
  it { should contain_file('/etc/graphite-web/graphTemplates.conf') }
  it { should contain_file('/etc/graphite-web/local_settings.py') }
  it { should contain_apache__vhost('graphite') }

  context 'no vhost' do
    let(:params) { { :vhost => false } }
    it { should_not contain_apache__vhost('graphite') }
  end

end
