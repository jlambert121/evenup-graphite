require 'spec_helper'

describe 'graphite::whisper::install', :type => :class do

  it { should contain_package('whisper') }

end
