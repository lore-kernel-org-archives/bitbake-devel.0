Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web10.47067.1591043303040877609
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 13:28:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=S8gmErYM;
 spf=pass (domain: gmail.com, ip: 209.85.166.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f169.google.com with SMTP id a13so5914221ilh.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tcn2/qQNuYgTJPc37lvt6bzns5nAhQupaaM9AQR7/0g=;
        b=S8gmErYMBJrHs/BoIHqNQou/974TflfS27ZoDuKPuPPCkmLkT+HXmkhZyCFKSQmWDM
         KpsSq0E9+ODGmPItiZ3Ey6d4PmAeCM1clnY+geAa58N+MyWmwIARfVMdudcd4AnoPEx1
         08p8lwtuR+BAMHoDiFWQvoXiCV9x+I0tOy3pA0wP/j6rbrLufp8O5BpNkK/BzLLyWAp2
         ecAUQSGcdXe201mNcwPEUxrAIJYePYb1jLQxKNtJuuZll4jii1yE5eh2uCVrujsoNSX0
         FvjMFv+f5UQ2Fr+uuXyMbocYpXZNmJM7uxuisle6K0EHQKAcAvbcrkenzhRimmgoo8IL
         GoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tcn2/qQNuYgTJPc37lvt6bzns5nAhQupaaM9AQR7/0g=;
        b=KYa28GQDTDBMwzF9CgqNFL/bRIFd3Df0ojLw4b5OaXqT1RJwMicQiWGNWT+tAP6j2D
         U+LPFCplo3x/bLh5kbpWQLz/Pb402oXqGjOhB45Cblw2RKjt95Mbgi8MK7C+5TNcf/s8
         mGFAqsL9nX/T5IcLvpbX8kpzaY4Ld5hn6y82z8uKT0j8lUgX2iOwEHG1SIhjlaMBOx1H
         xbmTcqr0eY1evVTYaAP4PX8h7YoJVu/t9abD0JtHf9BOAs07zMc+Z2B8ZaMvTX7bq9W6
         cQ0ANztJnQSh7tespHBodufrcAepJm5GnoFEk86vXNpdikkRBif2d8EJr9jUezD7jxVP
         mYHQ==
X-Gm-Message-State: AOAM532nc6Ai3ihyQ1v6dPQRxoFTmrejSK6Xk4gIDbRlgsJdMmO2OQQ2
	+9iVtJ9bjc9uWWUUIw5+HU0tug9T2HA=
X-Google-Smtp-Source: ABdhPJzxuwCZr453vpEJAGJsSezHgpbf6e5QOXtuGtjMa45KoXRIY9SKBSg05jMqH0UzVvHTpHNsdw==
X-Received: by 2002:a05:6e02:6c9:: with SMTP id p9mr3022472ils.185.1591043302200;
        Mon, 01 Jun 2020 13:28:22 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id v16sm300705ilo.47.2020.06.01.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:28:21 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 7/8] bitbake: tests: Add tests for BBMASK in multiconfig
Date: Mon,  1 Jun 2020 15:28:06 -0500
Message-Id: <20200601202807.26357-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601202807.26357-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>

Adds a test to validate that multiconfigs can independently mask off
recipes by setting BBMASK. See the test description for further
information about how the test works.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 .../lib/bb/tests/runqueue-tests/conf/bitbake.conf |  3 ++-
 .../runqueue-tests/conf/multiconfig/mc1.conf      |  1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf      |  1 +
 .../runqueue-tests/recipes/fails-mc/fails-mc1.bb  |  5 +++++
 .../runqueue-tests/recipes/fails-mc/fails-mc2.bb  |  4 ++++
 bitbake/lib/bb/tests/runqueue.py                  | 15 +++++++++++++++
 6 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb

diff --git a/bitbake/lib/bb/tests/runqueue-tests/conf/bitbake.conf b/bitbake/lib/bb/tests/runqueue-tests/conf/bitbake.conf
index 5e451fc2c0..efebf001a9 100644
--- a/bitbake/lib/bb/tests/runqueue-tests/conf/bitbake.conf
+++ b/bitbake/lib/bb/tests/runqueue-tests/conf/bitbake.conf
@@ -1,7 +1,8 @@
 CACHE = "${TOPDIR}/cache"
 THISDIR = "${@os.path.dirname(d.getVar('FILE'))}"
 COREBASE := "${@os.path.normpath(os.path.dirname(d.getVar('FILE')+'/../../'))}"
-BBFILES = "${COREBASE}/recipes/*.bb"
+EXTRA_BBFILES ?= ""
+BBFILES = "${COREBASE}/recipes/*.bb ${EXTRA_BBFILES}"
 PROVIDES = "${PN}"
 PN = "${@bb.parse.vars_from_file(d.getVar('FILE', False),d)[0]}"
 PF = "${BB_CURRENT_MC}:${PN}"
diff --git a/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf b/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
index ecf23e1c73..f34b8dcccf 100644
--- a/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
+++ b/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
@@ -1 +1,2 @@
 TMPDIR = "${TOPDIR}/mc1/"
+BBMASK += "recipes/fails-mc/fails-mc1.bb"
diff --git a/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf b/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf
index eef338e4cc..c3360fc5c8 100644
--- a/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf
+++ b/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf
@@ -1 +1,2 @@
 TMPDIR = "${TOPDIR}/mc2/"
+BBMASK += "recipes/fails-mc/fails-mc2.bb"
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
new file mode 100644
index 0000000000..17a181fffb
--- /dev/null
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
@@ -0,0 +1,5 @@
+python () {
+    if d.getVar("BB_CURRENT_MC") == "mc1":
+        bb.fatal("Multiconfig is mc1")
+}
+
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
new file mode 100644
index 0000000000..cc69e7b82d
--- /dev/null
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
@@ -0,0 +1,4 @@
+python () {
+    if d.getVar("BB_CURRENT_MC") == "mc2":
+        bb.fatal("Multiconfig is mc2")
+}
diff --git a/bitbake/lib/bb/tests/runqueue.py b/bitbake/lib/bb/tests/runqueue.py
index 4ba12a0772..091b5e41e0 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -232,6 +232,21 @@ class RunQueueTests(unittest.TestCase):
                 expected.remove(x)
             self.assertEqual(set(tasks), set(expected))
 
+    def test_multiconfig_bbmask(self):
+        # This test validates that multiconfigs can independently mask off
+        # recipes they do not want with BBMASK. It works by having recipes
+        # that will fail to parse for mc1 and mc2, then making each multiconfig
+        # build the one that does parse. This ensures that the recipes are in
+        # each multiconfigs BBFILES, but each is masking only the one that
+        # doesn't parse
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            extraenv = {
+                "BBMULTICONFIG" : "mc1 mc2",
+                "BB_SIGNATURE_HANDLER" : "basic",
+                "EXTRA_BBFILES": "${COREBASE}/recipes/fails-mc/*.bb",
+            }
+            cmd = ["bitbake", "mc:mc1:fails-mc2", "mc:mc2:fails-mc1"]
+            self.run_bitbakecmd(cmd, tempdir, "", extraenv=extraenv)
 
     @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
     def test_hashserv_single(self):
-- 
2.17.1

