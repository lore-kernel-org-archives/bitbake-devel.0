Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686BCCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 17:38:50 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23483.1762882725052236229
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 09:38:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ehJsDpAw;
 spf=pass (domain: gmail.com, ip: 209.85.161.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-656b8900ac1so1785829eaf.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 09:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762882724; x=1763487524; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqvaLnjQKeSQBilliInh1s8VKWQyQePXLSHfzodLwUY=;
        b=ehJsDpAw/weXjB4f0mEKTfknBtlWczBr/wRtVkwh7SoCI5TCbobJ/wnu4GxAUNRcwJ
         TPXsY9ZQAGb4TWRnUc6k+TX9emH96Lfger2z4AU4NJiLyj2lwtGSYqLgrrSSUIDrE7HP
         ihaFmgCgtzvV8BDlRQow5kKWQo9+Js8bq9B3pbaSr6wr4K+lHveIx/3HihZmK000ay3Z
         JGRTf5RMggd7V5Ubq9ZLlKuOb1e0DwKa1WT8qIaiiOV51F91vZfdypyXPXa/BLsxTLCT
         VxGs2itHVmIsPoookr219Y80GDGIvdR66iqQMfFXJ9sxW5MlxPU1NlUBbJwKfzmZ0iUx
         n9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882724; x=1763487524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqvaLnjQKeSQBilliInh1s8VKWQyQePXLSHfzodLwUY=;
        b=oOjcDrnvtw/vsyVCsW/JundRgXmLiiDA/YqvNJiLIvn0DQ0Z1JxTPvDrgj9Zlf+0Qd
         MoHwm8U0Q9gvPrz6iRU9Sadv/NSSlBjVd2rVjFrA62G++BZ3rlvvkaC3rZZb2b23pweA
         SHbELW8uz6IxVO+zCXRMaViA+NCJnTCNN2nJffbHh4mWevWyErU0mb/S9W0I9TRrDdYc
         mFjLCs7KMEDBi+GhhToqtWZUbUrk/KrH6vpKzhHPWJrZpeQYJC2QldAZwPTJekfcy0SB
         xVoFtAxj4yR39TKh7HwmuYvCgfE8A3kGsFyyKAfmUn+iQFGbR14TfZCLd6mFkwdd5t1f
         Fz/g==
X-Gm-Message-State: AOJu0Yw5ZGz3CQVgDajFEMjD3iF0OS4X6fcItGlpGgH4UoisR1/xdH4u
	erjBkedTJtdv0sTlyhLdGo7PnCTwFHksE2EQ2yfYLNnFlEMUPIOMbAxJT4xRrA==
X-Gm-Gg: ASbGncsLmCTmFIU134pALXVVHsEOAQ2eDEfuwjhReCxOrA/ifZIbqXsuv3LwkhFL5ie
	2rRisd2a0DbcsL/WQMIXGeQ+IRmSN8fL/R0SHtNSe1zOda8pSs2POBKJMhLrFyTjEU8oppq8ujy
	hKWS1BuAtAH1TucLSJQDL5kjJQhjUR3eUQ5AnshebsqiCg1knaf7yPfmY3bWvd4wodmne2uTF8s
	nS7Y+o+Ib1Q5sQH5CluHPVY3lbhGJYXnfNF6GgJ9fRsueBohMTtWddlvc77WL/PehtwEZ7PQDPA
	z6GitVLLsAq02AMyytDYR0jGQfAigqupBDwZTJRTLZfY2Hjqvgvcu3edaxZF9Z0cz+5vkkuk1cD
	CIFIHwCEqHNqcE2L78EMwGS4R0ujJNslN9OYi2wR0ACMn991Ud/+7mSZ6suuNxLtNtO4ccwJ7yL
	czeF3Re48e
X-Google-Smtp-Source: AGHT+IFqcmVczqhJiQcrYf7OBV+86fCHhajDW0IqpAQrtA4eiZXqu5FtDpYCnEozwWiyfmFPUkgRsw==
X-Received: by 2002:a05:6820:2209:b0:638:3df8:c802 with SMTP id 006d021491bc7-656d9005bb5mr5902952eaf.5.1762882724131;
        Tue, 11 Nov 2025 09:38:44 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9115])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656e55853bfsm4104071eaf.10.2025.11.11.09.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:38:43 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-setup: Improve continue prompt
Date: Tue, 11 Nov 2025 10:38:41 -0700
Message-ID: <20251111173841.2842051-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 17:38:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18332

Reworks the prompt to continue with the setup wizard in a number of
ways:
 1) Default to 'Y' if the user just hits enter. In general, users are
    more likely to want to continue than they want to exit.
 2) The tools prints "Exiting" when the user doesn't want to continue,
    as a clear indication that the script exited without doing anything.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-setup | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 282fa82ff..9c6d787bf 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -134,6 +134,14 @@ def checkout_layers(layers, layerdir, d):
 
     return layers_fixed_revisions
 
+def prompt_continue(non_interactive):
+    if not non_interactive:
+        p = input('Continue? (Y/n): ')
+        if p and p.lower() != 'y':
+            print("Exiting")
+            exit()
+        print()
+
 def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
     def _setup_build_conf(layers, filerelative_layers, build_conf_dir):
         os.makedirs(build_conf_dir)
@@ -483,11 +491,7 @@ def init_config(top_dir, settings, args, d):
         return
 
     print("Initializing a setup directory in\n    {}".format(setupdir))
-    if not args.non_interactive:
-        y_or_n = input('Continue? (y/N): ')
-        if y_or_n != 'y':
-            exit()
-        print()
+    prompt_continue(args.non_interactive)
 
     os.makedirs(setupdir, exist_ok=True)
 
@@ -676,10 +680,7 @@ def create_siteconf(top_dir, non_interactive=True):
         print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
     else:
         print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
-        if not non_interactive:
-            y_or_n = input('Proceed? (y/N): ')
-            if y_or_n != 'y':
-                exit()
+        prompt_continue(non_interactive)
 
         os.makedirs(os.path.dirname(top_dir), exist_ok=True)
         with open(siteconfpath, 'w') as siteconffile:
-- 
2.51.1


