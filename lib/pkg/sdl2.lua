return {
    source = {
        type      = 'dist',
        location  = 'https://www.libsdl.org/release/SDL2-2.0.4.tar.gz',
        sha256sum = 'da55e540bf6331824153805d58b590a29c39d2d506c6d02fa409aedeab21174b'
    },
    build = {
        type = 'GNU',
        options = {
            '--disable-joystick',
            '--disable-haptic',
            '--disable-oss',
            '--disable-alsa',
            '--disable-esd',
            '--disable-pulseaudio',
            '--disable-arts',
            '--disable-nas',
            '--disable-sndio',
            '--disable-diskaudio',
            '--disable-video-wayland',
            '--disable-video-mir',
            '--disable-video-x11',
            '--disable-video-vivante',
            '--disable-video-cocoa',
            '--disable-video-directfb',
            '--disable-fusionsound',
            '--disable-video-opengl',
            '--disable-video-opengles1',
            '--disable-video-opengles2',
            '--disable-libudev',
            '--disable-dbus',
            '--disable-ibus',
            '--disable-input-tslib',
            '--disable-directx',
            '--disable-rpath',
            '--disable-render-d3d',
            '--without-x',
        }
    },
}
