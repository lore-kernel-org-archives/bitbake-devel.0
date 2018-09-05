Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7724B74743
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Sep 2018 17:01:11 +0000 (UTC)
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so8720664wmb.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Sep 2018 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id;
	bh=UACxCR9C5MWwdp4dBmJTgE5JRcVrlgHykRvwFF8nIxA=;
	b=WDljaTYrcVjh+r/hcoeATiaQ17fj3bK5yHZGSQd4J8MPCK1pAnjcoJENHRuWfsn6cy
	QL4gdyqrMk2+eht4jtJlG9TkEXa7rW0CHuGSPUPsVskyRubzGAAB33imOt7jknNra77p
	9bIPo8pKn1J3zetzEcW99/1o20s3fEixD2BXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=UACxCR9C5MWwdp4dBmJTgE5JRcVrlgHykRvwFF8nIxA=;
	b=C3W0EJqb7EHejEhZaXi0hu46vGIKS1S2xXkA1GYtXmvZh4QApzCvarHdnb3xrKPLzi
	uEH3embxyus6XIq5bedBHHwDv+Q2gjh8Zz68twbbE+BAikJIS7RNccktRbi7uKhPPZnc
	qiDlmh51oSbQvd5RcvBk+N/AlWDDsK1OV4/Qx0z+3mtdvHST08QADz5NQv9upGSj0l1B
	1HmBXMeQeK/PzlAas/ZJuuXW+2NYeB3vQxzKHeWezr2OdbuNtf237w4pCBvdIuU+KoKy
	zi+JBJN+SG/x8erxdTpT1ENp/oV53bITRgLjJ6+Jqe/fOFtGFmiXOzyIGvsmkxUeECOP
	0UyQ==
X-Gm-Message-State: APzg51DyH3s2AxftLTAdkg3GaGw2wdVxn6Hd2GPQkinSUyKhOUUDGdWS
	e5kMnyirt5NGg6RBXr4GqVD/0NYaMk8=
X-Google-Smtp-Source: ANB0VdZqM0yb/f9SWP4nX+V0hUt5IrGnhjZeL/EYcHJyI8h4zTwfTtR5QiipH6BDvRsm67pW1u0qwQ==
X-Received: by 2002:a1c:9808:: with SMTP id a8-v6mr764910wme.62.1536166871877; 
	Wed, 05 Sep 2018 10:01:11 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	y10-v6sm2895611wrl.87.2018.09.05.10.01.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Sep 2018 10:01:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  5 Sep 2018 18:01:09 +0100
Message-Id: <20180905170109.31505-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
Subject: [PATCH] server/process: Various server startup logging fixes
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
X-List-Received-Date: Wed, 05 Sep 2018 17:01:11 -0000

There were various problems in the server startup loggin:

a) stdout/stderr were not being flushed before forking which could potentially
   duplicate output

b) there were separate buffers for stdout/stderr leading to confusing logs
   where the entries could be reordered. This was particularly confusing
   due to the separator the logs use to idendify new messages

c) an fd wasn't being closed during server startup meaning if the
   server failed to start, the closed fd wasn't detected as it was held
   open by the other reference

d) If the pipe was detected as being closed, the code incorrectly retried
   server startup

e) The event code would remap stdout/stderr without flushing them, leading
   to lose log messages

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/daemonize.py      | 12 +++++++++---
 lib/bb/event.py          |  3 +++
 lib/bb/server/process.py | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/lib/bb/daemonize.py b/lib/bb/daemonize.py
index bf16793468..613fb35536 100644
--- a/lib/bb/daemonize.py
+++ b/lib/bb/daemonize.py
@@ -16,6 +16,10 @@ def createDaemon(function, logfile):
     background as a daemon, returning control to the caller.
     """
 
+    # Ensure stdout/stderror are flushed before forking to avoid duplicate output
+    sys.stdout.flush()
+    sys.stderr.flush()
+
     try:
         # Fork a child process so the parent can exit.  This returns control to
         # the command-line or shell.  It also guarantees that the child will not
@@ -66,12 +70,14 @@ def createDaemon(function, logfile):
 
     try:
         so = open(logfile, 'a+')
-        se = so
         os.dup2(so.fileno(), sys.stdout.fileno())
-        os.dup2(se.fileno(), sys.stderr.fileno())
+        os.dup2(so.fileno(), sys.stderr.fileno())
     except io.UnsupportedOperation:
         sys.stdout = open(logfile, 'a+')
-        sys.stderr = sys.stdout
+
+    # Have stdout and stderr be the same so log output matches chronologically
+    # and there aren't two seperate buffers
+    sys.stderr = sys.stdout
 
     try:
         function()
diff --git a/lib/bb/event.py b/lib/bb/event.py
index c0ec605209..5b1b094a80 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -141,6 +141,9 @@ def print_ui_queue():
     logger = logging.getLogger("BitBake")
     if not _uiready:
         from bb.msg import BBLogFormatter
+        # Flush any existing buffered content
+        sys.stdout.flush()
+        sys.stderr.flush()
         stdout = logging.StreamHandler(sys.stdout)
         stderr = logging.StreamHandler(sys.stderr)
         formatter = BBLogFormatter("%(levelname)s: %(message)s")
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 9e5e709f04..38b923fe2d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -395,11 +395,16 @@ class BitBakeServer(object):
         bb.daemonize.createDaemon(self._startServer, logfile)
         self.sock.close()
         self.bitbake_lock.close()
+        os.close(self.readypipein)
 
         ready = ConnectionReader(self.readypipe)
         r = ready.poll(30)
         if r:
-            r = ready.get()
+            try:
+                r = ready.get()
+            except EOFError:
+                # Trap the child exitting/closing the pipe and error out
+                r = None
         if not r or r != "ready":
             ready.close()
             bb.error("Unable to start bitbake server")
@@ -425,21 +430,16 @@ class BitBakeServer(object):
                         bb.error("Server log for this session (%s):\n%s" % (logfile, "".join(lines)))
             raise SystemExit(1)
         ready.close()
-        os.close(self.readypipein)
 
     def _startServer(self):
         print(self.start_log_format % (os.getpid(), datetime.datetime.now().strftime(self.start_log_datetime_format)))
         server = ProcessServer(self.bitbake_lock, self.sock, self.sockname)
         self.configuration.setServerRegIdleCallback(server.register_idle_function)
+        os.close(self.readypipe)
         writer = ConnectionWriter(self.readypipein)
-        try:
-            self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
-            writer.send("ready")
-        except:
-            writer.send("fail")
-            raise
-        finally:
-            os.close(self.readypipein)
+        self.cooker = bb.cooker.BBCooker(self.configuration, self.featureset)
+        writer.send("ready")
+        writer.close()
         server.cooker = self.cooker
         server.server_timeout = self.configuration.server_timeout
         server.xmlrpcinterface = self.configuration.xmlrpcinterface
-- 
2.17.1


