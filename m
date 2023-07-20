Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F53EB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 23:41:34 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.420.1689896485531039320
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jul 2023 16:41:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=gNZonH5r;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: belouargamohamed@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-31297125334so872750f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Jul 2023 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689896483; x=1690501283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuakzeXbVQU41VvxHXSVvnt8OnYSlNwqjdfqQZot6oA=;
        b=gNZonH5rqUGuGL3wc+jiYfrRnNFknXxzA7o8g0QBQF0desMdJWtS9IDc63/GXl7h4q
         x5JezyNCNAMnu02feIEihAirSzLePCDrxxHmWfevsMaf1IjPABnJxrAw+x9zpJbQ0gi/
         QWMrbh4lvR4ZeqBKYKU1c8d7A9R2WDdnuUTXOpL65z3zUJr/O4pJjoBIaczEyUWaK47o
         Dc/xVom8IRe0wO724qq94BD4eKXCgy51Z+JE0Mozt1Nf8gpeIZze9HY/tWE1iTYINKnl
         FJxIpOWjgdqX/+UavC14gHejUHblaDIlgOV6JDgJImLTALoTxFEYdHS9SQ7t9yZp5tJX
         RV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689896483; x=1690501283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuakzeXbVQU41VvxHXSVvnt8OnYSlNwqjdfqQZot6oA=;
        b=FvV0/0lxDWsUrVysb19FEBJz0j6rEIjJRwLxJhPARYTy/LFFXM6NMOHV0g0+2DRkpF
         +JVDvUHsRWt/Jr2E+RlD548q8W1Ay01DUmI1K5/xEfPYt+Wep5ewdLSf6P6hCcmYreJ6
         DfD5SWMbP8/H+vRhV3uMw9W9Xi46vROe1jNUaurdLs7HY+X2DLk5evRtD3Evb/ntMn5r
         T/pVoSIXkn5+xUkjDDokk2eQWKW3fQBuuQ117gV15K8kBoNxuGnxXBo7J29Dyv7hsyl4
         dlGVfObQHFdODhWLdIRM8s8gtsmy1NH+MbJvDFqoWvwcX31Ic+aMDDdxYTdckLrPryaq
         2Rkg==
X-Gm-Message-State: ABy/qLZukexqIvcQXZkZewacK0TrPTDBgnOSSsEY6Arx5QsPbWeyk/EH
	R2v/aLlqBqPz4tJB0ow1vEkpV488TfM=
X-Google-Smtp-Source: APBJJlHEPO2LtJjiEuRu+pWloohvb1fVPru1CubxOmvDr0RlvP5PLmRH1rFcjGIranl89O4PNKvvKw==
X-Received: by 2002:adf:dd0e:0:b0:314:1d6:8aa7 with SMTP id a14-20020adfdd0e000000b0031401d68aa7mr254374wrm.29.1689896483456;
        Thu, 20 Jul 2023 16:41:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:842a:2e:7001:d55c:2acd:57ac:a0f7])
        by smtp.gmail.com with ESMTPSA id h17-20020adffd51000000b0030fa3567541sm2564889wrs.48.2023.07.20.16.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 16:41:23 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [PATCH] bitbake: fetch2/npmsw: Check if there are dependencies before trying to fetch them
Date: Fri, 21 Jul 2023 01:41:21 +0200
Message-Id: <20230720234121.168334-1-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jul 2023 23:41:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14882

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

When there are no dependencies, _foreach_proxy_method does not verify that there are
dependencies to fetch before fetching them.

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 lib/bb/fetch2/npmsw.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 971ccc9050..4ff2c8ffc3 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -225,13 +225,15 @@ class NpmShrinkWrap(FetchMethod):
     @staticmethod
     def _foreach_proxy_method(ud, handle):
         returns = []
-        for proxy_url in ud.proxy.urls:
-            proxy_ud = ud.proxy.ud[proxy_url]
-            proxy_d = ud.proxy.d
-            proxy_ud.setup_localpath(proxy_d)
-            lf = lockfile(proxy_ud.lockfile)
-            returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
-            unlockfile(lf)
+        #Check if there are dependencies before try to fetch them
+        if len(ud.deps) > 0:
+            for proxy_url in ud.proxy.urls:
+                proxy_ud = ud.proxy.ud[proxy_url]
+                proxy_d = ud.proxy.d
+                proxy_ud.setup_localpath(proxy_d)
+                lf = lockfile(proxy_ud.lockfile)
+                returns.append(handle(proxy_ud.method, proxy_ud, proxy_d))
+                unlockfile(lf)
         return returns
 
     def verify_donestamp(self, ud, d):
-- 
2.25.1


