Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E5ECDC193
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:10:49 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88566.1767701440533429038
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 04:10:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KnSoI7mX;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79af62d36bso167515866b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767701439; x=1768306239; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fyBMAVpfir80Ys8d/2wX4ZB348IoLKcdz93a8jKvew=;
        b=KnSoI7mX15hIEaH5YkADknm2igFyRhHCgioKpy7CemuYP6MJLI0n+bX9naHO464deu
         hzsTm+KcWzpYcLBsZyjtVH9mINS0ApHyFDAMVcS/ra7oedJh0hnUPb4c0EYsK/wgzxJl
         rnGe1I6E4FiqpjfWXhg+l/M0US+VZhsjjMo0Mol1vBMnpvAY9jNsYEJn1OhqJQuWGOEK
         gkhLok2m31ePLHtAxvBjvJAEw6VZ6dIcjYO6+33JtPenZTHIePdfCFm43JIYO2NZMHNc
         xcWED2QAyzL4eulXXEt3RA3nD4K2vWk6/YYfg1WZld4YitBBYg1tmWWnuEHv/WfGPZtB
         pDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767701439; x=1768306239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fyBMAVpfir80Ys8d/2wX4ZB348IoLKcdz93a8jKvew=;
        b=T9EYPWHOThbX8NoPDlHHQ8LbgXqf85mhSzMd2XXLSqlCKrer8QC06r9p7wIWBHaeha
         N1oS1CGeqEqo8kHimsS5VNCsVOaKVrVyVSmQPo29xiTiUSBlgpx5g/mBPUBSxvs4DUTF
         mJ3QYcT0VUaN/qDOwzetHltZ7EbE0TJy4BSdiONgWX3TZo1393QSAMl1VvkaEACvwZcP
         UPH2LwyJF9CUzizAQYekC8gBbzYIFxIBd/dJxEUPmo0SXlX9qeBoOEFloru5lB3XqB9I
         6Rjk8tXuzLUPUxr6/KYWg3rKUyoqoHpAhNwCyj/r5dJsblMtXhtTg0rWwHTu2xhmHvQx
         zQlQ==
X-Gm-Message-State: AOJu0Yz8IgLrT8eqXt8rWb59xXrecbx5/YiskTtn5c4dhnSVEvN1+EVo
	ltH12TTrafLldBzg0u3WczICnGJWi+aTrmhMCE68ldYUAR7MED30QxSI0nN+CA==
X-Gm-Gg: AY/fxX7xmwiQc9U7/yEHk2llf6DtfsclHuhxNKwr0vNEXNztuoRa1F0JHLGJzDQQ+rm
	qqB2k1Qx+wVxFzUs8yTdSeXGO7rQs9bLh1z5mlQZysDSTetUCR1cCPUpunbomp+KDsGblOzdtsM
	kbalnPNfQfFhZHm6JZdKa3LxJus9wlXbDyqwA0uqvMncYTG9aHfDXr9e/yZdA5Sg0UrZXllEcps
	cg+bbBUkpKf6ueVXWW51kb9SSsMI/lzscXgaCYBy7YEBereV3BaNJJd7+aoXffDevbM4k1PVd/B
	aNqzvUBHSYiPgX3kc9WSJy/RldasvNnHm2xwcbhxIaRW8aLFYLtHOPkn40G4ncle+UznnPnpHA/
	Hsoxncq3kqK7aa0vKby4ssmyxJ8/R0/aE2tq1d5nPqYCRr+BrssWuzGBOP+mGJ7YaVuqsJQVTz4
	7OgZfOjZzLIOMxRYvwXjQdN2a+OeQJcLo3AWfroQmE+apaxyg=
X-Google-Smtp-Source: AGHT+IHP9K8w6Z26WbNdh+FCgMJ2RGXzjDgBVWgBnyCepFNsQnxV3F/Dfalrie/aTCn3VHBj3IYsYQ==
X-Received: by 2002:a17:906:f59c:b0:b77:1a33:1669 with SMTP id a640c23a62f3a-b8426c1d5b2mr366593066b.57.1767701438524;
        Tue, 06 Jan 2026 04:10:38 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8429fdf4e7sm223329466b.0.2026.01.06.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:10:38 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 03/10] bitbake-setup: test after every update that config hasn't changed
Date: Tue,  6 Jan 2026 13:10:25 +0100
Message-ID: <20260106121033.3892596-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106121033.3892596-1-alex.kanavin@gmail.com>
References: <20260106121033.3892596-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 12:10:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18693

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


