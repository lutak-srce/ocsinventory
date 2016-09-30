#
# = Class: ocsinventory::reports
#
# This module manages OCS reports
class ocsinventory::reports (
  $package              = $::ocsinventory::params::package_reports,
  $version              = 'installed',
  $template_dbconfig    = 'ocsinventory/dbconfig.inc.erb',
  $path_dbconfig        = $::ocsinventory::params::path_reports_dbconfig,
  $file_owner           = $::ocsinventory::params::file_owner_reports,
  $file_group           = $::ocsinventory::params::file_group_reports,
  $file_mode            = '0640',
  $db_server            = 'localhost',
  $db_name              = 'ocsweb',
  $db_username          = 'ocs',
  $db_password          = 'ocs',
) inherits ocsinventory::params {

  File {
    ensure  => present,
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    require => Package['ocsinventory-reports'],
  }

  package { 'ocsinventory-reports':
    ensure => $version,
    name   => $package,
  }

  file { '/etc/ocsinventory/ocsinventory-reports/dbconfig.inc.php':
    path    => $path_dbconfig,
    content => template($template_dbconfig),
  }

}
