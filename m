Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5C02F7842D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:38:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VGcfCU028725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 17:38:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSUL-0003Fp-Ag; Thu, 31 Aug 2017 17:38:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:38:38 +0100
Message-Id: <1504197520-12428-8-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 17:38:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 08/10] prserv/serv: Send sentinel to stop handler thread
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
X-List-Received-Date: Thu, 31 Aug 2017 16:38:46 -0000

Shutdown from SIGTERM currently has to wait for the handler thread to timeout.
Add a sentinel value which triggers it to loop and allows for a quick exit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/prserv/serv.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index a2da072..6be78c8 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -84,6 +84,8 @@ class PRServer(SimpleXMLRPCServer):
             except queue.Empty:
                 self.table.sync_if_dirty()
                 continue
+            if request is None:
+                continue
             try:
                 self.finish_request(request, client_address)
                 self.shutdown_request(request)
@@ -103,7 +105,8 @@ class PRServer(SimpleXMLRPCServer):
     def sigterm_handler(self, signum, stack):
         if self.table:
             self.table.sync()
-        self.quit=True
+        self.quit()
+        self.requestqueue.put((None, None))
 
     def process_request(self, request, client_address):
         self.requestqueue.put((request, client_address))
-- 
2.7.4


