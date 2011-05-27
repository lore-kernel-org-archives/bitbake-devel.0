Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QQ4AD-0007AV-VC
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 May 2011 23:01:46 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 27 May 2011 13:57:34 -0700
X-ExtLoop1: 1
Received: from vorpal.jf.intel.com (HELO [10.7.199.68]) ([10.7.199.68])
	by orsmga002.jf.intel.com with ESMTP; 27 May 2011 13:57:34 -0700
From: Joshua Lock <josh@linux.intel.com>
To: openembedded-core@lists.openembedded.org
Date: Fri, 27 May 2011 14:01:05 -0700
In-Reply-To: <1306526949.1747.8.camel@vorpal>
References: <cover.1306477652.git.lianhao.lu@intel.com>
	<1306515635.27470.284.camel@rex>
	<7DC6724C-BF20-4EA1-A87D-32FBEEECDA3B@dominion.thruhere.net>
	<1306526949.1747.8.camel@vorpal>
X-Mailer: Evolution 3.0.1 (3.0.1-1.fc15) 
Message-ID: <1306530065.1747.14.camel@vorpal>
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 00/11] Add PR service and integrate PKGV/PKGR from OE
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
X-List-Received-Date: Fri, 27 May 2011 21:01:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From 1618318f0a30847b08c158e7ac82f9043126144e Mon Sep 17 00:00:00 2001
From: Joshua Lock <josh@linux.intel.com>
Date: Fri, 27 May 2011 13:04:44 -0700
Subject: [PATCH 2/2] uievent: fix queueing of events for xmlrpc before
UI has
 loaded

The change to Queue up events before the UI is spawned broke the xmlrpc
server because the uievent implementation of BBUIEventQueue expects
pickled
strings for its queue_event() method.
This is because the RPC exposed event.send() method must accept pickled
strings, but for xmlrpc event.send() is just mapped to queue_event().
Work
around this by adding a send_event method which unpickles strings and
hands
them off to queue_event() which can then be used for the remapping.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/uievent.py |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index b404805..2fef4e4 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -63,17 +63,20 @@ class BBUIEventQueue:
 
     def queue_event(self, event):
         self.eventQueueLock.acquire()
-        self.eventQueue.append(pickle.loads(event))
+        self.eventQueue.append(event)
         self.eventQueueNotify.set()
         self.eventQueueLock.release()
 
+    def send_event(self, event):
+        self.queue_event(pickle.loads(event))
+
     def startCallbackHandler(self):
 
         server = UIXMLRPCServer()
         self.host, self.port = server.socket.getsockname()
 
         server.register_function( self.system_quit, "event.quit" )
-        server.register_function( self.queue_event, "event.send" )
+        server.register_function( self.send_event, "event.send" )
         server.socket.settimeout(1)
 
         self.EventHandle =
self.BBServer.registerEventHandler(self.host, self.port)
-- 
1.7.5.1




