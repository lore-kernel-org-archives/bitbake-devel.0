Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F275FC4332F
	for <webhook@archiver.kernel.org>; Mon, 21 Feb 2022 17:13:42 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web09.1385.1645463622065983835
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Feb 2022 09:13:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=S+p7T+PE;
 spf=pass (domain: gmail.com, ip: 209.85.128.46,
 mailfrom: rybczynska@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id
 k127-20020a1ca185000000b0037bc4be8713so13996221wme.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Feb 2022 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTBz+8+Fs7VNHFt+eDfxuTKvVZSrNIKzCoXJrd34DXA=;
        b=S+p7T+PEGiSsswRg5djAttAFnNMSmz6lSqYP0yDXXnqJCNrGkg6bTiAOBYaVA9bCxf
         LmoRGnVi9930tuPBksYydzpmml6If+bKkMO0Q+2jJWJbZ+tovSDZmy7n9H9pYtm875wO
         34rTjY+5FZvZYheRJqVHMBFx25qE8RieMr9DAaYmR9LjjFlNlTvyq5JGxol+e/ULNUQA
         VuR5mSVKimZfptE57cnCiTZvQtyCTbabpMhN/u/VaLAL6163o2FtTX9RPjMTVmToDpWX
         nhD7V1pk0sVQxvGYkuMdTJxdNNIpglPNFbKT2z6GnkHtnEAyp+TklW17OoL4izgWr7fr
         rr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qTBz+8+Fs7VNHFt+eDfxuTKvVZSrNIKzCoXJrd34DXA=;
        b=jCR9V7yN4xttvwMcCIdG+Puol52AR2GDULC9aj3tKfo3gsu5AFlnQGBhr9DNwkbN1D
         9PFv4rNoB73tqHgCEiuxuypnpBUaCtQFJPyeau5jH2MvXL2HHsOuOAMQxUa7yCMm3LEM
         zisChe8QDjGgd8SSX2oRnKyfDFoAQEvaZsGzqiqntgs8vsJYRBMDV73pbM6jofv5Odms
         Ed0haKmHoD248GM4yHy+ls38PZnss6+eLgBrP8rQv7jQg92KmgVxxWA4LYNiObBbJ+0G
         NL0WiVdpQOIxzOkjCmCkB4exzJFAdiAJuoqDHdeRY9K9mIoVDVPz72m/ZTrQKsq8NA3Y
         0i4g==
X-Gm-Message-State: AOAM533y/0Pxq8a8d09v+IGKNfL1O25XRhaOzi6szJi8kSnZ/ojiGLWd
	7v1r0PEpaHA8sJdTapqhZwI=
X-Google-Smtp-Source: 
 ABdhPJzdo5UOr/NtZ6z4v/3QY/CG1VhzJOSAF3kSex1MRdNZOFUzv/MZjAPO6ds9D6VY9dyiJegWXg==
X-Received: by 2002:a05:600c:20c7:b0:37b:b739:8177 with SMTP id
 y7-20020a05600c20c700b0037bb7398177mr18534316wmm.121.1645463620398;
        Mon, 21 Feb 2022 09:13:40 -0800 (PST)
Received: from localhost.localdomain ([80.215.234.23])
        by smtp.gmail.com with ESMTPSA id
 x7sm43542367wro.21.2022.02.21.09.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 09:13:39 -0800 (PST)
From: Marta Rybczynska <rybczynska@gmail.com>
To: richard.purdie@linuxfoundation.org,
	bitbake-devel@lists.openembedded.org
Cc: Marta Rybczynska <rybczynska@gmail.com>,
	Marta Rybczynska <marta.rybczynska@huawei.com>
Subject: [PATCH][master-next] lib/bb: fix exit when found renamed variables
Date: Mon, 21 Feb 2022 18:13:31 +0100
Message-Id: <20220221171331.6197-1-rybczynska@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Feb 2022 17:13:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13395

Until now, if a renamed variable was found, bitbake exited
immediately if it was in a class, but continued after an error
message if the variable was in a recipe. This was caused by
cookerdata.py CookerDataBuilder::parseBaseConfiguration checking
a different DataSmart instance than the variable was set in.
To solve the issue, add a special variable and set it when we
find a renamed variable. Check for it in ast.py and bail out
if needed.

Signed-off-by: Marta Rybczynska <marta.rybczynska@huawei.com>
---
 lib/bb/data_smart.py | 4 ++++
 lib/bb/parse/ast.py  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7b06d3a1..e7047d79 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -546,6 +546,8 @@ class DataSmart(MutableMapping):
         shortvar = var.split(":", 1)[0]
         if shortvar in self._var_renames:
             _print_rename_error(shortvar, loginfo, self._var_renames, fullvar=var)
+            # Mark that we have seen a renamed variable
+            self.setVar("_FAILPARSINGERRORHANDLED", True)
 
         self.expand_cache = {}
         parsing=False
@@ -737,6 +739,8 @@ class DataSmart(MutableMapping):
 
         if var in self._var_renames:
             _print_rename_error(var, loginfo, self._var_renames)
+            # Mark that we have seen a renamed variable
+            self.setVar("_FAILPARSINGERRORHANDLED", True)
 
         if 'op' not in loginfo:
             loginfo['op'] = "set"
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 31bcc8e7..c186a45e 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -333,6 +333,9 @@ def runAnonFuncs(d):
 def finalize(fn, d, variant = None):
     saved_handlers = bb.event.get_handlers().copy()
     try:
+        if d.getVar("_FAILPARSINGERRORHANDLED", False) == True:
+            bb.fatal ("Found renamed variables. Please fix them before trying again\n")
+
         for var in d.getVar('__BBHANDLERS', False) or []:
             # try to add the handler
             handlerfn = d.getVarFlag(var, "filename", False)
-- 
2.33.0


