Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web11.5516.1591727661665403145
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jun 2020 11:34:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=O2drLdUt;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id a13so21368168ilh.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2020 11:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhDCzwRIyF1L6Ng3VMmlgnzoRJvZC8P5Hlg7TpNtF8E=;
        b=O2drLdUtiNctLrHhkHFhWI5j8hoBqfTNxWgACofYg51F/YQXKEjPpLsMjp57sMAySL
         ZLTxHG7E3+GqzTq7Eo+Q3wCifxRdTToMIoD60k/CIt3DOueqtxj09pcb+ahKglHCLX0x
         3iXOjRCxPaK8WkwzMazmcWtQwlRMsmtOKqZoZrRT+4cUh4WuF0x16eWSaounUl3xYo3I
         10ya0uPhDexGc99/onii6rZ5iUfgAwjIuhXVIUfZDly1yPOXTe8fkEGdpkyXHDA5spD3
         aJwJC+jRlgBWYJSFiNMtTd8cGT5YO9JAp1PZawWNXyUfotYpX8Ef8yxP5ml0tRwa9wIH
         mXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhDCzwRIyF1L6Ng3VMmlgnzoRJvZC8P5Hlg7TpNtF8E=;
        b=cCsXGD3CHddtrFQSOIqnTCyRzNYhPbqYxEHFaJjtEQkarA0zwcDY0ng1+zPxpvhub6
         ifmOLblq6FmQUV7LuekqOIDqDXuYanncQZ+42kcLacxBwWlqc58LSYIwsKnNSktLarTa
         17fa5uEDE0IeE98yHst3NK+9FYQskRTbgiLPmTXo/T0rlyiPCcuynEAzcydPUfbhOZYc
         aaYcjbSMoa7+6HT3hhXJHtwG3z5T23nlhpty5LJZRwBPM1dSvGTKdsJQ2kQJs2qsdIK9
         3VJy9Imf08pcD59oWnrL7xYxT0jAQHuW6OLfzZ5p+u7St3OcULQyebRZba+AMzzuUfsz
         0PZQ==
X-Gm-Message-State: AOAM531jC/J+sbu8mXjObQr6NBJU9RcjlWRPrBYqLIP7X+bdOct9A7E7
	rnqwsq/fubb6i8TZdPX/PEXWuk6x
X-Google-Smtp-Source: ABdhPJzUmkCE4YgJ7BNnPFsre2FcBlLpzD2jrBfZCPsY0izCkgIpvMJn3fAq3vv0LQPyzxk2ioKz5w==
X-Received: by 2002:a92:8b0a:: with SMTP id i10mr26807056ild.245.1591727660657;
        Tue, 09 Jun 2020 11:34:20 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:6cec:510:bc9:611])
        by smtp.gmail.com with ESMTPSA id p5sm9342260ilg.88.2020.06.09.11.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:34:19 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 2/2] bitbake: tests: Add mcdepends test
Date: Tue,  9 Jun 2020 13:34:15 -0500
Message-Id: <20200609183415.21914-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609183415.21914-1-JPEWhacker@gmail.com>
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
 <20200609183415.21914-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a test to validate that mcdepends causes the dependent tasks to
build, and also that a change in the dependent task causes the dependee
task to re-execute.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../lib/bb/tests/runqueue-tests/recipes/f1.bb |  1 +
 bitbake/lib/bb/tests/runqueue.py              | 30 +++++++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb

diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb
new file mode 100644
index 0000000000..d45a4cff52
--- /dev/null
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb
@@ -0,0 +1 @@
+do_install[mcdepends] = "mc:mc1:mc2:a1:do_build"
diff --git a/bitbake/lib/bb/tests/runqueue.py b/bitbake/lib/bb/tests/runqueue.py
index 091b5e41e0..d3d62b98f9 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -248,6 +248,36 @@ class RunQueueTests(unittest.TestCase):
             cmd = ["bitbake", "mc:mc1:fails-mc2", "mc:mc2:fails-mc1"]
             self.run_bitbakecmd(cmd, tempdir, "", extraenv=extraenv)
 
+    def test_multiconfig_mcdepends(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BBMULTICONFIG" : "mc1 mc2",
+                "BB_SIGNATURE_HANDLER" : "TestMulticonfigDepends",
+                "EXTRA_BBFILES": "${COREBASE}/recipes/fails-mc/*.bb",
+            }
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            expected = ["mc1:f1:%s" % t for t in self.alltasks] + \
+                       ["mc2:a1:%s" % t for t in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+
+            # A rebuild does nothing
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            self.assertEqual(set(tasks), set())
+
+            # Test that a signature change in the dependent task causes
+            # mcdepends to rebuild
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc2:a1", "-c", "compile", "-f"], tempdir, "", extraenv=extraenv, cleanup=True)
+            expected = ["mc2:a1:compile"]
+            self.assertEqual(set(tasks), set(expected))
+
+            rerun_tasks = self.alltasks[:]
+            for x in ("fetch", "unpack", "patch", "prepare_recipe_sysroot", "configure", "compile"):
+                rerun_tasks.remove(x)
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            expected = ["mc1:f1:%s" % t for t in rerun_tasks] + \
+                       ["mc2:a1:%s" % t for t in rerun_tasks]
+            self.assertEqual(set(tasks), set(expected))
+
     @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
     def test_hashserv_single(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
-- 
2.26.2

