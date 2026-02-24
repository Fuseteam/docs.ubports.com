.. _DeviceInfo_pulseaudio-module-droid-discover:

pulseaudio-module-droid-discover
================================

Overview of all pulseaudio-module-droid-discover keys::

    <devicename>:
      PulseaudioModulesDroid_ExtraCardArgs: <arguments>
      PulseaudioModulesDroid_ExtraGlueArgs: <arguments>
      PulseaudioModulesDroid_ExtraHidlArgs: <arguments>

About pulseaudio-module-droid-discover
--------------------------------------

pulseaudio-module-droid-discover is a module which loads the correct version of
pulseaudio-module-droid and the related modules, depending on Android version.
Due to how different device vendors implement Android Audio HAL differently,
there's a need to pass arguments to those modules. These Deviceinfo keys allow
you to do so.

For information about what kinds of arguments are needed, see
:doc:`the section "Sound" </porting/configure_test_fix/Sound>`.

Available keys
--------------

====================================  =================================================  ====================================================================
Key                                   Description                                        Value(s)
====================================  =================================================  ====================================================================
PulseaudioModulesDroid_ExtraCardArgs  Arguments to pass to pulseaudio-module-droid       Whitespace-separated list of arguments in the form of <key>=<value>
PulseaudioModulesDroid_ExtraGlueArgs  Arguments to pass to pulseaudio-module-droid-glue  Whitespace-separated list of arguments in the form of <key>=<value>
PulseaudioModulesDroid_ExtraHidlArgs  Arguments to pass to pulseaudio-module-droid-hidl  Whitespace-separated list of arguments in the form of <key>=<value>
====================================  =================================================  ====================================================================

Examples
--------

Device ``sample``'s Audio HAL requires the audio sampling rate of 48000 and
needs to have ``hw_volume`` disabled.

Config file::

    $ cat /etc/deviceinfo/devices/sample.yaml
    sample:
      PulseaudioModulesDroid_ExtraCardArgs: "hw_volume=false rate=48000"
