Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id D59617319F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:05 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002658"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:03 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:48 +0000
Message-Id: <a4863117888ede1cead1ddf43c7740226f61c5c2.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 03/11] toaster: split long lines, add/remove whitespace
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:06 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Made toaster script more readable by splitting long lines and
removing and adding whitespace.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index f43bcb1..a849559 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -37,7 +37,8 @@ webserverKillAll()
             while kill -0 $pid 2>/dev/null; do
                 kill -SIGTERM -$pid 2>/dev/null
                 sleep 1
-                # Kill processes if they are still running - may happen in interactive shells
+                # Kill processes if they are still running - may happen
+                # in interactive shells
                 ps fux | grep "python.*manage.py runserver" | awk '{print $2}' | xargs kill
             done
             rm  ${pidfile}
@@ -55,7 +56,7 @@ webserverStartAll()
 
     retval=0
     # you can always add a superuser later via
-    # python bitbake/lib/toaster/manage.py python manage.py createsuperuser --username=<ME>
+    # ../bitbake/lib/toaster/manage.py createsuperuser --username=<ME>
     python $BBBASEDIR/lib/toaster/manage.py migrate --noinput || retval=1
 
     if [ $retval -eq 1 ]; then
@@ -72,7 +73,9 @@ webserverStartAll()
 
     echo "Starting webserver..."
 
-    python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
+    python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" \
+           </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
+           & echo $! >${BUILDDIR}/.toastermain.pid
 
     sleep 1
 
@@ -128,8 +131,10 @@ start_bitbake() {
     fi
     export BBSERVER=0.0.0.0:-1
     export DATABASE_URL=`$BBBASEDIR/lib/toaster/manage.py get-dburl`
-    if [ $NOTOASTERUI -eq 0 ]; then        # we start the TOASTERUI only if not inhibited
-        bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc >>${BUILDDIR}/toaster_ui.log 2>&1 \
+    # we start the TOASTERUI only if not inhibited
+    if [ $NOTOASTERUI -eq 0 ]; then
+        bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc \
+            >>${BUILDDIR}/toaster_ui.log 2>&1 \
             & echo $! >${BUILDDIR}/.toasterui.pid
     fi
     return 0
@@ -146,7 +151,6 @@ check_pidbyfile() {
     [ -e $1 ] && kill -0 `cat $1` 2>/dev/null
 }
 
-
 notify_chldexit() {
     if [ $NOTOASTERUI -eq 0 ]; then
         check_pidbyfile ${BUILDDIR}/.toasterui.pid && return
@@ -154,7 +158,6 @@ notify_chldexit() {
     fi
 }
 
-
 verify_prereq() {
     # Verify Django version
     reqfile=$(python -c "import os; print os.path.realpath('$BBBASEDIR/toaster-requirements.txt')")
@@ -171,7 +174,6 @@ verify_prereq() {
     return 0
 }
 
-
 # read command line parameters
 if [ -n "$BASH_SOURCE" ] ; then
     TOASTER=${BASH_SOURCE}
@@ -207,7 +209,7 @@ if [ -n "$TEMPLATECONF" ]; then
         fi
         if [ ! -d "$TEMPLATECONF" ]; then
             echo >&2 "Error: '$TEMPLATECONF' must be a directory containing toasterconf.json"
-	    [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
+            [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
         fi
     fi
 fi
@@ -216,10 +218,12 @@ if [ "$TOASTER_CONF" = "" ]; then
     TOASTER_CONF="$TEMPLATECONF/toasterconf.json"
     export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
 fi
+
 if [ ! -f $TOASTER_CONF ]; then
     echo "$TOASTER_CONF configuration file not found. Set TOASTER_CONF to specify file or fix .templateconf"
     [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
 fi
+
 # this defines the dir toaster will use for
 # 1) clones of layers (in _toaster_clones )
 # 2) the build dir (in build)
@@ -284,7 +288,8 @@ if [ "$TOASTER_CONF" = "" ]; then
     export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
 fi
 if [ ! -f $TOASTER_CONF ]; then
-    echo "$TOASTER_CONF configuration file not found. set TOASTER_CONF to specify a path"
+    echo "$TOASTER_CONF configuration file not found."
+    echo " set TOASTER_CONF to specify a path"
     return 1
 fi
 # this defines the dir toaster will use for
@@ -293,7 +298,8 @@ fi
 # 3) the sqlite db if that is being used.
 # 4) pid's we need to clean up on exit/shutdown
 # note: for future. in order to make this an arbitrary directory, we need to
-# make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
+# make sure that the toaster.sqlite file doesn't default to `pwd`
+# like it currently does.
 export TOASTER_DIR=`dirname $BUILDDIR`
 
 # Determine the action. If specified by arguments, fine, if not, toggle it
@@ -328,7 +334,8 @@ if [ ${CMD} = 'start' ] && [ $lock -eq 0 ]; then
 fi
 
 if [ ${CMD} = 'start' ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
-    echo "Warning: bitbake appears to be dead, but the Toaster web server is running. Something fishy is going on." 1>&2
+    echo "Warning: bitbake appears to be dead, but the Toaster web server is running." 1>&2
+    echo " Something fishy is going on." 1>&2
     echo "Cleaning up the web server to start from a clean slate."
     webserverKillAll
 fi
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


