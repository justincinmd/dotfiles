#!/bin/bash
sudo openvpn --config duo.vpn --nobind
read -rsp $'Press any key to continue...\n' -n1 key
