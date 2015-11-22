# Class: ocsinventory::params
#
# This module manages OCS inventory agent
#
class ocsinventory::params {
  $package_ensure = 'latest'
  $server = 'localhost'
  $pause = 0
  case $::osfamily {
    /(RedHat|redhat)/: {
      $ocsinventory_conf_path = '/etc/sysconfig/ocsinventory-agent'
      $ocsinventory_conf_tmpl = 'ocsinventory/ocsinventory-agent.erb'
      $package_name           = 'ocsinventory-agent'
    }
    /(Debian|debian|Ubuntu|ubuntu)/: {
      $ocsinventory_conf_path = '/etc/ocsinventory/ocsinventory-agent.cfg'
      $ocsinventory_conf_tmpl = 'ocsinventory/ocsinventory-agent.cfg.erb'
      $package_name           = 'ocsinventory-agent-srce'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
    }
  }
}
