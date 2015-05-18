Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 4DB26609B2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 22:06:21 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 18 May 2015 15:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,455,1427785200"; d="scan'208";a="573315028"
Received: from bitbang.jf.intel.com ([10.7.201.37])
	by orsmga003.jf.intel.com with ESMTP; 18 May 2015 15:06:22 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2015 15:06:11 -0700
Message-Id: <1431986772-17395-2-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1431986772-17395-1-git-send-email-randy.e.witt@linux.intel.com>
References: <1431986772-17395-1-git-send-email-randy.e.witt@linux.intel.com>
Subject: [PATCH 1/2] localhostbecontroller: Fix server search debug message
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
X-List-Received-Date: Mon, 18 May 2015 22:06:21 -0000

When the output from the commands ran was redirected to
"toaster_server.log" instead of the console, the debug message stating
the port on which bitbake is running would no longer appear.

This change makes looks at "toaster_server.log" for the port rather than
the _shellcmd output. This makes the debug message useful again.

Signed-off-by: Randy Witt <randy.e.witt@linux.intel.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 1bd5143..95ba481 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -122,10 +122,11 @@ class LocalhostBEController(BuildEnvironmentController):
         port = "-1"
         logger.debug("localhostbecontroller: starting builder \n%s\n" % cmd)
         cmdoutput = self._shellcmd(cmd)
-        for i in cmdoutput.split("\n"):
-            if i.startswith("Bitbake server address"):
-                port = i.split(" ")[-1]
-                logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
+        with open(self.be.builddir + "/toaster_server.log", "r") as f:
+            for i in f.readlines():
+                if i.startswith("Bitbake server address"):
+                    port = i.split(" ")[-1]
+                    logger.debug("localhostbecontroller: Found bitbake server port %s" % port)
 
         def _toaster_ui_started(filepath, filepos = 0):
             if not os.path.exists(filepath):
-- 
1.9.3


