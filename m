Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B1C43334
	for <webhook@archiver.kernel.org>; Wed,  1 Jun 2022 18:22:45 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.1528.1654107762532212830
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jun 2022 11:22:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZJepdSBO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id k16so3473936wrg.7
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Jun 2022 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vuDqOGGBcJe8glsvpoBDAvoSKsBQ4DL1lfZh0bI+GSI=;
        b=ZJepdSBOKtK8jisuIBmY3sV1PsY6/ymicovi4NgAbf5u+wQzattwAI6TK8amO28C0o
         HMOe/8QT0oIC/s4EFan3+OOCdLiaAnxrY9sKmItWgr160CjWaUPAlWsqhkldJds37MXP
         U2VunPzCQAFHcbbkKD/p7IL4kaI3Gyvy0haY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuDqOGGBcJe8glsvpoBDAvoSKsBQ4DL1lfZh0bI+GSI=;
        b=ZgdfoWst4kwk3a8UlAuG0HqcqdG7cLV4A0UmIAmIGGS/VOq/nqYqEmO/5unTzkGICT
         1WMgVLyARXOOLl74PoQTJOjfz7r7KaX9PHlvG+Lajao8EPQ5KePXMIrTCrd64sz0cz6I
         RpsQRi6e6STQIC0XmC6hBdeNUFBuPCtBcQ/dS0GDKdVj9BFVtOrSFazyfjfhAZFypHcd
         w0TVW3eOosLKs6i/UXTKUQaAmt++iTXAlVJaratP7RWP204zdjc3mRQQOnxlnLXcKaMC
         39dDXdJyXlrpgl3cSWNct31t6WCFt2/IMqsjMboHQAWk7mdRarPWbrvN/5/qAUzgpi/F
         4wBg==
X-Gm-Message-State: AOAM532Jt62p+o6F6Qp3ajst/TPeeY8bGqt+NZJ1hvARxGSND8nLzCyP
	C89wROHYCAUqZgcTiIKH3K+UQC8zVQ1wqKPu
X-Google-Smtp-Source: 
 ABdhPJyCHyArgW/P3A6vRtsiEBFrejMQETB9WY2hcEKoYA0YyHNj1QyzdUeHazi/x3qTsLWvGsoi2A==
X-Received: by 2002:adf:f1cb:0:b0:210:a2a:51ec with SMTP id
 z11-20020adff1cb000000b002100a2a51ecmr588451wro.294.1654107760815;
        Wed, 01 Jun 2022 11:22:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:eab:cafb:b8d4:fe67])
        by smtp.gmail.com with ESMTPSA id
 l14-20020a05600c2cce00b0039751bb8c62sm6665150wmc.24.2022.06.01.11.22.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:22:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] cache/siggen: Add unihash cache copy function
Date: Wed,  1 Jun 2022 19:22:38 +0100
Message-Id: <20220601182239.103588-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220601182239.103588-1-richard.purdie@linuxfoundation.org>
References: <20220601182239.103588-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Jun 2022 18:22:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13726

We see rare failures in eSDK generation with zero sized unihash cache files. This is
almost certainly due to races in the cache file being updated. Add a copy function
where the cache file can be copied with the lock held to avoid this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py  | 9 +++++++++
 lib/bb/siggen.py | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 92e9a3ced7..988c596c39 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -24,6 +24,7 @@ from collections.abc import Mapping
 import bb.utils
 from bb import PrefixLoggerAdapter
 import re
+import shutil
 
 logger = logging.getLogger("BitBake.Cache")
 
@@ -998,3 +999,11 @@ class SimpleCache(object):
             p.dump([data, self.cacheversion])
 
         bb.utils.unlockfile(glf)
+
+    def copyfile(self, target):
+        if not self.cachefile:
+            return
+
+        glf = bb.utils.lockfile(self.cachefile + ".lock")
+        shutil.copy(self.cachefile, target)
+        bb.utils.unlockfile(glf)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 08eca7860e..3f3d6df54d 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -120,6 +120,9 @@ class SignatureGenerator(object):
     def save_unitaskhashes(self):
         return
 
+    def copy_unitaskhashes(self, targetdir):
+        return
+
     def set_setscene_tasks(self, setscene_tasks):
         return
 
@@ -358,6 +361,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
     def save_unitaskhashes(self):
         self.unihash_cache.save(self.unitaskhashes)
 
+    def copy_unitaskhashes(self, targetdir):
+        self.unihash_cache.copyfile(targetdir)
+
     def dump_sigtask(self, fn, task, stampbase, runtime):
 
         tid = fn + ":" + task
-- 
2.34.1


