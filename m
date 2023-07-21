Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869FFEB64DD
	for <webhook@archiver.kernel.org>; Fri, 21 Jul 2023 23:49:23 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.20762.1689983353312952569
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jul 2023 16:49:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=iN7dPW8r;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: belouargamohamed@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-317009c0f9aso2099527f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jul 2023 16:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689983351; x=1690588151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOtFjRRETpCMTzHUfQMF3BGNnatQQ6kv0N+tgjKroIk=;
        b=iN7dPW8rbETJNwKHtdsf65+eaOsERhZJbfG4JmoIouLdnMi2hcKBOHi7iIOXonJnFB
         iUG48V2Pa9EGZhE+3i6WK96hVQ/iO8KYin1PnpoF2Ir4yh0Dkj8aXc8Il5mRhCNlwNDG
         ACroRSdKaLBjQIMsWUmYL2q44MMI9kAU7PnxL2hyoASMhxe0JTUWSgk+8Zn6Jk5MW/i1
         JR8pMSR4ldKkVPoGhTNKfoyrtz1uyZX5TqzEL/gTJTe9TBs5NRMWddoGfkekfkpuSW6h
         e+cn095aSGzXQeizbpvAnVB0BnrSP5nCUsPzpD4ptzYtuMhc4w5+ikzRKcWGMgLopw1m
         LN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689983351; x=1690588151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOtFjRRETpCMTzHUfQMF3BGNnatQQ6kv0N+tgjKroIk=;
        b=dHOj3A1r982Na3PGvnb558ZVB/ZIQ/S1/RACt6NSm7lqopmHRwpH5pi4Mfn5DTiR03
         IbQbsgu9FNOpuMHcNtZfkCsQwsVEGMyj6sl6xs1BgCrA5fY76ogKnwnM+23cS0kU9HPB
         xuL2lz1Q0wspn46+nSYFnbuBAMe6qu/WiVdyGuxR4LNdb1aU1n4wbsK7+L0inylxZskw
         3BPdMmbsqd9MWHwWMVQyDN7GBF4eunUvKk8bEz8+Ns39y+L2IGLy/TIUMr3jKj/vgDXY
         0CNN0lYkgMbcTByqwqy9igEX6TrHZXPgVZIYEPGMQzmRkKd6IKna8vOF49YJKSF8iJ/D
         rVyw==
X-Gm-Message-State: ABy/qLYqXpqCXiOc6OIQTHRDFw1JhOAALEi0AjgLNDVtP6RS3ZKN8J3T
	x7BtJWSja/NmCCh1cxzZZrij1Ggm7Ag=
X-Google-Smtp-Source: APBJJlGXnOb5/ycbp0BjlVGjG9EfjH7r682b5yTER/zHSNN6GZT9myiSrFMgLIWLa3eJP1MKvw0nuw==
X-Received: by 2002:adf:f0d1:0:b0:315:a74c:f627 with SMTP id x17-20020adff0d1000000b00315a74cf627mr2456445wro.16.1689983351176;
        Fri, 21 Jul 2023 16:49:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:842a:2e:7001:1a4:aa35:84e9:ae9c])
        by smtp.gmail.com with ESMTPSA id q1-20020adfcd81000000b003140fff4f75sm218847wrj.17.2023.07.21.16.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 16:49:10 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [PATCH] fetch2:init check if path is none before calculating checksums
Date: Sat, 22 Jul 2023 01:49:07 +0200
Message-Id: <20230721234907.220309-1-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jul 2023 23:49:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14883

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

Add one more verification that checks if localpath is None, because
we can't compute checksum of a None.

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 lib/bb/fetch2/__init__.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 770021de16..f6e5d19627 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1402,6 +1402,9 @@ class FetchMethod(object):
         Is localpath something that can be represented by a checksum?
         """
 
+        # We cannot compute checksums for None
+        if urldata.localpath is None:
+            return False
         # We cannot compute checksums for directories
         if os.path.isdir(urldata.localpath):
             return False
-- 
2.25.1


