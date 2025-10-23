Installing the kernel
---------------------

After your kernel is done building, you will have to build the rootfs. For this, just execute this:

``./build/prepare-fake-ota.sh out/device_<your device's codename>_usrmerge.tar.xz ota``
This will download the rootfs, extract it and pack it into tarballs for our final script to create flashable images.

Next up, run:

``./build/system-image-from-ota.sh ota/ubuntu_command images``
This will convert the tarballs into flashable images, and your images will be stored in the `images/` directory. There will be a number of files depending on how you configured your deviceinfo.
But the basic file structure will be as given:

|    images/
|    ├── boot.img
|    ├── rootfs.img
|    └── system.img


The ``boot.img`` will be flashed onto the boot partition of the phone.
The ``system.img`` and ``rootfs.img`` are interchangable. ``rootfs.img`` is pushed to the data partition as ``ubuntu.img`` if you didn't include ``systempart`` in deviceinfo's cmdline.
Otherwise, ``system.img`` is flashed to your system partition.

info::

    Ensure that the rootfs image file is named `ubuntu.img`, if you do not use system-as-root.
    The device will not boot correctly if it is `rootfs.img`, as certain partitions will not be mounted correctly.

Notes
^^^^^

For a lot of kernel-related commands, you'll need the ARCH variable's value, this is either arm or arm64 depending on where you found your defconfig. A thing to keep in mind for kernel patches.
