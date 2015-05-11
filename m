Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id BF26F73F78
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:59:12 +0000 (UTC)
Received: by wgbhc8 with SMTP id hc8so24015965wgb.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Qtr4bTG0EMCKnf44m9iAzcZuC0tgB+Y1nA7fNsbv6KU=;
	b=P6irOByL6lm0fO6Tyy00PMUclaq6lleqvW/K1MJ3SoVNgGi6hBpL27rttdHMlcFGlg
	utBnjRWerMRYKahUt4Yt2Y5liwLWreBov/HKn+xtyNN+e3CdcHV5+gcr774o/l0rxvTy
	JGdH2OWAvXzYpBY32g4fJIvnK0oMHDEMQNq3y9hihHjrvrTFlfnnc8gRkEZx8qrvTlXE
	1rgXUJTu7flCmtY5QkLXo/yHKFccv10wHRYAf9+0hj7OzrXZZNpRrShggs2LDHvjMMn8
	7X2oViIbbSDKSEo4mFTos/b4ww9RM/OR4DzzeLVtitJX/uHetaY26Xjt89gVyfdVum7Q
	myNQ==
X-Gm-Message-State: ALoCoQkf8HwKUyPW6YxyqA31peh/UnrggvekNIvUndjr0rlI8LFm8BNDBojA686bXOLHsuNUEiCo
X-Received: by 10.180.91.76 with SMTP id cc12mr19954095wib.67.1431341953268;
	Mon, 11 May 2015 03:59:13 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l3sm12705828wik.16.2015.05.11.03.59.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:59:12 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E524E5603AB; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:34 +0100
Message-Id: <0b7fab0b182a480e6d2433f2b2d26b47e520286c.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 03/11] toaster: Make toaster script working in zsh
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
X-List-Received-Date: Mon, 11 May 2015 10:59:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Fixed shell syntax not understood by zsh. Made toaster
script to work for both shells in both modes: sourced and
directly called.

[YOCTO #6964]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bin/toaster | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 792fb72..8568c13 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -63,7 +63,7 @@ function webserverStartAll()
             retval=0
             python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
         fi
-	if [ "x$TOASTER_MANAGED" == "x1" ]; then
+	if [ "$TOASTER_MANAGED" '==' '1' ]; then
 	        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
 		python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
 	fi
@@ -97,7 +97,7 @@ INSTOPSYSTEM=0
 function stop_system()
 {
     # prevent reentry
-    if [ $INSTOPSYSTEM == 1 ]; then return; fi
+    if [ $INSTOPSYSTEM -eq 1 ]; then return; fi
     INSTOPSYSTEM=1
     if [ -f ${BUILDDIR}/.toasterui.pid ]; then
         kill $(< ${BUILDDIR}/.toasterui.pid ) 2>/dev/null
@@ -119,7 +119,7 @@ function check_pidbyfile() {
 
 
 function notify_chldexit() {
-    if [ $NOTOASTERUI == 0 ]; then
+    if [ $NOTOASTERUI -eq 0 ]; then
         check_pidbyfile ${BUILDDIR}/.toasterui.pid && return
         stop_system
     fi
@@ -143,8 +143,7 @@ function verify_prereq() {
 
 
 # read command line parameters
-
-BBBASEDIR=`dirname ${BASH_SOURCE}`/..
+BBBASEDIR=`dirname ${BASH_SOURCE:-${(%):-%x}}`/..
 RUNNING=0
 
 NOTOASTERUI=0
@@ -168,8 +167,9 @@ for param in $*; do
     esac
 done
 
+[ -z "$ZSH_NAME" ] && SRCFILE=${BASH_SOURCE} || SRCFILE=$_
 
-if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; then
+if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
     # We are called as standalone. We refuse to run in a build environment - we need the interactive mode for that.
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
@@ -183,7 +183,7 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
         exit 1;
     fi
 
-    if [ "x`which daemon`" == "x" ]; then
+    if ! which daemon >/dev/null 2>&1; then
         echo -e "Failed dependency; toaster needs the 'daemon' program in order to be able to start builds'. Please install the 'daemon' program from your distribution repositories or http://www.libslack.org/daemon/" 1>&2;
 	exit 1;
     fi
@@ -251,14 +251,14 @@ fi
 
 
 # We make sure we're running in the current shell and in a good environment
-if [ -z "$BUILDDIR" ] || [ -z `which bitbake` ]; then
+if [ -z "$BUILDDIR" ] ||  ! which bitbake >/dev/null 2>&1 ; then
     echo "Error: Build environment is not setup or bitbake is not in path." 1>&2;
     return 2
 fi
 
 
 # Determine the action. If specified by arguments, fine, if not, toggle it
-if [ "x$1" == "xstart" ] || [ "x$1" == "xstop" ]; then
+if [ "$1" '==' 'start' ] || [ "$1" '==' 'stop' ]; then
     CMD="$1"
 else
     if [ -z "$BBSERVER" ]; then
@@ -274,16 +274,16 @@ echo "The system will $CMD."
 
 lock=1
 if [ -e $BUILDDIR/bitbake.lock ]; then
-    (flock -n 200 ) 200<$BUILDDIR/bitbake.lock || lock=0
+    python -c "import fcntl; fcntl.flock(open(\"$BUILDDIR/bitbake.lock\"), fcntl.LOCK_EX|fcntl.LOCK_NB)" 2>/dev/null || lock=0
 fi
 
-if [ ${CMD} == "start" ] && [ $lock -eq 0 ]; then
+if [ ${CMD} '==' 'start' ] && [ $lock -eq 0 ]; then
     echo "Error: bitbake lock state error. File locks show that the system is on." 1>&2
     echo "Please wait for the current build to finish, stop and then start the system again." 1>&2
     return 3
 fi
 
-if [ ${CMD} == "start" ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
+if [ ${CMD} '==' 'start' ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
     echo "Warning: bitbake appears to be dead, but the Toaster web server is running. Something fishy is going on." 1>&2
     echo "Cleaning up the web server to start from a clean slate."
     webserverKillAll
@@ -311,7 +311,7 @@ case $CMD in
             echo "Bitbake server start failed"
         else
             export BBSERVER=0.0.0.0:-1
-            if [ $NOTOASTERUI == 0 ]; then        # we start the TOASTERUI only if not inhibited
+            if [ $NOTOASTERUI -eq 0 ]; then        # we start the TOASTERUI only if not inhibited
                 bitbake --observe-only -u toasterui >>${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
             fi
         fi
-- 
1.9.1


