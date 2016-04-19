rule {
    source = 'SDL2-2.0.4.tar.gz',
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
