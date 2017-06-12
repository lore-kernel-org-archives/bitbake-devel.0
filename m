Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id B1F71782BE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Jun 2017 17:12:05 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Jun 2017 10:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,334,1493708400"; d="scan'208";a="97170514"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.53])
	by orsmga004.jf.intel.com with ESMTP; 12 Jun 2017 10:12:06 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Jun 2017 10:12:04 -0700
Message-Id: <1497287524-5406-2-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497287524-5406-1-git-send-email-juro.bystricky@intel.com>
References: <1497287524-5406-1-git-send-email-juro.bystricky@intel.com>
Cc: richard.purdie@intel.com, jurobystricky@hotmail.com,
	paul.eggleton@linux.intel.com
Subject: [PATCH 1/1] bitbake:process: flush stderr/stdout to log
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
X-List-Received-Date: Mon, 12 Jun 2017 17:12:05 -0000

When a process terminates, some messages may still remain in stdout or
stderr and do not make it into the log file.
In addition, the messages that do make it to the log file may end up in
the log file in incorrect order.
This patch flushes all messages into the log file after the
process terminates. Some additional log flushing is also needed
to keep the various messages showing up in the log file in proper order.

[YOCTO#10785]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/process.py | 81 +++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/bitbake/lib/bb/process.py b/bitbake/lib/bb/process.py
index a4a5599..93149c0 100644
--- a/bitbake/lib/bb/process.py
+++ b/bitbake/lib/bb/process.py
@@ -94,45 +94,52 @@ def _logged_communicate(pipe, log, input, extrafiles):
                 if data is not None:
                     func(data)
 
+    def read_all_pipes(log, rin, outdata, errdata):
+        rlist = rin
+        stdoutbuf = b""
+        stderrbuf = b""
+
+        try:
+            r,w,e = select.select (rlist, [], [], 1)
+        except OSError as e:
+            if e.errno != errno.EINTR:
+                raise
+
+        readextras(r)
+
+        if pipe.stdout in r:
+            data = stdoutbuf + pipe.stdout.read()
+            if data is not None and len(data) > 0:
+                try:
+                    data = data.decode("utf-8")
+                    outdata.append(data)
+                    log.write(data)
+                    log.flush()
+                    stdoutbuf = b""
+                except UnicodeDecodeError:
+                    stdoutbuf = data
+
+        if pipe.stderr in r:
+            data = stderrbuf + pipe.stderr.read()
+            if data is not None and len(data) > 0:
+                try:
+                    data = data.decode("utf-8")
+                    errdata.append(data)
+                    log.write(data)
+                    log.flush()
+                    stderrbuf = b""
+                except UnicodeDecodeError:
+                    stderrbuf = data
+
     try:
+        # Read all pipes while the process is open
         while pipe.poll() is None:
-            rlist = rin
-            stdoutbuf = b""
-            stderrbuf = b""
-            try:
-                r,w,e = select.select (rlist, [], [], 1)
-            except OSError as e:
-                if e.errno != errno.EINTR:
-                    raise
-
-            if pipe.stdout in r:
-                data = stdoutbuf + pipe.stdout.read()
-                if data is not None and len(data) > 0:
-                    try:
-                        data = data.decode("utf-8")
-                        outdata.append(data)
-                        log.write(data)
-                        stdoutbuf = b""
-                    except UnicodeDecodeError:
-                        stdoutbuf = data
-
-            if pipe.stderr in r:
-                data = stderrbuf + pipe.stderr.read()
-                if data is not None and len(data) > 0:
-                    try:
-                        data = data.decode("utf-8")
-                        errdata.append(data)
-                        log.write(data)
-                        stderrbuf = b""
-                    except UnicodeDecodeError:
-                        stderrbuf = data
-
-            readextras(r)
-
-    finally:    
-        log.flush()
-
-    readextras([fobj for fobj, _ in extrafiles])
+            read_all_pipes(log, rin, outdata, errdata)
+
+        # Pocess closed, drain all pipes...
+        read_all_pipes(log, rin, outdata, errdata)
+    finally:
+        log.flush
 
     if pipe.stdout is not None:
         pipe.stdout.close()
-- 
2.7.4


