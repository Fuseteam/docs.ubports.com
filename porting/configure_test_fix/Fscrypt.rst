
.. _FileSystemEncryption:

Filesystem encryption for Ubuntu Touch 24.04
============================================

Filesystem encryption in this document refers to encrypting files on a per-file basis using "File Based Encryption", in comparison to "Full Disk Encryption".

Encryption on Ubuntu Touch 24.04 is solved using `fscrypt. <https://github.com/google/fscrypt>`_

Technical details
-----------------

Instead of Full Disk Encryption like LUKS would provide, fscrypt enables encryption baked into the ext4 and f2fs filesystems, for individual directory hierarchies. This way the system can boot off of an unencrypted root file system while postponing PIN entry until the point where it's needed. This is especially important with the Ubuntu Touch partitioning scheme.

This is accomplished by loading a user's key into either the user's keyring (policy v1) or the filesystem keyring (policy v2), with which the file system can then encrypt the data. Loading the key into the user's keyring has the effect of disallowing file decryption for other users, even root. With filesystem keyring in use, things like Docker with access to the home directory work properly.

All directories set up by the user using the login protector (PIN or password) will unlock at bootup when the user unlocks their device. This means that the user might have potentially added multiple additional directories to encrypt.

Creating an fscrypt.conf file
-----------------------------

A new device port requires a pre-configured file in `/etc/fscrypt.conf` to be present. In order to support encryption on the device this is a must to overlay.

Run `sudo fscrypt setup` to generate a new file.

The resulting configuration file might look like::

  {
      "source": "custom_passphrase",
      "hash_costs": {
          "time": "12",
          "memory": "131072",
          "parallelism": "8"
      },
      "options": {
          "padding": "32",
          "contents": "AES_256_XTS",
          "filenames": "AES_256_CTS",
          "policy_version": "1"
      },
      "use_fs_keyring_for_v1_policies": false,
      "allow_cross_user_metadata": false
  }

use_fs_keyring_for_v1_policies configuration switch
---------------------------------------------------

Device adaptations which ship with policy version `"2"` but want to keep supporting already encrypted version `"1"` storage will have to set this switch to `true` in order to have login unlock the home directory and store the key in the filesystem's keyring.

Devices shipping with newer kernels (5.4 and above) don't require this to be changed, and can solely rely on version 2 of the encryption policies.

Device info configuration
-----------------------------

To signify finished configuration, and to unlock the encryption UI from within lomiri-system-settings, the DeviceInfo config switch `FilesystemEncryption` needs to be set to `true`.


Example::

  sargo:
    Vendor: Google
    PrettyName: Pixel 3a
    DeviceType: phone
    GridUnit: 25
    SupportedOrientations:
      - Portrait
      - Landscape
      - InvertedLandscape
    FilesystemEncryption: true

Only after this will you be able to set up encryption on your device.

Kernel backports
----------------

If your device uses kernel version 4.14 or 4.19, then you can backport policy version 2 support from the `Android Common Kernel <https://android.googlesource.com/kernel/common/>`_ repository. To fetch sources from there, add the remote to your Git tree::

  git remote add google https://android.googlesource.com/kernel/common

An easy way to "transplant" policy v2 support is by finding the nearest Common Kernel version which has policy v2 support matching your device's kernel version, and checking out individual files related to fscrypt and supported filesystems in your kernel tree. To get started, find a commit which merges the commit `"fscrypt: v2 encryption policy support"` and related commits into the Common Kernel.

For example, if the device kernel is using 4.19.81, according to the Common Kernel's Git history an appropriate source base would be `commit c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 <https://android.googlesource.com/kernel/common/+/c2ad33f0296a2528fd0bf4e96af0802dad0b1b27>`_, which is based on version 4.19.78 and a close match to the rest of the source tree. Fetch those sources using::

  git fetch google c2ad33f0296a2528fd0bf4e96af0802dad0b1b27

After determining the right commit, check out `fs/crypto` and encryption-supporting filesystems at that commit (replace the commit hash in the example with your determined match)::

  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/crypto/
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/f2fs/
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/ext4
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/ubifs
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/linux/f2fs_fs.h
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/linux/fs.h
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/linux/fscrypt.h
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/uapi/linux/fs.h
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/uapi/linux/fscrypt.h

Should the compilation of your kernel fail at first with missing identifier errors, undefined references or missing files, compare with the Common Kernel and check out missing changes and dependencies individually::

  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/verity
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/unicode
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/direct-io.c
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- fs/inode.c
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- mm/mmap.c
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- block/blk-merge.c
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/linux/mm.h
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/linux/dcache.h
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/linux/fsverity.h
  git checkout c2ad33f0296a2528fd0bf4e96af0802dad0b1b27 -- include/uapi/linux/fsverity.h

Should your device kernel have inter-dependencies between crypto code, filesystem code and other drivers, then you will have to break those dependencies by manually changing the code to accommodate for the newer fscrypt. For example, on Qualcomm devices the `"qseecom"` driver might call into functions overwritten by the manual checkout, and you will have to supplement those missing functions in your adaptation. Kernels with `"sdcardfs"` enabled will have to adapt the sdcardfs driver to work with the new fscrypt, either by forward-porting missing functions or by simply removing them.
