Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kRy-0005xo-GV
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:24:14 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113068964"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 06:14:39 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:29 +0800
Message-Id: <93713faf8701668260d1822f9be8c8e6deaafc03.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 32/32] Hob: Disable the handling of "NoProvider" event
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 Feb 2012 14:24:14 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

Currently for non-x86 architecture, there are un-resolved dependency
issue when generate universe dependency tree. Therefore disable the
handling of "NoProvider" event in Hob to enable the build for non-x86
architectures. After we resolved the dependency for universe, we still
need to handle this event in Hob.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |   37 ++++++++++++++------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 6c109fc..9c82bfe 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -215,23 +215,26 @@ class HobHandler(gobject.GObject):
         elif isinstance(event, bb.command.CommandCompleted):
             self.current_phase = None
             self.run_next_command()
-
-        elif isinstance(event, bb.event.NoProvider):
-            if event._runtime:
-                r = "R"
-            else:
-                r = ""
-            if event._dependees:
-                self.error_msg += " Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
-            else:
-                self.error_msg += " Nothing %sPROVIDES '%s'" % (r, event._item)
-            if event._reasons:
-                for reason in event._reasons:
-                    self.error_msg += " %s" % reason
-
-            self.commands_async = []
-            self.emit("command-failed", self.error_msg)
-            self.error_msg = ""
+        # TODO: Currently there are NoProvider issues when generate
+        # universe tree dependency for non-x86 architecture.
+        # Comment the follow code to enable the build of non-x86
+        # architectures in Hob.
+        #elif isinstance(event, bb.event.NoProvider):
+        #    if event._runtime:
+        #        r = "R"
+        #    else:
+        #        r = ""
+        #    if event._dependees:
+        #        self.error_msg += " Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
+        #    else:
+        #        self.error_msg += " Nothing %sPROVIDES '%s'" % (r, event._item)
+        #    if event._reasons:
+        #        for reason in event._reasons:
+        #            self.error_msg += " %s" % reason
+
+        #    self.commands_async = []
+        #    self.emit("command-failed", self.error_msg)
+        #    self.error_msg = ""
 
         elif isinstance(event, bb.command.CommandFailed):
             self.commands_async = []
-- 
1.7.6



