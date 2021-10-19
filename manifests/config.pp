# == Class: powerdns::config
#
# Configures PowerDNS - expects to have settings pulled from Hiera pulled and passed to it.
#

class powerdns::config (
  $settings,
  $config_path = '/etc/powerdns',
  $config_file = '/etc/powerdns/pdns.conf',
) {

  $tags = ['pdns']
  # Use tags to make sure pdns restarts when the config changes
  Powerdns_config<| tag == 'pdns' |> ~> Service<| tag == 'pdns' |>

  file { $config_path:
    ensure => directory,
    owner  => 'pdns',
    group  => 'pdns',
    mode   => '0755',
    tag    => $tags,
  }

  file { "${config_path}/pdns.d":
    ensure => directory,
    owner  => 'pdns',
    group  => 'pdns',
    mode   => '0755',
  } ->
  file { $config_file:
    ensure => present,
    owner  => 'pdns',
    group  => 'pdns',
    mode   => '0640',
    tag    => $tags,
    notify => Service['powerdns'],
  }

  $settings.each |$setting, $value| {
    powerdns_config { "${config_file}: ${setting}":
      value => $value,
      tag   => $tags,
    }
  }

}
