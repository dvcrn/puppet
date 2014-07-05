class sources {
    class { 'apt':
      always_apt_update    => true,
      disable_keys         => true,
      purge_sources_list   => true,
      purge_sources_list_d => true,
    }

    apt::source { 'puppetlabs':
        location    => 'http://apt.puppetlabs.com',
        repos       => 'main',
        release     => 'precise',
        key         => '4BD6EC30',
        key_server  => 'pgp.mit.edu',
        include_src => true
    }

    apt::source { 'ubuntu-main':
        location          => 'http://archive.ubuntu.com/ubuntu',
        release           => 'precise',
        repos             => 'main restricted universe',
        include_src       => true
    }

    apt::source { 'ubuntu-updates':
        location          => 'http://archive.ubuntu.com/ubuntu',
        release           => 'precise-updates',
        repos             => 'main restricted universe',
        include_src       => true
    }

    apt::source { 'ubuntu-security':
        location          => 'http://archive.ubuntu.com/ubuntu',
        release           => 'precise-security',
        repos             => 'main restricted universe multiverse',
        include_src       => true
    }

    apt::source { 'ubuntu-partner':
        location          => 'http://archive.ubuntu.com/ubuntu',
        release           => 'precise-security',
        repos             => 'partner',
        include_src       => true
    }
}
