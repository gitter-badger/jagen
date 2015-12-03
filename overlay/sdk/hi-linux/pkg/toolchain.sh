#!/bin/sh

jagen_pkg_install() {
    : ${jagen_target_toolchain_dir:?}
    : ${jagen_toolchain_dir:?}
    : ${jagen_toolchain_prefix:?}

    local bin name

    rm -fr "$jagen_target_toolchain_dir"
    mkdir -p "$jagen_target_toolchain_dir"

    for bin in "$jagen_toolchain_dir"/bin/*; do
        name="$(basename "$bin" | cut -d- -f5-)"
        ln -sr "$bin" "${jagen_toolchain_prefix}${name}"
    done
}