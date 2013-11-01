Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 188FD6D4F0
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:47 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337457"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:33 +0000
Message-Id: <035bbb3a5b805d9ccb7991f4bad70af6491f8fc2.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 6/8] toaster: server shutdown on terminal exit
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:47 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

If the terminal where the server was started is closed,
the bitbake server should shutdown. Currently the system
is left in hanging state.

This patch uses "trap" command to make sure the servers
are closed on terminal exit.

[YOCTO #5376]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/toaster | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 16de52b..cc631f6 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -49,6 +49,19 @@ function webserverStartAll()
         return $retval
 }
 
+# define the stop command
+function stop_system()
+{
+    if [ -f ${BUILDDIR}/.toasterui.pid ]; then
+        kill $(< ${BUILDDIR}/.toasterui.pid )
+        rm ${BUILDDIR}/.toasterui.pid
+    fi
+    BBSERVER=localhost:8200 bitbake -m
+    unset BBSERVER
+    webserverKillAll
+    # force stop any misbehaving bitbake server
+    lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
+}
 
 # We make sure we're running in the current shell and in a good environment
 
@@ -116,6 +129,9 @@ and
 fi
 
 
+
+
+
 # Execute the commands
 
 case $CMD in
@@ -127,17 +143,12 @@ case $CMD in
         if [ $NOTOASTERUI == 0 ]; then        # we start the TOASTERUI only if not inhibited
             bitbake --observe-only -u toasterui >${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
         fi
+        # stop system on terminal exit
+        trap stop_system SIGHUP
     ;;
     stop )
-        if [ -f ${BUILDDIR}/.toasterui.pid ]; then
-            kill $(< ${BUILDDIR}/.toasterui.pid )
-            rm ${BUILDDIR}/.toasterui.pid
-        fi
-        bitbake -m
-        unset BBSERVER
-        webserverKillAll
-        # force stop any misbehaving bitbake server
-        lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
+        stop_system
+        trap '' SIGHUP
     ;;
 esac
 
-- 
1.8.1.2


