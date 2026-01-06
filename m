Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC604CDC178
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:39 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88564.1767701438893195569
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HWyWr9zE;
 spf=pass (domain: gmail.com, ip: 209.85.218.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324054so164384466b.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701437; x=1768306237; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+AvEvZMWxk89/Km99mkiP7CsVVAby6Ms07AOXtOi0WM=;
        b=HWyWr9zEGxjTWmFoRQOMMai6+52px3Uxknp9FrtuARfhpYUOJ0RMUWBdjmGoKB0Ura
         9TMU4tcIL59+resihy5ZuNRO4xK4j3k50nG/FnVdF9pMXgdj6a6m56eTMs6IcGc8Dt3V
         SFVeLnPqva3Kfsd6py25ftlijU/xVxyL1/4zC9bZbCRiMEiC5299eD81ytejZWR4hG1+
         dkLHApBp5SMjArUu8DWuH4v9QX/0aJLMOkvM8GMiyWq9YrRviRCIXPeEEMP5XeQwdW4I
         maDCURt+sF3fQRsmBmqK5WVT2Oj7bL7X42HjQs2JMsb6HxA/IOVt7xSghjIeDCItTL+c
         UmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701437; x=1768306237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AvEvZMWxk89/Km99mkiP7CsVVAby6Ms07AOXtOi0WM=;
        b=wJGXpzb8eAC3zlf2z9+DCHC0jP3oiHAsv2vG2kQgeHVku9lW2Z4B2AWEcsoO2qSStu
         wedHZuym0GQpk97Y+JZ+V79ujFWJGz6vuvcaXRYQZr7F0XWY40XgMvAKflX7jagI0QF9
         wsvVrLROuU2J5pQ09kYpXhfeV1GhQxG2sz1zgelIeJoAExfuirk5djPkrHn6RGrMJCAh
         RrultrD5ktJSLOuVsRnqxe5gfKJrEIEFTfxz/Kfb2ph2lnAbm2G1AriyttH+JzR/tXYZ
         BtR9r0WEVFuYNS+lwAPMhNO5OBPTuGdODBtcUfkXV6ecyvqdFQD2P7Da9HPACL9Q4iOR
         g5Wg==
X-Gm-Message-State: AOJu0Yzqfgxc73/mgFOZUCjjLI7ZJUyMMHR8d+nIvbzna2Gm0yDjNaXl
	OQT+FEK8pNMx+FnfHbN+bAiveH2DRcrpGKfwDLgj7zDL6ywEzIs3RGZ7jpl68A==
X-Gm-Gg: AY/fxX5tznilPoEMm9YWynkxNR+UpiLT6JQPxkulec5xjQrwlOAD5JcFDLd0FIETFYP
	k0nZ3qG4HoHP6AH0OJHI3wswFxQjP+SzLcFUqFyDVRt1BPsHQuFRapPfZcs8Q2tZj34UKWGHK3o
	7gteb+B+mHAgRp+rctLiqX/mrK8HBB0AICdDy8Y3eaArDEjfZ9ILHEERscBLorPSLj81GiahDVR
	8yWANZaDDkIVfFTxx8WP+mgOeDWIDnzCPK/D4nGI+SySIztSZMUN0MVjB8JNdfHKZIYsRhhb3Nm
	+VEsdcCiZpfoQB95hI4CW/GsAGjXVe8j9kXa1oee/YlOlN5hqu43Y/kn7ayraXVWRHvYunLx6Cd
	Z43iLkXXZxOI1wZ9/mrxUU89l+oGtA8n8oMc/RjqIqQHOjax9ypEcWyRINbSee7V7TLrQpu5dTg
	q5i9MJLHNCdQ+iatiDEC6vDHmvoO6GDc8DdeUNsFye6i9Q7uA=
X-Google-Smtp-Source: AGHT+IGYT+q2jvbNiUNJUm8HRkFvat9gBlWrGKuabql3lFFBLZqQ9/JtmZlrrBXTyftUOKblhkIOdA==
X-Received: by 2002:a17:907:6d22:b0:b73:667e:bb29 with SMTP id a640c23a62f3a-b8426a4a80cmr285678566b.8.1767701436972;
        Tue, 06 Jan 2026 04:10:36 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:36 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 01/10] bitbake-setup: move the local source tests to the end
Date: Tue,  6 Jan 2026 13:10:23 +0100
Message-ID: <20260106121033.3892596-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18691

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


