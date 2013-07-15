# Class: graphite::carbon
#
# Wrapper class to install carbon
#
# Sample Usage:
#   class { 'graphite::carbon': }
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
class graphite::carbon {

  anchor{ 'graphite::carbon::begin': }
  class{ 'graphite::carbon::install': }
  class{ 'graphite::carbon::config': }
  class{ 'graphite::carbon::service': }
  anchor{ 'graphite::carbon::end': }

}
