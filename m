Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.2278.1591322021491666874
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 18:53:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=tHjNnJBV;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id nm22so1927221pjb.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 18:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLE2xavfWqzPiMNJYNxkmr/DoKEttQByHYxmiFhLxI0=;
        b=tHjNnJBVP5DwpVR+T0l3wO6JvGIZid6LjM/XQDGsOnRHqH5TpKFnZbSAWWOS4ZZ8hq
         pQ0yuA9bm+LY4Ty1KIArLL7RS9jClQVeILiDCHJ/E/NgPeuAy2QhuKTSLhsFgEp7Kedv
         uiecLyS90V4D23GG/kSybZ8keUyPHsrF/MJwSFrPMMju44W3tIvzmEKIblqcOMq7o2IK
         JYEQrtfkzmNdHsD+zoE05i/WXAVGGoAPbmmpQgsuHS1uVIj7kxOFjNDOKalYJVI6BO72
         K13cQm7lXzlRvdeFF7Gnl9mZuHzWLk+Ck9lsQwwvbQx/O9+gX2j7SL/kihqRZuEs9U2k
         vI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLE2xavfWqzPiMNJYNxkmr/DoKEttQByHYxmiFhLxI0=;
        b=HE3pa81wsFe05gKKXpp48qRjLB5nH5RbIKuB1ezRyyc7QLJaLylD+KhkVFSngpDpEh
         qywWOxI0qk1Z7QC8jBOxKnpZslJ5hBoTS8r1LhJYS4GWT5/YOCPI0CaA8KTMZC/HSR4G
         ESw6mERm3vwZN1HQWbUu/W5cW7GKI+wUBaoGhZ9/8bixnnmDIs5EAZ859boYBI7UPpbh
         hrYEtW1QlZ/mkPOq7+Qzbh3Z894xKP6IpX5KsmFE+PUoPXEC0Hk7NxulXxsQF/BozOzF
         weg9t95K8JTSsYcIpfll9UvX8pMiqqt73BmaDTOYAscVQTo9mcNYjKpH98dNrR0G4t42
         h4WA==
X-Gm-Message-State: AOAM533MnkwbbNbpqkvQ6SKgZ/4u18bL52HozDwhKI6eh9yaC6IiSgDU
	zQBd0mVNk6vMONvyj/OeI+Vf6nJTeWw=
X-Google-Smtp-Source: ABdhPJwyH3anAj274O22Xui0H0CrErsPqRDUiPxEXvHHFfzYcsyrrxjoCHXUR5mt9d2g8ITO+JJYxQ==
X-Received: by 2002:a17:902:b203:: with SMTP id t3mr7674757plr.129.1591322020685;
        Thu, 04 Jun 2020 18:53:40 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:bdc6:d557:64ed:7ccf])
        by smtp.gmail.com with ESMTPSA id x12sm5673516pfo.72.2020.06.04.18.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 18:53:40 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 7/8] bitbake: tests: Add tests for BBMASK in multiconfig
Date: Thu,  4 Jun 2020 20:53:24 -0500
Message-Id: <20200605015325.35395-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
 <20200605015325.35395-1-JPEWhacker@gmail.com>
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

