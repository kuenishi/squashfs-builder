# squashfs-builder

Prerequisite: Docker


Build
```sh
$ make build
```

Make an image
```sh
$ docker run -v `pwd`:/workdir mksquashfs mksquashfs ./COPYING ./Makefile ./test.img
```

Show files in an image
```sh
$ docker run -v `pwd`:/workdir mksquashfs unsquashfs -llc test.img
Parallel unsquashfs: Using 2 processors
3 inodes (2 blocks) to write

-rw-r--r-- root/root             18092 2020-05-06 01:50 squashfs-root/COPYING
-rw-r--r-- root/root                70 2020-05-06 01:52 squashfs-root/Makefile
-rw-r--r-- root/root                 0 2020-05-06 04:41 squashfs-root/test/foo
```
