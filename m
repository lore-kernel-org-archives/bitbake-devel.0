Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7706FA3758
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:34:50 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11799.1767382487859401759
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MDEtNFjA;
 spf=pass (domain: gmail.com, ip: 209.85.218.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b83122f9d78so967498266b.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382486; x=1767987286; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AvEvZMWxk89/Km99mkiP7CsVVAby6Ms07AOXtOi0WM=;
        b=MDEtNFjAz4JchuSVMx+IcQHQKSn8+LUNF2Zh3VTGdyYnk4KoupW9tTtPtU0I/9kQK+
         ljIbBJqMoPAf/rFMrhw1pWP8HhskFVjNqKuj0GEuolDZRF3Bu1/UIPxhEWEvpgSWj9ns
         Q/p4J479eqzveLoLVbW/EtoTRO9KOavqo4m1ajc/Qgot2sEfEiCJbKDbqb6Jzy3J3Yjf
         iL90xcCABFV0qGei+7QqfUtm+T7WBlhOqjVcH9pKbFHsA086alJknr5O/X3evsIt2YlM
         Wn/ZVhqT1pjD3HzfPj2G0oupE2TuRwUDBEqqjxAjqqzHT5RkUEkdplbSnext2mS/HHg1
         rsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382486; x=1767987286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AvEvZMWxk89/Km99mkiP7CsVVAby6Ms07AOXtOi0WM=;
        b=c/jJVEOLfKzYaqTgdvFlt9jsXaVtU875D2ZAbjDitQa97lWEyhmUZ/by+odU+6WueK
         xCm8rYW4ePzoXHmtP5xdkagE2v4x/mNVp7C0niaCyrLt9TDZZlmoxqvU7zNwQAuI7+ac
         Gm4dBxJWqCA9M5saUmFyTkj3oqYTBfVphHFuPbo5xHyKeOCLZInx1OEAE13FBAN4QuR0
         3ZgAoOFslBMNHuXbpAMCTH3YyFuc2sQA970K+c+P9N5FNOpqK4XK1/adcz2qIjZUIz7K
         zW3Rtuh+3xPnjO+tOcaaWiK08F1rwArMYI9VFChnwXXbfcE/9y3hfw4kCTAhSmily1X4
         fPlA==
X-Gm-Message-State: AOJu0Yy/QcqOCP/baotq7PstQQXqSjpR7OXV8B+XUy4+2fVsvsFsRIzu
	dg4AaI5Gnx23YHsIJH7MLtKSH/ci6mPkpqC+u4YGWP5bhLutcXAmBAg1Vu0QsQ==
X-Gm-Gg: AY/fxX5GU/8KkPnLtVjfF3o27lNoCkY0STtKPwxSl3czZUy0pGwaLJG6n6uV9jZUJb3
	lokT9s1d8iy4g3XMytxdIw0A4jvQKv1LjOcZ1fAeHLljFFtdMEYJfqp+iLIEh9EioQsrOPQVcpm
	dBz6WNQwjgadFqOoQnqPpjUTiliNk1kgpgOl5Bdm6b910HyyDTopRQueL/eIXIJDlAX750xzu8a
	5pmWC1VbbDKnw1k//luSHv27bpoS3t9YxMLsBGI+ommOFKKov/1BcQ6Qhnzgiy+NU+5vta6hB3o
	brkTRlILx+PeR9qwYoaQmfo0Nan8PUCFfzjDUm4YgQX27y3GBW4FM3NzKftRz/F0dAOFxzBZRnM
	8foBlccyYiEBmGCkbcs5CIA77CKRkNyML28EpydPpqhI57tGjnlSTCeMpG79HR7SDPmKBPeYInh
	9mC5hTXyPWfZpCT8M4JuyOUmQQ6QMi9jEteRhjHadDZDwiYLU=
X-Google-Smtp-Source: AGHT+IGSH2PIt2HTl0JHpnAE4yeRAm6wzvKuztInMHqOMzE4YdBJm0iJW7L3/DGNRPlFzelFppWAyA==
X-Received: by 2002:a17:906:c145:b0:b79:f984:1557 with SMTP id a640c23a62f3a-b8037180307mr4441955666b.46.1767382485988;
        Fri, 02 Jan 2026 11:34:45 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:45 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 01/10] bitbake-setup: move the local source tests to the end
Date: Fri,  2 Jan 2026 20:34:28 +0100
Message-ID: <20260102193438.2960561-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:34:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18671

From: Alexander Kanavin <alex@linutronix.de>

They are not a part of the main testing sequence, and logically
should not be in the middle of it.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 933178c84..ad09913f4 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -320,34 +320,6 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 out = self.runbbsetup("update --update-bb-conf='yes'")
                 self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
 
-        # check source overrides, local sources provided with symlinks, and custom setup dir name
-        source_override_content = """
-{
-    "sources": {
-        "test-repo": {
-            "local": {
-                "path": "."
-            }
-        }
-    }
-}"""
-        override_filename = 'source-overrides.json'
-        custom_setup_dir = 'special-setup-dir'
-        self.add_file_to_testrepo(override_filename, source_override_content)
-        out = self.runbbsetup("init --non-interactive --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), custom_setup_dir))
-        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
-        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
-        self.assertTrue(os.path.islink(custom_layer_path))
-        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
-
-        # same but use command line options to specify local overrides
-        custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
-        out = self.runbbsetup("init --non-interactive -L test-repo {} --setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_setup_dir))
-        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
-        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
-        self.assertTrue(os.path.islink(custom_layer_path))
-        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
-
         # install buildtools
         out = self.runbbsetup("install-buildtools")
         self.assertIn("Buildtools installed into", out[0])
@@ -428,3 +400,31 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             out = self.runbbsetup("update --update-bb-conf='no'")
             sums_after = _conf_chksum(f"{setuppath}/build/conf")
             self.assertEqual(sums_before, sums_after)
+
+        # check source overrides, local sources provided with symlinks, and custom setup dir name
+        source_override_content = """
+{
+    "sources": {
+        "test-repo": {
+            "local": {
+                "path": "."
+            }
+        }
+    }
+}"""
+        override_filename = 'source-overrides.json'
+        custom_setup_dir = 'special-setup-dir'
+        self.add_file_to_testrepo(override_filename, source_override_content)
+        out = self.runbbsetup("init --non-interactive --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), custom_setup_dir))
+        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
+        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
+        self.assertTrue(os.path.islink(custom_layer_path))
+        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
+
+        # same but use command line options to specify local overrides
+        custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
+        out = self.runbbsetup("init --non-interactive -L test-repo {} --setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_setup_dir))
+        custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
+        custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
+        self.assertTrue(os.path.islink(custom_layer_path))
+        self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
-- 
2.47.3


