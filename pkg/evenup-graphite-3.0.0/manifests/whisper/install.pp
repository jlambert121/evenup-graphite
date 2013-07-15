# Class: graphite::whisper::install
#
# Installs the whsiper package.  Not intended to be called directly
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class graphite::whisper::install {

  package { 'whisper':
    ensure  => 'latest',
  }

}
