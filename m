Return-Path: <abongwabonalais@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F6AC43217
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 19:49:23 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.844.1649183382730729235
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 11:29:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=IMHEYgap;
 spf=pass (domain: gmail.com, ip: 209.85.128.42,
 mailfrom: abongwabonalais@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id p189so8562362wmp.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDwIcUx5F+c5Sg3QN5VYaRzSK3oENxb6ZFZ5kW5N3g0=;
        b=IMHEYgapGOEJlkLKcN8wlCgvWrKt5uXO1qmOYTtCIouU3lJsALlAwUlx2J0T3p/HEe
         sCiPPy3N+tcNz4CcfM4aPbKaKK/FoiGib6a8ByYlK3HWwpwwt1oUXW2MIe4esM/G3IZ+
         nH/j8npecUqB/hgBaVA/XRMd6CErcahfun23sJUmHbe+MKUKnmREhFot2Ow/q0EOEezx
         thwllWDCuLHpel+8JLu4F53hhstwX59Xzw7e4oUtMFIkWrn0JRft99IcmMhskzKC4mkN
         09n3u9/OarHJn4lXTwkZHPwbahUtnNeTtHvyGEchVSfrQ3lZtaQWEEDj27GkGfKR8uSO
         +fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDwIcUx5F+c5Sg3QN5VYaRzSK3oENxb6ZFZ5kW5N3g0=;
        b=krrBgWidtV5Yi5dpilcTM7h16xfGtTQ0J7yk+3R0YSp8bTMEL3LB0VTPK3VNEoet1K
         jq7HwECHO4nsPD385tYznNTv+sdqGigzSA9MX0qKIuQu/XVn+Vz+sogrU+gWrKn+aiE+
         vj6UvadVQ2I6lF+Mqnq2fqxbEpgJUt1k9YBhxxGY/ljLbGFa+Fe2wl0TLcd5T+YpKv1H
         1ztGUACqc1QO1xZLIQ1vq+yU2lGiCBKegWH+M6A8mm5rmFJlOn7L9Vb4T6S4/0fQeLoT
         7tKxGhjhw+UuIYAhW18uQKije1LqOKspCG9vwQdACIvrRsC3FyibHkuPW4JY3Nvi+t8l
         Dwsw==
X-Gm-Message-State: AOAM531mOHqKmdrW1fgikGOsLUsfXi6ZiQ2jIxJJ3prfShygxH/cxzIT
	HFg7OuEfQG3I1rY5TsmgNueYmANXVGkd+ZWB
X-Google-Smtp-Source: 
 ABdhPJwUm8rmQYvAVT0FFKuuOYxWiqO4Po62fR5NnjK8BI/aZFyKX/ar50kZcnKyRVhjZzvD/8ZawA==
X-Received: by 2002:a05:600c:885:b0:38e:7d65:18d3 with SMTP id
 l5-20020a05600c088500b0038e7d6518d3mr4151977wmp.115.1649183386866;
        Tue, 05 Apr 2022 11:29:46 -0700 (PDT)
Received: from localhost.localdomain ([154.72.153.155])
        by smtp.gmail.com with ESMTPSA id
 l15-20020a05600c4f0f00b0038cbdf5221dsm2966096wmq.41.2022.04.05.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 11:29:46 -0700 (PDT)
From: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
Subject: [PATCH] Added double quotes aound variables in bitbake/source to
 prevent gobbling or splitting
Date: Tue,  5 Apr 2022 19:29:06 +0100
Message-Id: <20220405182906.57588-1-abongwabonalais@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Apr 2022 19:49:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13582

Signed-off-by: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
---
 bitbake/bin/toaster | 65 +++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 558a819570..d98c4c69f0 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -1,4 +1,5 @@
-#!/bin/echo ERROR: This script needs to be sourced. Please run as .
+#!/bin/sh 
+echo ERROR: This script needs to be sourced. Please run as .
 
 # toaster - shell script to start Toaster
 
@@ -20,8 +21,8 @@ Usage 2: source toaster manage [createsuperuser|lsupdates|migrate|makemigrations
 custom_extention()
 {
     custom_extension=$BBBASEDIR/lib/toaster/orm/fixtures/custom_toaster_append.sh
-    if [ -f $custom_extension ] ; then
-        $custom_extension $*
+    if [ -f "$custom_extension" ] ; then
+        $custom_extension "$*"
     fi
 }
 
@@ -51,19 +52,19 @@ databaseCheck()
 webserverKillAll()
 {
     local pidfile
-    if [ -f ${BUILDDIR}/.toastermain.pid ] ; then
+    if [ -f "${BUILDDIR}"/.toastermain.pid ] ; then
         custom_extention web_stop_postpend
     else
         custom_extention noweb_stop_postpend
     fi
-    for pidfile in ${BUILDDIR}/.toastermain.pid ${BUILDDIR}/.runbuilds.pid; do
-        if [ -f ${pidfile} ]; then
-            pid=`cat ${pidfile}`
-            while kill -0 $pid 2>/dev/null; do
-                kill -SIGTERM $pid 2>/dev/null
+    for pidfile in "${BUILDDIR}"/.toastermain.pid "${BUILDDIR}"/.runbuilds.pid; do
+        if [ -f "${pidfile}" ]; then
+            pid=`cat "${pidfile}"`
+            while kill -0 "$pid" 2>/dev/null; do
+                kill -SIGTERM "$pid" 2>/dev/null
                 sleep 1
             done
-            rm  ${pidfile}
+            rm  "${pidfile}"
         fi
     done
 }
@@ -84,8 +85,8 @@ webserverStartAll()
     echo "Starting webserver..."
 
     $MANAGE runserver --noreload "$ADDR_PORT" \
-           </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
-           & echo $! >${BUILDDIR}/.toastermain.pid
+           </dev/null >>"${BUILDDIR}"/toaster_web.log 2>&1 \
+           & echo "$!" >"${BUILDDIR}"/.toastermain.pid
 
     sleep 1
 
@@ -95,7 +96,7 @@ webserverStartAll()
     else
         echo "Toaster development webserver started at http://$ADDR_PORT"
         echo -e "\nYou can now run 'bitbake <target>' on the command line and monitor your build in Toaster.\nYou can also use a Toaster project to configure and run a build.\n"
-        custom_extention web_start_postpend $ADDR_PORT
+        custom_extention web_start_postpend "$ADDR_PORT"
     fi
 
     return $retval
@@ -131,8 +132,8 @@ verify_prereq() {
     exp=$exp'vmax=["%02d" % int(n) for n in "\4".split(".")];'
     exp=$exp'sys.exit(not (version \1 vmin and version \3 vmax))'
     exp=$exp'/p'
-    if ! sed -n "$exp" $reqfile | python3 - ; then
-        req=`grep ^Django $reqfile`
+    if ! sed -n "$exp" "$reqfile" | python3 - ; then
+        req=`grep ^Django "$reqfile"`
         echo "This program needs $req"
         echo "Please install with pip3 install -r $reqfile"
         return 2
@@ -150,10 +151,10 @@ else
     TOASTER=$0
 fi
 
-export BBBASEDIR=`dirname $TOASTER`/..
+export BBBASEDIR=`dirname "$TOASTER"`/..
 MANAGE="python3 $BBBASEDIR/lib/toaster/manage.py"
 if [ -z "$OE_ROOT" ]; then
-    OE_ROOT=`dirname $TOASTER`/../..
+    OE_ROOT=`dirname "$TOASTER"`/../..
 fi
 
 # this is the configuraton file we are using for toaster
@@ -164,7 +165,7 @@ fi
 # in the local layers that currently make using an arbitrary
 # toasterconf.json difficult.
 
-. $OE_ROOT/.templateconf
+. "$OE_ROOT"/.templateconf
 if [ -n "$TEMPLATECONF" ]; then
     if [ ! -d "$TEMPLATECONF" ]; then
         # Allow TEMPLATECONF=meta-xyz/conf as a shortcut
@@ -199,10 +200,10 @@ for param in $*; do
     webport=*)
             ADDR_PORT="${param#*=}"
             # Split the addr:port string
-            ADDR=`echo $ADDR_PORT | cut -f 1 -d ':'`
-            PORT=`echo $ADDR_PORT | cut -f 2 -d ':'`
+            ADDR=`echo "$ADDR_PORT" | cut -f 1 -d ':'`
+            PORT=`echo "$ADDR_PORT" | cut -f 2 -d ':'`
             # If only a port has been speified then set address to localhost.
-            if [ $ADDR = $PORT ] ; then
+            if [ "$ADDR" = "$PORT" ] ; then
                 ADDR_PORT="localhost:$PORT"
             fi
     ;;
@@ -229,7 +230,7 @@ for param in $*; do
     esac
 done
 
-if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
+if [ `basename \""$0"\"` = `basename \""${TOASTER}"\"` ]; then
     echo "Error: This script needs to be sourced. Please run as . $TOASTER"
     return 1
 fi
@@ -265,7 +266,7 @@ fi
 echo "The system will $CMD."
 
 # Execute the commands
-custom_extention toaster_prepend $CMD $ADDR_PORT
+custom_extention toaster_prepend "$CMD" "$ADDR_PORT"
 
 case $CMD in
     start )
@@ -279,7 +280,7 @@ case $CMD in
         # Create configuration file
         conf=${BUILDDIR}/conf/local.conf
         line='INHERIT+="toaster buildhistory"'
-        grep -q "$line" $conf || echo $line >> $conf
+        grep -q "$line" "$conf" || echo "$line" >> "$conf"
 
         if [ $WEBSERVER -eq 0 ] ; then
             # Do not update the database for "noweb" unless
@@ -290,17 +291,17 @@ case $CMD in
                     return 4
                 fi
             fi
-            custom_extention noweb_start_postpend $ADDR_PORT
+            custom_extention noweb_start_postpend "$ADDR_PORT"
         fi
-        if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
+        if [ "$WEBSERVER" -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
         fi
         export BITBAKE_UI='toasterui'
         if [ $TOASTER_BUILDSERVER -eq 1 ] ; then
             $MANAGE runbuilds \
-               </dev/null >>${BUILDDIR}/toaster_runbuilds.log 2>&1 \
-               & echo $! >${BUILDDIR}/.runbuilds.pid
+               </dev/null >>"${BUILDDIR}"/toaster_runbuilds.log 2>&1 \
+               & echo $! >"${BUILDDIR}"/.runbuilds.pid
         else
             echo "Toaster build server not started."
         fi
@@ -308,7 +309,7 @@ case $CMD in
         # set fail safe stop system on terminal exit
         trap stop_system SIGHUP
         echo "Successful ${CMD}."
-        custom_extention toaster_postpend $CMD $ADDR_PORT
+        custom_extention toaster_postpend "$CMD" "$ADDR_PORT"
         return 0
     ;;
     stop )
@@ -316,9 +317,9 @@ case $CMD in
         echo "Successful ${CMD}."
     ;;
     manage )
-        cd $BBBASEDIR/lib/toaster
-        $MANAGE $manage_cmd
+        cd "$BBBASEDIR"/lib/toaster
+        "$MANAGE $manage_cmd"
     ;;
 esac
-custom_extention toaster_postpend $CMD $ADDR_PORT
+custom_extention toaster_postpend "$CMD" "$ADDR_PORT"
 
-- 
2.25.1


