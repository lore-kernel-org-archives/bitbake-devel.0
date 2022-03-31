Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60EBC433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 20:05:48 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web09.1866.1648757147513292740
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 13:05:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HqEQUz1i;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id
 k124-20020a1ca182000000b0038c9cf6e2a6so315339wme.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II8LtEqkdIb5TR8xlNIgToZiCnsmq0ShCoHHd4QOubQ=;
        b=HqEQUz1iMH44sM4TC9WO6ar4B1pmuWVFW45pvLooMtypyiojGNGW5PTlXu7XFQy8ov
         X9wpewMJtfH5wOTH7iU4A93V8/K5Zz/VhwFhNHjDUuJAWJsedZ2MXTtJLPGLOrK2n07v
         rQi9ZtIHD3AW5m7JVqRe7f/HJ46qIiln/elBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=II8LtEqkdIb5TR8xlNIgToZiCnsmq0ShCoHHd4QOubQ=;
        b=owvkbrTqnr9ATI3xrvBbgbG+C+JL5AAyGia53TacoxBILQmwGGxtyGEbDb66AhTXTg
         gaM87NIj/f02BQzC1YW0+CbPNlaCMVvfvvlhH8bOLpEr8Woe4hsTbzXF8O1dzK2Gw1Zr
         1RMTawWeBmEWzMTOriwR3GFhjb2wU7kEeTc//0xNfiezbyt/Qf8fdAOBcFj4M3nWhZGF
         8WDPBVncWfkQcYWE9/8MvC72+4kBmvpqumdLtk0U8J1CVx8gISg/hejq7SU8QzSkGp/g
         1sVkQf1odcCBpqp4miYWL71QasnBgTXgptgIuMheLG0yIzcLmw5+RSQBNZh6bU4fsh4I
         Kpmg==
X-Gm-Message-State: AOAM530xi2Xihf9AvZJDZVrncZFiRZPX9OPqbEFz7FlbvZDW7/gBbzFo
	7XYZY9OWIUPzAsYFA+menMTktqBjTbDsdklS
X-Google-Smtp-Source: 
 ABdhPJxfjqbo3aJ9pQ12WY/m5gUPRLnW1O8nLYDS/w2mTjnWgJ2timGqq/B9SNLm/CIB+prz1FlJbQ==
X-Received: by 2002:a05:600c:3016:b0:38c:8786:d3b6 with SMTP id
 j22-20020a05600c301600b0038c8786d3b6mr6024385wmh.135.1648757145526;
        Thu, 31 Mar 2022 13:05:45 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a160:31eb:e235:3dfd])
        by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b0038cabc63721sm184452wms.30.2022.03.31.13.05.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:05:44 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2 v2] cooker: Restore sys.path and sys.modules between
 parses
Date: Thu, 31 Mar 2022 21:05:42 +0100
Message-Id: <20220331200543.1583022-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Mar 2022 20:05:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13560

When memory resident bitbake is active and we re-parse, the old module
configuration is present which can lead to strange errors. Reset this
when reparsing so the state is consistent. This fixes memory resident
bitbake errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1359d33f77..0d29aa03a0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -159,6 +159,9 @@ class BBCooker:
             for f in featureSet:
                 self.featureset.setFeature(f)
 
+        self.orig_syspath = sys.path.copy()
+        self.orig_sysmodules = [*sys.modules]
+
         self.configuration = bb.cookerdata.CookerConfiguration()
 
         self.idleCallBackRegister = idleCallBackRegister
@@ -350,6 +353,11 @@ class BBCooker:
         self.state = state.initial
         self.caches_array = []
 
+        sys.path = self.orig_syspath.copy()
+        for mod in [*sys.modules]:
+            if mod not in self.orig_sysmodules:
+                del sys.modules[mod]
+
         # Need to preserve BB_CONSOLELOG over resets
         consolelog = None
         if hasattr(self, "data"):
-- 
2.32.0


