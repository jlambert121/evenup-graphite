# Class: logrotate
#
# Configures carbon.  Not intended to be called directly
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
class graphite::carbon::config (
  # Storage
  $default_retention            = '10s:2d,1m:5d,15m:5y',
  # Carbon Cache
  $storage_dir                  = '/var/lib/carbon/',
  $local_data_dir               = '/var/lib/carbon/whisper/',
  $whitelists_dir               = '/var/lib/carbon/lists/',
  $conf_dir                     = '/etc/carbon/',
  $log_dir                      = '/var/log/carbon-cache',
  $pid_dir                      = '/var/run/',
  $user                         = 'carbon',
  $max_cache_size               = 'inf',
  $max_updates_per_second       = 500,
  $max_creates_per_minute       = 50,
  $line_receiver_interface      = '0.0.0.0',
  $line_receiver_port           = 2003,
  $enable_udp_listener          = false,
  $udp_receiver_interface       = '0.0.0.0',
  $udp_receiver_port            = 2003,
  $pickle_receiver_interface    = '0.0.0.0',
  $pickle_receiver_port         = 2004,
  $use_insecure_unpickler       = false,
  $cache_query_interface        = '0.0.0.0',
  $cache_query_port             = 7002,
  $use_flow_control             = true,
  $log_updates                  = false,
  $whisper_autoflush            = false,
  $whisper_sparse_create        = false,
  $whisper_lock_writes          = false,
  $use_whitelist                = false,
  $carbon_metric_interval       = 60,
  $enable_amqp                  = false,
  $amqp_verbose                 = false,
  $amqp_host                    = 'amqp',
  $amqp_port                    = 5672,
  $amqp_vhost                   = '/graphite',
  $amqp_user                    = 'user',
  $amqp_password                = 'password',
  $amqp_exchange                = 'graphite',
  $amqp_metric_name_in_body     = true,
  # Relay Config
  $r_log_dir                    = '/var/log/carbon-relay',
  $r_line_receiver_interface    = '0.0.0.0',
  $r_line_receiver_port         = 2013,
  $r_pickle_receiver_interface  = '0.0.0.0',
  $r_pickle_receiver_port       = 2014,
  $r_relay_method               = 'rules',
  $r_replication_factor         = 1,
  $r_destinations               = '127.0.0.1:2004',
  $r_max_datapoints_per_message = 500,
  $r_max_queue_size             = 10000,
  $r_use_flow_control           = true,
  $r_use_whitelist              = false,
  $r_carbon_metric_prefix       = 'carbon',
  $r_carbon_metric_interval     = 60,
  # Aggregator Config
  $a_log_dir                    = '/var/log/carbon-aggregator',
  $a_destinations               = '127.0.0.1:2004',
  $a_line_receiver_interface    = '0.0.0.0',
  $a_line_receiver_port         = 2023,
  $a_pickle_receiver_interface  = '0.0.0.0',
  $a_pickle_receiver_port       = 2024,
  $a_max_queue_size             = 10000,
  $a_use_flow_control           = true,
  $a_max_datapoints_per_message = 500,
  $a_max_aggregation_intervals  = 5,
  $a_use_whitelist              = false,
  $a_carbon_metric_prefix       = 'carbon',
  $a_carbon_metric_interval     = 60,
){

  File {
    ensure  => file,
    owner   => carbon,
    group   => carbon,
    mode    => 0444,
    require => Class['graphite::carbon::install'],
    notify  => Class['graphite::carbon::service'],
  }

  Exec {
    path  => '/usr/bin/:/bin/:/sbin/:/usr/sbin'
  }

  # Ensure base directories exist.  I understand the comlexity with
  # -p in puppet, but very annoying
  exec{ "mkdir -p ${storage_dir}":
    unless => "test -d ${storage_dir}",
  }

  file { $storage_dir:
    ensure  => 'directory',
    mode    => '0775',
    require => Exec["mkdir -p ${storage_dir}"],
  }

  exec{ "mkdir -p ${local_data_dir}":
    unless => "test -d ${local_data_dir}",
  }

  file { $local_data_dir:
    ensure  => 'directory',
    mode    => '0775',
    require => Exec["mkdir -p ${local_data_dir}"],
  }

  exec{ "mkdir -p ${whitelists_dir}":
    unless => "test -d ${whitelists_dir}",
  }

  file { $whitelists_dir:
    ensure  => 'directory',
    mode    => '0555',
    require => Exec["mkdir -p ${whitelists_dir}"],
  }

  exec{ "mkdir -p ${conf_dir}":
    unless => "test -d ${conf_dir}",
  }

  file { $conf_dir:
    ensure  => 'directory',
    mode    => '0555',
    owner   => 'root',
    group   => 'root',
    require => Exec["mkdir -p ${conf_dir}"],
  }

  exec{ "mkdir -p ${log_dir}":
    unless => "test -d ${log_dir}",
  }

  file { $log_dir:
    ensure  => 'directory',
    mode    => '0775',
    require => Exec["mkdir -p ${log_dir}"],
  }

  exec{ "mkdir -p ${a_log_dir}":
    unless => "test -d ${a_log_dir}",
  }

  file { $a_log_dir:
    ensure  => 'directory',
    mode    => '0775',
    require => Exec["mkdir -p ${a_log_dir}"],
  }

  exec{ "mkdir -p ${r_log_dir}":
    unless => "test -d ${r_log_dir}",
  }

  file { $r_log_dir:
    ensure  => 'directory',
    mode    => '0775',
    require => Exec["mkdir -p ${r_log_dir}"],
  }

  # On to actual config files
  file { '/etc/carbon/carbon.conf':
    content => template('graphite/carbon.conf'),
  }

  concat { '/etc/carbon/storage-schemas.conf':
    group  => 'carbon',
    mode   => '0444',
    owner  => 'carbon',
    notify => Class['graphite::carbon::service'],
  }

  graphite::carbon::storage { 'carbon':
    pattern     => '^carbon\.*',
    retentions  => "${carbon_metric_interval}:90d",
    order       => 0,
  }

  # Default retention
  graphite::carbon::storage { 'default_retention':
    pattern     => '.*',
    retentions  => $default_retention,
    order       => 99,
  }

  file { '/etc/carbon/storage-aggregation.conf':
    content => template('graphite/storage-aggregation.conf'),
  }

  file { '/etc/sysconfig/carbon-cache':
    content => template('graphite/carbon-cache.sysconfig'),
  }

  file { '/etc/sysconfig/carbon-aggregator':
    content => template('graphite/carbon-aggregator.sysconfig'),
  }

  file { '/etc/sysconfig/carbon-relay':
    content => template('graphite/carbon-relay.sysconfig'),
  }

}
