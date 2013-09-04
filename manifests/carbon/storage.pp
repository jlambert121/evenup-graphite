# == Define: graphite::carbon::storage
#
# This definition adds a block to the storage-schemas to change the retention
# period of graphs matching a mattern.
#
#
# === Parameters
#
# [*pattern*]
#   String. Pattern to match for whisper files.
#   Required
#
# [*retentions*]
#   String.  Retentions to use for this pattern
#   Required
#
# [*order*]
#   Integer.  Order this pattern should fall in the file
#   Default: 10
#
#
# === Examples
#
#   apache::vhost {
#     'www-http':
#       serverName      => $::fqdn,
#       serverAlias     => someone@mydomain.com,
#       redirectToHTTPS => true,
#    }
#
# * Removal:
#     Remove the definition and the apache class will clean it up
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
define graphite::carbon::storage (
  $pattern,
  $retentions,
  $order = 10,
) {

  include graphite::carbon::install
  include graphite::carbon::config
  include graphite::carbon::service
  Class['graphite::carbon::install'] ->
  Graphite::Carbon::Storage[$name] ~>
  Class['graphite::carbon::service']

  concat::fragment { $name:
    target  => '/etc/carbon/storage-schemas.conf',
    order   => $order,
    content => template('graphite/storage-schemas.conf.erb'),
  }
}

