define apache::vhost (
  $docroot,
  $port = '80',
  $priority = '10',
  $options = 'Indexes MultiViews',
  $vhost_name = $title,
  $servername = $title,
  $logdir = '/var/log/httpd',
) {
  file { "/etc/httpd/conf.d/${title}.conf":
    ensure  => file,
    owner   => 'apache',
    group   => 'apache',
    mode    => '0644',
    content => template('apache/vhost.conf.erb'),
  }
}
