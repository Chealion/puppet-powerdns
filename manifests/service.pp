# == Class: powerdns::service
#
# Configures PowerDNS - expects to have settings pulled from Hiera pulled and passed to it.
#

class powerdns::service (
  $service_name = 'pdns',
  $service_enable = true,
  $service_ensure = 'running',
) {

  service { 'powerdns':
    name   => $service_name,
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
