class squid {

    if(!defined(Package['build-essential'])) {
        package { 'build-essential':
          ensure => present,
        }
    }

    # Since there is no package for 3.4 available, we'll just compile it ourselves.
    puppi::netinstall { 'squid':
        url => 'http://www.squid-cache.org/Versions/v3/3.4/squid-3.4.6.tar.gz',
        extracted_dir => 'squid-3.4.6',
        destination_dir => '/tmp',
        postextract_command => '/tmp/squid-3.4.6/configure --prefix=/usr  --localstatedir=/var --libexecdir=${prefix}/lib/squid --srcdir=. --datadir=${prefix}/share/squid --sysconfdir=/etc/squid --with-default-user=proxy --with-logdir=/var/log --with-pidfile=/var/run/squid.pid && make && sudo make install'
    }

    file {"/etc/init.d/squid":
        ensure => present,
        group => root,
        owner => root,
        source => "puppet:///modules/squid/initscript",
        mode => 751
    }

    file {"/etc/init/squid.conf":
        ensure => present,
        group => root,
        owner => root,
        source => "puppet:///modules/squid/upstart",
        mode => 751
    }

    file {"/etc/squid/squid.conf":
        ensure => present,
        group => root,
        owner => root,
        source => "puppet:///modules/squid/squid.conf",
    }

    file { "/etc/squid/whitelist":
        ensure => present,
        group => root,
        owner => root,
        require => Puppi::Netinstall['squid'],
    }


    service {"squid":
        ensure => running,
        require => [
            Puppi::Netinstall['squid'],
            File['/etc/squid/squid.conf'],
            File['/etc/init.d/squid'],
            File['/etc/init/squid.conf'],
            File['/etc/squid/whitelist']
        ]
    }
}
