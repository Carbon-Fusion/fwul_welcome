#!/bin/bash - 
#####################################################################################################
#
# This is FWUL: [F]orget [W]indows [U]se [L]inux
#
# Copyright (C) 2017-2018 steadfasterX <steadfastX@boun.cr>
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

# find and save the path where executed
EXDIR=${0%/*}
ICONPATH="$EXDIR/icons"
CKSPLASH="$HOME/.fwul-splash"

[ -f "$CKSPLASH" ] && exit

source /etc/fwul-release
[ -z "$patchlevel" ]&& patchlevel=0
WELCTXT="<span font='18'>\n   Welcome to\n\n\tFWUL <b>$fwulversion</b></span>\n\t(build: $fwulbuild, patchlevel: $patchlevel, mode: $fwul_Chassis)\n\n"

if [ "$fwul_Chassis" == "vm" ];then
        WELCTXT="$WELCTXT\t<span font='14' foreground='red'><b>!! Virtualization detected !!</b></span><span foreground='red'>\n\n\twhen doing critical operations (like flashing a ROM/bootloader) do <b><u>not</u> use FWUL from within VirtualBox.</b>\n\n\t(This is not a limitation of FWUL but is generally related to virtualization - <a href='https://github.com/Carbon-Fusion/build_fwul/issues/76'>click here</a> for details)</span>\n"
else
        WELCTXT="$WELCTXT\n\n\n\n\n"
fi

F_FAQ(){
        xdg-open 'https://forum.xda-developers.com/showpost.php?p=70272692&postcount=4'
}; export -f F_FAQ
F_SUPPORT(){
       xdg-open "http://webchat.freenode.net/?channels=Carbonfusion-user"
}; export -f F_SUPPORT
F_ISSUE(){
        xdg-open "https://github.com/Carbon-Fusion/build_fwul/issues/new"
}; export -f F_ISSUE
F_INSTALL(){
        yad --title SORRY --center --text '\nSorry this is not ready yet.\nCheck the FWUL Project page for details and process.'
}; export -f F_INSTALL
F_WEB(){
        xdg-open "https://tinyurl.com/FWULatXDA"
}; export -f F_WEB
F_SOURCES(){
        xdg-open "https://github.com/Carbon-Fusion/build_fwul"
}; export -f F_SOURCES

F_CLOSE(){
        kill -s SIGUSR1 $YAD_PID >> /dev/null 2>&1
}; export -f F_CLOSE

YRET=$(yad -on-top --no-escape --title="Welcome to FWUL" --width=1000 --image="$ICONPATH/welcome.png" --undecorated --skip-taskbar --center --always-print-result --height=400\
        --text "$WELCTXT\n\n" \
        --form --field="":LBL true --field=" Disable Welcome Screen (only for persistent build)":CHK false \
        --buttons-layout=spread \
        --button="Close":"bash -c F_CLOSE"\
        --button="FAQ!$ICONPATH/faq.png!Frequently Asked Questions":"bash -c F_FAQ" \
        --button="Support!$ICONPATH/support.png!Get immediate support on IRC":"bash -c F_SUPPORT" \
        --button="Bugs!$ICONPATH/issues.png!File a bug / Request a new feature":"bash -c F_ISSUE" \
        --button="Forum!$ICONPATH/website.png!Forum / Homepage":"bash -c F_WEB" \
        --button="Sources!$ICONPATH/build.png!Build your own version of FWUL":"bash -c F_SOURCES" \
        )
# parse selection
SELECT=$(echo "${YRET}"|cut -d "|" -f2)

# disable welcome screen on next boot
if [ "$SELECT" == "TRUE" ];then
    date > $CKSPLASH
    exit
fi


