Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id B1BF06CB5B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:12 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 24 Sep 2013 09:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="298814531"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Sep 2013 09:53:08 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id B5FFD5613B9; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:54 +0100
Message-Id: <37554369fe51c143654cb80500a147c551917de6.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 25/94] bitbake: webhob: fix and cleanup start script
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Make sure that the script can start without a bitbake.lock
file present.
Fixes [YOCTO #4873].

Also, clean up whitespace.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/bin/webhob | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/bitbake/bin/webhob b/bitbake/bin/webhob
index 8513a3a..44a25cb 100755
--- a/bitbake/bin/webhob
+++ b/bitbake/bin/webhob
@@ -21,8 +21,8 @@
 # use as:  source webhob [start|stop]
 
 # Helper function to kill a background webhob development server
-        
-function webserverKillAllComponents() 
+
+function webserverKillAllComponents()
 {
 	local pidfile
 	for pidfile in ${BUILDDIR}/whbmain.pid; do
@@ -42,7 +42,7 @@ if [ -z "$ZSH_NAME" ] && [ `basename "$0"` = `basename $BASH_SOURCE` ]; then
     echo "Error: This script needs to be sourced. Please run as 'source webhob [start|stop]'" 1>&2;
     exit 1
 fi
-    
+
 if [ -z "$BUILDDIR" ] || [ -z `which bitbake` ]; then
     echo "Error: Build environment is not setup or bitbake is not in path." 1>&2;
     return 2
@@ -64,15 +64,17 @@ fi
 # Make sure it's safe to run by checking bitbake lock
 
 lock=1
-(flock -n 200 ) 200<$BUILDDIR/bitbake.lock || lock=0 
+if [ -e $BUILDDIR/bitbake.lock ]; then
+    (flock -n 200 ) 200<$BUILDDIR/bitbake.lock || lock=0
+fi
 
 if [ ${CMD} == "start" ] && ( [ $lock -eq 0 ] || [ -e $BUILDDIR/whbmain.pid ] ); then
     echo "Error: bitbake lock state error. System may be already on." 2>&1
-    return 3 
+    return 3
 elif [ ${CMD} == "stop" ] && ( [ $lock -eq 1 ] || ! [ -e $BUILDDIR/whbmain.pid ] ) ; then
     echo "Error: bitbake lock state error. System may be already off.
 manually stop system with bitbake -m / webserverKillAllComponents" 2>&1
-    return 3 
+    return 3
 fi
 
 
@@ -82,7 +84,7 @@ case $CMD in
     start )
         unset BBSERVER
         python $BBBASEDIR/lib/webhob/manage.py syncdb || (echo "Failed db sync, stopping system start" 1>&2 && return 0)
-        bitbake --server-only -t xmlrpc -B localhost:8200 
+        bitbake --server-only -t xmlrpc -B localhost:8200
         export BBSERVER=localhost:8200
         bitbake --observe-only -u dsi >/dev/null 2>&1 & echo $! >${BUILDDIR}/dsi.pid
         python $BBBASEDIR/lib/webhob/manage.py runserver </dev/null >${BUILDDIR}/whbmain.log 2>&1 & echo $! >${BUILDDIR}/whbmain.pid
@@ -95,4 +97,4 @@ case $CMD in
         webserverKillAllComponents
 esac
 
-    
+
-- 
1.8.1.2


