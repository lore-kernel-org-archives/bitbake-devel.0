Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3183E606D0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BM6tU0000453 for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:55 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id T_LSMljirOXk for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 23:06:55 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4BLsMth032696
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 May 2016 22:54:23 +0100
Message-ID: <1463003662.21831.292.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 May 2016 22:54:22 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] deamonize/prserv/tests/fetch: Convert file() -> open()
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
X-List-Received-Date: Wed, 11 May 2016 22:06:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Use python3 compatible functions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/daemonize.py b/bitbake/lib/bb/daemonize.py
index 346a618..ab4a954 100644
--- a/bitbake/lib/bb/daemonize.py
+++ b/bitbake/lib/bb/daemonize.py
@@ -178,8 +178,8 @@ def createDaemon(function, logfile):
 #    os.dup2(0, 2)                      # standard error (2)
 
 
-    si = file('/dev/null', 'r')
-    so = file(logfile, 'w')
+    si = open('/dev/null', 'r')
+    so = open(logfile, 'w')
     se = so
 
 
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 4ba688b..cba783f 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -450,7 +450,7 @@ class MirrorUriTest(FetcherTest):
 class FetcherLocalTest(FetcherTest):
     def setUp(self):
         def touch(fn):
-            with file(fn, 'a'):
+            with open(fn, 'a'):
                 os.utime(fn, None)
 
         super(FetcherLocalTest, self).setUp()
diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index affccd9..8cec9f8 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -242,8 +242,8 @@ class PRServer(SimpleXMLRPCServer):
 
         sys.stdout.flush()
         sys.stderr.flush()
-        si = file('/dev/null', 'r')
-        so = file(self.logfile, 'a+')
+        si = open('/dev/null', 'r')
+        so = open(self.logfile, 'a+')
         se = so
         os.dup2(si.fileno(),sys.stdin.fileno())
         os.dup2(so.fileno(),sys.stdout.fileno())
@@ -263,7 +263,7 @@ class PRServer(SimpleXMLRPCServer):
 
         # write pidfile
         pid = str(os.getpid()) 
-        pf = file(self.pidfile, 'w')
+        pf = open(self.pidfile, 'w')
         pf.write("%s\n" % pid)
         pf.close()
 
@@ -323,7 +323,7 @@ def start_daemon(dbfile, host, port, logfile):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
-        pf = file(pidfile,'r')
+        pf = open(pidfile,'r')
         pid = int(pf.readline().strip())
         pf.close()
     except IOError:
@@ -350,7 +350,7 @@ def stop_daemon(host, port):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
-        pf = file(pidfile,'r')
+        pf = open(pidfile,'r')
         pid = int(pf.readline().strip())
         pf.close()
     except IOError:



