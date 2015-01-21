Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E565165C7B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 13:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LDsFbm025693 for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 13:54:15 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nByPXVD6fAQt for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 13:54:15 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LDrx5V025684
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 13:54:10 GMT
Message-ID: <1421848439.1798.54.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Jan 2015 13:53:59 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] prserv/serv: Improve exit handling
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
X-List-Received-Date: Wed, 21 Jan 2015 13:54:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, I'm not sure how the prserver managed to shut down cleanly. These
issues may explain some of the hangs people have reported.

This change:

* Ensures the connection acceptance thread monitors self.quit
* We wait for the thread to exit before exitting
* We sync the database when the thread exits
* We do what the comment mentions, timeout after 30s and sync the database
  if needed. Previously, there was no timeout (the 0.5 applies to sockets,
  not the Queue object)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 25eb46a..a7639c8 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -77,12 +77,15 @@ class PRServer(SimpleXMLRPCServer):
 
         """
         iter_count = 1
-        # With 60 iterations between syncs and a 0.5 second timeout between
-        # iterations, this will sync if dirty every ~30 seconds.
+        # 60 iterations between syncs or sync if dirty every ~30 seconds
         iterations_between_sync = 60
 
-        while True:
-            (request, client_address) = self.requestqueue.get()
+        while not self.quit:
+            try:
+                (request, client_address) = self.requestqueue.get(True, 30)
+            except Queue.Empty:
+                self.table.sync_if_dirty()
+                continue
             try:
                 self.finish_request(request, client_address)
                 self.shutdown_request(request)
@@ -93,6 +96,7 @@ class PRServer(SimpleXMLRPCServer):
                 self.handle_error(request, client_address)
                 self.shutdown_request(request)
                 self.table.sync()
+            self.table.sync_if_dirty()
 
     def process_request(self, request, client_address):
         self.requestqueue.put((request, client_address))
@@ -137,7 +141,7 @@ class PRServer(SimpleXMLRPCServer):
         self.handlerthread.start()
         while not self.quit:
             self.handle_request()
-
+        self.handlerthread.join()
         self.table.sync()
         logger.info("PRServer: stopping...")
         self.server_close()



