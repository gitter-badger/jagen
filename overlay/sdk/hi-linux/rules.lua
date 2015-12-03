-- HiSilicon Linux SDK

package { 'make', 'host',
    source = 'make-3.81.tar.bz2'
}

package { 'hi-kernel' }

package { 'hi-sdk', 'target',
    { 'build_linux',
        { 'hi-kernel', 'unpack' }
    },
    { 'build_common'      },
    { 'build_msp'         },
    { 'install_linux'     },
    { 'install_common'    },
    { 'install_msp'       },
    { 'install_component' },
}

package { 'cmake-modules' }

package { 'libuv', 'target' }

package { 'ffmpeg', 'target' }

package { 'hi-utils', 'target',
    { 'build',
        { 'cmake-modules', 'unpack' }
    }
}

package { 'karaoke-player', 'target',
    { 'build',
        { 'cmake-modules', 'unpack'                      },
        { 'ffmpeg',        'install',           'target' },
        { 'hi-sdk',        'install_component', 'target' },
        { 'libuv',         'install',           'target' },
    }
}