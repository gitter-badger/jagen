return {
    source = {
        type = 'git',
        location = 'https://github.com/GENIVI/dlt-daemon.git',
        branch = 'v2.16.0',
    },
    build = {
        type = 'CMake',
        options = {
            '-DBUILD_SHARED_LIBS=YES',
            '-DWITH_SYSTEMD=NO',
            '-DWITH_SYSTEMD_WATCHDOG=NO',
            '-DWITH_SYSTEMD_JOURNAL=NO',
            '-DWITH_DOC=NO',
            '-DWITH_MAN=NO',
            '-DWITH_CHECK_CONFIG_FILE=NO',
            '-DWITH_TESTSCRIPTS=NO',
            '-DWITH_GPROF=NO',
            '-DWITH_DLTTEST=NO',
            '-DWITH_DLT_SHM_ENABLE=NO',
            '-DWTIH_DLT_ADAPTOR=NO',
            '-DWITH_DLT_CONSOLE=NO',
            '-DWITH_DLT_EXAMPLES=NO',
            '-DWITH_DLT_SYSTEM=NO',
            '-DWITH_DLT_DBUS=NO',
            '-DWITH_DLT_TESTS=NO',
            '-DWITH_DLT_UNIT_TESTS=NO',
            '-DWITH_DLT_CXX11_EXT=NO',
            '-DWITH_DLT_COREDUMPHANDLER=NO',
            '-DWITH_DLT_LOGSTORAGE_CTRL_UDEV=NO',
            '-DWITH_DLT_LOGSTORAGE_CTRL_PROP=NO',
            '-DWITH_DLT_USE_IPv6=NO',
            '-DWITH_DLT_KPI=NO',
        }
    },
}