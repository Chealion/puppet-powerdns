# == Class: powerdns::backend::gmysql
#
# Configures PowerdDNS MySQL backend.
# Expects settings to be pulled from Hiera and passed to it.
# If pdns-backend-mysql is not installed, be sure to install mysql-client on your own.
#

class powerdns::backend::gmysql (
  $settings,
  $config_file = '/etc/powerdns/pdns.d/gmysql.conf',
  $install = 'true',
) {

  if $install {
    package { 'pdns-backend-mysql':
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
