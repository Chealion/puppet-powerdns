# == Class: powerdns::backend::gpgsql
#
# Configures PowerdDNS PostgreSQL backend.
# Expects settings to be pulled from Hiera and passed to it.
#

class powerdns::backend::gpgsql (
  $settings,
  $config_file = '/etc/powerdns/pdns.d/gpgsql.conf',
  $install = 'true',
) {

  if $install {
    package { 'pdns-backend-pgsql':
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
