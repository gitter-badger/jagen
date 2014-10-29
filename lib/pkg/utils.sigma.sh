#!/bin/sh

p_type="git"
p_address="git@bitbucket.org:art-system/sigma-utils.git"

psourcedir="$ja_srcdir/sigma-utils"
pbuilddir="$pworkdir${pconfig:+/$pconfig}"

pkg_build_host() {
    use_env tools

    p_run cmake -G"$cmake_generator" \
        -DCMAKE_BUILD_TYPE="$ja_buildtype" \
        -DCMAKE_INSTALL_PREFIX="$toolsdir" \
        -DUSE_LOOPAES=0 \
        ${losetup:+"-DLOSETUP=$losetup"} \
        "$psourcedir"

    p_run cmake --build . -- $cmake_build_options
}

pkg_build_target() {
    p_run cmake -G"$cmake_generator" \
        -DCMAKE_BUILD_TYPE="$ja_buildtype" \
        -DCMAKE_INSTALL_PREFIX="$sdk_rootfs_root" \
        -DUSE_LOOPAES=1 \
        "$psourcedir"

    p_run cmake --build . -- $cmake_build_options
}

pkg_install_host() {
    p_run cmake --build . --target install
}

pkg_install_target() {
    p_run cmake --build . --target install
}
