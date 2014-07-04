class users () {
    $existingUsers = {
        'david' => {
            'ssh_key' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDTC6FO37muxMbhQ8v3LwnkVcuIAzeJuyVN7L8Ljrs4coCHS1HJBlUQRXEf+3dADy6kaqiH1W/XVyF5ErYuCQywIStD3KsE3n9BvjdAc4v1VSYsbemD5NZUH/hZe+p2w9xHeut+l8B1S4zqp3hcXAQZMMwQ8kKieJq2iIbBJhsduwEZ5gLFdAF5nAiIbFrMsgmOEMd2u6rR7I7InYUX1qpLncyT5V3yTQHVMjnis5oupwSK+YfjiEodTtGGm+d8m9Q/J5cm4VhKVUF1DD2x+mShvLIQy90MW3VN8YzEqwQgecwweoEpDQ1ZnVeUVt9d0bKZ+iCY+SLdlnFl3tutZNy5',
        }
    }

    $removedUsers = []
    create_resources(createUser, $existingUsers)

    prezto::install { "root":
        repo => 'https://github.com/dabido/prezto.git'
    } -> changeTheme { "root": }
}

define changeTheme() {
    if $title == 'root' { $home = '/root' } else { $home = "/home/${title}" }

    file_line { "Activate theme steeef for ${title}":
        path => "/${home}/.zpreztorc",
        line => "zstyle ':prezto:module:prompt' theme 'steeef'",
        match   => "^zstyle ':prezto:module:prompt' theme 'steeef'$",
    }
}

define createUser($ssh_key) {
    user { $name:
        ensure => 'present',
        home => "/home/${name}",
        managehome => true,
        password => '!',
        shell   => '/usr/bin/zsh',
        require => Package['zsh']
    }

    ssh_authorized_key { $name:
        ensure => 'present',
        user => $name,
        type => 'rsa',
        key => $ssh_key,
        require => User[$name]
    }

    sudo::conf { $name:
        priority => 10,
        content => "${name} ALL=(ALL) NOPASSWD: ALL",
        require => User[$name]
    }

    prezto::install { $name: } -> changeTheme { $name: }
}
