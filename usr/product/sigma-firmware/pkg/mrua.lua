return {
    source = {
        type     = 'git',
        location = 'git@bitbucket.org:art-system/sigma-mrua.git',
        branch   = '3.11.3'
    },
    build = {
        type = 'custom',
        in_source = true
    },
    install = {
        modules = '$pkg_source_dir/modules/$jagen_kernel_release'
    }
}
