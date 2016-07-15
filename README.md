Edison Wifi Setup Script
======================

A minimium script to configure a Wi-Fi network on Debian systems for Intel Edisons. 

You don't need wired network connection, direct changing linux partition or even a screen. 

This script may also be used in any Linux system with wpa_supplicant tools installed. 

System requirements
----------------------
* Linux system
* wpa\_supplicant installed, wpa\_cli command available
* A Wi-Fi network card supported by your system

How to use (generally)
----------------------
1. Edit the script file `setupWifi.sh`, enter your Wi-Fi SSID and password. 
2. Execute with `./setupWifi.sh` using root privilege. (by root user or via sudo)

You can now connect to your Edison via SSH if you know its IP Address.  Can be found by typing ifconfig... 

Thank you to @shamiao for the initial code written for a Raspberry Pi.
