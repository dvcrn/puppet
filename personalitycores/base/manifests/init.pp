class base {
    include "hostname"
    include "users"

    class { 'locales': }
    class { 'prezto': }
    class { 'sources': }

    Class['prezto'] -> Class['users']

    define install() {
        if(!defined(Package[$title])) {
            package { $title:
                ensure => present,
                require => Class['sources']
            }
        }
    }

    install { [
        "build-essential",
        "git",
        "python3",
        "vim",
        "tmux"
        ]:
    }

    package { 'apache2':
        ensure => absent
    }

    cron { 'execute-puppet':
        ensure  => present,
        command => "/opt/puppet/personalitycores/base/files/execute-puppet.sh",
        user    => root,
        minute  => '*/10'
    }
}
