# == Class: powerdns::backend::gsqlite3
#
# Configures PowerdDNS SQLite3 backend.
# Expects settings to be pulled from Hiera and passed to it.
#

class powerdns::backend::gsqlite3 (
  $settings,
  $config_file = '/etc/powerdns/pdns.d/gsqlite3.conf',
  $install = 'true',
) {

  if $install {
    package { 'pdns-backend-sqlite3':
      ensure => present,
    }
  }

  file { $config_file:
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    notify => Service['powerdns'],
  }

  $settings.each |$setting, $value| {
    powerdns_config { "${config_file}: ${setting}":
      value => $value,
    }
  }

}
