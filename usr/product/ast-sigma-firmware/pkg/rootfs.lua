return {
    source = {
        type     = 'git',
        location = 'git@bitbucket.org:art-system/sigma-rootfs.git'
    },
    build = {
        type = 'make',
        in_source = true,
        unset_cflags = true,
        jobs = 1
    },
    export = {
        root = '$pkg_source_dir/build_mipsel/root',
        prefix = '$pkg_source_dir/cross_rootfs'
    }
}
