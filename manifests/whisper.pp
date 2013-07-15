# Class: graphite::whisper
#
# Wrapper class to install whisper
#
# Sample Usage:
#   class { 'graphite::whisper': }
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
class graphite::whisper {

  anchor { 'graphite::whisper::begin': } ->
  class{ 'graphite::whisper::install': } ->
  anchor { 'graphite::whisper::end': }

}
