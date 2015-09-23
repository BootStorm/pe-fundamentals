class hosts::staging {

  class {'::staging':
    path  => '/var/staging',
    owner => 'root',
    group => 'root',
  }
}

