Return-Path: <alex.kiernan@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB5C433EF
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 07:06:50 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web12.7494.1654758410016501341
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 00:06:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=kzdxh2nQ;
 spf=pass (domain: gmail.com, ip: 209.85.218.51,
 mailfrom: alex.kiernan@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id h23so34556664ejj.12
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jun 2022 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RsjzvOsd/9Vh2f6un0+sV+C/XMc0+PjCJLjqM1Ctd0w=;
        b=kzdxh2nQm3DTF9bQLmagJtXY1HLfmWdPEtK7+Op8lld7KhaHV2GmxU3FWA1WddoE9A
         8cUeTwRzy3xsYJqJPjtG1SkdVYsSKaMfciv92NOroAkaUvvKEnH87UV1OnE2UsvibrXt
         sY8jr+eTqdig3ngHV3Df0RIrznp3McgKGtFnc9EsxNs9qG62bjk0szY4iw8v2qWCvM9K
         mZCIf7g4U31WKdVu108vGaouAr9qcl93unMF7XQFH9jUw7kmWZ9eka4ddtNl2ehw43U0
         B6/kZS2StGVirU6NH13GFZvbfRSG95qiWM6AM/5ZrH+POao2oLaFOH8YHOtBZYpDyoi+
         kh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RsjzvOsd/9Vh2f6un0+sV+C/XMc0+PjCJLjqM1Ctd0w=;
        b=hlSL12v0nGZSrjkB9TtKPqO9YsVIS3d/KTEV+a3lGyhDvrsVK21Rz5JPP4xhOVx/zk
         nudMiGC3IJK2Ln/KocAuL1EZZL+vf9yI9xNj9ozJOMDw9LAoc5p8z5TQkpQpZg9nj7Nq
         JpGSFeyRlwAKjQefj5U4SVre5u4LM4eloYiPNnpGC1IbYZbIwlV0pF/Z7cFP7B/Q6k4K
         OfaIbTyyjVbBhhRCjZdaKpXeOS3PLtPTvv7YOb5c6fi4nJHpWDkEYcUyt5Ivy6jgYR3k
         9kX4QvGVNRnoSdl4Fw3XuzQihxwdccXG7j16ZTklxXtpoqH8crW8xw80M3/d+zMs8By1
         gMoA==
X-Gm-Message-State: AOAM530nztDFNHsBuiD73ufoZ4P1R4a9p0aVx/zlhcpCYzxe7Yx25Zwx
	1VkrosM6FfdaJP72/0ycuPVLLqBWcN4=
X-Google-Smtp-Source: 
 ABdhPJyNfUjr+VOpqzbDiv9yfLMZGKE04JSR7h3yTu5I945bnpGKvnG2vJc5GoT3IAqG7KipnHu+cg==
X-Received: by 2002:a17:907:3ea9:b0:6fe:b416:fe20 with SMTP id
 hs41-20020a1709073ea900b006feb416fe20mr35014112ejc.358.1654758408089;
        Thu, 09 Jun 2022 00:06:48 -0700 (PDT)
Received: from localhost.localdomain (cust246-dsl91-135-6.idnet.net.
 [91.135.6.246])
        by smtp.gmail.com with ESMTPSA id
 t6-20020a170906948600b006fed062c68esm10169248ejx.182.2022.06.09.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:06:47 -0700 (PDT)
From: Alex Kiernan <alex.kiernan@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alex Kiernan <alex.kiernan@gmail.com>,
	otavio.salvador@ossystems.com.br,
	Alex Kiernan <alexk@zuma.ai>
Subject: [PATCH] data_smart: Pass flags through variable rename
Date: Thu,  9 Jun 2022 08:06:31 +0100
Message-Id: <20220609070631.23346-1-alex.kiernan@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jun 2022 07:06:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13745

During variable expansion, the flags are not passed through but are
discarded which makes constructs such as:

  ALTERNATIVE_TARGET:${PN}-foo[name] = "value"

fail.

This was previously attempted in 2013:

  https://lists.openembedded.org/g/bitbake-devel/message/3333

It's unclear what the issue called out last time was:

> I think this does not work for all cases but I don't know how to deal
> properly with it. It fixes the case of updates-alternative but breaks
> other code.

  https://lists.openembedded.org/g/bitbake-devel/message/3334

But this code now passes both oe-selftest and bitbake-selftest.

Cc: otavio.salvador@ossystems.com.br
Signed-off-by: Alex Kiernan <alex.kiernan@gmail.com>
Signed-off-by: Alex Kiernan <alexk@zuma.ai>
---
 lib/bb/data_smart.py | 12 +++++++-----
 lib/bb/tests/data.py |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index dd20ca557ee2..308f8eab4913 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -675,13 +675,15 @@ class DataSmart(MutableMapping):
 
         srcflags = self.getVarFlags(key, False, True) or {}
         for i in srcflags:
-            if i not in (__setvar_keyword__):
+            if i == "_content":
                 continue
             src = srcflags[i]
-
-            dest = self.getVarFlag(newkey, i, False) or []
-            dest.extend(src)
-            self.setVarFlag(newkey, i, dest, ignore=True)
+            if i in (__setvar_keyword__):
+                dest = self.getVarFlag(newkey, i, False) or []
+                dest.extend(src)
+                self.setVarFlag(newkey, i, dest, ignore=True)
+            else:
+                self.setVarFlag(newkey, i, src, ignore=True)
 
         if key in self.overridedata:
             self.overridedata[newkey] = []
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index e667c7c7d359..5cdf1494f3c4 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -440,6 +440,10 @@ class TestFlags(unittest.TestCase):
         self.assertEqual(self.d.getVarFlag("foo", "flag1", False), "value of flag1")
         self.assertEqual(self.d.getVarFlag("foo", "flag2", False), None)
 
+    def test_renameflag(self):
+        self.d.renameVar("foo", "bar")
+        self.assertEqual(self.d.getVarFlag("bar", "flag1", False), "value of flag1")
+
 
 class Contains(unittest.TestCase):
     def setUp(self):
-- 
2.35.1


