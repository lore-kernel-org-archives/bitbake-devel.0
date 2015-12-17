Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 9D13C731B6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:11 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002740"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:11 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:54 +0000
Message-Id: <d7622f038cfa58ee9740957ae7c1a491258c4956.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 09/11] toaster: move startup checks to a better place
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:11 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Moved addr:port, bitbake.lock and toastermain.pid checks
to the place where the rest of Toaster starting happens.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 1f4c400..6dd20c1 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -288,36 +288,33 @@ fi
 
 echo "The system will $CMD."
 
-# check if addr:port is not in use
-if [ "$CMD" == 'start' ]; then
-    $MANAGE checksocket "0.0.0.0:$WEB_PORT" || return 1
-fi
-
-# Make sure it's safe to run by checking bitbake lock
-
-lock=1
-if [ -e $BUILDDIR/bitbake.lock ]; then
-    python -c "import fcntl; fcntl.flock(open(\"$BUILDDIR/bitbake.lock\"), fcntl.LOCK_EX|fcntl.LOCK_NB)" 2>/dev/null || lock=0
-fi
-
-if [ ${CMD} = 'start' ] && [ $lock -eq 0 ]; then
-    echo "Error: bitbake lock state error. File locks show that the system is on." 1>&2
-    echo "Please wait for the current build to finish, stop and then start the system again." 1>&2
-    return 3
-fi
-
-if [ ${CMD} = 'start' ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
-    echo "Warning: bitbake appears to be dead, but the Toaster web server is running." 1>&2
-    echo " Something fishy is going on." 1>&2
-    echo "Cleaning up the web server to start from a clean slate."
-    webserverKillAll
-fi
-
-
 # Execute the commands
 
 case $CMD in
     start )
+        # check if addr:port is not in use
+        if [ "$CMD" == 'start' ]; then
+             $MANAGE checksocket "0.0.0.0:$WEB_PORT" || return 1
+        fi
+
+        # Make sure it's safe to start by checking bitbake lock
+        if [ -e $BUILDDIR/bitbake.lock ]; then
+            python -c "import fcntl; fcntl.flock(open(\"$BUILDDIR/bitbake.lock\"), fcntl.LOCK_EX|fcntl.LOCK_NB)" 2>/dev/null
+            if [ $? -ne 0 ] ; then
+                echo "Error: bitbake lock state error. File locks show that the system is on." 1>&2
+                echo "Please wait for the current build to finish, stop and then start the system again." 1>&2
+                return 3
+            fi
+        fi
+
+        # kill Toaster web server if it's alive
+        if [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
+            echo "Warning: bitbake appears to be dead, but the Toaster web server is running." 1>&2
+            echo " Something fishy is going on." 1>&2
+            echo "Cleaning up the web server to start from a clean slate."
+            webserverKillAll
+        fi
+
         # Create configuration file
         conf=${BUILDDIR}/conf/toaster.conf
         echo "# Created by toaster start script" > $conf
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


