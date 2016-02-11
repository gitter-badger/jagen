-- Common Android rules

package { 'make', 'host',
    source = 'make-3.81.tar.bz2'
}

package { 'android',
    { 'configure',
        requires = { { 'make', 'host' } }
    },
    { 'compile' }
}
