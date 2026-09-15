Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB76C88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 16:06:46 +0000 (UTC)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.457.1789488399881877654
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Sep 2026 09:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=hdOHk/Sd;
 spf=pass (domain: gmail.com, ip: 74.125.228.12, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so316385a12.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488399; x=1790093199; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s6fb5TXbB8qwOkzgXy94K5y4VFM4yM83CN02QI5uWhA=;
        b=hdOHk/Sd2PCXNHPMMP8kuDP+N+7g+//cahxg+KoxNYrGNd8c61SheoHywb8/Bg6NnG
         zKSqd/MJimREf/EK2FV0EpKnOc89c4En/9qbP+V7AWLceHE48fU/KNDg5K5mZDwYd+TK
         GMEjh7DrDvxE+lvFIZuWz1+/67B8e9GJBGbc/AP3dl2dkMYCjgebIxtwXcn/0fAWvsGr
         4jbVsVxTXROItytost8lyBSTR00hiNGZd+OYBzS3vFkpUFpwaajtE8hlvESYmpLh6ZQ9
         NU/p3Opbylt3mFETGZbpzw2alWsQaq/GGcJPrwT79iMxqBjuvV+6odpY4Losf4LDKTnH
         dzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488399; x=1790093199;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s6fb5TXbB8qwOkzgXy94K5y4VFM4yM83CN02QI5uWhA=;
        b=Z2EBXVNka66zK6Wa9GiwlViVWG9NI5BXvdlKWgcbeRL6ed9z79jNXK1+aVJgIVetP3
         yW6xuA0sz2tVNUdM2IVG/CDpfy+v4aUNVZcBn/Vq3gbpBvWwjPdJnJt+7RorGuaM576l
         0xwl5yeu1vybEXXIWDZccFX8k1dzfAuNwShhUBSP2CMJcrTXYro7hqPqN4JZU7CuG9sI
         L6zIYxfPUpF2AF+19HD5rE4K8jbOP2uwAnG2QlIimE779G6jDOrTdgKSoiNLBIx+5Fzp
         KRhCgg43+qYmtrpiOk5dMFUXRhigaD+H+BW4Zmm1oOshKn83DO3Bc05ezZVD/YgKa2ZO
         vDjA==
X-Gm-Message-State: AFuF++kO5gZ9W2UeEDqQOzgz6cPLR/6pjeubCHU/ZcWcB2KAx1hv3TFl
	KWmHNkLQBU1h7FOqXcPB7IFt09XmY3bxcGMocPPuwgzMzs155tWUb99d70KueULAa7w=
X-Gm-Gg: AYBFou2JbJygEsNs38SGXf3hi4HWg+pw2CdYaExyrT24F9nqFu5WmKqB1WcxWYE4xt7
	VMLk68ff5I061LHUgqCNGa/Y1JoXKIg9WB7GFrx439smyRSGJ+rwUc+fGmiotuT26ls7BvPwewd
	mD5xRUynfSa34jkClsExu99oYkxGxDf4QtLPT8LWestQMOntqlt5/4LvwzACJ3Lqp9Bt6+vMXB4
	5zVRdKzN4yhlBQMWSIHtHWoQnTRAyutNWNv3q257ulJeajDRS7UsJi+pl9HS5SINgL3cYfp9lGf
	vNec07lBbzxXKQAvfue8ciIL67OI0puS/ff0fA4REPzGJhVKQ+I5Ogf2rvORlkB1z7MQ5CcqH5R
	poGAir1xajtfSf+o7ZhHootVA5eLEsSIoFuRcbDc9weJ7uSWLRE3KjkjODzyc3xyzUXp7c+ctc3
	L1wr81dZd5EsFlali1trZ1euMf/r/7qsM/NAHBlOhvOif6BOEM7Wt6xWQPy7zPQSaRMEm1psKSU
	+MBN52gCw==
X-Received: by 2002:a17:90b:3881:b0:398:d6e8:f84e with SMTP id 98e67ed59e1d1-39e10cedc66mr2749005a91.9.1789488398988;
        Tue, 15 Sep 2026 09:06:38 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfba020d1sm2605678a91.2.2026.09.15.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:06:37 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH v2 2/3] prserv: make --start fail when the server does not come up
Date: Tue, 15 Sep 2026 16:06:32 +0000
Message-ID: <20260915160633.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160633.7-1-bbnpreetsingh@gmail.com>
References: <20260915160633.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Sep 2026 16:06:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20215

Make `prserv --start` fail when the server can’t start, and clean up stale pidfiles on failure.

AI-Generated: Uses Claude (claude-fable-5-1)
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 lib/prserv/serv.py  | 53 +++++++++++++++++++++++++++++++++++++++------
 lib/prserv/tests.py | 14 ++++++++++++
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index e17588630..6aba1c3e0 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -205,12 +205,13 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         return {"readonly": self.server.read_only}
 
 class PRServer(bb.asyncrpc.AsyncServer):
