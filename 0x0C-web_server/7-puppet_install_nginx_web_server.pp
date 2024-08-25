# Puppet manifest to configure Nginx with specific requirements

# Install the Nginx package
package { 'nginx':
  ensure => installed,
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => running,
  enable => true,
  require => Package['nginx'],
}

# Create the Nginx configuration file with a server block
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => '
server {
    listen 80;

    location / {
        return 200 "Hello World!";
        add_header Content-Type text/plain;
    }

    location /redirect_me {
        return 301 http://$host/;
    }
}
',
  notify  => Service['nginx'],
}

# Ensure the Nginx configuration file is linked correctly
file { '/etc/nginx/sites-enabled/default':
  ensure => link,
  target => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
}

