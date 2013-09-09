Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 1CB696BFD4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Sep 2013 16:41:09 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 09 Sep 2013 09:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,872,1371106800"; d="scan'208";a="393133549"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 09 Sep 2013 09:41:09 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 8CC3D56122C; Mon,  9 Sep 2013 17:41:08 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon,  9 Sep 2013 17:41:03 +0100
Message-Id: <585c3c03c81324e8c24856f0fc35d46374d94312.1378743829.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
References: <ea491a92f917fa72be06c5e897dc3a55045e776e.1378743829.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1378743829.git.alexandru.damian@intel.com>
References: <cover.1378743829.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 12/13] bitbake: xmlrpc: delete unused code BitBakeUIEventServer
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
X-List-Received-Date: Mon, 09 Sep 2013 16:41:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

BitBakeUIEventServer is an unused class that pushes UI
events over a separate thread.

The current version of XMLRPC server works just fine with
the classic UI event handlers, so this class is not needed.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/server/xmlrpc.py | 45 -----------------------------------------
 1 file changed, 45 deletions(-)

diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index a28672c..8326623 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -169,51 +169,6 @@ class BitBakeXMLRPCRequestHandler(SimpleXMLRPCRequestHandler):
         self.end_headers()
         self.wfile.write(response)
 
-class BitBakeUIEventServer(threading.Thread):
-    class EventAdapter():
-        """
-        Adapter to wrap our event queue since the caller (bb.event) expects to
-        call a send() method, but our actual queue only has put()
-        """
-        def __init__(self, notify):
-            self.queue = []
-            self.notify = notify
-            self.qlock = threading.Lock()
-
-        def send(self, event):
-            self.qlock.acquire()
-            self.queue.append(event)
-            self.qlock.release()
-            self.notify.set()
-
-        def get(self):
-            self.qlock.acquire()
-            if len(self.queue) == 0:
-                self.qlock.release()
-                return None
-            e = self.queue.pop(0)
-            if len(self.queue) == 0:
-                self.notify.clear()
-            self.qlock.release()
-            return e
-
-    def __init__(self, connection):
-        self.connection = connection
-        self.notify = threading.Event()
-        self.event = BitBakeUIEventServer.EventAdapter(self.notify)
-        self.quit = False
-        threading.Thread.__init__(self)
-
-    def terminateServer(self):
-        self.quit = True
-
-    def run(self):
-        while not self.quit:
-            self.notify.wait(0.1)
-            evt = self.event.get()
-            if evt:
-                self.connection.event.sendpickle(pickle.dumps(evt))
-
 
 class XMLRPCProxyServer(BaseImplServer):
     """ not a real working server, but a stub for a proxy server connection
-- 
1.8.1.2


