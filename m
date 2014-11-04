Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8FC6165E94
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 14:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA4E1xQG021582
	for <bitbake-devel@lists.openembedded.org>; Tue, 4 Nov 2014 14:01:59 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZDgmHR_H9mDp for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Nov 2014 14:01:59 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sA4E1vKm021579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 4 Nov 2014 14:01:58 GMT
Message-ID: <1415109752.23396.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 04 Nov 2014 14:02:32 +0000
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] prserv/serv: Ensure sync happens in the correct thread
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
X-List-Received-Date: Tue, 04 Nov 2014 14:02:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The sync/commit calls are happening in the submission thread which can
race against the handler. The handler may start new transactions which
then causes the submission thread to error with "cannot start a
transaction within a transaction".

The fix is to move the calls to the correct thread.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 6ab1097..25eb46a 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -76,11 +76,19 @@ class PRServer(SimpleXMLRPCServer):
         In addition, exception handling is done here.
 
         """
+        iter_count = 1
+        # With 60 iterations between syncs and a 0.5 second timeout between
+        # iterations, this will sync if dirty every ~30 seconds.
+        iterations_between_sync = 60
+
         while True:
             (request, client_address) = self.requestqueue.get()
             try:
                 self.finish_request(request, client_address)
                 self.shutdown_request(request)
+                iter_count = (iter_count + 1) % iterations_between_sync
+                if iter_count == 0:
+                    self.table.sync_if_dirty()
             except:
                 self.handle_error(request, client_address)
                 self.shutdown_request(request)
@@ -122,10 +130,6 @@ class PRServer(SimpleXMLRPCServer):
     def work_forever(self,):
         self.quit = False
         self.timeout = 0.5
-        iter_count = 1
-        # With 60 iterations between syncs and a 0.5 second timeout between
-        # iterations, this will sync if dirty every ~30 seconds.
-        iterations_between_sync = 60
 
         logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
                      (self.dbfile, self.host, self.port, str(os.getpid())))
@@ -133,9 +137,6 @@ class PRServer(SimpleXMLRPCServer):
         self.handlerthread.start()
         while not self.quit:
             self.handle_request()
-            iter_count = (iter_count + 1) % iterations_between_sync
-            if iter_count == 0:
-                self.table.sync_if_dirty()
 
         self.table.sync()
         logger.info("PRServer: stopping...")



