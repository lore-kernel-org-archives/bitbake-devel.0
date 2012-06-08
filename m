Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdB-0004ac-9E
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:53:37 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q58Dh6WS015520
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:06 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:06 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:36 -0500
Message-ID: <1339162913-23759-2-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 01/18] process.py, build.py: Fix log truncation problems with flush()
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
X-List-Received-Date: Fri, 08 Jun 2012 13:53:37 -0000
Content-Type: text/plain

There are two problems with the _logged_communicate that are both
caused as a result of buffering I/O, instead of flushing it out to the
log files as it arrives.

1) log truncation when python dumps
   I have seen the task logs missing data that was not flushed when
   bitbake crashes.

2) While a bitbake task is running it is impossible to see what is
   going on if it is only writing a small incremental log that is
   smaller than the buffer, or you get only a partial log, up until
   the task exists.  It is worse in the case that stderr and stdout
   are separate file handles, because previous code blocks on the read
   of stdout and then stderr, serially.

The right approach is simply to use select() to determine if there is
data available and then to flush the log buffers as they arrive.  This
still makes use of buffering in the cases where there is more than 1
byte of data, but the buffers are much more dynamic.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/build.py   |    3 ++-
 lib/bb/process.py |   29 +++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 95f1dcf..da4c911 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -135,7 +135,8 @@ class LogTee(object):
 
     def __repr__(self):
         return '<LogTee {0}>'.format(self.name)
-
+    def flush(self):
+        self.outfile.flush()
 
 def exec_func(func, d, dirs = None):
     """Execute an BB 'function'"""
diff --git a/lib/bb/process.py b/lib/bb/process.py
index b74cb18..9848fc3 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -1,6 +1,9 @@
 import logging
 import signal
 import subprocess
+import fcntl
+import errno
+import select
 
 logger = logging.getLogger('BitBake.Process')
 
@@ -70,18 +73,40 @@ def _logged_communicate(pipe, log, input):
 
     bufsize = 512
     outdata, errdata = [], []
+    rin = []
+
+    if pipe.stdout is not None:
+        fd = pipe.stdout.fileno()
+        fl = fcntl.fcntl(fd, fcntl.F_GETFL)
+        fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.O_NONBLOCK)
+        rin.append(pipe.stdout)
+    if pipe.stderr is not None:
+        fd = pipe.stderr.fileno()
+        fl = fcntl.fcntl(fd, fcntl.F_GETFL)
+        fcntl.fcntl(fd, fcntl.F_SETFL, fl | os.O_NONBLOCK)
+        rin.append(pipe.stderr)
+
     while pipe.poll() is None:
-        if pipe.stdout is not None:
+        rlist = rin
+        try:
+            r,w,e = select.select (rlist, [], [])
+        except OSError, e:
+            if e.errno != errno.EINTR:
+                raise
+
+        if pipe.stdout in r:
             data = pipe.stdout.read(bufsize)
             if data is not None:
                 outdata.append(data)
                 log.write(data)
+                log.flush()
 
-        if pipe.stderr is not None:
+        if pipe.stderr in r:
             data = pipe.stderr.read(bufsize)
             if data is not None:
                 errdata.append(data)
                 log.write(data)
+                log.flush()
     return ''.join(outdata), ''.join(errdata)
 
 def run(cmd, input=None, log=None, **options):
-- 
1.7.10



