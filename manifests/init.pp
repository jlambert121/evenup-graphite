# Class: logrotate
#
# Wrapper class to install graphite and related packages/services
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
class graphite {

  notify { 'ingraphite': }
  class { 'graphite::whisper': }
  class { 'graphite::carbon': }
  class { 'graphite::web': }

  anchor { 'graphite::begin': }
  anchor { 'graphite::end': }

  Anchor['graphite::begin'] ->
  Class['graphite::whisper'] ->
  Anchor['graphite::end']

  Anchor['graphite::begin'] ->
  Class['graphite::carbon'] ->
  Anchor['graphite::end']

  Anchor['graphite::begin'] ->
  Class['graphite::web'] ->
  Anchor['graphite::end']

}
