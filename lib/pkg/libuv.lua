package {
    name   = 'libuv',
    build  = {
        type = 'GNU',
        dir  = '$p_work_dir/build${p_config:+-$p_config}'
    },
    source = 'libuv-1.4.2.tar.gz'
}
