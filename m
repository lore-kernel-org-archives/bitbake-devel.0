Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BB2ECAAA1
	for <webhook@archiver.kernel.org>; Tue, 30 Aug 2022 15:59:35 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com
 [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web11.13613.1661875173122930249
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Aug 2022 08:59:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Kkw4vlvw;
 spf=pass (domain: gmail.com, ip: 209.85.160.46,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-11f11d932a8so9354110fac.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Aug 2022 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=J8/ZixhZ5EshZZCpGhBulB+7haYwSgXaZe3YHgTlNgg=;
        b=Kkw4vlvwSFo58Jd2baTnrZshvAaDOjY//yF45DLfSnjLz1j9rxRjNU1F20goWL6uNY
         jZGvdd8OwMetQQv+V0PD86+XCeAVU9o86Eplxil5FOHVnVdkrDOOXtyeWo6M7xkk2Q5u
         SRYxUhh2bCCA09Afkw3C8NOAyxK52hHm3nRYNjih8l7BDVLxIevEnfpgI3dfkyECsG8m
         R6ahoRAiFpNw5eVQ0aYfzngTV4AAXUT2jPRnC+SNq7ljMOzayjJSDT0netfa9Y0X/Q3M
         KyqUYFP6vU77RXSxqo29QlHAfmmDQTBMTjIgqDLjoHqjN3KhJP34sGdlfD/IU3+mjQyy
         iCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=J8/ZixhZ5EshZZCpGhBulB+7haYwSgXaZe3YHgTlNgg=;
        b=iRi+7jPd+aaDYNOiRVL7xD4ITPo41uwVV30avx1g2tjl87QC31tAVz/wZ7w03/yOTQ
         twMpWXRTayyx6Lz9Adkqk0ikxZsHL72VPoVnaVUrnMH72M9WDxup29AIUwvPmSFoCwgV
         ZQauWWSGMzhhF9rFcHl5LqDnq9t9ABS8P7U7dR+0aitrAhxGKRdupUS4c6bfx2GcwgS+
         H87vHwc4/3bTfyCmdlo3lRCBQwWyRTH1ry8QaUxmp8eypJr8cjPP5UDYy8HGd2WmBzvt
         ahEyhScdhber2CAL4pw5sZkvo+zl8G9QxpYSVDsgRtsvUDaa/EFe+IgmCXdoG/2rZBm3
         MJ0A==
X-Gm-Message-State: ACgBeo3L4fGTiL01maX8R4TJMaVTwFdiprrsHO1P745br9lHbSSHPtrz
	Yc/PcsZJy/7LlIbmj86TXr5vuJGDjCM=
X-Google-Smtp-Source: 
 AA6agR5xfRqZod3Mxr7g3DJsXvXXxSR16XTzHgz2lqY/+s3cOwN//ePIkkJQcXqn/0oPw66Fj/6Kbg==
X-Received: by 2002:a05:6870:c693:b0:11c:2a33:7fb4 with SMTP id
 cv19-20020a056870c69300b0011c2a337fb4mr10517877oab.116.1661875171977;
        Tue, 30 Aug 2022 08:59:31 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id
 y4-20020a544d84000000b00342fedaf7d9sm6238790oix.43.2022.08.30.08.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:59:30 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] utils: Pass lock argument in fileslocked
Date: Tue, 30 Aug 2022 10:59:09 -0500
Message-Id: <20220830155909.662089-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Aug 2022 15:59:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13946

Pass additional arguments in the fileslocked() context manager to the
underlying lockfile() function. This allows the context manager to be
used for any types of locks (non-blocking, shared, etc.) that the
lockfile() function supports.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/utils.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index b8b90df8d3..92d44c5260 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -431,12 +431,14 @@ def better_eval(source, locals, extraglobals = None):
     return eval(source, ctx, locals)
 
 @contextmanager
-def fileslocked(files):
+def fileslocked(files, *args, **kwargs):
     """Context manager for locking and unlocking file locks."""
     locks = []
     if files:
         for lockfile in files:
-            locks.append(bb.utils.lockfile(lockfile))
+            l = bb.utils.lockfile(lockfile, *args, **kwargs)
+            if l is not None:
+                locks.append(l)
 
     try:
         yield
-- 
2.33.0


