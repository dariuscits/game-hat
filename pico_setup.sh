#!/bin/bash

CFG="/etc/emulationstation/es_systems.cfg"

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script with sudo."
    exit 1
fi

# Check if the PICO-8 system already exists
if grep -q "<name>pico8</name>" "$CFG"; then
    echo "PICO-8 system already exists in $CFG"
    exit 0
fi

# Create a backup
cp "$CFG" "${CFG}.bak"

# Insert the system before the closing </systemList> tag
sed -i '/<\/systemList>/i\
    <system>\
        <name>pico8</name>\
        <fullname>PICO-8</fullname>\
        <path>/home/pi/RetroPie/roms/pico8</path>\
        <extension>.p8 .png .p8.png</extension>\
        <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pico8 %ROM%</command>\
        <platform>pico8</platform>\
        <theme>pico8</theme>\
    </system>' "$CFG"

echo "PICO-8 system added successfully!"
echo "Backup saved as ${CFG}.bak"
