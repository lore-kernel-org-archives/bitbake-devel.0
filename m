Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CCC6D78234
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 13:00:00 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6OCxxrt019020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 24 Jul 2017 14:00:00 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dZcxr-0003r4-2F; Mon, 24 Jul 2017 13:59:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Jul 2017 13:59:56 +0100
Message-Id: <1500901197-14779-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Mon, 24 Jul 2017 14:00:00 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/2] prserv/serv: Improve process exit handling
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
X-List-Received-Date: Mon, 24 Jul 2017 13:00:01 -0000

The server shutdown is currenlty laggy and race prone. This patch:

* adds a waitpid so that no zombie server is left around if its not
  running in daemon mode.
* adds a quit "sentinal" using a pipe so that we're not sitting in
  a socket poll() until timeout in order just to quit.
* use a select() call to poll the socket and the pipe for a quit signal.

The net result of this change is that the prserv exits with the cooker server
and it does so immediately and doesn't wait for the select/poll calls to
timeout. This makes bitbake a lot more responsive for startup/shutdown and
doesn't cause UI timeout errors as often when prserv is used.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/prserv/serv.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5f061c2..3145689 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -10,6 +10,7 @@ import bb.server.xmlrpcclient
 import prserv
 import prserv.db
 import errno
+import select
 
 logger = logging.getLogger("BitBake.PRserv")
 
@@ -59,6 +60,8 @@ class PRServer(SimpleXMLRPCServer):
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
 
+        self.quitpipein, self.quitpipeout = os.pipe()
+
         self.requestqueue = queue.Queue()
         self.handlerthread = threading.Thread(target = self.process_request_thread)
         self.handlerthread.daemon = False
@@ -153,11 +156,16 @@ class PRServer(SimpleXMLRPCServer):
 
     def quit(self):
         self.quit=True
+        os.write(self.quitpipeout, b"q")
+        os.close(self.quitpipeout)
         return
 
     def work_forever(self,):
         self.quit = False
-        self.timeout = 0.5
+        # This timeout applies to the poll in TCPServer, we need the select 
+        # below to wake on our quit pipe closing. We only ever call into handle_request
+        # if there is data there.
+        self.timeout = 0.01
 
         bb.utils.set_process_name("PRServ")
 
@@ -170,11 +178,16 @@ class PRServer(SimpleXMLRPCServer):
 
         self.handlerthread.start()
         while not self.quit:
-            self.handle_request()
+            ready = select.select([self.fileno(), self.quitpipein], [], [], 30)
+            if self.quit:
+                break
+            if self.fileno() in ready[0]:
+                self.handle_request()
         self.handlerthread.join()
         self.db.disconnect()
         logger.info("PRServer: stopping...")
         self.server_close()
+        os.close(self.quitpipein)
         return
 
     def start(self):
@@ -182,6 +195,7 @@ class PRServer(SimpleXMLRPCServer):
             pid = self.daemonize()
         else:
             pid = self.fork()
+            self.pid = pid
 
         # Ensure both the parent sees this and the child from the work_forever log entry above
         logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
@@ -472,6 +486,7 @@ def auto_shutdown(d=None):
             PRServerConnection(host, port).terminate()
         except:
             logger.critical("Stop PRService %s:%d failed" % (host,port))
+        os.waitpid(singleton.prserv.pid, 0)
         singleton = None
 
 def ping(host, port):
-- 
2.7.4


