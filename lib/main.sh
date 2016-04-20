#!/bin/sh

# deal with it
if [ "$ZSH_VERSION" ]; then
    setopt shwordsplit
fi

jagen_FS=$(printf '\t')
jagen_IFS=$(printf '\n\t')

export jagen_shell=""

export jagen_debug="${jagen_debug}"
export jagen_flags=""

export jagen_product=""
export jagen_board=""
export jagen_sdk=""
export jagen_toolchain=""

export jagen_import_path=""

export jagen_lib_dir="${jagen_dir:?}/lib"

export jagen_bin_dir="$jagen_root/bin"
export jagen_src_dir="$jagen_root/src"
export jagen_build_dir="$jagen_root/build"
export jagen_include_dir="$jagen_root/include"
export jagen_log_dir="$jagen_build_dir"

export jagen_toolchain_dir
export jagen_sdk_dir

jagen_build_verbose="no"

. "$jagen_lib_dir/common.sh" || return

# Avoid import during init-root
if [ "$jagen_root" ]; then
    try_include "$jagen_root/config.sh"
fi

if [ "$jagen_product" ]; then
    jagen_import_path="$jagen_dir/usr/product/$jagen_product"
fi
if [ "$jagen_board" ]; then
    jagen_import_path="$jagen_dir/usr/board/$jagen_board"
fi
if [ "$jagen_sdk" ]; then
    jagen_import_path="$jagen_dir/usr/sdk/$jagen_sdk"
fi
if [ "$jagen_toolchain" ]; then
    jagen_import_path="$jagen_dir/usr/toolchain/$jagen_toolchain"
fi

export jagen_host_dir="$jagen_root/host"

export jagen_target_dir="$jagen_root/target"

export LUA_PATH="$jagen_dir/lib/?.lua;$jagen_dir/src/?.lua;;"

add_PATH "$jagen_host_dir/bin"
add_LD_LIBRARY_PATH "$jagen_host_dir/lib"

export PATH
export LD_LIBRARY_PATH
export LINGUAS=""

in_flags ccache && use_env ccache

import env