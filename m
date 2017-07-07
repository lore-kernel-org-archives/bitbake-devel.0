Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0B50177E9D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jul 2017 14:48:58 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v67EmwxL006266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 7 Jul 2017 15:48:59 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dTUZ0-0007bR-1G; Fri, 07 Jul 2017 15:48:58 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Jul 2017 15:48:55 +0100
Message-Id: <1499438935-29179-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1499438935-29179-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1499438935-29179-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 07 Jul 2017 15:48:59 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/2] server/xmlrpc: Add Heartbeat event support
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
X-List-Received-Date: Fri, 07 Jul 2017 14:48:59 -0000

When heartbeat event support was added it was only added to process.py. Add
it to server/xmlrpc too. There is duplicated code however since we're likely
to combine the server abstractions soon its not worth worrying about now.

This ensures the backends have the same event support.

[YOCTO #10741]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/xmlrpc.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index d0f5a6d..1a475e0 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -227,6 +227,8 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.idle_timeout = idle_timeout
         if idle_timeout:
             self.register_idle_function(self.handle_idle_timeout, self)
+        self.heartbeat_seconds = 1 # default, BB_HEARTBEAT_EVENT will be checked once we have a datastore.
+        self.next_heartbeat = time.time()
 
     def addcooker(self, cooker):
         BaseImplServer.addcooker(self, cooker)
@@ -250,6 +252,15 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         return []
 
     def serve_forever(self):
+        heartbeat_event = self.cooker.data.getVar('BB_HEARTBEAT_EVENT')
+        if heartbeat_event:
+            try:
+                self.heartbeat_seconds = float(heartbeat_event)
+            except:
+                # Throwing an exception here causes bitbake to hang.
+                # Just warn about the invalid setting and continue
+                bb.warn('Ignoring invalid BB_HEARTBEAT_EVENT=%s, must be a float specifying seconds.' % heartbeat_event)
+
         # Start the actual XMLRPC server
         bb.cooker.server_main(self.cooker, self._serve_forever)
 
@@ -297,6 +308,21 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
                 # we ignore interrupted calls
                 pass
 
+            # Create new heartbeat event?
+            now = time.time()
+            if now >= self.next_heartbeat:
+                # We might have missed heartbeats. Just trigger once in
+                # that case and continue after the usual delay.
+                self.next_heartbeat += self.heartbeat_seconds
+                if self.next_heartbeat <= now:
+                    self.next_heartbeat = now + self.heartbeat_seconds
+                heartbeat = bb.event.HeartbeatEvent(now)
+                bb.event.fire(heartbeat, self.cooker.data)
+            if nextsleep and now + nextsleep > self.next_heartbeat:
+                # Shorten timeout so that we we wake up in time for
+                # the heartbeat.
+                nextsleep = self.next_heartbeat - now
+
         # Tell idle functions we're exiting
         for function, data in list(self._idlefuns.items()):
             try:
-- 
2.7.4


