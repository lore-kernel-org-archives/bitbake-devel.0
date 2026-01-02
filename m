Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8355FA3753
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 19:34:50 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11801.1767382489209437185
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Jan 2026 11:34:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z9sQT3PD;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64b9b0b4d5dso20998674a12.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 11:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767382487; x=1767987287; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fyBMAVpfir80Ys8d/2wX4ZB348IoLKcdz93a8jKvew=;
        b=Z9sQT3PDwju9I8/KA7aRzPzW3a6d/zTRFVlNuDJEh0wRHiYKwXhDoJwjJ4T6ljD1ro
         uca1Qp+sqiyExDxRF9TmuLuBmdp9w8cz3xwLBvz2BVQDhlY0q/lcgSscUnRraDq5Ntkn
         Kgvkr4GEfM1w3U3hA890kqj/rXPoorXyZPGpwIi8XB4Yc6Fn3gXTrgAGMCkKEso6D8vX
         q3l06McxLagm8J2qnrMUDDV6Orf4+0qOD3DvORQbP0ABg8xoKT3yCR3S8/V6xFVta2Rj
         u5gEAMHimCdDGKkphwPaRavo2G6+909dI+hn+i4lt3TKJ/DCjY7zmimJvpPVCfv6huGD
         /ozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767382487; x=1767987287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fyBMAVpfir80Ys8d/2wX4ZB348IoLKcdz93a8jKvew=;
        b=mVIjzc53Y9k/jdORzyq/0R5XdxBjemeqbmvFmpIGRDDv62q2jsQQr/c+yjRSjUIcwj
         OBw3FgIgFcDa6KA6iNIGoyFBBKN8jvxyFqorccblyB1k+kcvqD68VNqKj87aPh2r7CCp
         ehv7DDsekO8Y8HtLPbmnueaWtLkLtOjtPBKUALdLDOCUZrhY+C4pObt+q9ZYYkCfYp6o
         7MYMzG/lqigXT0k/b0hrbul6P/lqMDr+euP4Etmlg3hfaywX4dwcFBQzHFW7Q3HD9l9r
         mj9mk1mDH23tE7agO/ow0QyWWLFwpuQmOauRu4oOhLXeVOELANzeAflIaIqPRtLHFP2+
         MjaQ==
X-Gm-Message-State: AOJu0YzzJ6Y/GS/3FEgy7wWzVjfA3XduyWxWDY7PxTOeUKAVPPuaP/ob
	mrr5u9LnFyKrjt1ueUvxtV03om4c7I64tzXG3blXU9sbSIW3PpghJzHFioSu/Q==
X-Gm-Gg: AY/fxX65oSpHN7bUcXFwnC2uI02IRtBRjNZGUtWPwqYcObOYrO0rv49s8kSqbNajZBk
	i15rDP7nC5KBFxLTC2OM6pzkVW3xzZr5ZWrJiS00w5DbM0ZIrLi5KfNwzIRUWhOT0uTmHogXjPZ
	qLf6IAYarp1GuTydry0wBaQuDYFYs0VOxhOmU0k8EOplS5Wjk4cTtEEitqN6W1vuvtqC2C0w9Zi
	NzVMDm0uDjHBTFKsGAwYwW2yQbKRutrPvUvCGEKPEeRxABoab5zSzC7MiMNYaNM/8R/GOR5kQus
	2upA+yZt9DW8645Dl6Nxor19ffqv6prgCcZ7IXZwe5PKqpj7Rj2Y5hL7aIiqE373UzhY4OIO9Zu
	IifKfdVKUtXKvhfdqyCDXFUWYlX2NMACH8rTCCjrmaWcZHjkow55hVp+B2E11+B4ngksyJ6ZiFv
	U/S1tLlRJRrJwbTBgw32nK+kLdkcRsConXZFRJ88bHnH7F/a8=
X-Google-Smtp-Source: AGHT+IGGlZctVEygRsV6hj8xDJ1dbfj60suJXudEMr3Pj8T+tbNgKg9C85+ucmhi9n5ytYqL425PfA==
X-Received: by 2002:a17:906:6a17:b0:b77:1d75:8b78 with SMTP id a640c23a62f3a-b8037180282mr4815537866b.53.1767382487307;
        Fri, 02 Jan 2026 11:34:47 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11e5sm4645615866b.39.2026.01.02.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 11:34:46 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 03/10] bitbake-setup: test after every update that config hasn't changed
Date: Fri,  2 Jan 2026 20:34:30 +0100
Message-ID: <20260102193438.2960561-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102193438.2960561-1-alex.kanavin@gmail.com>
References: <20260102193438.2960561-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Jan 2026 19:34:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18673

From: Alexander Kanavin <alex@linutronix.de>

This would catch situations where update hasn't run through to
completion even though bitbake-setup finished without error,
such as the one fixed in the previous commit.

Also unset BBPATH from environment so that it doesn't leak out
of the function where it's used. Adjust buildtools test to pass
setup dir explicitly, as it was previously relying on BBPATH being set.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/tests/setup.py | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ad09913f4..55e9e50ec 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -180,6 +180,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('add {}'.format(name), cwd=self.testrepopath)
         self.git('commit -m "Adding {}"'.format(name), cwd=self.testrepopath)
 
+    def config_is_unchanged(self, setuppath):
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("status")
+        self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
+        out = self.runbbsetup("update --update-bb-conf='yes'")
+        self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
+        del os.environ['BBPATH']
+
     def check_setupdir_files(self, setuppath, test_file_content):
         with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
             config_upstream = json.load(f)
@@ -228,6 +236,8 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertTrue('BUILD_SERVER' in init_build_env)
             # a more throrough test could be to initialize a bitbake build-env, export FOO to the shell environment, set the env-passthrough on it and finally check against 'bitbake-getvar FOO'
 
+        self.config_is_unchanged(setuppath)
+
     def get_setup_path(self, cf, c):
         if c == 'gizmo':
             return os.path.join(self.tempdir, 'bitbake-builds', 'this-is-a-custom-gizmo-build')
@@ -314,14 +324,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
                 setuppath = self.get_setup_path(cf, c)
                 self.check_setupdir_files(setuppath, test_file_content)
-                os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-                out = self.runbbsetup("status")
-                self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
-                out = self.runbbsetup("update --update-bb-conf='yes'")
-                self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
 
         # install buildtools
-        out = self.runbbsetup("install-buildtools")
+        out = self.runbbsetup("install-buildtools --setup-dir {}".format(setuppath))
         self.assertIn("Buildtools installed into", out[0])
         self.assertTrue(os.path.exists(os.path.join(setuppath, 'buildtools')))
 
-- 
2.47.3


