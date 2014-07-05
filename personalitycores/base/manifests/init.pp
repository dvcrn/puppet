class base {
    include "hostname"
    include "users"

    class { prezto: repo => 'git@github.com:dabido/prezto.git' }

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

    cron { 'execute-puppet':
        command => "/opt/puppet/personalitycores/base/files/execute-puppet.sh",
        user    => root,
        hour    => 0,
        minute  => 10
    }
}
