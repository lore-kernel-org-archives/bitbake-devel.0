Return-Path: <abongwabonalais@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0BC43219
	for <webhook@archiver.kernel.org>; Wed,  6 Apr 2022 16:33:18 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web08.999.1649195306742254256
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 14:48:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=gSNr97+f;
 spf=pass (domain: gmail.com, ip: 209.85.128.54,
 mailfrom: abongwabonalais@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id
 123-20020a1c1981000000b0038b3616a71aso451824wmz.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfFMy41gHkc19vQDcpChmZLPMAWG3eeR4gSA0uiee40=;
        b=gSNr97+fLO5o1scjXk5PHPILHI5k+t/nbR++ZbkeqAW3JtiNtu1pOdPeGAISvVPyiK
         P1LyyUFLtr8kLG6oACE6FrnK1zPIEEsH10a0qylEaGgUfoSO1Qe9LL7jlkK3bsqeslXd
         0n99YS2rSDm6sZvzb8GN1ERl21z7zCotakcnauH2pL4GAJN3CgewCczrpbpIH7bO5Bkz
         bD2kDR4j0fLYAZcTigXZLn7dYfCnLeW+y6VUhQ1MGg5GlLiUXSY+mcEz0WQxTH5sENpw
         WOCTLIpI41TWzv1Yl3FHNz9ULEG7teiU0ABAI//XldHBH3kPZtorYiCfw+lwCI+uFFls
         Sgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfFMy41gHkc19vQDcpChmZLPMAWG3eeR4gSA0uiee40=;
        b=Att123bFyH0mVlvcu+QASd0WgSG2QqlYaXSA/sZP8Gl0mEJ7xU4sG8ZgkoKeOask69
         apQEZxdvrotTpVVW+1gWPvMP7LpxXqH+o+TUydlD5lRQK23gxWvaV4c3BWFOd6huMzwp
         80SMQMm1Hy6rnaLKfzqNQHwQ7H3FbrFj9IxNaCSuVYyvSPS26CTcOTg+y4KmETaFa+GX
         bqhpIbnbtLn+XAIaySa2NWMrpDGGxA55Ex5JDR66GToA3zjaAElzGsRX2DKjmGYrnsC9
         3bJlXhVVNCf+6YQbdCk1cP6/ukAISBPvb9rvtn0OgdY8+7SrlJnG5Wbekem1CISlxZZe
         o9kQ==
X-Gm-Message-State: AOAM530Uv16ZTHnUsnER4fIrUQVqTHhaUpNNOUeyKIoFCvVJY7lwJbho
	0dPRdoquT0BSxePYWSgWvRWLenQ0/lP4Tqst
X-Google-Smtp-Source: 
 ABdhPJwXxnCBn5swKc6Q2xKq3sxy4TkZ7JvAwSIjN3K2c2UJB2Jge8o0kCxHireXSGZb+ow4e76BYg==
X-Received: by 2002:a05:600c:4408:b0:388:a042:344f with SMTP id
 u8-20020a05600c440800b00388a042344fmr4604477wmn.52.1649195304610;
        Tue, 05 Apr 2022 14:48:24 -0700 (PDT)
Received: from localhost.localdomain ([154.72.153.155])
        by smtp.gmail.com with ESMTPSA id
 n1-20020a1ca401000000b0038e748c2f64sm3179818wme.31.2022.04.05.14.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 14:48:24 -0700 (PDT)
From: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
Subject: [PATCH] toaster: Add quoting of variables to avoid splitting
Date: Tue,  5 Apr 2022 22:47:42 +0100
Message-Id: <20220405214741.62174-1-abongwabonalais@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Apr 2022 16:33:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13591

Signed-off-by: Abongwa Bonalais Amahnui <abongwabonalais@gmail.com>
---
 bitbake/bin/toaster | 66 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 558a819570..2c223a53bf 100755
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
+        "$MANAGE" "$manage_cmd"
     ;;
 esac
-custom_extention toaster_postpend $CMD $ADDR_PORT
+custom_extention toaster_postpend "$CMD" "$ADDR_PORT"
 
-- 
2.25.1


