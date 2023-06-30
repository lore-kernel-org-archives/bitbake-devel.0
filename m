Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9E4EB64D7
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 17:05:29 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.19342.1688144720133323136
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jun 2023 10:05:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=gVDtlho5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so18881605e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1688144718; x=1690736718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa7JiXOmX78trrDHGxkbEPybq2X0QhNEYE2S0FjzWF0=;
        b=gVDtlho5qbOr3+td4fPu9nUp/z2cR/FhLmVC6rLNegllMGZxlObRPCwhhaBAG2jXow
         SLVaa5VIdinrHc4eBd8fTw31oWWWfYQ0EogwXv7iBtXVKERBv+YOS/XlnYfPVVMRuNaO
         1huPs6x0HqsS+XmcM9MJ+LWDHmzkuOw0S5RII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144718; x=1690736718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa7JiXOmX78trrDHGxkbEPybq2X0QhNEYE2S0FjzWF0=;
        b=XZelwyMjAudkkgg6Y4Jyex9pU/tiywR75pj1YLMtoE/bArs7VtYwxVoVbJ/bSYGkF2
         m+b5CxTySKYzbxpLuf67uUC8LCPKqfoI1a5eWSmAw88dKjocTSLIWIgOvjS5RidAT6k+
         7sPZt5dHveDNF3Nhikiqz88YoL7Fl05hB+XbnaM7KMVD/8+gTjVmj5UVlc32Gus+RtqS
         IErVqkISHgS3v3P5gSI0qoQ3dxMXDY8qK6PLRHVmDfNyYLXSAvwcUXk87/TY9VQjDDft
         vX3q/6ylhWuFCpWKFNpnDlUConoPlbmgkIB7sBBxb/LJjvASQeAiKRPT/Xi54zqdg8vl
         ZTDg==
X-Gm-Message-State: AC+VfDzxeSjBtLPs8m91ll1NS37LSUG801jEUu/0hhuNF5BitPzeN7pV
	P8kV5gQulKeGKVoqqKkZxV6NKscyJjl+O/W1PLg=
X-Google-Smtp-Source: ACHHUZ4sBM78Ycx14IViSQO83QiexANxxDHO++tWiv2nu+kHIh+eJpfmGe1984johR26aItpbzCqkg==
X-Received: by 2002:a7b:ce0a:0:b0:3fb:b1fd:4172 with SMTP id m10-20020a7bce0a000000b003fbb1fd4172mr2405851wmc.22.1688144718338;
        Fri, 30 Jun 2023 10:05:18 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6269:f4b4:b452:51cc])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c240d00b003f7f2a1484csm19401809wmp.5.2023.06.30.10.05.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:05:17 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Log when parsing starts in server log
Date: Fri, 30 Jun 2023 18:05:17 +0100
Message-Id: <20230630170517.2764827-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 17:05:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14871

It is unclear from the server logs when parsing starts. We know that timeouts
sometimes happen when parsing but it is unclear where in the code the delays
are from. Adding this debug message to the server log should help narrow
that down.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 0a21f1c2f8..11c9fa2c40 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1666,6 +1666,7 @@ class BBCooker:
             self.updateCacheSync()
 
         if self.state != state.parsing and not self.parsecache_valid:
+            bb.server.process.serverlog("Parsing started")
             self.setupParserWatcher()
 
             bb.parse.siggen.reset(self.data)
-- 
2.39.2


