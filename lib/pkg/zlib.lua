rule {
    source = 'zlib-1.2.8.tar.gz',
    build  = {
        type = 'make',
        in_source = true
    }
}
