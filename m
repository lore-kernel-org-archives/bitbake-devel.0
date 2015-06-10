Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 276A9758ED
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:57 +0000 (UTC)
Received: by wgme6 with SMTP id e6so37429373wgm.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=6QchaR55pjVeOUZVxnUFnDzsFLP5gxmnhacaoQmhLac=;
	b=LGVyNp5DBnkWKgwrnMLccresryt94dklsqgh13+jJ51NSeNlKZiyxDK6aYWFKQSwGi
	z0UTWkGHzFsHNK3NDV41vkd91I4eTtDYx1UtN1ZORc58bWDzk92ZO9fW40msOJKU9hAH
	BRGKSrD2AibzGtpNtJh0eHn1ck0mMzWHv5zDTWjL5fjcVCx3j5M51QWcMRDQy9PHJtRO
	grgBC/PhDOdriIhugLuteX/YMlgVpW+HmEIa3Xn+rEvOxqpLD/YWs9aSklq7WCOfCdB6
	grv4cbulahAk98oKh9fe7iENeXR/jH+ZEJi0z2QIOQTPS866r/UJQwvkfkThW7iZ1Or8
	Oflg==
X-Gm-Message-State: ALoCoQmAUUQHDGgB3rr7Gy7TCiFXa+SJNSvvaXvUD/VSfpGkVVSqlvdVMPLzIkbX/2Dw1luEOvzE
X-Received: by 10.194.200.228 with SMTP id jv4mr6631148wjc.157.1433947198248; 
	Wed, 10 Jun 2015 07:39:58 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k2sm8254179wif.3.2015.06.10.07.39.57
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:57 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 218A656122E; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:02 +0100
Message-Id: <bd95425c35c7d8386c57329e425aa7802537b479.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 14/19] toaster: Code cleanup: bashisms
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 10 Jun 2015 14:39:57 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed the following bashisms:
 replaced echo -e -> printf
 removed 'function' from function definitions
 replaced $(< ${file}) -> `cat ${file}`

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bin/toaster | 55 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index ee19937..0fa8b60 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -28,23 +28,24 @@
 
 # Helper function to kill a background toaster development server
 
-function webserverKillAll()
+webserverKillAll()
 {
     local pidfile
     for pidfile in ${BUILDDIR}/.toastermain.pid; do
         if [ -f ${pidfile} ]; then
-        while kill -0 $(< ${pidfile}) 2>/dev/null; do
-            kill -SIGTERM -$(< ${pidfile}) 2>/dev/null
-            sleep 1
-            # Kill processes if they are still running - may happen in interactive shells
-            pkill -U $UID -f "python.*manage.py runserver"
-        done;
-        rm  ${pidfile}
+            pid=`cat ${pidfile}`
+            while kill -0 $pid 2>/dev/null; do
+                kill -SIGTERM -$pid 2>/dev/null
+                sleep 1
+                # Kill processes if they are still running - may happen in interactive shells
+                ps fux | grep "python.*manage.py runserver" | awk '{print $2}' | xargs kill
+            done
+            rm  ${pidfile}
         fi
     done
 }
 
