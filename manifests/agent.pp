class ocsinventory::agent (
  String               $package_name,
  String               $package_ensure,
  Array                $support_packages,
  String               $support_packages_ensure,
  String               $server,
  Integer              $pause,
  Stdlib::Absolutepath $ocsinventory_conf_file,
  String               $ocsinventory_conf_ensure,
  String               $ocsinventory_conf_owner,
  String               $ocsinventory_conf_group,
  String               $ocsinventory_conf_mode,
  String               $ocsinventory_conf_epp,
) {
  package { $::ocsinventory::agent::package_name :
    ensure  => $::ocsinventory::agent::package_ensure,
    require => Package[$::ocsinventory::agent::support_packages],
  }
  package { $::ocsinventory::agent::support_packages :
    ensure  => $::ocsinventory::agent::support_packages_ensure,
  }
  file { $::ocsinventory::agent::ocsinventory_conf_file:
    ensure  => $::ocsinventory::agent::ocsinventory_conf_ensure,
    require => Package[$::ocsinventory::agent::package_name],
    content => epp($::ocsinventory::agent::ocsinventory_conf_epp),
    owner   => $::ocsinventory::agent::ocsinventory_conf_owner,
    group   => $::ocsinventory::agent::ocsinventory_conf_group,
    mode    => $::ocsinventory::agent::ocsinventory_conf_mode,
  }
}
