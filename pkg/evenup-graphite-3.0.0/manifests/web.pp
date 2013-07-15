# Class: graphite::web
#
# Wrapper class to install the graphite webapp
#
# Sample Usage:
#   class { 'graphite::web': }
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
class graphite::web {

  anchor { 'graphite::web::begin': } ->
  class{ 'graphite::web::install': } ->
  class{ 'graphite::web::config': } ->
  anchor { 'graphite::web::end': }

}
