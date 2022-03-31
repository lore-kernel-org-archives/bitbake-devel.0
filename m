Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE4AC433FE
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 20:05:49 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web09.1867.1648757148548762011
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 13:05:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PfqtDAtD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id r7so464827wmq.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 13:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=leslJjAfHVOwdnTJ9cATvHNlH0LZfsuXGoZf5TtAFSk=;
        b=PfqtDAtDhJZXV8LAubR/c5De3khJhK1jjjFeJb9cD89VJtNwdVerRmHBEz6lv1YpBi
         cuwQOl/HmdZejLqhInZE5Jy3UzYABWCKWYye+i/nv4FlxXI3T3HtsAG4lfMplwCUe/iV
         8j8qOQOEMOJUEGA71dChoWIsez6aFRY+KhAqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=leslJjAfHVOwdnTJ9cATvHNlH0LZfsuXGoZf5TtAFSk=;
        b=00N34T7sqHa/plkKyAMI7VLZ2bS435xjES51bzIzDs1UEgKaW8hWC/aJbAW1hA4ynf
         JZoc+DRRYKiluhr7RUFElwZpzSAo+a0g374p0Ve9XfpNQaSCElWD1K8xMWQ4w59lMn7/
         O9GfrtOlU90akQz1Ey5ZFqb6+l/LgtrnPXLkAZlL5FPSlALddrZDHG8JC0I3UMo61G+u
         wexUniEI6K+zqU5imel4v6cYuaupaS9YPcxOMFs1X7ma6Dkr/s4Npm6+IS3L2zUv91yg
         LkFTiehP7zSVCZAapz/Jzpy9KMZXRYqoX8vra27hXCxo3TvQTNr4wolgGQDEwj5SnEWl
         Mwww==
X-Gm-Message-State: AOAM530IayrilL5gyuP7yJXhakrX0HSqnjdpWc0uZ/KwoffjGBVBdrap
	tSFQAQPlpPDeFvqMXmcQMhJqAbqTGsJC4Bml
X-Google-Smtp-Source: 
 ABdhPJzoU8htLKCNzjCr1JHq05rSh2SiWpwTFvV0uu12MK+TBtnEL2iSfp9V7GKWcopoz/mQq68CQA==
X-Received: by 2002:a05:600c:3ba5:b0:38c:b19e:253c with SMTP id
 n37-20020a05600c3ba500b0038cb19e253cmr6081136wms.35.1648757146836;
        Thu, 31 Mar 2022 13:05:46 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a160:31eb:e235:3dfd])
        by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b0038cabc63721sm184452wms.30.2022.03.31.13.05.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 13:05:45 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker: Ensure any existing hashserv connection is closed
Date: Thu, 31 Mar 2022 21:05:43 +0100
Message-Id: <20220331200543.1583022-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331200543.1583022-1-richard.purdie@linuxfoundation.org>
References: <20220331200543.1583022-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Mar 2022 20:05:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13561

Ensure any exiting hash server connection is terminated before we start
a new bitbake session. This avoids errors seen with memory resident bitbake
when the asyncio event loop isn't closed correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0d29aa03a0..d100b96f53 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1766,6 +1766,8 @@ class BBCooker:
         self.state = state.initial
 
     def reset(self):
+        if hasattr(bb.parse, "siggen"):
+            bb.parse.siggen.exit()
         self.initConfigurationData()
         self.handlePRServ()
 
-- 
2.32.0


