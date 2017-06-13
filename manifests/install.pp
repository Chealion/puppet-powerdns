# == Class: powerdns::install
#
# Installs PowerDNS using OS package manager
#
# === Parameters
#

class powerdns::install (
  $package_ensure = latest,
) {

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
