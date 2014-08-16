class graphite(
  $prefix = $graphite::params::prefix,
  $version = $graphite::params::version
) inherits graphite::params {

  file { $prefix:
    ensure => directory,
  }
->
  class { 'whisper':
    revision => $version,
  }
->
  carbon::cache { 'a':
  }
->
  class { 'graphite_web':
    revision => $version,
    prefix => $prefix,
  }
->
  class { 'graphite::config':
    prefix => $prefix,
  }
->
  exec { 'start_carbon':
    user    => "www-data",
    command => "${prefix}/bin/carbon-cache.py start",
    creates => "${prefix}/storage/carbon-cache-a.pid",
  }
->
  exec { 'create_database':
    user    => "www-data",
    command => "/usr/bin/python ${prefix}/webapp/graphite/manage.py syncdb --noinput",
    creates => "${prefix}/storage/graphite.db",
  }
->
  class { 'uwsgi::app':
  }

}
