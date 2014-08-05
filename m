Return-Path: <dmtkatsa@gmail.com>
Received: from mail-la0-f66.google.com (mail-la0-f66.google.com
	[209.85.215.66])
	by mail.openembedded.org (Postfix) with ESMTP id E6EFD65CD8;
	Tue,  5 Aug 2014 15:29:46 +0000 (UTC)
Received: by mail-la0-f66.google.com with SMTP id mc6so424786lab.1
	for <multiple recipients>; Tue, 05 Aug 2014 08:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:cc:subject:date:message-id;
	bh=Uev8KHFCnjcL+OE0YXYJNFv98kiNLsYsUTwCiHgrNIU=;
	b=s20aaJxmOzl4hcSauadK6bTRRY+qSeY6jtEpyJncGPg1GFXrWFqOBLx8LIkfXxtKHl
	YYGUr7sGC0yyFntD9DPh5kTAkz9+dgLD1/uuFYqCtgItBBDogPR1FQ6ICHmxIXVsZeRE
	7eGu9mVp3plxaQJFhfp5IT2ir2K70O9XzKEyweYAaulu5VmX7ww2FWatRP2ZEI9dI/Ox
	g/sxYdBgGzDgT31D3XfplrhDx4P3tm+fdHg+x8DAc69BwV1q6zQiV9xHNiUQviYPhWgp
	Nelv6za4GHu7RjjoU5MiomIq+9TUOvWoWje+o2BFBQJpMPquCrC/1bq3vdlhPCqTbpi2
	qdbA==
X-Received: by 10.152.19.65 with SMTP id c1mr4962769lae.88.1407252586812;
	Tue, 05 Aug 2014 08:29:46 -0700 (PDT)
Received: from localhost (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net.
	[80.197.57.18])
	by mx.google.com with ESMTPSA id e5sm1072792laf.3.2014.08.05.08.29.44
	for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Tue, 05 Aug 2014 08:29:45 -0700 (PDT)
Sender: Dimitrios Katsaros <patcherwork@gmail.com>
From: Dimitrios Katsaros <dmtkatsa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Aug 2014 17:29:26 +0200
Message-Id: <1407252566-9146-1-git-send-email-dmtkatsa@gmail.com>
X-Mailer: git-send-email 1.9.1
Cc: ricardo.ribalda@gmail.com, Dimitrios Katsaros <dmtkatsa@gmail.com>,
	openembedded-core@lists.openembedded.org
Subject: [PATCH] PR_Service: Improvement of persistance of PR service
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
X-List-Received-Date: Tue, 05 Aug 2014 15:29:48 -0000

The current implementation only commits database changes
after database exceptions or daemon shutdown. This patch adds
a delayed commit after every request finish, defaulting to 20 seconds.
I chose to make the sync on the consumer thread rather than the
producer. This is to avoid simultaneous access to the database.
I chose to use a separate timeout than the timeout defined for handle_request
in work_forever. This is because the consumer thread would reach the
handle_request before the quit flag was set. Thus for long timeouts
the stop_daemon function would have to wait for an equally long
amount of time.

This solution is based on this discussion :
https://www.mail-archive.com/openembedded-core@lists.openembedded.org/msg52932.html

NOTE: I made a mistake with the previous patch I posted in this post:
http://lists.openembedded.org/pipermail/openembedded-core/2014-July/095133.html

I was using the wrong repository. This time it should be correct.

Signed-off-by: Dimitrios Katsaros <dmtkatsa@gmail.com>
---
 lib/prserv/serv.py | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 1e170ce..9c37339 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -1,4 +1,4 @@
-import os,sys,logging
+import os,sys,logging, time
 import signal, time, atexit, threading
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import xmlrpclib
@@ -36,7 +36,7 @@ singleton = None
 
 
 class PRServer(SimpleXMLRPCServer):
-    def __init__(self, dbfile, logfile, interface, daemon=True):
+    def __init__(self, dbfile, logfile, interface, daemon=True, sync_timeout=20):
         ''' constructor '''
         SimpleXMLRPCServer.__init__(self, interface,
                                     logRequests=False, allow_none=True)
@@ -46,6 +46,8 @@ class PRServer(SimpleXMLRPCServer):
         self.working_thread=None
         self.host, self.port = self.socket.getsockname()
         self.pidfile=PIDPREFIX % (self.host, self.port)
+        self.dirty = False
+        self.sync_timeout = sync_timeout
 
         self.register_function(self.getPR, "getPR")
         self.register_function(self.quit, "quit")
@@ -70,8 +72,13 @@ class PRServer(SimpleXMLRPCServer):
         while True:
             (request, client_address) = self.requestqueue.get()
             try:
-                self.finish_request(request, client_address)
-                self.shutdown_request(request)
+                if request == "Sync":
+                    self.table.sync()
+                else:
+                    self.finish_request(request, client_address)
+                    self.shutdown_request(request)
+                    self.time_from_dirty = time.time()
+                    self.dirty = True
             except:
                 self.handle_error(request, client_address)
                 self.shutdown_request(request)
@@ -126,6 +133,13 @@ class PRServer(SimpleXMLRPCServer):
         self.server_close()
         return
 
+    def handle_timeout(self):
+        if self.dirty:
+            # making the consumer thead perform sync to ensure thread safty
+            if time.time() - self.time_from_dirty > self.sync_timeout:
+                self.requestqueue.put(("Sync", None))
+                self.dirty = False
+
     def start(self):
         pid = self.daemonize()
         # Ensure both the parent sees this and the child from the work_forever log entry above
-- 
1.9.1


