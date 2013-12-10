Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 285B460EE0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 18:24:25 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 10 Dec 2013 10:24:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,866,1378882800"; d="scan'208";a="447828210"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2013 10:24:20 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 4BEC356022D; Tue, 10 Dec 2013 18:24:20 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Dec 2013 18:24:18 +0000
Message-Id: <1386699858-13195-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] toaster: add two-stage commit startup logic
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
X-List-Received-Date: Tue, 10 Dec 2013 18:24:26 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Toaster start script lunches multiple process components
of the toaster system.

This patch adds logic into the startup script to
safely fail startup and do proper cleanup on any error
that may happen during system start.

Bitbake needs to return 0 if it will successfully lunches
the server-mode.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>

diff --git a/bin/bitbake b/bin/bitbake
index 5857b92..fbd8c91 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -343,6 +343,7 @@ def main():
             server_connection.terminate()
     else:
         print("server address: %s, server port: %s" % (server.serverImpl.host, server.serverImpl.port))
+        return 0
 
     return 1
 
diff --git a/bin/toaster b/bin/toaster
index fc59fe5..38e71ac 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -51,6 +51,11 @@ function webserverStartAll()
         fi
         if [ $retval -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
+            sleep 1
+            if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
+                retval=1
+                rm "${BUILDDIR}/.toastermain.pid"
+            fi
         fi
         return $retval
 }
@@ -120,9 +125,13 @@ else
 fi
 
 NOTOASTERUI=0
-if [ "x$2" == "xnoui" ]; then
-    NOTOASTERUI=1
-fi
+for param in $*; do
+    case $param in
+    noui )
+            NOTOASTERUI=1
+    ;;
+    esac
+done
 
 echo "The system will $CMD."
 
@@ -157,22 +166,38 @@ fi
 
 case $CMD in
     start )
+        start_success=1
         addtoConfiguration "INHERIT+=\"toaster buildhistory\"" toaster.conf
-        webserverStartAll || return 4
+        if ! webserverStartAll; then
+            echo "Failed ${CMD}."
+            return 4
+        fi
         unset BBSERVER
         bitbake --postread conf/toaster.conf --server-only -t xmlrpc -B localhost:8200
-        export BBSERVER=localhost:8200
-        if [ $NOTOASTERUI == 0 ]; then        # we start the TOASTERUI only if not inhibited
-            bitbake --observe-only -u toasterui >${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
+        if [ $? -ne 0 ]; then
+            start_success=0
+            echo "Bitbake server start failed"
+        else
+            export BBSERVER=localhost:8200
+            if [ $NOTOASTERUI == 0 ]; then        # we start the TOASTERUI only if not inhibited
+                bitbake --observe-only -u toasterui >${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
+            fi
+        fi
+        if [ $start_success -eq 1 ]; then
+            # set fail safe stop system on terminal exit
+            trap stop_system SIGHUP
+            echo "Successful ${CMD}."
+        else
+            # failed start, do stop
+            stop_system
+            echo "Failed ${CMD}."
         fi
-        # stop system on terminal exit
-        trap stop_system SIGHUP
     ;;
     stop )
         stop_system
         trap '' SIGHUP
+        echo "Successful ${CMD}."
     ;;
 esac
 
-echo "Successful ${CMD}."
 
-- 
1.8.3.2


