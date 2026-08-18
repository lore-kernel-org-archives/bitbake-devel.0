Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2F5C5DF81
	for <webhook@archiver.kernel.org>; Tue, 18 Aug 2026 20:37:21 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18322.1787085435858531429
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Aug 2026 13:37:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GsxVqAj5;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954df200ddso2146085e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787085434; x=1787690234; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Zylrw1dC5qMoyJs98N4XztjFgTgYvZ6kU/gnP+Iz78=;
        b=GsxVqAj57lrbEaLWAiELBmVaflMf3qC29BeItadLUuQzHDRJs2ZGuIEPRvsM5e9Myr
         NfGhQJ0dWIQlo/aECc3YM1GrnEizuhxcJD94JTk5VuiZzS9XZ9uyQDO/CMIanLO7kZo9
         V9SSBuMLuz3nzNU474JMdpjvvJUHK9R0S2Yr5H6wWRi4k4qstGvXxoYQeSPBMY4J3dt/
         x5txpuVxo69t9zNGYeS7RqSVCeAy+oELmIE2cliDSsjibokwgCdDepafFIMPD95Fz8/8
         ayqbtzHbByRyyCZs1s7Au/tQJMEz+aCFGdaTMl/2jpi8ZLxunEBgYCq8BfykFwmscUum
         WVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085434; x=1787690234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Zylrw1dC5qMoyJs98N4XztjFgTgYvZ6kU/gnP+Iz78=;
        b=NxD2ZITAJPyXnjLW3VjYBtQrIo8m/xrVThDVVes+p5vvkIwGMDc7i5mpAyl+jMarOh
         I9RsHrWq3InolsD/tKm5UCPso0n/bd8fzp8VjnBWMQFhGKP0v9EddeTqvrcOBAYy8jI9
         gJLbEdkVAredDsA+Bn/Zaj4yWxXYx0roxP6AE/rYYY/Tu98DGeitmAQhCd+nKXzeIl+h
         fV//ubnCeLk+o5HOGlmrKnGaE4v1K92cEgevFBJ9rzuybrmWQ02ED2aH6Kb7OGqgwkUc
         fensIcZePRgwdE3ZM2ibzSKNZkA2xJN5oSrw2a2pfH/wvGELN7MozHhLIxszJIjr2aNM
         R4hA==
X-Gm-Message-State: AOJu0Yw/CQoK2idhV6fdH0ckx2kzeIgedDcaOc4uZ9A8KQrZN06q41Bk
	OfO9S0+KZ/00oQGrTf4PuT9ZRFJ4oQxqCv8nK4Yd0ePCtQEWcESGjoVPe4kq7MNF
X-Gm-Gg: AR+sD11EfguH6L2WZQQww8xk5ng+0IA94aGCGuQe0In+4cu6x6DijS/5UBe0ztLPiwI
	apeJNc94WFQivrkyv+W2QoBrtZIH1amVPUxZhCVXQI12uQ+SRJriB86mq0PioR4u89Vfc6w0ipG
	Nzzk5vCyZciLCqn2KCIKUXW/wy9U6j0SSNv9f/grc780o70WTRYfbuNMcmCiX7M3/tHexNBHGgG
	GFbhEX9dLGZ4MGnPdNSaV90MCo21dlDGL5YFQZCqgTZPbSfJxcybXbR3nfaoLef7774lONIL+06
	EOLGn7f5tMMfFF1SpLit9itnOsGLQ1WA90Sb1dGcH6Y9mKBDXQaT8QohbY5hniTy60jQW032jYI
	5IxLE4DMba00KWRKsV/WR5KnFxgeSgG/OrX+3zRlcbuzykGpFGlKYKuUEWV8YugZKbf8nGp/6cB
	e39xosh1Qd4VUBN71udmh7+tU4HF4l9XULz//xS95S9UpzcYWV/LjMobfizP8HxWzBaMDUKZT+J
	7IXaG8Zg4uSRYZcw1i6pbFxGxt91XEBCqFqdvWUVSkmpr6Q1tylQvmbbT8CeT3rpPZSvnaU3W33
	VlIt9jrYZhJrIz23cb1A1Uo9K5dVqyjvx/hz/if0800AvJPM/lJoYD+gNhP5kgyYpAnSpfHKt+7
	cOI9cJXLeoZRCuS4rObACaRI/X7pHgDaih9ZkvuM=
X-Received: by 2002:a05:600c:699a:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499a8fcfc6fmr11839785e9.9.1787085434000;
        Tue, 18 Aug 2026 13:37:14 -0700 (PDT)
Received: from localhost.localdomain (93-45-67-79.ip101.fastwebnet.it. [93.45.67.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm630565535e9.13.2026.08.18.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 13:37:13 -0700 (PDT)
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Subject: [PATCH] bitbake-setup: preserve VSCode extension recommendation
Date: Tue, 18 Aug 2026 22:36:58 +0200
Message-ID: <20260818203658.90975-1-giancarlo.cicellyn@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 20:37:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19986

configure_vscode() initializes the Yocto BitBake extension recommendation
when creating a new workspace. When an existing workspace is loaded, its
extensions section replaces that initial value, so the managed
recommendation can disappear.

Merge the managed recommendation into the existing recommendations while
preserving recommendations added by the user. Extend test_vscode to cover
both cases.

Tests:
  LC_ALL=C LANG=C bitbake-selftest bb.tests.setup

AI-Generated: Uses OpenAI ChatGPT
Signed-off-by: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
---
 bin/bitbake-setup     |  5 +++++
 lib/bb/tests/setup.py | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 34260139c..9e5f9b31c 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -716,6 +716,11 @@ def configure_vscode(setupdir, layerdir, builddir, init_script):
     else:
         logger.debug("configure_vscode: creating new workspace file: {}".format(workspace_file))
 
+    # Update extension recommendations
+    recommendations = workspace.setdefault("extensions", {}).setdefault("recommendations", [])
+    if "yocto-project.yocto-bitbake" not in recommendations:
+        recommendations.append("yocto-project.yocto-bitbake")
+
     # Update folders
     existing_folders = workspace.get("folders", [])
     new_folders = [{"name": "conf", "path": conf_path}]
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 53a07ee3a..0dfbd910e 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -644,6 +644,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # user-added folders and settings while still rewriting managed ones
         workspace['folders'].append({"name": "user-folder", "path": "user/custom"})
         workspace['settings']['my.user.setting'] = 'preserved'
+        workspace['extensions']['recommendations'] = ['user.example-extension']
         with open(workspace_file, 'w') as f:
             json.dump(workspace, f, indent=4)
 
@@ -658,6 +659,16 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                       "User-added folder was removed during update")
         self.assertIn('my.user.setting', updated['settings'],
                       "User-added setting was removed during update")
+        self.assertIn(
+            'yocto-project.yocto-bitbake',
+            updated.get('extensions', {}).get('recommendations', []),
+            "Managed BitBake extension recommendation was not restored during update"
+        )
+        self.assertIn(
+            'user.example-extension',
+            updated.get('extensions', {}).get('recommendations', []),
+            "User-added extension recommendation was removed during update"
+        )
 
         # update with a corrupt workspace file should log an error and leave it unchanged
         self.add_file_to_testrepo('test-file', 'updated-again\n')
-- 
2.43.0


