# Class: ocsinventory::agent
#
# This module manages OCS inventory agent
class ocsinventory::agent (
  $package_ensure         = $ocsinventory::params::package_ensure,
  $server                 = $ocsinventory::params::server,
  $pause                  = $ocsinventory::params::pause,
  $package_name           = $ocsinventory::params::package_name,
  $ocsinventory_conf_path = $ocsinventory::params::ocsinventory_conf_path,
  $ocsinventory_conf_tmpl = $ocsinventory::params::ocsinventory_conf_tmpl,
) inherits ocsinventory::params {
  package { $package_name :
    ensure  => $package_ensure,
  }
  file { $ocsinventory_conf_path :
    ensure  => present,
    require => Package[$package_name],
    content => template($ocsinventory_conf_tmpl),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }
}
