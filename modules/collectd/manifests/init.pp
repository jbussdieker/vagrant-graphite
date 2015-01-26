class collectd(
  $interval = 60,
  $graphite_host = 'localhost',
  $graphite_port = 2003,
  $graphite_protocol = 'tcp',
  $graphite_prefix = 'collectd\.',
) {

  package { 'collectd':
    ensure => present,
  }

  file { '/etc/collectd':
    ensure  => directory,
    require => Package['collectd'],
  }

  file { '/etc/collectd/collectd.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('collectd/collectd.conf.erb'),
    notify  => Service['collectd'],
  }

  service { 'collectd':
    ensure  => running,
    require => Package['collectd'],
  }

}
