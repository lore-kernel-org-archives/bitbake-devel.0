Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web12.1088.1591381082345333619
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 11:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZJoTcQ9T;
 spf=pass (domain: gmail.com, ip: 209.85.216.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f53.google.com with SMTP id jz3so3016548pjb.0;
        Fri, 05 Jun 2020 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnSD80YyFROlvR39d6aaF5uGFEFU9s6XJX/s1FIgJp4=;
        b=ZJoTcQ9Tg9zpeq2rakGGpIORVw+P2h9BlqVFFs+R7yJLJyhtPl38WJV/rk3u5RXz8W
         voOdCtlrQ/xq5dKa2gYYrRgrFX0CSCcuE9DC0JdHcIyBWc8lG9WLX1ukhRRdwxhi61iU
         6Z2M4PKMN7gfjQijbL44+Um0r0MFLAV7MdBmdpLz+UjZmXi30ehxT2e3CPQCVzyKJ0m0
         lFRb06hHduQ2IFxWiHh965j9mxiR23+6jeydXasczUdr9qtFd1UH1sWMj3pHMhFMt11Z
         LkOFzUhmccs1PXJJi5vTG56Wp1esz+t7dSH7p+QsKtqUoELzs1xg0bM4j9HstXfUymqL
         4ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnSD80YyFROlvR39d6aaF5uGFEFU9s6XJX/s1FIgJp4=;
        b=PfG6XclYu/AEEmRofAw10lc2jke5wpxqc1mieId5TtJ6yR5vI6dOmfPE+noKOU+DhX
         /ipBwDgEGBLAC2g+WbEGemLjG1pvOxIriUFZ7ouIh+zbAYxsW1KHGHbKPKlW4Et4mOch
         MX4LszdgSO2BFwBfOAkZMidsu8HKLYpKatlrxSPfW/mRnUHmFXOmVYXkoIiPtyYGl/fQ
         KcoXJuJla6ZgHQ0dl7WNpvMbvHAP1l/pJ24hkifFIEHys5HFMsrylbBD58x/sHC0za1T
         nrP/TH+XrI+TU38e1YqmMr8i6xA4pfKyCEzb2hiLRVpAoG7vnPHGdfiGsF0RKaOLKH3e
         2vGg==
X-Gm-Message-State: AOAM533MMn0tJur/KPkuwyT1f0Q5JoVLpV02VWwuCuC/fSBhAmMqXKOm
	w+KjfuArYImMLhP3eBdJfBFRJSETKlk=
X-Google-Smtp-Source: ABdhPJym3IL/1PP9PKQBfUbGo4wg+o7RRqw6CRArUQ6ljsGvPXo++xS77YlauZTsFJUPaXEFrLFOzg==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr10726668pld.73.1591381081614;
        Fri, 05 Jun 2020 11:18:01 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id g21sm246096pfh.134.2020.06.05.11.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:18:01 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [RFC PATCH 2/3] bitbake: tests: Add mcdepends test
Date: Fri,  5 Jun 2020 13:17:53 -0500
Message-Id: <20200605181754.32883-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181754.32883-1-JPEWhacker@gmail.com>
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
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
index 091b5e41e0..988272b19f 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -248,6 +248,36 @@ class RunQueueTests(unittest.TestCase):
             cmd = ["bitbake", "mc:mc1:fails-mc2", "mc:mc2:fails-mc1"]
             self.run_bitbakecmd(cmd, tempdir, "", extraenv=extraenv)
 
+    def test_multiconfig_mcdepends(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BBMULTICONFIG" : "mc1 mc2",
+                "BB_SIGNATURE_HANDLER" : "basichash",
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

