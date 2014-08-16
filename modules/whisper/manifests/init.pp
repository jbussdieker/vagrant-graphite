class whisper(
  $prefix = '/opt/graphite',
  $source = 'https://github.com/graphite-project/whisper.git',
  $source_path = '/usr/local/src/whisper',
  $revision = 'master',
) {

  vcsrepo { $source_path:
    ensure   => present,
    revision => $revision,
    source   => $source,
    provider => git,
  }

  exec { 'install_whisper':
    cwd     => $source_path,
    command => '/usr/bin/python setup.py install',
    creates => '/usr/local/lib/python2.7/dist-packages/whisper.py',
    require => Vcsrepo[$source_path],
  }

}
