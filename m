Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8D5C433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 11:04:42 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.5684.1648724681880896384
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 04:04:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MVbNMw56;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id j18so33226606wrd.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jnp4vaxKMkWzMKoceo3FJdrdEbR9Cu91Z3Iyj2Cy1nY=;
        b=MVbNMw568X9jEmvTzADBFYkrgvfmx/I0NNbndvLsjFPPn48gz16l6hqUEgWyKNZiVW
         S715q3nkdJormvVNSq/MPPrDQnfkGOAWi2Bl9GmaSSx1Xozhnbb2aBE4BAid8Mvc53zK
         S8oqFyDOvgBpjP7nel6Tq8z8ZTmvTJbPQDUD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnp4vaxKMkWzMKoceo3FJdrdEbR9Cu91Z3Iyj2Cy1nY=;
        b=ycpTx6GKqgiJkzmWQL0rtJ28brrlpWd7rxak1yxiw+3IDiFARC7O952FLnKgUzzq5v
         TP7i4/MtkiVE0dH83VBy8bF1m/szNzb/+8d1GEQ34gdjMQrZr1zb4kXClPDgtMqwjEYS
         y06G6KghFM7xlq8tTkIkh5mtvn1JZ2KBItSozVx8cQ93Eu80fcQvvid+OSIr2t841soh
         3URJILykAiQEwnQAemlQunvaK/o4W6IMaMhCKoBIyM/n471TvDFJBaew5p8suhrtWsUX
         gSXhD+mqsnA3agfSmbH4ZidDIZzePdvCu6xNEcmh8PnZxOSItgiEQoPCTTn5Czt6ZXJZ
         oCMQ==
X-Gm-Message-State: AOAM530IK0aW9bHMzHQGZT1Fcw2CIW7o5WxwCogpVXX5jH9rZZ4yS0OX
	3552sUEEp5a/adH1uJCJh/URBrBXijrdX7kk
X-Google-Smtp-Source: 
 ABdhPJwTGa9n9/IeNKlGFJ/J6PxflYfUDH+s+9k/hKkwK4fSdrTxHtXkcLce2+BVZQ91FFZpE1TmJA==
X-Received: by 2002:adf:ab1b:0:b0:205:b27d:66cb with SMTP id
 q27-20020adfab1b000000b00205b27d66cbmr3704669wrc.708.1648724680143;
        Thu, 31 Mar 2022 04:04:40 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:6605:7b3b:ef3e:a309])
        by smtp.gmail.com with ESMTPSA id
 m3-20020a5d64a3000000b00203ed35b0aesm33155728wrp.108.2022.03.31.04.04.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 04:04:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker: Restore sys.path and sys.modules between parses
Date: Thu, 31 Mar 2022 12:04:37 +0100
Message-Id: <20220331110437.1562951-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331110437.1562951-1-richard.purdie@linuxfoundation.org>
References: <20220331110437.1562951-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Mar 2022 11:04:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13556

When memory resident bitbake is active and we re-parse, the old module
configuration is present which can lead to strange errors. Reset this
when reparsing so the state is consistent. This fixes memory resident
bitbake errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1359d33f77..4753fd16e2 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -159,6 +159,9 @@ class BBCooker:
             for f in featureSet:
                 self.featureset.setFeature(f)
 
+        self.orig_syspath = sys.path.copy()
+        self.orig_sysmodules = sys.modules.copy()
+
         self.configuration = bb.cookerdata.CookerConfiguration()
 
         self.idleCallBackRegister = idleCallBackRegister
@@ -350,6 +353,9 @@ class BBCooker:
         self.state = state.initial
         self.caches_array = []
 
+        sys.path = self.orig_syspath.copy()
+        sys.modules = self.orig_sysmodules.copy()
+
         # Need to preserve BB_CONSOLELOG over resets
         consolelog = None
         if hasattr(self, "data"):
-- 
2.32.0


