class sources {
    class { 'apt':
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

    apt::source { 'ubuntu-extras':
        location          => 'http://archive.canonical.com/ubuntu',
        release           => 'precise',
        repos             => 'partner',
    }

    apt::source { 'ubuntu-extras':
        location          => 'http://extras.ubuntu.com/ubuntu',
        release           => 'precise',
        repos             => 'main',
        key               => '16126D3A3E5C1192',
        key_server        => 'subkeys.pgp.net'
    }
}
