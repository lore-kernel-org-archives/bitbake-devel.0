Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A63D1A628
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 13:20:18 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9813.1767964812252937734
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 05:20:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f1i1iycb;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47755de027eso25083265e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 05:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767964811; x=1768569611; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij90d5M737kUKvADqyblyXi7XMuhZXxlIuc/FwmDHsg=;
        b=f1i1iycb/0gwdTb4eW4GR0KDQqmGxjlFKd1Fn14ST29sAo1KAWMnuVBlXimbtUKxxP
         qK609JNezZgBhyPG91Huo2TwwgSeTNIk26KqAmGBqIzV9s8TnqvOW/UzZmp+zyyDGWkk
         UBOk9fg40420L9FvpJrKD6rQhoC+ylTxHDR9it1HowyHHuLrqQJtlq8Kav3igIwwrWFJ
         9xcXu1NwoZ6a3FJPtB1zghBh0gSTpHORg7jMHjdmtYYxywX93CpYOJ9+spXEyiD0r29S
         O38bG63Z8jsBSbu9DhA/NGpEl8eb4TNKIjekRZKKeShtqia37IFPMUuGt3p1sPB8C6fl
         4UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767964811; x=1768569611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ij90d5M737kUKvADqyblyXi7XMuhZXxlIuc/FwmDHsg=;
        b=FAk37KkLcwV5VClSK98WNvdEg/8HVwCsrzwOtPxgVsDnRCmHGCZa3npLWbu+Rsoio1
         daCGBLbfWy9kMq757mQb+tHwHAKszzyw811aDmG30gmAKe+9aIV72CcJEV/RUuJFmm9k
         8JH9tBQgrXFcLjiyan6UyhST/XRZMw0Ld7PCLy17esSB5hxX3TA60cfOu1gqdU3HeIrd
         DVh1lJfKFE4GKqpMGc7MJrhZfxkSJeqkqHV6gjPp3FMp2k1qsvqW1GvV+BxXOPt1z3md
         uUpWBS2GKNq4otdhDg292wzLPNZUVd7PWpDXdPUE+n1P/XDXjyErs5GD+59JjEHCVewO
         9Dxw==
X-Gm-Message-State: AOJu0Yxquwy/b4ferIDnJcWNwTT24hIesNuqCK4xVsRMkxf/Neg2xyA0
	eaBJ4FyHLa7yNQtZDjmGarXmZLfzOTi1c2IIiAJ8GRX8/+invKgEftSxE/1NtQ==
X-Gm-Gg: AY/fxX4fbuEosr/SlfcbpOpuU1swaPFE2dsH2AO8fmSBo1zt3W7WRQhCjnxUCbuQKTr
	lIzftdmQS73g1Qd7KbKJ91kLvHImXYT3b13oP1QdIQT1FRNWD9YYknCvSwXLTTm+W7vKDF+CwfT
	YeU7S/cBXACK17jJq7GHPT6s73QAcmL9lu/8gTkL0GQIFja+Yydjx9fVNQmZgr2G0i2KhVGwK6O
	ghTRXShzPpT/RNlS9BBSanD8yQ0ks8GBxThe49OpArKb6KTcAI9YARbyarQHNdQYO6Dy7qm3r9G
	C2N/ks5XoVqu+k0no6U7B/+byNaU371lNV0DR180/Vc1Dzv6LlAyL/DjCGvDyq13zoFeED7w7SV
	znJG8JiG/e2a6q/E0YXS0LNH2oWvUPipWXVl4ds2+KLah77aLThpolz+rUeSHrmXS2yYaQkWnP7
	qbHDwUP05O9qrf2BqMPED1FgFLDP+K3R78HOnBET+YAsekLjpOYMZ+dKzbfQ==
X-Google-Smtp-Source: AGHT+IF0dwJl4E/w8VMtwWlub46Xn9rDINFpHxaabUwacouDXc64tVs3zg9OubINfI0DE2wDgdDnhg==
X-Received: by 2002:a05:600c:3556:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-47d84b086ccmr119070765e9.1.1767964810469;
        Fri, 09 Jan 2026 05:20:10 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm202291505e9.5.2026.01.09.05.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:20:10 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 5/5] bitbake-setup: add tests for update scenarios fixed in the previous commit
