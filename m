Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0E0C5479D
	for <webhook@archiver.kernel.org>; Wed, 11 Jan 2023 22:38:13 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.39567.1673476692252145190
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jan 2023 14:38:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile-fr.20210112.gappssmtp.com header.s=20210112 header.b=OUPG18e1;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso15374438wms.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 14:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ayHvu3bdqLJp4A2P35ROw1Gdj6ztBDEUMgtgco920cU=;
        b=OUPG18e1iNo9LvpaOiUur6PCBInT3gG+yM7sM1Z6S/eK/49qwan7HAh1ABBifschww
         cuSvEwmz8bRrWr7bcqtKPpB5xouab03wRCRZFYwWhYFy18zwCljZYAUpAbbAqKVy7xDV
         BWciBA2gwZYSvU1vd4QqDFAGv7Y9gCQv2ksUJYIJUxq/Rj2mGWA2hQKUrXuD8+KcPGMR
         mwlX+GL6JzdB4WETgbWKMtgfzePGq1oYLc97JbDIemc+woh/GbYyS8y+UxyH7zKXKMUk
         gwd7mQCGY6TN/ywg9A+pF49YmFcwJxMcEv81WHRk0tCpheEMHPXJsvTJm/eUs81XwO1Q
         viLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayHvu3bdqLJp4A2P35ROw1Gdj6ztBDEUMgtgco920cU=;
        b=KvZ4lHzhfPe5GyUYLFxCZskZVULN2L59Cx2a2W9dz3zSI49GpfozYoEtew+1+lnNmh
         Yt86pxjg3qAEDPJgDYfLncF/6Ajo+oyqko9GjvWokfLG3VsuWf4pexydVFyC5j8b0WFu
         MYvIKIFIkNXnauMhRbuRbKPWV3d36GbxUWtfXWjBcZtpcuNmgRdPb0g2aaabWPldX8dr
         FSFwtNBAatVqND2ljzXNkBeT2pM06MkIHWDlf/wDF+4O62QljvEqVch4kEOa2UMKw1F6
         mh5b9x682CU68JVCUIqL9laWkZuIMjuUSEB2SBptxljQer0PMr9Ev/6zR22hCE5R2UXC
         z0og==
X-Gm-Message-State: AFqh2kq2gEWwzvir2l4Gzq2wRHrRAlum0WqV1ZdmDlvvMg8qndfSvXcC
	yAfAnW+KnUhY8sTHGDpUDCk9t3Azuic6KbOv
X-Google-Smtp-Source: AMrXdXt25WF2RKayO6t1e5LYoONrNnigGuB9u58Npal0C4scXL5fAJIdcenBU7khxiGHtMBYONtSjA==
X-Received: by 2002:a05:600c:1e24:b0:3d0:8643:caf1 with SMTP id ay36-20020a05600c1e2400b003d08643caf1mr54494358wmb.16.1673476690047;
        Wed, 11 Jan 2023 14:38:10 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.numericable.fr (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c71358a42dsm32694677wmq.18.2023.01.11.14.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:38:09 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] persist_data: Handle sqlite error when cachefile path is too long
Date: Wed, 11 Jan 2023 23:37:29 +0100
Message-Id: <20230111223729.3472181-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 22:38:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14305

Sqlite can't open the cachefile when its path is too long (>= 505 char by
my tests).

We do have a path length check in sanity.bbclass but this code is called
before sanity checks.

Treat the error in the exception instead of checking before hand in case
sqlite eventually fixes this.

Fixes [YOCTO #12374]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/persist_data.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index ce84a158..a027f912 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -249,4 +249,20 @@ def persist(domain, d):
 
     bb.utils.mkdirhier(cachedir)
     cachefile = os.path.join(cachedir, "bb_persist_data.sqlite3")
-    return SQLTable(cachefile, domain)
+
+    try:
+        return SQLTable(cachefile, domain)
+    except sqlite3.OperationalError:
+        # Sqlite fails to open database when its path is too long.
+        # After testing, 504 is the biggest path length that can be opened by
+        # sqlite.
+        # Note: This code is called before sanity.bbclass and its path length
+        # check
+        max_len = 504
+        if len(cachefile) > max_len:
+            logger.critical("The path of the cache file is too long "
+                    f"({len(cachefile)} chars > {max_len}) to be opened by sqlite! "
+                    f"Your cache file is \"{cachefile}\"")
+            sys.exit(1)
+        else:
+            raise
-- 
2.30.2


