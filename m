Return-Path: <sgw@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BC1D077009
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Sep 2015 17:20:07 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 02 Sep 2015 10:20:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,454,1437462000"; d="scan'208";a="637237264"
Received: from ngniech-mobl.amr.corp.intel.com (HELO
	swold-mobl.amr.corp.intel.com) ([10.254.55.139])
	by orsmga003.jf.intel.com with ESMTP; 02 Sep 2015 10:20:08 -0700
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 10:20:06 -0700
Message-Id: <1441214406-11183-1-git-send-email-sgw@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Cc: akuster808@gmail.com
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
X-List-Received-Date: Wed, 02 Sep 2015 17:20:10 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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
(cherry picked from commit 0926492295d485813d8a4f6b77c7b152e4c5b4c4)
Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/prserv/serv.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 25eb46a..a7639c8 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
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
-- 
2.1.0


