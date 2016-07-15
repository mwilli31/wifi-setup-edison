#! /bin/sh

#   wifi-setup-edison
#
#   A minimium command line script to configure Wi-Fi network on Debian
#   system
#
# Copyright (C) 2013 Sha Miao
# This program is released under the MIT license, see LICENSE file or
# <http://opensource.org/licenses/MIT> for full text.
#
# See README for usage.

###############################################################
################### Input Parameters defined ##################
###############################################################

NET_SSID=""
NET_PASS=""
NET_ENCR=""

NET_SSID_ARG="false"
NET_PASS_ARG="false"
NET_ENCR_ARG="false"

#check for flowthings arguments
while [ $# -gt 0 ]
do
        case "$1" in
                -s)
                        shift
                        NET_SSID="$1"
			                  NET_SSID_ARG="true"
			                  shift
                        ;;
                -p)
                        shift
                        NET_PASS="$1"
			                  NET_PASS_ARG="true"
			                  shift
                        ;;
                -e)
                        shift
                        NET_ENCR="$1"
                        NET_ENCR_ARG="true"
                        shift
                        ;;
		             *)
                  			shift
                  			break
                  			;;
        esac
done

#Exit if any of the four required parameters are missing
if [ "$NET_SSID_ARG" == "false" ] || [ "$NET_SSID" == "" ]; then
	echo "Network SSID argument -s required"
	exit 1
fi
if [ "$NET_PASS_ARG" == "false" ] || [ "$NET_PASS" == "" ]; then
        echo "Network Password argument -p required"
	exit 1
fi
if [ "$NET_ENCR_ARG" == "false" ] || [ "$NET_ENCR" == "" ]; then
        echo "Network Encryption Type argument -e required"
	exit 1
fi

###############################################################
#################### PLEASE EDIT THIS PART ####################
###############################################################

# SSID (aka. network name).
SSID='$NET_SSID'

# Network encryption method.
# * 'WPA' for WPA-PSK/WPA2-PSK (note: most Wi-Fi networks use WPA);
# * 'WEP' for WEP;
# * 'Open' for open network (aka. no password).
ENCRYPTION='$NET_ENCR'

# Network password. (WPA-PSK/WPA2-PSK password, or WEP key)
PASSWORD='$NET_PASS'

###############################################################
####################   OK. STOP EDITING!   ####################
###############################################################

if [ $(id -u) -ne 0 ]; then
  printf "This script must be run as root. \n"
  exit 1
fi

NETID=$(wpa_cli add_network | tail -n 1)
wpa_cli set_network $NETID ssid \"$SSID\"
case $ENCRYPTION in
'WPA')
    wpa_cli set_network $NETID key_mgmt WPA-PSK
    wpa_cli set_network $NETID psk \"$PASSWORD\"
    ;;
'WEP')
    wpa_cli set_network $NETID wep_key0 $PASSWORD
    wpa_cli set_network $NETID wep_key1 $PASSWORD
    wpa_cli set_network $NETID wep_key2 $PASSWORD
    wpa_cli set_network $NETID wep_key3 $PASSWORD
    ;;
*)
    ;;
esac
wpa_cli enable_network $NETID
wpa_cli save_config
