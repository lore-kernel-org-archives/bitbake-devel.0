Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 4B0376011F
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 11:23:07 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP; 04 Jan 2016 03:23:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,520,1444719600"; d="scan'208";a="627697714"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2016 03:23:07 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 7FD266A4006;
	Mon,  4 Jan 2016 04:11:05 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jan 2016 11:26:34 +0200
Message-Id: <1451899594-16564-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1451895278-14099-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1451895278-14099-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 4/4 v3] uievent: refactor retry loop
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
X-List-Received-Date: Mon, 04 Jan 2016 11:23:08 -0000

Replaced 'while' loop with 'for' loop.
Made the code more compact and hopefully more understandable.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/ui/uievent.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/uievent.py b/bitbake/lib/bb/ui/uievent.py
index 19a9301..4670cdb 100644
--- a/bitbake/lib/bb/ui/uievent.py
+++ b/bitbake/lib/bb/ui/uievent.py
@@ -45,27 +45,25 @@ class BBUIEventQueue:
         server.socket.settimeout(1)
 
         self.EventHandle = None
-        count_tries = 0
 
         # the event handler registration may fail here due to cooker being in invalid state
         # this is a transient situation, and we should retry a couple of times before
         # giving up
 
-        while self.EventHandle == None and count_tries < 5:
+        for count_tries in range(5):
+
             self.EventHandle, error = self.BBServer.registerEventHandler(self.host, self.port)
 
-            if (self.EventHandle != None):
+            if self.EventHandle != None:
                 break
 
-            errmsg = "Could not register UI event handler. Error: %s, host %s, "
-                     "port %d" % (error, self.host, self.port))
+            errmsg = "Could not register UI event handler. Error: %s, host %s, "\
+                     "port %d" % (error, self.host, self.port)
             bb.warn("%s, retry" % errmsg)
-            count_tries += 1
+
             import time
             time.sleep(1)
-
-
-        if self.EventHandle == None:
+        else:
             raise Exception(errmsg)
 
         self.server = server
-- 
2.1.4


