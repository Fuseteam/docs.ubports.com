.. _Overlay:

Overlay file method
===================

Overview
--------

The UBports root filesystem image provides a set of default configuration files for a number of features such as display scaling, sound, bluetooth and more. These files may not be tailored to the device-specific features of the porting target and may therefore have to be adjusted. Furthermore, it may be also be necessary to add additional configuration files as well as scripts for specific needs. Overlay files provide a solution for replacing existing or adding new files to the file system.

The way how overlay files are implemented and their limitations vary across build methods and different versions of Ubuntu Touch.

How mount-based overlay files work
----------------------------------

You can overlay individual files, but also replace or merge existing directories without actually modifying the underlying filesystem.  This works on the Ubuntu Touch root partition as well as Android partitions.

- If a subdirectory contains a special file named ``.halium-override-dir`` that directory will replace the destination directory tree, i.e. the contents of the underlying directory and its descendants will no longer be accessible.

- If a subdirectory contains a special file named ``.halium-overlay-dir`` it will be merged with with the destination directory.  Any file in the underlying directory or descendants thereof remain accessible if no file with the same destination path exists in the overlaying directory tree.  Files and whole directories which only exist in the overlay are made accessible in their respective destination paths.  This is implemented using the overlayfs filesystem (see the `overlayfs documentation <https://www.kernel.org/doc/html/latest/filesystems/overlayfs.html>`_ for the technical details).

- Files in directories containing none of the above special files are bind-mounted over files with an absolute path derived by stripping the above prefix. Subdirectories will be further traversed and evaluated according to the outlined rules.

.. note::

    If your kernel version is old, you may need to apply patches for overlayfs to work.
    Without these patches, you can still overlay individual files, but overlaying/merging whole directories may fail with mounting errors.

.. note::

    You should set the following option in your port's ``deviceinfo`` to enable mount-based overlay files: ``deviceinfo_use_overlaystore="true"``.

The specifics on how an overlay file or directory can be placed there depends on the used build system and will be described below.

Example
"""""""

Contents of ``overlay/system/halium``::

    overlay
    └── system
        └── halium
            └── etc
                ├── foo
                │   ├── .halium-overlay-dir
                │   ├── conf.d
                │   │   ├── 50-drivers.conf
                │   │   └── 90-local.conf
                │   └── foo.conf
                ├── bar
                │   ├── .halium-override-dir
                │   └── bar.conf
                └── bazrc

Contents of the underlying filesystem image::

    /etc
    ├── foo
    │   ├── conf.d
    │   │   ├── 10-global.conf
    │   │   ├── 20-system.conf
    │   │   └── 90-local.conf
    │   └── foo.conf
    ├── bar
    │   ├── bar.conf
    │   └── baz.conf
    └── bazrc

The resulting combined filesystem the looks as follows::

    /etc
    ├── foo
    │   ├── .halium-overlay-dir
    │   ├── conf.d
    │   │   ├── 10-global.conf
    │   │   ├── 20-system.conf
    │   │   ├── 50-drivers.conf (added)
    │   │   └── 90-local.conf   (replaced)
    │   └── foo.conf (replaced)
    ├── bar (replaced)
    │   ├── .halium-override-dir
    │   └── bar.conf
    └── bazrc (replaced)

The directory ``/etc/foo`` has been merged, whereas the ``/etc/bar`` directory and the file ``/etc/bazrc`` have been replaced.