-function webserverStartAll()
+webserverStartAll()
 {
     # do not start if toastermain points to a valid process
     if ! cat "${BUILDDIR}/.toastermain.pid" 2>/dev/null | xargs -I{} kill -0 {} ; then
@@ -62,7 +63,7 @@ function webserverStartAll()
     if [ $retval -eq 1 ]; then
         echo "Failed db sync, stopping system start" 1>&2
     elif [ $retval -eq 2 ]; then
-        echo -e "\nError on migration, trying to recover... \n"
+        printf "\nError on migration, trying to recover... \n"
         python $BBBASEDIR/lib/toaster/manage.py migrate orm 0001_initial --fake
         retval=0
         python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
@@ -87,7 +88,7 @@ function webserverStartAll()
 
 # Helper functions to add a special configuration file
 
-function addtoConfiguration()
+addtoConfiguration()
 {
     file=$1
     shift
@@ -98,13 +99,13 @@ function addtoConfiguration()
 INSTOPSYSTEM=0
 
 # define the stop command
-function stop_system()
+stop_system()
 {
     # prevent reentry
     if [ $INSTOPSYSTEM -eq 1 ]; then return; fi
     INSTOPSYSTEM=1
     if [ -f ${BUILDDIR}/.toasterui.pid ]; then
-        kill $(< ${BUILDDIR}/.toasterui.pid ) 2>/dev/null
+        kill `cat ${BUILDDIR}/.toasterui.pid` 2>/dev/null
         rm ${BUILDDIR}/.toasterui.pid
     fi
     BBSERVER=0.0.0.0:-1 bitbake -m
@@ -117,12 +118,12 @@ function stop_system()
     INSTOPSYSTEM=0
 }
 
-function check_pidbyfile() {
-    [ -e $1 ] && kill -0 $(< $1) 2>/dev/null
+check_pidbyfile() {
+    [ -e $1 ] && kill -0 `cat $1` 2>/dev/null
 }
 
 
-function notify_chldexit() {
+notify_chldexit() {
     if [ $NOTOASTERUI -eq 0 ]; then
         check_pidbyfile ${BUILDDIR}/.toasterui.pid && return
         stop_system
@@ -130,16 +131,16 @@ function notify_chldexit() {
 }
 
 
-function verify_prereq() {
+verify_prereq() {
     # Verify prerequisites
 
     if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (6,)" | python 2>/dev/null | grep True >/dev/null; then
-        echo -e "This program needs Django 1.6. Please install with\n\npip install django==1.6\n"
+        printf "This program needs Django 1.6. Please install with\n\npip install django==1.6\n"
         return 2
     fi
 
     if ! echo "import south; print reduce(lambda x, y: 2 if x==2 else 0 if x == 0 else y, map(lambda x: 1+cmp(x[1]-x[0],0), zip([0,8,4], map(int,south.__version__.split(\".\"))))) > 0" | python 2>/dev/null | grep True >/dev/null; then
-        echo -e "This program needs South 0.8.4. Please install with\n\npip install south==0.8.4\n"
+        printf "This program needs South 0.8.4. Please install with\n\npip install south==0.8.4\n"
         return 2
     fi
     return 0
@@ -182,42 +183,42 @@ if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
     if ! verify_prereq; then
-        echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
+        echo "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
         exit 1
     fi
 
     if [ -n "$BUILDDIR" ]; then
-        echo -e "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window." 1>&2
+        printf "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window." 1>&2
         exit 1
     fi
 
     # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
     BUILDDIR=/tmp/toaster_$$
     if [ -d "$BUILDDIR" ]; then
-        echo -e "Previous toaster run directory $BUILDDIR found, cowardly refusing to start. Please remove the directory when that toaster instance is over" 2>&1
+        echo "Previous toaster run directory $BUILDDIR found, cowardly refusing to start. Please remove the directory when that toaster instance is over" 2>&1
         exit 1
     fi
 
     mkdir -p "$BUILDDIR"
 
     RUNNING=1
-    function trap_ctrlc() {
+    trap_ctrlc() {
         echo "** Stopping system"
         webserverKillAll
         RUNNING=0
     }
 
-    function do_cleanup() {
+    do_cleanup() {
         find "$BUILDDIR" -type f | xargs rm
         rmdir "$BUILDDIR"
     }
-    function cleanup() {
+    cleanup() {
         if grep -ir error "$BUILDDIR" >/dev/null; then
             if grep -irn "That port is already in use" "$BUILDDIR"; then
                 echo "You can use the \"webport=PORTNUMBER\" parameter to start Toaster on a different port (port $WEB_PORT is already in use)"
                 do_cleanup
             else
-                echo -e "\nErrors found in the Toaster log files present in '$BUILDDIR'. Directory will not be cleaned.\n Please review the errors and notify toaster@yoctoproject.org or submit a bug https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Toaster"
+                printf "\nErrors found in the Toaster log files present in '$BUILDDIR'. Directory will not be cleaned.\n Please review the errors and notify toaster@yoctoproject.org or submit a bug https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Toaster"
             fi
         else
             echo "No errors found, removing the run directory '$BUILDDIR'"
@@ -248,7 +249,7 @@ fi
 
 
 if ! verify_prereq; then
-    echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
+    echo "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
     return 1
 fi
 
-- 
1.9.1


