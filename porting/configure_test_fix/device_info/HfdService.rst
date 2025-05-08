.. _DeviceInfo_HfdService:

hfd-service
===========

Overview of all hfd-service keys::

    <devicename>:
      SingleColorLedSysfsPath: </path/to/the/device>
      VibrateDurationExtraMs: <any integer value>

Device quirks
-------------

=======================  =============================================  ==================
Key                      Description                                    Value(s)
=======================  =============================================  ==================
SingleColorLedSysfsPath  File path to notification LED device           File path
VibrateDurationExtraMs   Milliseconds to extend all vibration calls by  Any integer number
=======================  =============================================  ==================

Examples
--------

Device ``sample`` using:

- Single-color notification LED controllable via ``/sys/class/leds/green/brightness``
- Extend vibrations by 50 milliseconds to feel the on-screen keyboard haptics on devices with simpler on/off vibration motors

Config file::

    $ cat /etc/deviceinfo/devices/sample.yaml
    sample:
      SingleColorLedSysfsPath: /sys/class/leds/green
      VibrateDurationExtraMs: 50
