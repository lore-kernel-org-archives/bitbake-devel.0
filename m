Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Eo-00067J-Hx
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:40:46 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 15 Mar 2012 01:31:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129245722"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2012 01:31:58 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:29:50 +0800
Message-Id: <e3c5eed2244d7885418c59a62c9584f6397ee623.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 02/12] Hob: Disable the handling of "NoProvider" event
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
X-List-Received-Date: Thu, 15 Mar 2012 08:40:46 -0000

Currently for non-x86 architecture, there are un-resolved dependency
issue when generate universe dependency tree. Therefore disable the
handling of "NoProvider" event in Hob to enable the build for non-x86
architectures. After we resolved the dependency for universe, we still
need to handle this event in Hob.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |   37 ++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 6c109fc..9c82bfe 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
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
1.7.4.1



