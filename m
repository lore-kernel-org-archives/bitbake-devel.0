Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471FFC433FE
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 11:32:07 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web12.10613.1645011122472814549
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ae7PqeL4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id q7so2894213wrc.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Feb 2022 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ij+CFMkEXOLBRZAsM07EfPSGEt2Tn8wIxhs86vjXXU=;
        b=Ae7PqeL4tSOZIFubzWXKcvsHZIhJ/ZiUhqonGrfCKb+tjVtKh/oUc5pYEuoasHan31
         Mz3gOIgcTgLTjQt7HgWH3tBtjtIkGvB7gw4sy4Auf95wxRil7mdBHgjwMwP6NnN192H8
         u3r1RzDRSAgjRZ+LKX/oSf2bghzTrgKMM/+v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ij+CFMkEXOLBRZAsM07EfPSGEt2Tn8wIxhs86vjXXU=;
        b=0PMHViu7AKXTwPlZ3aN3h2fdJu7D/Krs+2PeoWq9v6V/CFvaS/Xc+x/cK5l1Hu304T
         78bwEHp5aVIhhAtbBA2+cHuoCW73JJn3F1EJSv4q6YshyhadUFOweAkHQ12Y2CjhCpPj
         7dN0eQ3lp7gvzwWd/qj5r7KRhuZNDRXLGWqpBp0AlbKJ4mxq+s1HafxP64pVIx/w7AtB
         A8FMpqsWCVXKN+7O80MvXUIx+h9fVOcg4QEsjSpw5rVo6r8MqDrZUa1tltbty9035Z4c
         Qk6hsdGM4pD1CU5IP4mvZ0T+f01mG8EELEgGdD4SVp4tOCpyT7gsBn8ivhIIAOfyd3ya
         bSGw==
X-Gm-Message-State: AOAM531gg8auHI5iroAJAMd08UdRFImeE3c0K/t+Ur8Lt6QpjJvLU9bm
	MMyugSzIEzfxrjJDDbihhrbY1HvkMLcLDny8
X-Google-Smtp-Source: 
 ABdhPJzwv8CQXmNCaaI2inKxMp20sSTiQ84TB96zTDr9iGnl1cG2KiSIq02V4MF04KK/Y2ybA3X5Ug==
X-Received: by 2002:adf:e4c2:0:b0:1e3:3e5d:bd65 with SMTP id
 v2-20020adfe4c2000000b001e33e5dbd65mr2021891wrm.422.1645011120279;
        Wed, 16 Feb 2022 03:32:00 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a680:61af:4a53:1ad3])
        by smtp.gmail.com with ESMTPSA id
 x18sm35476238wrw.17.2022.02.16.03.31.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:31:59 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/5] data_smart: Fix overrides file/line message additions
Date: Wed, 16 Feb 2022 11:31:54 +0000
Message-Id: <20220216113158.2899964-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Feb 2022 11:32:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13351

The overrides warning message is meant to show filename and line
numbers but the variable names are incorrect and this wasn't working.
Fix it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 543372d153..242476be0e 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -494,10 +494,10 @@ class DataSmart(MutableMapping):
 
         if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
             info = "%s" % var
-            if "filename" in loginfo:
-                info += " file: %s" % loginfo[filename]
-            if "lineno" in loginfo:
-                info += " line: %s" % loginfo[lineno]
+            if "file" in loginfo:
+                info += " file: %s" % loginfo["file"]
+            if "line" in loginfo:
+                info += " line: %s" % loginfo["line"]
             bb.fatal("Variable %s contains an operation using the old override syntax. Please convert this layer/metadata before attempting to use with a newer bitbake." % info)
 
         self.expand_cache = {}
-- 
2.32.0


