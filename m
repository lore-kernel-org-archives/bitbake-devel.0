Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06787C4332F
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 12:50:02 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.204424.1672318194541111599
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 04:49:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PVp/UxlH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10633940wmb.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjDLbMnuniOOsmiyIXCZI8VpncJqUiR9HJKqZZEeLjo=;
        b=PVp/UxlHLzW7bPLO8Mr/7Xw3J/BanJ51iamlpRRMJB9miv7Lwv5fkWTHIehk7g/YOZ
         kvCOjVZrEPN0mTpoZDZNA6EDN5KWjJgMGB060ZqJ5uRPRs3byWeJDOO7jsWYW7UPgqzs
         pxURi19SHyrkscE8lVRdnNRr9gKNofB0mYES4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjDLbMnuniOOsmiyIXCZI8VpncJqUiR9HJKqZZEeLjo=;
        b=nj3T500lVgpch5rI8j8HXrWwtxt7caQQobp4fO0RCe0l8lwY1upDtmV/lFI4KQ7LYV
         QU18XvjgkEZ1oLEcjRu6BL3Ns1sO6mIb9rUncu9rTSJSxUvDkbrvrst5RUePySSf9SOz
         /Hwet7pS8lueoCK8meNXcGW3VugvELR8xdxVhovxXGkLfmH5rC0gTljj+DXLStn/0lQE
         XynK56JeXteLkxFOlb3jr0MVFyY8t/DNVAqSx6hNUnUXrY5I6GFQN0RSW5fViUonkJ8U
         QERw39NllhnLN9mzA+SmnFEi9YPPRKA/VkNYNH0ik1YIrE19OVQ9CDx3DUGpPJ3DeKwF
         wyPQ==
X-Gm-Message-State: AFqh2kppzze58R6LSK/kaA5CUSJ63kuh8qiFE3AhSlofMP7SW0HnC+Bp
	UnvjN+K1qM8E/VkdnfMkM+DMqAF1GInAMUIm
X-Google-Smtp-Source: AMrXdXurL+QAuzSbocPDys5KrdtjnGmLlCCaDWYh7YvhzLKDmiKllaOQ/v215o0hl6Y3ZVqtp/03gQ==
X-Received: by 2002:a05:600c:1d20:b0:3d2:2aaf:316 with SMTP id l32-20020a05600c1d2000b003d22aaf0316mr20332726wms.36.1672318192395;
        Thu, 29 Dec 2022 04:49:52 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bca41000000b003d1de805de5sm24116917wml.16.2022.12.29.04.49.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 04:49:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tinfoil: Ensure CommandExit is handled
Date: Thu, 29 Dec 2022 12:49:51 +0000
Message-Id: <20221229124951.868534-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 12:50:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14242

By inspection, tinfoil handles two of the three command exit cases but
one is missing. Add the CommandExit case in case this is the cause of
one of our recipetool/devtool hangs. Regardless, the fix is necessary.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index e68a3b879a..8978bb5261 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -773,7 +773,7 @@ class Tinfoil:
                             if isinstance(event, bb.command.CommandCompleted):
                                 result = True
                                 break
-                            if isinstance(event, bb.command.CommandFailed):
+                            if isinstance(event, (bb.command.CommandFailed, bb.command.CommandExit)):
                                 self.logger.error(str(event))
                                 result = False
                                 break
-- 
2.37.2


