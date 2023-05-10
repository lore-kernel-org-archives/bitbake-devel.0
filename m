Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B55C77B7D
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 20:35:11 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.28958.1683750902754688444
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 13:35:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=MhyRnHys;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so6900195e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683750901; x=1686342901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oz8E10udzWW3ta9IMumRo9b9Lan/sJKevLKY/L8mK2U=;
        b=MhyRnHysgIlmjFs2o7ZqkcLXyfU7vSBkbvy51xMO73ia38V5mYa/jGoFh5CHnNzUq1
         qjUhMEfEycovyrAaADrpmf/bPfKaLa8/zWhHF98SJWbFf0scyIL08cOnKTfq4PklEVD2
         7mkHQk4EuzkQm3vEWafCLKEGyMOTMs6BdqXWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750901; x=1686342901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oz8E10udzWW3ta9IMumRo9b9Lan/sJKevLKY/L8mK2U=;
        b=Qt+FOyV117Svnft9XeWcSH9SR20QnY+T8JEhlEfaxZjIkVZweoJLt0D1LPFbOeY1QM
         OBV94Qe9JaGXW6SjVD35aBoH8LaHfT9kEbqxdC5M7ph6FFINRDueUqsILcRa+jXYjjx5
         6nyoC00FcEZq+ApIXjCtaXl+/p3xMlnlQC8YQdAyyIwJEsCdud0IopUs+7rxkVR2ruob
         8RWcsO3Dm51RkahSHiZ180lVFhP5X1TdwKy9tCuwhyzRriMedt9jrd4L+87Neulg/2WS
         Ts30GoXdcXcuug4ozLeCUspUWPttBH86R2D4Rq9mdi+Ph99GwZ8EQCVjRWzoPng4gKdv
         88aw==
X-Gm-Message-State: AC+VfDzhmblKW1Ldk4ALwFpai6jkZlXjLr9Hn/50xC/rFfDXnyIQMX2Y
	YvlU5z8sTJsxN8kSnuHERYN1qHahGB88WIogNgQ=
X-Google-Smtp-Source: ACHHUZ4KUjQfjIwhhdwEuZTUfBnUh8sfjMNNScwLh/Lpphha1Clkw59JoS1k3Z3yUxmnAujK9MxPqQ==
X-Received: by 2002:a1c:7303:0:b0:3f1:6e88:5785 with SMTP id d3-20020a1c7303000000b003f16e885785mr13403970wmb.14.1683750900754;
        Wed, 10 May 2023 13:35:00 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b4cd:cc57:565e:2ba8])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c024a00b003f423dfc686sm11007398wmj.45.2023.05.10.13.35.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:35:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Fix/improve collections handling
Date: Wed, 10 May 2023 21:34:59 +0100
Message-Id: <20230510203459.1758249-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 20:35:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14780

Code changes for FILE_LAYERNAME exposed lifecycle issues around the collections
objection in Cooker which only appeared in devtool usage in eSDK. Move
the collections setup to an earlier stage after parsing compeltes to
avoid any kind of race around it.

Also stop overwriting the code variable in MatchFiles. Ultimately we
need to combine these codepaths but that is for another patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3e298c478b..0a21f1c2f8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -504,6 +504,9 @@ class BBCooker:
             self.recipecaches[mc] = bb.cache.CacheData(self.caches_array)
 
         self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
+        self.collections = {}
+        for mc in self.multiconfigs:
+            self.collections[mc] = CookerCollectFiles(self.bbfile_config_priorities, mc)
 
         self._parsecache_set(False)
 
@@ -1379,8 +1382,8 @@ class BBCooker:
         if bf.startswith("/") or bf.startswith("../"):
             bf = os.path.abspath(bf)
 
-        self.collections = {mc: CookerCollectFiles(self.bbfile_config_priorities, mc)}
-        filelist, masked, searchdirs = self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
+        collections = {mc: CookerCollectFiles(self.bbfile_config_priorities, mc)}
+        filelist, masked, searchdirs = collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -1678,13 +1681,10 @@ class BBCooker:
                 for dep in self.configuration.extra_assume_provided:
                     self.recipecaches[mc].ignored_dependencies.add(dep)
 
-            self.collections = {}
-
             mcfilelist = {}
             total_masked = 0
             searchdirs = set()
             for mc in self.multiconfigs:
-                self.collections[mc] = CookerCollectFiles(self.bbfile_config_priorities, mc)
                 (filelist, masked, search) = self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
 
                 mcfilelist[mc] = filelist
-- 
2.39.2


