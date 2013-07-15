require 'spec_helper'

describe 'graphite::whisper', :type => :class do

  it { should contain_class('graphite::whisper::install') }

end
