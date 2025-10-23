
.. _AppArmor:

AppArmor
========

Without AppArmor a number of device features will not function properly and most apps will crash when launched. For more information on AppArmor, refer to the `Ubuntu Wiki. <https://wiki.ubuntu.com/AppArmor>`_

AppArmor is added through a combination of integrating the necessary code into the kernel source tree and setting necessary kernel configuration.

It is generally sufficient to cherry pick certain commits to the kernel source rather than replacing the whole ``apparmor`` directory in the kernel source tree. Follow the link below which corresponds to your device's kernel version and select the most recent block of commits (i.e. all the commits that were added on the same and most recent date):

    * `3.18 AppArmor patches <https://github.com/MotoZ-2016/android_kernel_motorola_msm8996/commits/halium-9.0/security/apparmor>`_
    * `4.4 AppArmor patches <https://github.com/moto-SDM660/android_kernel_motorola_sdm660/commits/halium-9.0/security/apparmor>`_
    * `4.9 AppArmor patches <https://github.com/erfanoabdi/android_kernel_motorola_sdm632/commits/halium-9.0/security/apparmor>`_
    * `4.14 AppArmor patches <https://github.com/kdrag0n/proton_zf6/commits/halium/security/apparmor>`_

Make sure your kernel defconfig has the setting::

    CONFIG_DEFAULT_SECURITY="apparmor"

Now rebuild the boot image, and flash it onto your device. Check if keyboard vibration works. This is a good indication that AppArmor has been successfully applied. Also, check if apps launch normally.
