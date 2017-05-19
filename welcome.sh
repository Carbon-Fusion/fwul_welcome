#!/bin/bash - 
#####################################################################################################
#
# This is FWUL: [F]orget [W]indows [U]se [L]inux
#
# Copyright (C) 2017 steadfasterX <steadfastX@boun.cr>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
######################################################################################################

set -o nounset                              # Treat unset variables as an error

# find and save the path where executed
EXDIR=${0%/*}
ICONPATH="$EXDIR/icons"

WELCTXT="<span font='18'>\nWelcome to FWUL <b>$(cat /etc/fwul-release)</b></span>\n\nThe goal of this project is to provide an easy and stressless access to your favorite Android device\n\n(sorry but FWUL is <b>no</b> Android development tool)\n"

yad --title "Welcome to FWUL" --center --width=800 --undecorated --skip-taskbar --always-print-result --close-on-unfocus \
    --item-separator="|" \
    --button=Close:99 \
    --text "$WELCTXT" \
    --text-align=center --form \
    --field="   <b>FAQ</b>                                     |$ICONPATH/faq.png:FBTN" \
    --field="   <b>Support</b>                               |$ICONPATH/support.png:FBTN" \
    --field="   <b>Bug/Feature Request</b>          |$ICONPATH/issues.png:FBTN" \
    --field="   <b>Install FWUL</b>                        |$ICONPATH/install.png:FBTN" \
    --field="   <b>FWUL Project</b>                      |$ICONPATH/website.png:FBTN" \
    --field="   <b>Build FWUL / Sources</b>        |$ICONPATH/build.png:FBTN" \
    --field="Show screen on startup:CHK"\
    "xdg-open https://forum.xda-developers.com/showpost.php?p=70272692&postcount=4"\
    "xdg-open http://webchat.freenode.net/?channels=Carbon-user" \
    "xdg-open https://github.com/Carbon-Fusion/build_fwul/issues/new" \
    "yad --title SORRY --center --text '\nSorry this is not ready yet.\nCheck the FWUL Project page for details and process.'" \
    "xdg-open https://tinyurl.com/FWULatXDA" \
    "xdg-open https://github.com/Carbon-Fusion/build_fwul" \
    TRUE

