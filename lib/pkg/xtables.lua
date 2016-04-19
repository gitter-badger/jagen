rule {
    source = 'iptables-1.4.21.tar.bz2',
    build  = {
        type    = 'GNU',
        options = {
            '--disable-ipv6',
            '--enable-devel',
            '--disable-libipq'
        },
        libs = { 'iptc', 'ip4tc', 'ip6tc', 'xtables' }
    }
}
