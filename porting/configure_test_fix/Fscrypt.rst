
.. _FileSystemEncryption:

Filesystem encryption
=====================

Filesystem encryption in this document refers to encrypting files on a per-file basis using "File Based Encryption", in comparison to "Full Disk Encryption".

Encryption on Ubuntu Touch is solved using `fscrypt. <https://github.com/google/fscrypt>`_

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

Older device kernels which require a policy version `"1"` will have to set this switch to `true` in order to have login unlock the home directory successfully.

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
