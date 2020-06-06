Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web10.3740.1591413356622097302
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 20:15:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=bxtESMeV;
 spf=pass (domain: gmail.com, ip: 209.85.166.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f45.google.com with SMTP id u13so6374964iol.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLE2xavfWqzPiMNJYNxkmr/DoKEttQByHYxmiFhLxI0=;
        b=bxtESMeVuZTdtQ4R2q8JuP4PS4x99PQwsC9g7rC0qtFN1PDpG0BD94RPTKHbymOv1o
         os5Wc+ULiX27V9ZrWgDD/MYUT4drhIzIxUMTAFsAV6nnJ3bH6dxOSd+oq1RhWpEivVLf
         blSHVUv8hwHxrOaMWgagnW3zhltaQKsuCCnSnMUMJCGz0gkCj6HDhMcokYp9N/95XcyK
         U8rALPBVwYu1sT0O7zCKoBlsUi5VGjKXwr9XBkns58pdmCwhNUi7sbgPRr9cWoqL0gVW
         DIzWxznLKM6XOqQOfaJnEijVIaH8gd6P6pd9W/UFVkOSY3JYZ+8OsmbZgbcQk8aVWl8W
         kMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLE2xavfWqzPiMNJYNxkmr/DoKEttQByHYxmiFhLxI0=;
        b=ksWwXdOVTijacIuYlOvaFgYNP6/LM1911L6J8haglPRY8z+ZxjPBwgZT163ZugnaR3
         3xavxo+CBMBjsCykfArrC7Pe7jX24Qkxid9u66VGtdWQWFPvQOU9iWRfbcQqHG/mPjbM
         SaLTWqjFcpkpUMhDRCbBQt23wooqVsBCCV6uF36HEwX1XviOtR6Ev2uCKiB1qpJCMMzm
         Fsupmfv7l1eeAS8e4XB2PulSL8vPIgfxRvG6Rk/ql5HoJQ76DWyUftW5ditHDlCMEKzh
         1EFY+N65FRsTCJ1K4K9/Ujy8DqZppIfSqHPpVZ4ciB2GnaDQ6h1GNfX6XYhTfPSfVSJ8
         rPqA==
X-Gm-Message-State: AOAM531HdgTGCwV+OnvNzqz7B8cQYVYzBaKG+5B1VMnI8dFu9G1xf8ZY
	eoCOy1fJGHmsVVE3yszQuuwrC3E+f2Y=
X-Google-Smtp-Source: ABdhPJywdTeH2xhX7iCfkwi3srrvcYFW2cI/HWIVkFom+V3eSWgzKmAVaoIsD22NLfKLvFgqimwjtw==
X-Received: by 2002:a6b:1487:: with SMTP id 129mr11231168iou.197.1591413355386;
        Fri, 05 Jun 2020 20:15:55 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id p9sm2885221ile.87.2020.06.05.20.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 20:15:54 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 7/8] bitbake: tests: Add tests for BBMASK in multiconfig
Date: Fri,  5 Jun 2020 22:15:35 -0500
Message-Id: <20200606031536.15956-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606031536.15956-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
 <20200606031536.15956-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.26.2

