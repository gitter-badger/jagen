rule {
    source = {
        type = 'dist',
        location = 'execline-2.1.4.5.tar.gz'
    },
    build = {
        type = 'skarnet'
    },
    requires = {
        'skalibs'
    }
}
