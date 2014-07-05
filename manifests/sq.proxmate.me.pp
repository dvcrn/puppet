node /^(.*)\.sq\.proxmate\.me$/ {
    include "base"
    include "squid"

    file { "/etc/squid/fetch_whitelist.py":
        ensure => present,
        group => root,
        user => root,
        source => "puppet:///modules/squid/fetch_whitelist.py",
    }

    cron { 'execute-puppet':
        command => "/etc/squid/fetch_whitelist.py",
        user    => root,
        hour    => 0,
        minute  => 10,
        mode    => 771
    }
}
