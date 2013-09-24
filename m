Return-Path: <ddalex@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BDD216CABF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:08 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Sep 2013 09:53:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="382902455"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by orsmga001.jf.intel.com with ESMTP; 24 Sep 2013 09:53:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id DE0B95621CA; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:52:10 +0100
Message-Id: <ca1b3964ce8ec36f09b020ec177e334bac7e2a86.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 41/94] bitbake: webhob: improve startup script
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

A couple of modification targeted at making the
system start/stop script more resilient.

Also, it now checks for the correct Django version.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/bin/webhob | 53 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/bitbake/bin/webhob b/bitbake/bin/webhob
index 44a25cb..7b74465 100755
--- a/bitbake/bin/webhob
+++ b/bitbake/bin/webhob
@@ -22,13 +22,13 @@
 
 # Helper function to kill a background webhob development server
 
-function webserverKillAllComponents()
+function webserverKillAll()
 {
 	local pidfile
 	for pidfile in ${BUILDDIR}/whbmain.pid; do
 		if [ -f ${pidfile} ]; then
 		while kill -0 $(< ${pidfile}) 2>/dev/null; do
-			kill -SIGTERM -$(< ${pidfile})
+			kill -SIGTERM -$(< ${pidfile}) 2>/dev/null
 			sleep 1;
 		done;
 		rm  ${pidfile}
@@ -36,6 +36,15 @@ function webserverKillAllComponents()
 	done
 }
 
+
+function webserverStartAll()
+{
+        python $BBBASEDIR/lib/webhob/manage.py syncdb || (echo "Failed db sync, stopping system start" 1>&2 && return 2)
+        python $BBBASEDIR/lib/webhob/manage.py runserver </dev/null >${BUILDDIR}/whbmain.log 2>&1 & echo $! >${BUILDDIR}/whbmain.pid
+        return 0
+}
+
+
 # We make sure we're running in the current shell and in a good environment
 
 if [ -z "$ZSH_NAME" ] && [ `basename "$0"` = `basename $BASH_SOURCE` ]; then
@@ -50,6 +59,16 @@ fi
 
 BBBASEDIR=`dirname ${BASH_SOURCE}`/..
 
+
+# Verify prerequisites
+
+if ! echo "import django; print (1,4,5) == django.VERSION[0:3]" | python 2>/dev/null | grep True >/dev/null; then
+    echo -e "This program needs Django 1.4.5. Please install with\n\nsudo pip install django==1.4.5"
+    return 2
+fi
+
+
+
 # Determine the action. If specified by arguments, fine, if not, toggle it
 if [ "x$1" == "xstart" ] || [ "x$1" == "xstop" ]; then
     CMD="$1"
@@ -61,6 +80,13 @@ else
     fi;
 fi
 
+NODSI=0
+if [ "x$2" == "xnodsi" ]; then
+    NODSI=1
+fi
+
+echo "The system will $CMD."
+
 # Make sure it's safe to run by checking bitbake lock
 
 lock=1
@@ -69,11 +95,11 @@ if [ -e $BUILDDIR/bitbake.lock ]; then
 fi
 
 if [ ${CMD} == "start" ] && ( [ $lock -eq 0 ] || [ -e $BUILDDIR/whbmain.pid ] ); then
-    echo "Error: bitbake lock state error. System may be already on." 2>&1
+    echo "Error: bitbake lock state error. System is already on." 2>&1
     return 3
 elif [ ${CMD} == "stop" ] && ( [ $lock -eq 1 ] || ! [ -e $BUILDDIR/whbmain.pid ] ) ; then
-    echo "Error: bitbake lock state error. System may be already off.
-manually stop system with bitbake -m / webserverKillAllComponents" 2>&1
+    echo "Error: bitbake lock state error. Trying to stop a stopped system ?
+manually stop system with bitbake -m / webserverKill" 2>&1
     return 3
 fi
 
@@ -82,19 +108,24 @@ fi
 
 case $CMD in
     start )
+        webserverStartAll || return 4
         unset BBSERVER
-        python $BBBASEDIR/lib/webhob/manage.py syncdb || (echo "Failed db sync, stopping system start" 1>&2 && return 0)
         bitbake --server-only -t xmlrpc -B localhost:8200
         export BBSERVER=localhost:8200
-        bitbake --observe-only -u dsi >/dev/null 2>&1 & echo $! >${BUILDDIR}/dsi.pid
-        python $BBBASEDIR/lib/webhob/manage.py runserver </dev/null >${BUILDDIR}/whbmain.log 2>&1 & echo $! >${BUILDDIR}/whbmain.pid
+        if [ $NODSI == 0 ]; then        # we start the DSI only if not inhibited
+            bitbake --observe-only -u dsi >/dev/null 2>&1 & echo $! >${BUILDDIR}/dsi.pid
+        fi
     ;;
     stop )
-        kill $(< ${BUILDDIR}/dsi.pid )
-        rm ${BUILDDIR}/dsi.pid
+        if [ -f ${BUILDDIR}/dsi.pid ]; then
+            kill $(< ${BUILDDIR}/dsi.pid )
+            rm ${BUILDDIR}/dsi.pid
+        fi
         bitbake -m
         unset BBSERVER
-        webserverKillAllComponents
+        webserverKillAll
+    ;;
 esac
 
+echo "Successful ${CMD}."
 
-- 
1.8.1.2


