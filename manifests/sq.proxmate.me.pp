node /^(.*)\.sq\.proxmate\.me$/ {
    include "base"
    include "squid"

    file {"/etc/squid/":
        ensure => directory,
        group => root,
        owner => root
    }

    file { "/etc/squid/fetch_whitelist.py":
        ensure => present,
        group => root,
        owner => root,
        source => "puppet:///modules/squid/fetch_whitelist.py",
        mode    => 771,
        require => File["/etc/squid/"]
    }

    cron { 'whitelist-update':
        ensure  => absent
    }

    # cron { 'whitelist-update':
    #     ensure  => present,
    #     command => "/etc/squid/fetch_whitelist.py",
    #     user    => root,
    #     minute  => '*/10',
    #     require => File["/etc/squid/"]
    # }
}
