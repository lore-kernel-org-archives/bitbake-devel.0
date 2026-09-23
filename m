Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA28C98302
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 17:06:46 +0000 (UTC)
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.461.1790183201551873772
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 10:06:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=eT3F9mvL;
 spf=pass (domain: snapchat.com, ip: 74.125.229.12, mailfrom: ecordonnier@snapchat.com)
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664dbe2dso501798eec.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 10:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1790183201; x=1790788001; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZNK8Br5IRFyuucnPZrZ4GNc+6+GsvHveYLMKBuUYitc=;
        b=eT3F9mvLQRTDTXZvoG3+S2NPZI0FlZNfP+CBI7gx6uxPtrwB3X3ep7xOxXoPhTcBD3
         7mrzOUmGXJvVWws/BrzNI6K01NTVP6me+H53YOs3Eq5e8uM/BUyGOsnNc7IfcH2ZOyg8
         gVJAa2KKLH5Jv1o62NO0F06BYi9N5UNftlWeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183201; x=1790788001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZNK8Br5IRFyuucnPZrZ4GNc+6+GsvHveYLMKBuUYitc=;
        b=RioooSiZG8JGwE9vK9wPKc+Xl+LyXe1lC2Fze9/LS9ZVj6t2NQ6saV9R1jWOBSRXTK
         2O97zAOUD2w5p/ucb0cpmwDHR1Um2hE4rQXxU7rh6HiPDECjVLbxd9wMqYJyiYLdrvY9
         eA4dbUIlKrYXqa1rpLFtLhgC0sH0pCcoRXaiy99ZVWfUOUY7THeA1cQtJHxARRLC3ojv
         ttIOgQzbZKrPkksZV0ucO+Pam643FbVsBLBpO4ONbc6rWHprtJzyP9sGLTtty3RiyF2p
         bEENBdsxmZD517dT3TTuOyx+aIa5Ds1soR+DeshT/HVh/82WikK0oFgyAiFnNt5b1y4W
         0FPg==
X-Gm-Message-State: AFuF++mcGLkoMYBBe+Y+BMXe0dzJbr2hHots8AVTwECJyRoVRF/duOhM
	q8a7HJY8pTY2u7WeKKpl/MlinESGgtKFVTAHM3uC8dzlYHKWgCjumwOLRRtC7uDaAFNF0zpyb0+
	75776tB4=
X-Gm-Gg: AYBFou2qgFLuZ9kzEFpzAB9Iz9cLRSgbt7yiazPk3V1znXuLXsS28ZvraBur+FOnncU
	vKBVJWXoX9bzhfwW6ragGwl0C26glZx23XTTdFTPr/pUqgYdQ40RX9v5LKm9zWwUk7gmR7V05aj
	MpoOljYcs0K7tWpbhJZuAoh2FLCaA9T5VulKIpyUPd+AA+Gx7gr5luwOMOPo1h0sPch+5AlMi+D
	YvEHKKGaVB9ATMWYPgnqe1oMWT+Zz5ppvajLoV2OyAE1YbF1gC990/g14txy+Q7bHjaHPgCWbpo
	13nsAuSobFGtU21CUES4ByXZlQEekzSP3Fb8kmc2Q5N02Q0av5WqysAiXjv1hgv5LZnxwPbilJw
	ceSjzf81k/npAMT4zQJkzz+uyH/zjTxRIVywDSAYAeCgOvkj4CMDVhwttcNwVP03DG37ulqTRmR
	skOKHImz3WhE3VPN2JUH0GXAO0FY81BBQR8bmNuEH/XDB9KYurvK+ixx77rZlYy2C+CE4oJATEL
	/2HlegR0cT21MLufq6e0eIkoDj7sD1ggDm6fb8JX1R2dM5AyIzp
X-Received: by 2002:a05:693c:80cb:b0:33c:43c:f3dd with SMTP id 5a478bee46e88-33e7c426a71mr2900669eec.11.1790183200416;
        Wed, 23 Sep 2026 10:06:40 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e972395f9sm6489295eec.30.2026.09.23.10.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:06:39 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] cache: Reuse os.path.exists() results during dependency validation
Date: Wed, 23 Sep 2026 19:06:33 +0200
Message-ID: <20260923170633.1313487-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 17:06:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20245

From: Etienne Cordonnier <ecordonnier@snap.com>

cacheValidUpdate() checks each recipe's file_checksums entries with
os.path.exists(). Many recipes reference the same optional class or
checksum candidate paths, so the same path is checked repeatedly within
one validation pass. In a warm parse of 5,112 recipes (poky, meta-yocto,
meta-oe, meta-python), the real cache data shows 585,348 such calls
against only 48,757 unique paths, with the hottest path checked 16,894
times: 536,591 calls are redundant. At 3.5us per os.path.exists() call on
a nonexistent path on this machine, that is about 1.9s of avoidable
syscall time per validation pass. Cache the result per Cache instance,
which is discarded and recreated at the start of each validation pass, so
a filesystem change between passes is still observed.

AI-Generated: Uses Claude Code (Claude Opus 5.5)
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/cache.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 2361c5684..01020f844 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -401,6 +401,8 @@ class Cache(object):
         self.clean = set()
         self.checked = set()
         self.depends_cache = {}
+        # os.path.exists() results for this validation pass (see file_exists())
+        self.exists_cache = {}
         self.data_fn = None
         self.cacheclean = True
         self.data_hash = data_hash
@@ -619,7 +621,8 @@ class Cache(object):
                     if not f:
                         continue
                     f, exist = f.rsplit(":", 1)
-                    if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
+                    file_exists = self.file_exists(f)
+                    if (exist == "True" and not file_exists) or (exist == "False" and file_exists):
                         self.logger.debug2("%s's file checksum list file %s changed",
                                              fn, f)
                         self.remove(fn)
@@ -657,6 +660,11 @@ class Cache(object):
         self.clean.add(fn)
         return True
 
+    def file_exists(self, fn):
+        if fn not in self.exists_cache:
+            self.exists_cache[fn] = os.path.exists(fn)
+        return self.exists_cache[fn]
+
     def remove(self, fn):
         """
         Remove a fn from the cache
-- 
2.43.0


