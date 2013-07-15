# Class: graphite::web::config
#
# Configures the graphite webapp.  Not intended to be called directly
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
class graphite::web::config (
  $vhost = true,
){

  if $vhost {
    File {
      notify  => Class['apache::service'],
    }
  }

  file { '/etc/graphite-web/dashboard.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/graphite/dashboard.conf',
    require => Class['graphite::web::install'],
  }

  file { '/etc/graphite-web/graphTemplates.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/graphite/graphTemplates.conf',
    require => Class['graphite::web::install'],
  }

  # TODO - I NEED CONFIG!
  file { '/etc/graphite-web/local_settings.py':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('graphite/local_settings.py'),
    require => Class['graphite::web::install'],
  }

  if $vhost {
    apache::vhost { 'graphite':
      serverName      => $::hostname,
      serverAlias     => $::fqdn,
      docroot         => '/usr/share/graphite/webapp',
      aliases         => '/media/ "/usr/lib/python2.6/site-packages/django/contrib/admin/media/"',
      locations       => [{'name' => '/content/', 'params' => ['SetHandler None']}, {'name' => '/media/', 'params' => ['SetHandler None']}],
      siteDirectives  => ['WSGIDaemonProcess graphite processes=5 threads=5 display-name="%{GROUP}" inactivity-timeout=120',
                          'WSGIProcessGroup graphite',
                          'WSGIApplicationGroup %{GLOBAL}',
                          'WSGIImportScript /usr/share/graphite/graphite-web.wsgi process-group=graphite application-group=%{GLOBAL}',
                          'WSGIScriptAlias / /usr/share/graphite/graphite-web.wsgi'
      ],
      logstash        => true,
    }
  }

}
