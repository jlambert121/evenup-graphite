# Class: graphite::carbon::install
#
# Installs the carbon package.  Not intended to be called directly
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
class graphite::carbon::install {

  # Required since python-txAMQP doesn't depend on it as it should
  package { 'python-twisted-core':
    ensure  => 'latest',
  }

  package { 'python-txAMQP':
    ensure => 'latest',
  }

  package { 'carbon':
    ensure  => 'latest',
  }

  user { 'carbon':
    ensure  => present,
    system  => true,
    comment => 'Graphite carbon user',
    gid     => 'carbon',
    home    => '/var/lib/carbon',
    shell   => '/sbin/nologin',
  }

  group {'carbon':
    ensure  => present,
    system  => true,
  }

}
