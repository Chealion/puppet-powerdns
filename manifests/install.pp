# == Class: powerdns::install
#
# Installs PowerDNS 4.4 using repo.powerdns.com
#
# === Parameters
#

class powerdns::install (
  $package_ensure = latest,
) {

  apt::key { 'powerdns':
    ensure => present,
    id     => '9FAAA5577E8FCF62093D036C1B0C6205FD380FBB',
    source => 'https://repo.powerdns.com/FD380FBB-pub.asc',
  }

  apt::source { 'repo.powerdns.com':
    ensure => present,
    location => 'http://repo.powerdns.com/ubuntu',
    repos => 'main',
    release => 'xenial-auth-44',
    architecture => 'amd64',
    require      => Apt::Key['powerdns'],
  }

  apt::pin { 'powerdns':
    priority => 600,
    packages => 'pdns-*',
    origin   => 'repo.powerdns.com',
    require  => Apt::Source['powerdns'],
  }

  $default_package_name = $::osfamily ? {
    'Debian' => 'pdns-server',
    'RedHat' => 'pdns',
    default  => undef,
  }

  package { $default_package_name:
    ensure => $package_ensure,
  } ~>
  exec { 'Remove default Ubuntu conf files':
    command => '/bin/rm /etc/powerdns/pdns.d/pdns.*;',
    onlyif  => "/usr/bin/test -f /etc/powerdns/pdns.d/pdns.local.conf",
  }

}
