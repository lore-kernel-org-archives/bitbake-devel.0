Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 0915D6A91D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Jun 2013 16:30:37 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 17 Jun 2013 09:30:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,882,1363158000"; d="scan'208";a="318324888"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by azsmga001.ch.intel.com with ESMTP; 17 Jun 2013 09:30:31 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id BCE7C560386; Mon, 17 Jun 2013 17:30:31 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: richard.purdie@linuxfoundation.org,
	bitbake-devel@lists.openembedded.org
Date: Mon, 17 Jun 2013 17:30:29 +0100
Message-Id: <1371486629-14039-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH] xmlrpc,events: cleanup stale code
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 17 Jun 2013 16:30:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch cleans up some stale code that isn't used anymore.
The unused code obscures file readability.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/event.py         |  7 -------
 lib/bb/server/xmlrpc.py | 46 ----------------------------------------------
 2 files changed, 53 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 9c134ee..d8111f1 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -294,12 +294,6 @@ class BuildBase(Event):
     def setName(self, name):
         self._name = name
 
-    def getCfg(self):
-        return self.data
-
-    def setCfg(self, cfg):
-        self.data = cfg
-
     def getFailures(self):
         """
         Return the number of failed packages
@@ -308,7 +302,6 @@ class BuildBase(Event):
 
     pkgs = property(getPkgs, setPkgs, None, "pkgs property")
     name = property(getName, setName, None, "name property")
-    cfg = property(getCfg, setCfg, None, "cfg property")
 
 
 
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 026415e..56cae49 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -149,52 +149,6 @@ class BitBakeXMLRPCRequestHandler(SimpleXMLRPCRequestHandler):
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
-
 class XMLRPCProxyServer(BaseImplServer):
     """ not a real working server, but a stub for a proxy server connection
 
-- 
1.8.1.2


