#!/bin/sh

. "$jagen_dir/lib/env.sh" ||
    { echo "Failed to load environment"; exit 1; }

: ${pkg_run_jobs:=$(nproc)}
: ${pkg_run_on_error:=exit}

pkg_run() {
    local cmd="$1"
    debug "$*"
    shift

    case $cmd in
        make)
            cmd="$cmd -j$pkg_run_jobs"
            [ "$jagen_build_verbose" = "yes" ] && cmd="$cmd V=1"
            ;;
        ninja)
            cmd="$cmd -j$pkg_run_jobs"
            [ "$jagen_build_verbose" = "yes" ] && cmd="$cmd -v"
            ;;
    esac

    $cmd "$@" || $pkg_run_on_error
}

pkg_clean_dir() {
    local dir="$1"
    if [ -d "$dir" ]; then
        rm -rf "$dir"/* ||
            die "Failed to clean directory: $dir"
    else
        mkdir -p "$dir" ||
            die "Failed to create directory: $dir"
    fi
}

pkg_strip_dir() {
    local root files
    root="$1"
    files=$(find "$root" -type f -not -name "*.ko" \
        "(" -path "*/lib*" -o -path "*/bin*" -o -path "*/sbin*" ")" | \
        xargs -r file | grep "ELF.*\(executable\|shared object\).*not stripped" | cut -d: -f1)

    for f in $files; do
        pkg_run "$STRIP" -v --strip-unneeded \
            -R .comment \
            -R .GCC.command.line \
            -R .note.gnu.gold-version \
            "$f"
    done
}

pkg_run_patch() {
    pkg_run patch -p${1} -i "$jagen_patch_dir/${2}.patch"
}

pkg_install_modules() {
    mkdir -p "$jagen_kernel_extra_modules_dir"
    touch "$jagen_kernel_modules_dir/modules.order"
    touch "$jagen_kernel_modules_dir/modules.builtin"
    for m in "$@"; do
        local f="$PWD/${m}.ko"
        cp "$f" "$jagen_kernel_extra_modules_dir"
    done &&
        (
    cd $jagen_kernel_dir/linux && \
        /sbin/depmod -ae -F System.map -b $INSTALL_MOD_PATH $jagen_kernel_release
    )
}

pkg_run_depmod() {
    pkg_run /sbin/depmod -ae \
        -F "$LINUX_KERNEL/System.map" \
        -b "$INSTALL_MOD_PATH" \
        "$jagen_kernel_release"
}

pkg_fix_la() {
    local filename="$1"
    local prefix=${2:-"$jagen_sdk_rootfs_prefix"}
    debug "fix la $filename $prefix"
    pkg_run sed -i "s|^\(libdir=\)'\(.*\)'$|\1'${prefix}\2'|" "$filename"
}

pkg_run_autoreconf() {
    pkg_run autoreconf -if -I "$jagen_host_dir/share/aclocal"
}

pkg_link() {
    local dst="${1:?}" src="${2:?}"

    pkg_run cd $(dirname "$dst")
    pkg_run rm -rf "$src"
    pkg_run ln -rs $(basename "$dst") "$src"
}

jagen_pkg_clean() {
    set -- $pkg_source
    local kind="$1"

    case $kind in
        git|hg)
            if in_list "$pkg_name" $jagen_source_exclude; then
                message "pkg source '$pkg_name' excluded from cleaning"
            elif [ -d "$pkg_source_dir" ]; then
                _jagen src clean "$pkg_name"
            fi
            ;;
    esac

    pkg_clean_dir "$pkg_work_dir"
}

default_unpack() {
    set -- $pkg_source
    local src_type="$1"
    local src_path="$2"

    [ "$pkg_source" ] || return 0

    case $src_type in
        git|hg|repo)
            if [ -d "$pkg_source_dir" ]; then
                if in_flags offline; then
                    message "not updating $pkg_name: offline mode"
                elif _jagen src dirty "$pkg_name"; then
                    warning "not updating $pkg_name: $pkg_source_dir is not clean"
                else
                    _jagen src update "$pkg_name"
                fi
            else
                if in_flags offline; then
                    die "could not clone $pkg_name in offline mode"
                else
                    _jagen src clone "$pkg_name"
                fi
            fi
            ;;
        dist)
            pkg_run tar -C "$pkg_work_dir" -xf "$src_path"
            ;;
        *)
            die "unknown source type: $src_type"
    esac
}

jagen_pkg_unpack() { default_unpack; }

default_patch() {
    if [ ! -x "$pkg_source_dir/configure" -a -x "$pkg_source_dir/autogen.sh" ]; then
        "$pkg_source_dir/autogen.sh"
    fi
}

jagen_pkg_configure() {
    pkg_run cd "$pkg_source_dir"
    if [ "$pkg_with_provided_libtool" ]; then
        pkg_run_autoreconf
    fi
}

default_build() {
    if [ -x "$pkg_source_dir/configure" ]; then
        pkg_run "$pkg_source_dir/configure" \
            --host="$pkg_system" \
            --prefix="$pkg_prefix" \
            $pkg_options
        pkg_run make
    fi
}

default_install() {
    pkg_run make DESTDIR="$pkg_dest_dir" install

    for name in $pkg_libs; do
        pkg_fix_la "$pkg_dest_dir$pkg_prefix/lib/lib${name}.la" "$pkg_dest_dir"
    done
}

jagen_pkg_patch_pre() {
    pkg_run cd "$pkg_source_dir"
}

jagen_pkg_patch() { default_patch; }

jagen_pkg_build() { default_build; }

jagen_pkg_install() { default_install; }
