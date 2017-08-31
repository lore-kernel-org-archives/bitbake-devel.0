Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 55971781E6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 16:38:42 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VGcfbO028726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 17:38:42 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnSUL-0003Fv-BA; Thu, 31 Aug 2017 17:38:41 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 17:38:39 +0100
Message-Id: <1504197520-12428-9-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1504197520-12428-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 17:38:42 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 09/10] prserv/serv: Rename self.quit -> self.quitflag
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
X-List-Received-Date: Thu, 31 Aug 2017 16:38:45 -0000

self has a quit function and a variable. Separate this to two different
things as the current setup is prone to breakage.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/prserv/serv.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 6be78c8..dfcbd20 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -78,7 +78,7 @@ class PRServer(SimpleXMLRPCServer):
 
         bb.utils.set_process_name("PRServ Handler")
 
-        while not self.quit:
+        while not self.quitflag:
             try:
                 (request, client_address) = self.requestqueue.get(True, 30)
             except queue.Empty:
@@ -142,7 +142,7 @@ class PRServer(SimpleXMLRPCServer):
         return self.table.importone(version, pkgarch, checksum, value)
 
     def ping(self):
-        return not self.quit
+        return not self.quitflag
 
     def getinfo(self):
         return (self.host, self.port)
@@ -158,13 +158,13 @@ class PRServer(SimpleXMLRPCServer):
             return None
 
     def quit(self):
-        self.quit=True
+        self.quitflag=True
         os.write(self.quitpipeout, b"q")
         os.close(self.quitpipeout)
         return
 
     def work_forever(self,):
-        self.quit = False
+        self.quitflag = False
         # This timeout applies to the poll in TCPServer, we need the select 
         # below to wake on our quit pipe closing. We only ever call into handle_request
         # if there is data there.
@@ -180,9 +180,9 @@ class PRServer(SimpleXMLRPCServer):
                      (self.dbfile, self.host, self.port, str(os.getpid())))
 
         self.handlerthread.start()
-        while not self.quit:
+        while not self.quitflag:
             ready = select.select([self.fileno(), self.quitpipein], [], [], 30)
-            if self.quit:
+            if self.quitflag:
                 break
             if self.fileno() in ready[0]:
                 self.handle_request()
-- 
2.7.4


