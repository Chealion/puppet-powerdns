Really simple PowerDNS module that expects a site module to pass in settings pulled from Hiera as k/v store and writes it to the PowerDNS configs.

Example use:

Hiera:
    powerdns::setting_name: value
    powerdns::setting_name_2: value

    powerdns::backend::setting_name: value
    powerdns::backend::setting_name: value

Manifest:
  include ::powerdns::install
  include ::powerdns::config
  include ::powerdns::backend::gmysql
  include ::powerdns::service

