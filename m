Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.48888.1591048198709462350
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=pEh/XJz0;
 spf=pass (domain: gmail.com, ip: 209.85.215.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-pg1-f182.google.com with SMTP id t7so3252623pgt.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLE2xavfWqzPiMNJYNxkmr/DoKEttQByHYxmiFhLxI0=;
        b=pEh/XJz0WiLD+EFRlNhOwZEUVTRcCXsre4jRLCI6RWRzXK6wR0APPi8jVrytDNLSwQ
         0Bmo8AHuGpkcm0qInVIEV8PQ0Zb9nHdtZH5YOva2sFyO7kU2/KA0UkieycJSb+DoMTGw
         8l2pODR2CGOIylX/H1DdXa8sEhfCtOWVZsMDdnnTkzluqODIp12/Nq79+Ysm6yLand13
         McVRpRZNdsq3EJJokVP2AIAk4uc5uxU3ruhTijCfcQbqUNKSG1kJ1yvpIEFUFx5S/yKZ
         HwFkmrl3u7PC3tmTkkGHauFHOvlIMw+Q6DUwVdmeBK87gWOgEi1YxnirrBtrRPtJs/mA
         X3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLE2xavfWqzPiMNJYNxkmr/DoKEttQByHYxmiFhLxI0=;
        b=BFGSDihZzWhQfN59F7cCns1ei64Ig4UbIJBX9yiwy+zUY0eGwZhjSsakXkruVtC6a+
         650ys0+DWz1mDg9rukM46AkmWaRKQAYJLzVVqR2GjhkPTVWS3oecgG0mcKVdPOnQSroa
         uu6ALfsqiIxtfA8ZuRKYg4vEygCCgiE7z7DuCwAR3/gNph/TVJ3WSEz0kaDbki86+oEl
         IyUA+g1WbzW8Eh3WWNNuuZKraKYLEk54L4olfkv0GnUL3APbcSUNGgruYs+6HbGuwlkh
         W//OVHHx7LDOOYMmVDqcnz7R6eu0F7b0JgCnTowYqsyj0eCK1Qd8k5qMSnq1ODOQ5zll
         BUCQ==
X-Gm-Message-State: AOAM533W3V3H/AnAC8yblqOyfFYkDp71s8Zston2rkAtTPczuGuT3RU8
	ytU5K295BUSdcdvy/l0HKsjA0BE3VNo=
X-Google-Smtp-Source: ABdhPJxGcvIiqwflMIyTc/PkKhoZmTna0MY+I+8mRci/t1IvqO5ocVWBtvq1ytXpFamxo7ES2YjFQw==
X-Received: by 2002:a63:2252:: with SMTP id t18mr18461652pgm.450.1591048197937;
        Mon, 01 Jun 2020 14:49:57 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:57 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 7/8] bitbake: tests: Add tests for BBMASK in multiconfig
Date: Mon,  1 Jun 2020 16:49:44 -0500
Message-Id: <20200601214945.32481-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601214945.32481-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
 <20200601214945.32481-1-JPEWhacker@gmail.com>
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

