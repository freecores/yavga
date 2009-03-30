#!/bin/sh
#

################################################################################
####                                                                        ####
#### This file is part of the yaVGA project                                 ####
#### http://www.opencores.org/?do=project&who=yavga                         ####
####                                                                        ####
#### Description                                                            ####
#### Implementation of yaVGA IP core                                        ####
####                                                                        ####
#### To Do:                                                                 ####
####                                                                        ####
####                                                                        ####
#### Author(s):                                                             ####
#### Sandro Amato, sdroamt@netscape.net                                     ####
####                                                                        ####
################################################################################
####                                                                        ####
#### Copyright (c) 2009, Sandro Amato                                       ####
#### All rights reserved.                                                   ####
####                                                                        ####
#### Redistribution  and  use in  source  and binary forms, with or without ####
#### modification,  are  permitted  provided that  the following conditions ####
#### are met:                                                               ####
####                                                                        ####
####     * Redistributions  of  source  code  must  retain the above        ####
####       copyright   notice,  this  list  of  conditions  and  the        ####
####       following disclaimer.                                            ####
####     * Redistributions  in  binary form must reproduce the above        ####
####       copyright   notice,  this  list  of  conditions  and  the        ####
####       following  disclaimer in  the documentation and/or  other        ####
####       materials provided with the distribution.                        ####
####     * Neither  the  name  of  SANDRO AMATO nor the names of its        ####
####       contributors may be used to  endorse or  promote products        ####
####       derived from this software without specific prior written        ####
####       permission.                                                      ####
####                                                                        ####
#### THIS SOFTWARE IS PROVIDED  BY THE COPYRIGHT  HOLDERS AND  CONTRIBUTORS ####
#### "AS IS"  AND  ANY EXPRESS OR  IMPLIED  WARRANTIES, INCLUDING,  BUT NOT ####
#### LIMITED  TO, THE  IMPLIED  WARRANTIES  OF MERCHANTABILITY  AND FITNESS ####
#### FOR  A PARTICULAR  PURPOSE  ARE  DISCLAIMED. IN  NO  EVENT  SHALL  THE ####
#### COPYRIGHT  OWNER  OR CONTRIBUTORS  BE LIABLE FOR ANY DIRECT, INDIRECT, ####
#### INCIDENTAL,  SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, ####
#### BUT  NOT LIMITED  TO,  PROCUREMENT OF  SUBSTITUTE  GOODS  OR SERVICES; ####
#### LOSS  OF  USE,  DATA,  OR PROFITS;  OR  BUSINESS INTERRUPTION) HOWEVER ####
#### CAUSED  AND  ON  ANY THEORY  OF LIABILITY, WHETHER IN CONTRACT, STRICT ####
#### LIABILITY,  OR  TORT  (INCLUDING  NEGLIGENCE  OR OTHERWISE) ARISING IN ####
#### ANY  WAY OUT  OF THE  USE  OF  THIS  SOFTWARE,  EVEN IF ADVISED OF THE ####
#### POSSIBILITY OF SUCH DAMAGE.                                            ####
################################################################################


INIT_ELEM=32

CURR_ELEM=0
CURR_INIT=""
INIT_NUM=0
while read LINE ; do
  case "${LINE}" in
    \#*) # skip
         ;;

      *) HEX=`echo "obase=16; ibase=2; ${LINE}" | sed -e ' s/-/0/g ' | sed -e ' s/@/1/g ' | bc`

         CURR_ELEM=$((${CURR_ELEM} + 1))
#         echo ${CURR_ELEM}

         if [ ${#HEX} = 1 ] ; then
           CURR_INIT="0${HEX}${CURR_INIT}"
         else
           CURR_INIT="${HEX}${CURR_INIT}"
         fi

         if [ ${CURR_ELEM} = ${INIT_ELEM} ] ; then
           INIT_HEX=`echo "obase=16; ibase=10; ${INIT_NUM}" | bc`
           echo "INIT_${INIT_HEX} => X\"${CURR_INIT}\","
           CURR_ELEM=0
           CURR_INIT=""

           INIT_NUM=$((${INIT_NUM} + 1))
         fi

         ;;
  esac
done < chars.map
           echo "INIT_${INIT_HEX} => X\"${CURR_INIT}\","


