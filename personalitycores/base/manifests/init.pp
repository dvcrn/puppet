class base {
    include "sources"
    include "hostname"
    include "users"
    include "dnsclient"

    class { 'locales': }
    class { 'prezto': }

    Class['prezto'] -> Class['users']
    Apt::Source <| |> -> Apt::Builddep <| |>

    define install() {
        if(!defined(Package[$title])) {
            package { $title:
                ensure => present,
                require => Class['apt']
            }
        }
    }

    install { [
        "build-essential",
        "git",
        "python3",
        "vim",
        "tmux",
        "curl",
        "aptitude"
        ]:
    }

    package { [
        'apache2.2-common',
        'apache2.2-bin'
        ]:
        ensure => absent
    }

    cron { 'execute-puppet':
        ensure  => present,
        command => "/opt/puppet/personalitycores/base/files/execute-puppet.sh",
        user    => root,
        minute  => '*/10'
    }
}
