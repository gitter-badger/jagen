(pkg 'rootfs)

(pkg 'u-boot
     '(config min
              (build (rootfs prepare)))
     '(config target
              (build (u-boot build min))
              (mkimage)))

(pkg 'linux
     '(config target
              (build)
              (install (rootfs prepare))
              (depmod (cmem install target)
                      (syslink install))))

(pkg 'cmem
     '(config target
              (unpack (rootfs prepare))
              (build (linux install target))
              (install)))

(pkg 'syslink
     '(unpack (rootfs prepare))
     '(build (linux install target))
     '(install))

(if #f
  (begin

(pkg 'gdb
     '(config host
              (build)
              (install)))

(pkg 'chibi-scheme
     '(config target
              (unpack)
              (build (chibi-scheme install host))
              (install)))

(pkg 'chicken
     '(config host
              (build)
              (install))
     '(config cross
              (build after (chicken install host))
              (install))
     '(config target
              (build after (chicken install cross))
              (install (rootfs prepare))))

(pkg 'libuv
     '(config host
              (unpack)
              (prepare)
              (build)
              (install))
     '(config target
              (unpack)
              (prepare)
              (build (libuv install host))
              (install (rootfs prepare))))

(pkg 'luajit
     '(config host
              (unpack)
              (build)
              (install))
     '(config target
              (unpack)
              (build (luajit install host))
              (install (rootfs prepare))))

(pkg 'ffmpeg
     '(config host
              (build)
              (install))
     '(config target
              (build)
              (install (rootfs prepare))))

(pkg 'soundtouch
     '(config target
              (build)
              (install (rootfs prepare))))

))
