
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

Older device kernels which require a policy version `"1"` might have to set this switch to `true` in order to have login unlock the home directory successfully.

Devices with newer kernels (5.4 and above) don't require this to be changed, and can solely rely on version 2 of the encryption policies.

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
