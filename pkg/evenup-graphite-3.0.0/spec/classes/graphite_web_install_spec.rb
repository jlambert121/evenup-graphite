require 'spec_helper'

describe 'graphite::web::install', :type => :class do

  it { should contain_package('graphite-web') }

end
