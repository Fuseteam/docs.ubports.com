Sound
=====

Ubuntu Touch uses Pulseaudio as the sound server, sitting between the device's Audio HAL and applications and other system components. It's also responsible for controlling Audio HAL for voice calls and Bluetooth headset support.

.. figure:: /_static/images/porting/sound-architecture.svg
        :align: center

Ubuntu Touch utilizes pulseaudio-modules-droid_ from SailfishOS to talk to Audio HAL. The module is responsible for:

- Loading appropriate Audio HAL from vendor partition.
- Presenting audio output (sink) and input (source) to Pulseaudio.
- Configuring Audio HAL correctly for voice call, routing the voice to earpiece, speaker, or Bluetooth headset.

.. _pulseaudio-modules-droid: https://github.com/mer-hybris/pulseaudio-modules-droid

Configuring pulseaudio-modules-droid quirks
-------------------------------------------

Due to how different device vendors implement Android Audio HAL differently, sometimes you'll have to pass arguments to pulseaudio-modules-droid. On Ubuntu Touch, this is done by providing a `Deviceinfo </porting/configure_test_fix/device_info>`_ key ``PulseaudioModulesDroid_ExtraCardArgs``.

The full list of options can be found on the `pulseaudio-modules-droid's GitHub page`_. However, the following are a few options that might have to be added:

- pulseaudio-modules-droid seems to incorrectly detect audio sampling rate on some devices. If the audio output sounds pitched and sped up/down, try adding ``rate=48000`` or ``rate=44100``.
- ``hw_volume=false`` can be used if changing volume seems to do nothing.
- ``use_legacy_stream_set_parameters=true`` can be tried if PulseAudio crashes on starting voicecall and/or voicecall doesn't produce sound.

.. _pulseaudio-modules-droid's GitHub page: https://github.com/mer-hybris/pulseaudio-modules-droid?tab=readme-ov-file#options

Configure pulseaudio-modules-droid to communicate with Binder-based HALs
------------------------------------------------------------------------

On a small number of devices, pulseaudio-modules-droid might not be able to load the Audio HAL directly but has to communicate to it over Binder. As pulseaudio-modules-droid has not been designed to communicate with Audio HAL over Binder, a workaround is needed.

To check if your device needs this workaround or not, run:

::

    ls /android/*/lib64/hw/audio.primary.*

If ``audio.primary.default.so`` is the only output, this usually means the workaround is needed. Follow the following steps to implement the workaround:

1. "Overlay" ``audio.primary.default.so`` with a compatibility module by placing the symlink in the overlay. From the device source repository, run the command:

::

    ln -s \
        /system/lib64/hw/audio.hidl_compat.default.so \
        overlay/vendor/lib64/hw/audio.primary.default.so

``audio.hidl_compat.default.so`` is a wrapper module which implements Audio HAL interface by connecting to the actual Audio HAL over Binder, thus allowing pulseaudio-modules-droid to connect to it.

2. Overlay ``init.disabled.rc`` so that Audio HAL process does not get disabled. Audio HAL process is disabled by default as it's expected that pulseaudio-modules-droid will be able to use Audio HAL directly. This is done by the following:
    - Get a copy of ``init.disabled.rc`` from the booted system. This can be done on booted system using ADB or SSH. For example:

    ::

        adb pull /system/etc/init/init.disabled.rc

    - Modify the file by commenting the sections which mentions ``audio-hal``. The entire section can be commented by placing ``#`` in front. For example:

    ::

        # service vendor.audio-hal-2-0 android.hardware.audio@2.0-service_HYBRIS_DISABLED
        #     disabled
        #     oneshot
        #     override

    - Place the modified file into the overlay directory in the device source repository, at ``overlay/system/etc/init/init.disabled.rc``.

.. note::
    If your port has not migrated to "overlaystore" overlay method, you'll need the overlays in a different location. Contact `UBports porting group <https://t.me/ubports_porting>`_ for help.

