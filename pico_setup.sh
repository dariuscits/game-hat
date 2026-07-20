#!/bin/bash

# Create PICO-8 ROM folder
mkdir -p /home/pi/RetroPie/roms/pico8

# Backup current EmulationStation config
cp /etc/emulationstation/es_systems.cfg /etc/emulationstation/es_systems.cfg.backup

# Add PICO-8 system if it doesn't exist
if ! grep -q "<name>pico8</name>" /etc/emulationstation/es_systems.cfg; then

sudo sed -i '/<\/systemlist>/i\
<system>\
    <name>pico8</name>\
    <fullname>PICO-8</fullname>\
    <path>/home/pi/RetroPie/roms/pico8</path>\
    <extension>.p8 .png .p8.png</extension>\
    <command>/opt/retropie/supplementary/runcommand/runcommand.sh 0 _SYS_ pico8 %ROM%</command>\
    <platform>pico8</platform>\
    <theme>pico8</theme>\
</system>' /etc/emulationstation/es_systems.cfg

fi

echo "PICO-8 setup complete!"
