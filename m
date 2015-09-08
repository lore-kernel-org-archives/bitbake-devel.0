Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 9928765C8A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 22:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t88MWKbD012244 for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Sep 2015 23:32:20 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ipngT9BREEPd for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Sep 2015 23:32:20 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t88MW7jI012240
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Sep 2015 23:32:18 +0100
Message-ID: <1441751527.24871.289.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 08 Sep 2015 23:32:07 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] prserv: SIGTERM and deamonization fixes
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
X-List-Received-Date: Tue, 08 Sep 2015 22:32:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Worryingly, if you SIGKILL the bitbake cooker, an autostarted PR server
will remain behind. It turns out there are a few things we should do:

* The PR service doesn't need to daemonize when started from cooker,
  it just complicated the process lifecycle. Add a fork() method
  to handle this and use the non-daemon mode for the singleton.

* Reset the sigterm and sigint handlers. Bitbake cooker installs its
  own which we inherit meaning PR server was ignoring SIGTERM. Installing
  our own handlers which include a sync makes most sense here. Since
  we're in the code, make it sync the database on SIGINT.

* Use the new bb.utils.signal_on_parent_exit() call so that we get a
  SIGTERM when the parent (usually cooker) exits and we can shutdown
  too. Alternatives would be having an open pipe or polling
  os.getppid() for changes but this seems more effective.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 0507485..07a5115 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -97,6 +97,13 @@ class PRServer(SimpleXMLRPCServer):
                 self.table.sync()
             self.table.sync_if_dirty()
 
+    def sigint_handler(self, signum, stack):
+        self.table.sync()
+
+    def sigterm_handler(self, signum, stack):
+        self.table.sync()
+        raise SystemExit
+
     def process_request(self, request, client_address):
         self.requestqueue.put((request, client_address))
 
@@ -147,7 +154,11 @@ class PRServer(SimpleXMLRPCServer):
         return
 
     def start(self):
-        pid = self.daemonize()
+        if self.daemon:
+            pid = self.daemonize()
+        else:
+            pid = self.fork()
+
         # Ensure both the parent sees this and the child from the work_forever log entry above
         logger.info("Started PRServer with DBfile: %s, IP: %s, PORT: %s, PID: %s" %
                      (self.dbfile, self.host, self.port, str(pid)))
@@ -180,6 +191,25 @@ class PRServer(SimpleXMLRPCServer):
         except OSError as e:
             raise Exception("%s [%d]" % (e.strerror, e.errno))
 
+        self.cleanup_handles()
+        os._exit(0)
+
+    def fork(self):
+        try:
+            pid = os.fork()
+            if pid > 0:
+                return pid
+        except OSError as e:
+            raise Exception("%s [%d]" % (e.strerror, e.errno))
+
+        bb.utils.signal_on_parent_exit("SIGTERM")
+        print os.getppid()
+        self.cleanup_handles()
+        os._exit(0)
+
+    def cleanup_handles(self):
+        signal.signal(signal.SIGINT, self.sigint_handler)
+        signal.signal(signal.SIGTERM, self.sigterm_handler)
         os.umask(0)
         os.chdir("/")
 
@@ -212,7 +242,6 @@ class PRServer(SimpleXMLRPCServer):
 
         self.work_forever()
         self.delpid()
-        os._exit(0)
 
 class PRServSingleton(object):
     def __init__(self, dbfile, logfile, interface):
@@ -223,7 +252,7 @@ class PRServSingleton(object):
         self.port = None
 
     def start(self):
-        self.prserv = PRServer(self.dbfile, self.logfile, self.interface)
+        self.prserv = PRServer(self.dbfile, self.logfile, self.interface, daemon=False)
         self.prserv.start()
         self.host, self.port = self.prserv.getinfo()
 



