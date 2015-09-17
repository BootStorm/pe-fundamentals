class apache {

  case $::operatingsystem {
    'Ubuntu': {
      $httpd_user = 'www-data'
      $httpd_group = 'www-data'
      $httpd_pkg = 'apache2'
      $httpd_svc = 'apache2'
      $httpd_conf = 'apache2.conf'
      $httpd_confdir = '/etc/apache2'
      $httpd_docroot = '/var/www'
    }
    'CentOS': {
      $httpd_user = 'apache'
      $httpd_group = 'apache'
      $httpd_pkg = 'httpd'
      $httpd_svc = 'httpd'
      $httpd_conf = 'httpd.conf'
      $httpd_confdir = '/etc/httpd/conf'
      $httpd_docroot = '/var/www/html'
    }
    default: {
      fail('oh noes its all gone to cheese')
    }
  }

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
    ensure => file,
    source => 'puppet:///modules/apache/index.html',
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
