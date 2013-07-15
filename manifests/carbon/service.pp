# Class: graphite::carbon::service
#
# Manages the carbon services.  Not intended to be called directly
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
class graphite::carbon::service (
  $cache_enabled      = true,
  $relay_enabled      = false,
  $aggregator_enabled = false,
) {

  $cache_status = $cache_enabled ? {
    true    => 'running',
    default => 'stopped',
  }

  $relay_status = $relay_enabled ? {
    true    => 'running',
    default => 'stopped',
  }

  $aggregator_status = $aggregator_enabled ? {
    true    => 'running',
    default => 'stopped',
  }

  Service {
    subscribe => Class['graphite::carbon::config'],
    require   => Class['graphite::carbon::install'],
  }

  service { 'carbon-cache':
    ensure  => $cache_status,
    enable  => $cache_enabled,
  }

  service { 'carbon-relay':
    ensure  => $relay_status,
    enable  => $relay_enabled,
  }

  service { 'carbon-aggregator':
    ensure  => $aggregator_status,
    enable  => $aggregator_enabled,
  }
}
