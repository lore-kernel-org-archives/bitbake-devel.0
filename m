Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D18D47CB8
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 09:57:55 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2733.1768557470908880003
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 01:57:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Uv1A7DdA;
 spf=pass (domain: gmail.com, ip: 209.85.128.65, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso12303385e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768557469; x=1769162269; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir2We5/8Ng2FizPwS33i9YGV05UtC5e7zDzPXTqwmIU=;
        b=Uv1A7DdAMvxTR8Q5ctTdCZPStNrQ82sqXZ5VQOgrnS9YP0nani/YB7kfbx7t982uib
         u+v8WAZWJ+6OkJmwOXImRBNcD/FHtrjr9b3a5faEFbPIwpPIcgqhr0J2E25ko2rFBubJ
         ok+CLX2qMZCvU9OwNd1ZaCNusmk4HwuJNiLN5Qg0Gca9X5JSCmtmMOOILQlhZUWkP/Bm
         d3ClQZU/2CxMj/ODjoDXJJr3doXgnchiWg+aSlaDe6ffttQF12WBApB7GspgMqDfu8DP
         VIT4Q+fhDUFkP+BhoNQ7pFx5Z/1eGHDie+MshLjE7Q4ZhrZHVHrhnHdKYBYAmTRemq8P
         jiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768557469; x=1769162269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ir2We5/8Ng2FizPwS33i9YGV05UtC5e7zDzPXTqwmIU=;
        b=wD6YuFHFO2LluZ5nLwK2FS+7QWnmg0jkd0Mcv+3wdXIrE9LAAwM7Ff7GflrI2Q79x9
         fYSlD43e3e9qFOAZfVllVUeZ+SZlg1WEFGJdIHYhpyQ01wJeKUIweR7IQX6CPkrNvYM7
         eS0Oah7Kc6yxjKm3ATFZGkXJW/L7lYmaaQqCIsxhFDhAm5cNgAOohDtbHmbV5SjQTIn6
         jD+U94wdDz313s5mhaHkuhJB2eR4QmmQL18ClAd3sLuldWUN50Ar1PvJq2N8d7XKkVu5
         Hrr5zbc5bmpqv/k0XIgCJlEfwAuSB1A6akHZ5djaRvNw5ImFuZB8c2uvQHUWkcH26yTE
         9D2A==
X-Gm-Message-State: AOJu0YyspsOJiJ+NVnZCUyoy6edVLXuBuS94Qt7ohGEpt28rTvwsdf3u
	EPQEWliYlZ/VcPHjiGb8ciUgnjy8lAmttvnYasuuH89mNeUrXIuInfYFxtgfpAbRhs8=
X-Gm-Gg: AY/fxX7g1KCCxUwm2FCPkjvuBZYARF1O3MynE6xgjrncsgGBvOQWEc6eaHiIlstFVl8
	xYS+KSwvhOQom0wljTRvFkzaPeUHHC2SgJLPvhP1nY/wIMIAZJDq4YgZSxjWDBXR9y+dO74TcA4
	StOBhYP5+bI8wctEX7IjvBkC5nK8PxUHdi/PiSdllC8AhJd0lOXu5JkDp6pyx6Zo3FHfhdQX05I
	H52GQS85Ir7RGbxF/GMZI5shoQn/YUf4DeRNnRbgep/nFJcoDUdZ5D1opRHptNvMtAyjUshtbaf
	6ks9SXfihYSPFr2DnhLBHA5qv8Wk6pSRMyWquXCNg+1tokl9FCagOLVEutocZlkuJ7RrYMkH7a+
	wf5UQAzJL5KKNnVMb4XrW4tiYo8geB0iIQ3CWrRBxsU4sUIIV3RTE5+h2vsKj3hsWngOcVlnhtP
	OD43TaVKelrBbtfhZl7ehPS7BBdqxkp3VekAgGpFh/uVafxIw=
X-Received: by 2002:a05:600c:35d2:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-4801e33a871mr36135705e9.17.1768557468923;
        Fri, 16 Jan 2026 01:57:48 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c1b2sm34188175e9.3.2026.01.16.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 01:57:48 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/7] bitbake-setup: do not print a premature notice about renaming bitbake configuration
Date: Fri, 16 Jan 2026 10:57:36 +0100
Message-ID: <20260116095741.3654153-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116095741.3654153-1-alex.kanavin@gmail.com>
References: <20260116095741.3654153-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 09:57:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18794

From: Alexander Kanavin <alex@linutronix.de>

This was done before setting up a new bitbake configuration, so that
it does not write over the old one, comparing the old and the new
bitbake configurations, and taking one of three possible actions:

- no changes, no need to keep a backup;
- changes exist, do not replace existing config
- changes exist, replace existing config.

All three options correctly print the eventual outcome,
so this early print is unnecessary and confusing.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 1 -
 lib/bb/tests/setup.py | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b61436272..8b5cb37ba 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -309,7 +309,6 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
     if os.path.exists(bitbake_confdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
-        logger.info("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
 
     if layers:
         filerelative_layers = bitbake_config.get("bb-layers-file-relative") or []
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 834d09854..802f017fb 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -362,7 +362,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
             out = self.runbbsetup("update --update-bb-conf='yes'")
             if c in ('gadget', 'gizmo'):
-                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
+                self.assertIn("Leaving the previous configuration in {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
             self.check_setupdir_files(setuppath, test_file_content)
 
@@ -386,7 +386,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertIn('-                    "rev": "master"\n+                    "rev": "another-branch"', out[0])
             out = self.runbbsetup("update --update-bb-conf='yes'")
             if c in ('gadget', 'gizmo'):
-                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
+                self.assertIn("Leaving the previous configuration in {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
             self.check_setupdir_files(setuppath, test_file_content)
 
-- 
2.47.3


