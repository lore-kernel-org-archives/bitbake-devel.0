Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id E10B97316F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Dec 2015 18:39:12 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 31 Dec 2015 10:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,504,1444719600"; d="scan'208";a="626313105"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Dec 2015 10:39:14 -0800
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 4D3976A4087;
	Thu, 31 Dec 2015 11:27:12 -0800 (PST)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Dec 2015 18:42:14 +0200
Message-Id: <1451580136-29714-3-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1451580136-29714-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 2/4] uievent: add error to registerEventHandler return
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
X-List-Received-Date: Thu, 31 Dec 2015 18:39:13 -0000

Current code throws Exception("Could not register UI event handler")
if event handler can't be registered. The real reason of this is that
cooker is in busy state. Error message lacks information about this.

Added error message to the return value of registerEventHandler.
Included returned error message into the log message and exception
text.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>

diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index b7647c1..17eb28b 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -97,10 +97,10 @@ class BitBakeServerCommands():
 
         # we don't allow connections if the cooker is running
         if (self.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]):
-            return None
+            return None, "Cooker is busy: %s" % bb.cooker.state.get_name(self.cooker.state)
 
         self.event_handle = bb.event.register_UIHhandler(s, True)
-        return self.event_handle
+        return self.event_handle, 'OK'
 
     def unregisterEventHandler(self, handlerNum):
         """
diff --git a/bitbake/lib/bb/ui/uievent.py b/bitbake/lib/bb/ui/uievent.py
index 7fc50c7..80686a6 100644
--- a/bitbake/lib/bb/ui/uievent.py
+++ b/bitbake/lib/bb/ui/uievent.py
@@ -52,19 +52,21 @@ class BBUIEventQueue:
         # giving up
 
         while self.EventHandler == None and count_tries < 5:
-            self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port)
+            self.EventHandle, error = self.BBServer.registerEventHandler(self.host, self.port)
 
             if (self.EventHandle != None):
                 break
 
-            bb.warn("Could not register UI event handler %s:%d, retry" % (self.host, self.port))
+            errmsg = "Could not register UI event handler. Error: %s, " \
+                     "host %s, port %d" % (error, self.host, self.port)
+            bb.warn("%s, retry" % errmsg)
             count_tries += 1
             import time
             time.sleep(1)
 
 
         if self.EventHandle == None:
-            raise Exception("Could not register UI event handler")
+            raise Exception(errmsg)
 
         self.server = server
 
-- 
2.1.4


