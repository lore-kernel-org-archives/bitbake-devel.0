Return-Path: <elliot.smith@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7C44560107
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Nov 2015 18:29:48 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 20 Nov 2015 10:29:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,323,1444719600"; d="scan'208";a="855928292"
Received: from unknown (HELO lp.ger.corp.intel.com) ([10.252.30.68])
	by orsmga002.jf.intel.com with ESMTP; 20 Nov 2015 10:29:43 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Nov 2015 18:29:34 +0000
Message-Id: <1448044174-10810-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] toaster: change toasterconf.json logic to use TEMPLATECONF, like oe-setup-builddir
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
X-List-Received-Date: Fri, 20 Nov 2015 18:29:50 -0000

From: brian avery <avery.brian@gmail.com>

This changes the way we pick a toasterconf.json file so that it
matches the way oe-setup-builddir does it. We now base it on TEMPLATECONF
found in the .templateconf file.

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 2c3432c..432756c 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -179,6 +179,7 @@ fi
 [ `basename \"$0\"` = `basename \"${TOASTER}\"` ] && TOASTER_MANAGED=1
 
 BBBASEDIR=`dirname $TOASTER`/..
+OEROOT=`dirname $TOASTER`/../..
 
 RUNNING=0
 
@@ -189,18 +190,33 @@ if [ "$WEB_PORT" = "" ]; then
     WEB_PORT="8000"
 fi
 # this is the configuraton file we are using for toaster
-# note default is assuming yocto. Override this if you are
-# running in a pure OE environment and use the toasterconf.json
-# in meta/conf/toasterconf.json
-# note: for future there are a number of relative path assumptions
-# in the local layers that currently prevent using an arbitrary
-# toasterconf.json
+# we are using the same logic that oe-setup-builddir uses
+# (based on TEMPLATECONF and .templateconf) to determine
+# which toasterconf.json to use.
+# note: There are a number of relative path assumptions
+# in the local layers that currently make using an arbitrary
+# toasterconf.json difficult.
+
+. $OEROOT/.templateconf
+if [ -n "$TEMPLATECONF" ]; then
+    if [ ! -d "$TEMPLATECONF" ]; then
+        # Allow TEMPLATECONF=meta-xyz/conf as a shortcut
+        if [ -d "$OEROOT/$TEMPLATECONF" ]; then
+            TEMPLATECONF="$OEROOT/$TEMPLATECONF"
+        fi
+        if [ ! -d "$TEMPLATECONF" ]; then
+            echo >&2 "Error: '$TEMPLATECONF' must be a directory containing toasterconf.json"
+	    [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
+        fi
+    fi
+fi
+
 if [ "$TOASTER_CONF" = "" ]; then
-    TOASTER_CONF="$(dirname $TOASTER)/../../meta-yocto/conf/toasterconf.json"
+    TOASTER_CONF="$TEMPLATECONF/toasterconf.json"
     export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
 fi
 if [ ! -f $TOASTER_CONF ]; then
-    echo "$TOASTER_CONF configuration file not found. set TOASTER_CONF to specify a path"
+    echo "$TOASTER_CONF configuration file not found. Set TOASTER_CONF to specify file or fix .templateconf"
     [ "$TOASTER_MANAGED" = '1' ] && exit 1 || return 1
 fi
 # this defines the dir toaster will use for
@@ -395,4 +411,3 @@ case $CMD in
         echo "Successful ${CMD}."
     ;;
 esac
-
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


