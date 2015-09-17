class users::admins {
  

  package { 'csh':
    ensure => installed,
  }

  group { 'staff':
    ensure => present,
  }

  user { 'admin':
    ensure => present,
    gid    => 'staff',
    shell  => '/bin/csh',
  }
}