-    def __init__(self, dbfile, read_only=False, upstream=None):
+    def __init__(self, dbfile, read_only=False, upstream=None, on_ready=None):
         super().__init__(logger)
         self.dbfile = dbfile
         self.table = None
         self.read_only = read_only
         self.upstream = upstream
+        self.on_ready = on_ready
 
     def accept_client(self, socket):
         return PRServerClient(socket, self)
@@ -226,6 +227,9 @@ class PRServer(bb.asyncrpc.AsyncServer):
         if self.upstream is not None:
             self.logger.info("And upstream PRServer: %s " % (self.upstream))
 
+        if self.on_ready is not None:
+            self.on_ready()
+
         return tasks
 
     async def stop(self):
@@ -253,16 +257,27 @@ class PRServSingleton(object):
 def run_as_daemon(func, pidfile, logfile):
     """
     See Advanced Programming in the UNIX, Sec 13.3
+
+    func runs in the daemon and is passed a callable to invoke once it is
+    ready to serve. Return the daemon's pid when that happens; raise
+    RuntimeError with the daemon's error if it fails first.
     """
+    readfd, writefd = os.pipe()
     try:
         pid = os.fork()
         if pid > 0:
+            os.close(writefd)
             os.waitpid(pid, 0)
+            with os.fdopen(readfd) as f:
+                report = f.read()
+            if report != "ready":
+                raise RuntimeError(report or "daemon exited before it was ready")
             #parent return instead of exit to give control
             return pid
     except OSError as e:
         raise Exception("%s [%d]" % (e.strerror, e.errno))
 
+    os.close(readfd)
     os.setsid()
     """
     fork again to make sure the daemon is not session leader,
@@ -316,9 +331,27 @@ def run_as_daemon(func, pidfile, logfile):
     with open(pidfile, "w") as pf:
         pf.write("%s\n" % pid)
 
-    func()
-    os.remove(pidfile)
-    os._exit(0)
+    def ready():
+        nonlocal writefd
+        os.write(writefd, b"ready")
+        os.close(writefd)
+        writefd = None
+
+    ret = 0
+    try:
+        func(ready)
+    except Exception as e:
+        import traceback
+        traceback.print_exc()
+        if writefd is not None:
+            os.write(writefd, str(e).encode())
+        ret = 1
+    try:
+        os.remove(pidfile)
+    except FileNotFoundError:
+        # --stop may have removed it already
+        pass
+    os._exit(ret)
 
 def start_daemon(dbfile, host, port, logfile, read_only=False, upstream=None):
     ip = socket.gethostbyname(host)
@@ -335,12 +368,18 @@ def start_daemon(dbfile, host, port, logfile, read_only=False, upstream=None):
         return 1
 
     dbfile = os.path.abspath(dbfile)
-    def daemon_main():
-        server = PRServer(dbfile, read_only=read_only, upstream=upstream)
+    logfile = os.path.abspath(logfile)
+    def daemon_main(ready):
+        server = PRServer(dbfile, read_only=read_only, upstream=upstream, on_ready=ready)
         server.start_tcp_server(ip, port)
         server.serve_forever()
 
-    run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
+    try:
+        run_as_daemon(daemon_main, pidfile, logfile)
+    except RuntimeError as e:
+        sys.stderr.write("Failed to start PRServer on %s:%s: %s\nSee %s for details.\n"
+                         % (ip, port, e, logfile))
+        return 1
     return 0
 
 def stop_daemon(host, port):
diff --git a/lib/prserv/tests.py b/lib/prserv/tests.py
index f3b2aae45..f1e4f12c8 100644
--- a/lib/prserv/tests.py
+++ b/lib/prserv/tests.py
@@ -7,6 +7,7 @@
 
 from . import create_server, create_client, increase_revision, revision_greater, revision_smaller, _revision_greater_or_equal
 import prserv.db as db
+from prserv.serv import PIDPREFIX
 from bb.asyncrpc import InvokeError
 import logging
 import os
@@ -383,6 +384,19 @@ class ScriptTests(unittest.TestCase):
     def tearDownClass(cls):
         cls.temp_dir.cleanup()
 
+    def test_0_start_bitbake_prserv_port_in_use(self):
+        with socket.socket() as s:
+            s.bind(("0.0.0.0", 0))
+            s.listen()
+            port = str(s.getsockname()[1])
+            result = subprocess.run([BIN_DIR / "bitbake-prserv", "--start", "-f", self.dbfile, "--port", port],
+                                    capture_output=True, text=True)
+        self.assertNotEqual(result.returncode, 0,
+                            "--start reported success with the port in use")
+        self.assertIn("Failed to start PRServer", result.stderr)
+        self.assertFalse(os.path.exists(PIDPREFIX % ("0.0.0.0", port)),
+                         "pidfile left behind by a server that never came up")
+
     def test_1_start_bitbake_prserv(self):
         try:
             subprocess.check_call([BIN_DIR / "bitbake-prserv", "--start", "-f", self.dbfile, "--port", self.port])
-- 
2.43.0