Date: Fri,  9 Jan 2026 14:20:00 +0100
Message-ID: <20260109132000.2372791-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109132000.2372791-1-alex.kanavin@gmail.com>
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 13:20:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18726

From: Alexander Kanavin <alex@linutronix.de>

This adds tests for the issues fixed in the previous commits:
- transitions in sources from remote to local, from local to local and from local to remote
- ensuring that local commits in sources are restricted
- ensuring that source backups do happen when that is expected.

Add a helper function that adds a test configuration with a local source in it.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 68 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 438dc0cd8..834d09854 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -175,6 +175,16 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 """ % (self.testrepopath, branch, rev)
         return self._add_json_config_to_registry_helper(name, sources)
 
+    def add_local_json_config_to_registry(self, name, path):
+        sources = """
+        "test-repo": {
+            "local": {
+                "path": "%s"
+            }
+        }
+""" % (path)
+        return self._add_json_config_to_registry_helper(name, sources)
+
     def add_file_to_testrepo(self, name, content, script=False):
         fullname = os.path.join(self.testrepopath, name)
         os.makedirs(os.path.join(self.testrepopath, os.path.dirname(name)), exist_ok=True)
@@ -413,7 +423,6 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             sums_after = _conf_chksum(f"{setuppath}/build/conf")
             self.assertEqual(sums_before, sums_after)
 
-        # check source overrides, local sources provided with symlinks, and custom setup dir name
         def _check_local_sources(custom_setup_dir):
             custom_setup_path = os.path.join(self.tempdir, 'bitbake-builds', custom_setup_dir)
             custom_layer_path = os.path.join(custom_setup_path, 'layers', 'test-repo')
@@ -421,6 +430,63 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertEqual(self.testrepopath, os.path.realpath(custom_layer_path))
             self.config_is_unchanged(custom_setup_path)
 
+        # Change the configuration to refer to a local source, then to another local source, then back to a git remote
+        # Run status/update after each change and verify that nothing breaks
+        c = 'gadget'
+        setuppath = self.get_setup_path('test-config-1', c)
+        self.config_is_unchanged(setuppath)
+
+        json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_local_sources(setuppath)
+
+        prev_path = self.testrepopath
+        self.testrepopath = prev_path + "-2"
+        self.git("clone {} {}".format(prev_path, self.testrepopath), cwd=self.tempdir)
+        json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_local_sources(setuppath)
+
+        self.testrepopath = prev_path
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        self.check_setupdir_files(setuppath, test_file_content)
+
+        # Also check that there are no layer backups up to this point, then make a change that should
+        # result in a layer backup, and check that it does happen.
+        def _check_layer_backups(layer_path, expected_backups):
+            files = os.listdir(layer_path)
+            backups = len([f for f in files if 'backup' in f])
+            self.assertEqual(backups, expected_backups, msg = "Expected {} layer backups, got {}, directory listing: {}".format(expected_backups, backups, files))
+
+        layers_path = os.path.join(setuppath, 'layers')
+        layer_path = os.path.join(layers_path, 'test-repo')
+        _check_layer_backups(layers_path, 0)
+
+        ## edit a file without making a commit
+        with open(os.path.join(layer_path, 'local-modification'), 'w') as f:
+            f.write('locally-modified\n')
+        test_file_content = "modified-again\n"
+        self.add_file_to_testrepo('test-file', test_file_content)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_layer_backups(layers_path, 1)
+
+        ## edit a file and try to make a commit; this should be rejected
+        with open(os.path.join(layer_path, 'local-modification'), 'w') as f:
+            f.write('locally-modified-again\n')
+        self.git('add .', cwd=layer_path)
+        with self.assertRaisesRegex(bb.process.ExecutionError, "making commits is restricted"):
+            self.git('commit -m "Adding a local modification"', cwd=layer_path)
+        test_file_content = "modified-again-and-again\n"
+        self.add_file_to_testrepo('test-file', test_file_content)
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        _check_layer_backups(layers_path, 2)
+
+        # check source overrides, local sources provided with symlinks, and custom setup dir name
         source_override_content = """
 {
     "sources": {
-- 
2.47.3


