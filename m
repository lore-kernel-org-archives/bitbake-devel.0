Return-Path: <abongwabonalais@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB9C4167B
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 16:33:18 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web08.913.1649194890578846885
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 14:41:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YKmRVUVz;
 spf=pass (domain: gmail.com, ip: 209.85.221.46,
 mailfrom: abongwabonalais@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id b19so402035wrh.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIZJJi2dCEE6Q8rzmm7v/mBt8A2EYfOKcz40+5GdQoE=;
        b=YKmRVUVzOeI6X+AKI4QUH9+I/2kt7jDE8tv2CL38pfMEyqEPug/+iVXf5CaCmxtbZm
         UJ4xppcaeMr94ITVczJFdIwaKBTN0l6VvTUCXYmiZdvhF4xAKnNcUmng6bicry2Bh1cU
         5JajjWkBu8WE/svJeaiYHuF7EWqrnVPNXP4BX+diE87I50qCH6mrFiBZpGmFaaa4xa0m
         w60p4Qro6X8OcfWtRI44uEp2DS7z1yVFm8CdnJsGtxPuH6sehfRZipyI+5bm5oKkUzCq
         fQtJS3mYk6dpRBEaxyKTtABWqyqvt3KTRISzu63ZVPrcTROgWvIaMRA+clmchCNrePqc
         DpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WIZJJi2dCEE6Q8rzmm7v/mBt8A2EYfOKcz40+5GdQoE=;
        b=iL3a0N/olY8WYrg0WP9fRuLUTrDWrXDK3JFQQGVaXkegU2P9A2ZUM4vl7zFpS0IUQO
         7r4dsiUmuOhu8V2TjbHZhTD+IIzW3uEjCDQK8rO2Iyi4grR+x/jsZg9EAPGMyF/3sbWZ
         OFkesttweuQQS6oH9G2fq18+50kFYrC4HqROhOk5rw+OhYn0P4OTi4s+EASO7eTpFotq
         xKo1oeInTm5906NNAmMjNTaD8U9yPaOH0AC+q8IkEgfRT0Sk0BbaUKWcU40TpGjJegw2
         Z6SW936f1kBIyYVH4CONlAtgdZLrv+U+plpBa/wFqVpwDnzsqt2Xa8DEyIASm++v63ie
         ECGQ==
X-Gm-Message-State: AOAM530SjujFytD/bJgffk1op4wS6gdSMGeZiPHLcAXxJP5nYyIXnSfi
	YiSwvriosNvGBvLuOrqQ/CLxv+bKedCIoYo+
X-Google-Smtp-Source: 
 ABdhPJzYaHqCY/qfA1A0rTlNMICLpbbESpAWA+g9AaU+YD/zsteRBJAhu6ERqGKBSmxvcOOH+4EdDw==
X-Received: by 2002:a5d:4207:0:b0:206:1593:3e8b with SMTP id
 n7-20020a5d4207000000b0020615933e8bmr4274401wrq.153.1649194888524;
        Tue, 05 Apr 2022 14:41:28 -0700 (PDT)
Received: from localhost.localdomain ([154.72.153.155])
        by smtp.gmail.com with ESMTPSA id
 y6-20020a05600015c600b00203fa70b4ebsm16095976wry.53.2022.04.05.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:41:28 -0700 (PDT)
From: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
Subject: [PATCH] toaster: Add quoting of variables to avoid splitting
Date: Tue,  5 Apr 2022 22:41:00 +0100
Message-Id: <20220405214100.61887-1-abongwabonalais@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Apr 2022 16:33:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13590

Signed-off-by: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
---
 bitbake/bin/toaster | 66 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 558a819570..e190f2c9db 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -19,9 +19,9 @@ Usage 2: source toaster manage [createsuperuser|lsupdates|migrate|makemigrations
 
 custom_extention()
 {
-    custom_extension=$BBBASEDIR/lib/toaster/orm/fixtures/custom_toaster_append.sh
-    if [ -f $custom_extension ] ; then
-        $custom_extension $*
+    custom_extension="$BBBASEDIR/lib/toaster/orm/fixtures/custom_toaster_append.sh"
+    if [ -f "$custom_extension" ] ; then
+        $custom_extension "$*"
     fi
 }
 
@@ -51,19 +51,19 @@ databaseCheck()
 webserverKillAll()
 {
     local pidfile
-    if [ -f ${BUILDDIR}/.toastermain.pid ] ; then
+    if [ -f "${BUILDDIR}/.toastermain.pid" ] ; then
         custom_extention web_stop_postpend
     else
         custom_extention noweb_stop_postpend
     fi
-    for pidfile in ${BUILDDIR}/.toastermain.pid ${BUILDDIR}/.runbuilds.pid; do
-        if [ -f ${pidfile} ]; then
-            pid=`cat ${pidfile}`
-            while kill -0 $pid 2>/dev/null; do
-                kill -SIGTERM $pid 2>/dev/null
+    for pidfile in "${BUILDDIR}/.toastermain.pid" "${BUILDDIR}/.runbuilds.pid"; do
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
@@ -84,8 +84,8 @@ webserverStartAll()
     echo "Starting webserver..."
 
     $MANAGE runserver --noreload "$ADDR_PORT" \
-           </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
-           & echo $! >${BUILDDIR}/.toastermain.pid
+           </dev/null >>"${BUILDDIR}/toaster_web.log" 2>&1 \
+           & echo "$!" >"${BUILDDIR}/.toastermain.pid"
 
     sleep 1
 
@@ -95,7 +95,7 @@ webserverStartAll()
     else
         echo "Toaster development webserver started at http://$ADDR_PORT"
         echo -e "\nYou can now run 'bitbake <target>' on the command line and monitor your build in Toaster.\nYou can also use a Toaster project to configure and run a build.\n"
-        custom_extention web_start_postpend $ADDR_PORT
+        custom_extention web_start_postpend "$ADDR_PORT"
     fi
 
     return $retval
@@ -131,8 +131,8 @@ verify_prereq() {
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
@@ -150,10 +150,10 @@ else
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
@@ -164,7 +164,7 @@ fi
 # in the local layers that currently make using an arbitrary
 # toasterconf.json difficult.
 
-. $OE_ROOT/.templateconf
+. "$OE_ROOT/.templateconf"
 if [ -n "$TEMPLATECONF" ]; then
     if [ ! -d "$TEMPLATECONF" ]; then
         # Allow TEMPLATECONF=meta-xyz/conf as a shortcut
@@ -199,10 +199,10 @@ for param in $*; do
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
@@ -229,7 +229,7 @@ for param in $*; do
     esac
 done
 
-if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
+if [ `basename "$0"` = `basename "${TOASTER}"` ]; then
     echo "Error: This script needs to be sourced. Please run as . $TOASTER"
     return 1
 fi
@@ -265,7 +265,7 @@ fi
 echo "The system will $CMD."
 
 # Execute the commands
-custom_extention toaster_prepend $CMD $ADDR_PORT
+custom_extention toaster_prepend "$CMD" "$ADDR_PORT"
 
 case $CMD in
     start )
@@ -277,9 +277,9 @@ case $CMD in
         fi
 
         # Create configuration file
-        conf=${BUILDDIR}/conf/local.conf
+        conf="${BUILDDIR}/conf/local.conf"
         line='INHERIT+="toaster buildhistory"'
-        grep -q "$line" $conf || echo $line >> $conf
+        grep -q "$line" "$conf" || echo "$line" >> "$conf"
 
         if [ $WEBSERVER -eq 0 ] ; then
             # Do not update the database for "noweb" unless
@@ -290,17 +290,17 @@ case $CMD in
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
+               </dev/null >>"${BUILDDIR}/toaster_runbuilds.log" 2>&1 \
+               & echo $! >"${BUILDDIR}/.runbuilds.pid"
         else
             echo "Toaster build server not started."
         fi
@@ -308,7 +308,7 @@ case $CMD in
         # set fail safe stop system on terminal exit
         trap stop_system SIGHUP
         echo "Successful ${CMD}."
-        custom_extention toaster_postpend $CMD $ADDR_PORT
+        custom_extention toaster_postpend "$CMD" "$ADDR_PORT"
         return 0
     ;;
     stop )
@@ -316,9 +316,9 @@ case $CMD in
         echo "Successful ${CMD}."
     ;;
     manage )
-        cd $BBBASEDIR/lib/toaster
-        $MANAGE $manage_cmd
+        cd "$BBBASEDIR/lib/toaster"
+        "$MANAGE $manage_cmd"
     ;;
 esac
-custom_extention toaster_postpend $CMD $ADDR_PORT
+custom_extention toaster_postpend "$CMD" "$ADDR_PORT"
 
-- 
2.25.1


