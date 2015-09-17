class apache {

  package { 'httpd':
    ensure => installed,
  }

  file { '/var/www':
    ensure => directory,
  }

  file { '/var/www/html':
    ensure => directory,
  }

  file { '/var/www/html/index.html':
    ensure => file,
    source => 'puppet:///modules/apache/index.html',
  }

  file { '/etc/httpd/conf/httpd.conf':
    ensure => file,
    source => 'puppet:///modules/apache/httpd.conf',
    notify => Service['httpd'],
  }

  service {'httpd':
    ensure  => running,
    require => Package['httpd'],
  }

}
