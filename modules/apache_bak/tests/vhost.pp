apache::vhost { 'elmo.puppetlabs.com':
  docroot => '/var/www/muppets/elmo',
  options => '-MultiViews',
}

apache::vhost { 'piggy.puppetlabs.com':
  docroot => '/var/www/muppets/piggy',
  options => 'Indexes MultiViews',
}
