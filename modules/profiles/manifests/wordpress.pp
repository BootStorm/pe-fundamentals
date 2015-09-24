class profiles::wordpress {

  # hiera lookups here
  $wordpress_user_pwd = hiera('profiles::wordpress::wordpress_user_pwd')
  $mysql_root_password = hiera('profiles::mysql::mysql_root_password')
  $mysql_wordpress_pwd = hiera('profiles::mysql::mysql_wordpress_pwd')
  $apache_wordpress_docroot = hiera('profiles::apache::wordpress_docroot')
  $wordpress_db_name = hiera('profiles::wordpress::wordpress_db_name')


  # base classes to include
  include ::apache
  include ::apache::mod::php
  #include ::mysql

  package { 'wget':
    ensure => installed,
  }

  # wordpress user
  user { 'wordpress':
    ensure   => present,
    password => $wordpress_user_pwd,
  }

  # install the basic database server
  class { '::mysql::server':
    root_password           => $mysql_root_password,
    remove_default_accounts => true,
  }

  # create the database 
  mysql::db { $wordpress_db_name:
    user     => 'wordpress',
    password => $mysql_wordpress_pwd,
    host     => 'localhost',
  }

  class { '::mysql::bindings':
    php_enable => true,
  }

  # configure a basic apache vhost for this
  apache::vhost { 'wordpress.puppetlabs.vm':
    docroot => $apache_wordpress_docroot,
  }

  #configure the basic wordpress instance
  class { 'wordpress':
    db_user        => 'wordpress',
    db_password    => $mysql_wordpress_pwd,
    db_name        => $wordpress_db_name,
    create_db      => false,
    create_db_user => false,
    install_dir    => $mysql_wordpress_docroot,
  }

}

