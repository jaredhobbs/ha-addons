# Home Assistant Add-on: AMRIDM2MQTT add-on

_Send AMR/ERT Power Meter Data Over MQTT_

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

Using an [inexpensive rtl-sdr dongle][rtl-sdr],
it's possible to listen for signals from ERT compatible smart meters using rtlamr.
This script runs as a daemon, launches rtl_tcp and rtlamr, and parses the output
from rtlamr. If this matches your meter, it will push the data into MQTT.

This code is adapted from MIT licensed code written by Ben Johnson and released
on his [github page][amridm2mqtt].

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[rtl-sdr]: https://www.amazon.com/s/ref=nb_sb_noss?field-keywords=RTL2832U
[amridm2mqtt]: https://github.com/ragingcomputer/amridm2mqtt
