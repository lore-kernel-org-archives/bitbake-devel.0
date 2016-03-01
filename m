Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E870A731EA
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Mar 2016 11:41:19 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 01 Mar 2016 03:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,522,1449561600"; d="scan'208";a="755920183"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.7.94])
	by orsmga003.jf.intel.com with ESMTP; 01 Mar 2016 03:41:18 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Mar 2016 11:40:55 +0000
Message-Id: <1456832455-6092-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: cleanup of bin/toaster startup code
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
X-List-Received-Date: Tue, 01 Mar 2016 11:41:21 -0000

From: brian avery <avery.brian@gmail.com>

This cleanup fixes a few issues:

    1) Removes the superflous code to set toasterconf.json
       - this isn't used and referenced meta-yocto
    2) Changes exit to return so we don't surprise the user by exiting their shell
       - this is necessary because it is being sourced
    3) Removes the last references to the old TOASTER_MANAGED variable
       - this is historical and no longer used.
    4) Adds -t parameter to lsof
      - This stops it from dying on odd filesystems and is much
        faster since all we are using are processes anyway
    5) Handles start and stop as params
      - it was easy to confuse the script especially
        if we were calling it with parameters.
      - if start/stop isn't specified, it will still toggle

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 72eae64..d409554 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -128,7 +128,7 @@ stop_bitbake() {
     BBSERVER=0.0.0.0:-1 bitbake -m
     unset BBSERVER
     # force stop any misbehaving bitbake server
-    lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
+    lsof -t bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
 }
 
 verify_prereq() {
@@ -177,7 +177,7 @@ if [ -n "$TEMPLATECONF" ]; then
         fi
         if [ ! -d "$TEMPLATECONF" ]; then
             echo >&2 "Error: '$TEMPLATECONF' must be a directory containing toasterconf.json"
-            [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
+            return 1
         fi
     fi
 fi
@@ -189,7 +189,7 @@ fi
 
 if [ ! -f $TOASTER_CONF ]; then
     echo "$TOASTER_CONF configuration file not found. Set TOASTER_CONF to specify file or fix .templateconf"
-    [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
+    return 1
 fi
 
 # this defines the dir toaster will use for
@@ -204,7 +204,7 @@ export TOASTER_DIR=`pwd`
 NOTOASTERUI=0
 WEBSERVER=1
 WEB_PORT="8000"
-
+unset CMD
 for param in $*; do
     case $param in
     noui )
@@ -213,6 +213,12 @@ for param in $*; do
     noweb )
             WEBSERVER=0
     ;;
+    start )
+            CMD=$param
+    ;;
+    stop )
+            CMD=$param
+    ;;
     webport=*)
             WEB_PORT="${param#*=}"
     esac
@@ -220,7 +226,7 @@ done
 
 if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
     echo "Error: This script needs to be sourced. Please run as . $TOASTER"
-    exit 1
+    return 1
 fi
 
 if [ "$1" = 'restart-bitbake' ] ; then
@@ -240,22 +246,6 @@ if [ -z "$BUILDDIR" ] ||  ! which bitbake >/dev/null 2>&1 ; then
     return 2
 fi
 
-# this is the configuraton file we are using for toaster
-# note default is assuming yocto. Override this if you are
-# running in a pure OE environment and use the toasterconf.json
-# in meta/conf/toasterconf.json
-# note: for future there are a number of relative path assumptions
-# in the local layers that currently prevent using an arbitrary
-# toasterconf.json
-if [ "$TOASTER_CONF" = "" ]; then
-    TOASTER_CONF="$(dirname $TOASTER)/../../meta-yocto/conf/toasterconf.json"
-    export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
-fi
-if [ ! -f $TOASTER_CONF ]; then
-    echo "$TOASTER_CONF configuration file not found."
-    echo " set TOASTER_CONF to specify a path"
-    return 1
-fi
 # this defines the dir toaster will use for
 # 1) clones of layers (in _toaster_clones )
 # 2) the build dir (in build)
@@ -267,9 +257,12 @@ fi
 export TOASTER_DIR=`dirname $BUILDDIR`
 
 # Determine the action. If specified by arguments, fine, if not, toggle it
-if [ "$1" = 'start' ] || [ "$1" = 'stop' ]; then
-    CMD="$1"
-else
+if [ "$CMD" = "start" ] ; then
+    if [ -n "$BBSERVER" ]; then
+	echo " Toaster is already running. Exiting..."
+	return 1
+fi
+elif [ "$CMD" = "" ]; then
     if [ -z "$BBSERVER" ]; then
         CMD="start"
     else
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


