class apache (
  $httpd_user = $apache::params::httpd_user,
  $httpd_group = $apache::params::httpd_group,
  $httpd_pkg = $apache::params::httpd_pkg,
  $httpd_svc = $apache::params::httpd_svc,
  $httpd_conf = $apache::params::httpd_conf,
  $httpd_confdir = $apache::params::httpd_confdir,
  $httpd_docroot = $apache::params::httpd_docroot,
) inherits apache::params {

  File {
    owner => $httpd_user,
    group => $httpd_group,
    mode  => '0644',
  }

  package { $httpd_pkg:
    ensure => installed,
  }

  file { $httpd_docroot:
    ensure => directory,
  }

  file { '/var/www/html/index.html':
    ensure   => file,
    content  => template('apache/index.html.erb'),
  }

  file { "${httpd_confdir}/${httpd_conf}":
    ensure => file,
    source => "puppet:///modules/apache/${httpd_conf}",
    notify => Service['httpd'],
  }

  service {'httpd':
    ensure  => running,
    name    => $httpd_svc,
    require => Package['httpd'],
  }

}
