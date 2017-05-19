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
CKSPLASH="$HOME/.fwul-splash"

[ -f "$CKSPLASH" ] && exit

WELCTXT="<span font='18'>\nWelcome to FWUL <b>$(cat /etc/fwul-release)</b></span>\n\nThe goal of this project is to provide an easy and stressless access to your favorite Android device\n\n(sorry but FWUL is <b>no</b> Android development tool)\n\n\n"

ARCH=$(uname -m)
if [ $ARCH == "i686" ];then
    WELCTXT="$WELCTXT\n\n<span foreground='red'><b>YOU ARE USING 32bit HARDWARE!</b>\nKeep in mind that FWUL provides limited support for 32bit only (e.g. some tools like JOdin are missing here)</span>\n\n"
fi

YRET=$(yad --title "Welcome to FWUL" --undecorated --skip-taskbar --height=650 --center --width=700 \
    --button="Disable Welcome Screen (for persistent mode only)":11 \
    --button=Close:99 \
    --buttons-layout="edge" \
    --no-escape \
    --text "$WELCTXT\n- double-click an entry to open -" --text-align=center \
    --list --grid-lines=hor --no-headers --print-column=3 \
    --column="icon:IMG" --column="what:TXT" --column="parse:HD" \
    "$ICONPATH/faq.png" "<b>FAQ</b>" faq\
    "$ICONPATH/support.png" "<b>Support</b>" support \
    "$ICONPATH/issues.png" "<b>Bug/Feature Request</b>" issue \
    "$ICONPATH/website.png" "<b>FWUL Project</b>" web \
    "$ICONPATH/build.png" "<b>Build FWUL / Sources</b>" sources)

# disable welcome screen on next boot
if [ $? -eq 11 ];then
    date > $CKSPLASH
    exit
fi

# parse selection
SELECT="${YRET/|/}"

# act based on selection
case "$SELECT" in
    faq) xdg-open "https://forum.xda-developers.com/showpost.php?p=70272692&postcount=4" ;;
    support) xdg-open "http://webchat.freenode.net/?channels=Carbon-user" ;;
    issue) xdg-open "https://github.com/Carbon-Fusion/build_fwul/issues/new" ;;
    install) yad --title SORRY --center --text '\nSorry this is not ready yet.\nCheck the FWUL Project page for details and process.' ;;
    web) xdg-open "https://tinyurl.com/FWULatXDA";;
    sources) xdg-open "https://github.com/Carbon-Fusion/build_fwul";;
    *)  echo "ERROR: $YRET";;
esac
