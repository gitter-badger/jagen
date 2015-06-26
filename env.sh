#!/bin/sh

export jagen_root="$PWD"
export jagen_build_root="$PWD"

. "$jagen_root/lib/env.sh" ||
    { echo "Failed to load environment"; return 1; }

p_path_prepend "$target_bin_dir"
p_path_prepend "$pkg_private_dir/bin"
p_path_prepend "$jagen_root/bin"
