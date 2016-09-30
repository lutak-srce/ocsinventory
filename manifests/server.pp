#
# = Class: ocsinventory::server
#
# This module manages OCS inventory server
class ocsinventory::server (
  $package              = $::ocsinventory::params::package_server,
  $version              = 'installed',
  $logdir               = '/var/log/ocsinventory-server',
  $configure_apache     = true,
  $template_serverconf  = 'ocsinventory/ocsinventory-server.conf.erb',
  $path_serverconf      = $::ocsinventory::params::path_serverconf,
  $dependency_class     = $::ocsinventory::params::dependency_class,
  $my_class             = $::ocsinventory::params::my_class,
) inherits ocsinventory::params {

  ### Extra classes
  if $dependency_class { include $dependency_class }
  if $my_class         { include $my_class         }

  File {
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['ocsinventory'],
  }

  package { 'ocsinventory':
    ensure => $version,
    name   => $package,
  }

  if ( $configure_apache ) {
    file { '/etc/ocsinventory-server.conf':
      path    => $path_serverconf,
      content => template($template_serverconf),
    }
  }

}
