# Class: graphite::web::install
#
# Installs the graphite web package.  Not intended to be called directly
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
class graphite::web::install {

  include apache::wsgi

  package { 'graphite-web':
    ensure  => 'latest',
  }

}
