Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Si2dT-0000YP-Ed for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jun 2012 14:06:47 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBu1dS001190
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:56:01 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31946-06 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:55:55 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBtr5X001170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:55:54 +0100
Message-ID: <1340366155.394.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jun 2012 12:55:55 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] process: Improve _logged_communicate buffering
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 22 Jun 2012 12:06:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There are two problems with the _logged_communicate that are both
caused as a result of buffering I/O issues:

1) log truncation when python fails

2) While a bitbake task is running it is impossible to see what is
   going on if it is only writing a small incremental log that is
   smaller than the buffer, or you get only a partial log, up until
   the task exists.  It is worse in the case that stderr and stdout
   are separate file handles, because previous code blocks on the read
   of stdout and then stderr, serially.

The right approach is simply to use select() to determine if there is
data available and also flush the log before exiting.

This is based on a patch from Jason Wessel <jason.wessel@windriver.com>
with some changes to flush upon exit, abstract the non blocking file
descriptor setup and drop the buffer size parameter.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 5e6b68d..21304c3 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -135,7 +135,8 @@ class LogTee(object):
 
     def __repr__(self):
         return '<LogTee {0}>'.format(self.name)
-
+    def flush(self):
+        self.outfile.flush()
 
 def exec_func(func, d, dirs = None):
     """Execute an BB 'function'"""
diff --git a/bitbake/lib/bb/process.py b/bitbake/lib/bb/process.py
index b74cb18..05b5172 100644
--- a/bitbake/lib/bb/process.py
+++ b/bitbake/lib/bb/process.py
@@ -1,6 +1,8 @@
 import logging
 import signal
 import subprocess
+import errno
+import select
 
 logger = logging.getLogger('BitBake.Process')
 
@@ -68,20 +70,38 @@ def _logged_communicate(pipe, log, input):
             pipe.stdin.write(input)
         pipe.stdin.close()
 
-    bufsize = 512
     outdata, errdata = [], []
-    while pipe.poll() is None:
-        if pipe.stdout is not None:
-            data = pipe.stdout.read(bufsize)
-            if data is not None:
-                outdata.append(data)
-                log.write(data)
-
-        if pipe.stderr is not None:
-            data = pipe.stderr.read(bufsize)
-            if data is not None:
-                errdata.append(data)
-                log.write(data)
+    rin = []
+
+    if pipe.stdout is not None:
+        bb.utils.nonblockingfd(pipe.stdout.fileno())
+        rin.append(pipe.stdout)
+    if pipe.stderr is not None:
+        bb.utils.nonblockingfd(pipe.stderr.fileno())
+        rin.append(pipe.stderr)
+
+    try:
+        while pipe.poll() is None:
+            rlist = rin
+            try:
+                r,w,e = select.select (rlist, [], [])
+            except OSError, e:
+                if e.errno != errno.EINTR:
+                    raise
+
+            if pipe.stdout in r:
+                data = pipe.stdout.read()
+                if data is not None:
+                    outdata.append(data)
+                    log.write(data)
+
+            if pipe.stderr in r:
+                data = pipe.stderr.read()
+                if data is not None:
+                    errdata.append(data)
+                    log.write(data)
+    finally:    
+        log.flush()
     return ''.join(outdata), ''.join(errdata)
 
 def run(cmd, input=None, log=None, **options):




