class profiles::wordpress {

  include ::apache
  include ::mysql

  user { 'wordpress':
    ensure => present,

