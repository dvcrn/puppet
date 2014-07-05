class base {
    include "hostname"
    include "users"
    include "apt"

    class { 'locales': }
    class { 'prezto': }

    Class['prezto'] -> Class['users']

    define install() {
        if(!defined(Package[$title])) {
            package { $title:
                ensure => present
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
