Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A68C678D5
	for <webhook@archiver.kernel.org>; Tue,  7 Mar 2023 12:52:04 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.13680.1678193521384223058
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Mar 2023 04:52:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W+T6mtHd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id p26so7675815wmc.4
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Mar 2023 04:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678193519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=khU1cAVk4EfbUtMNUUlU+YJYPAHt9vlCeGewDGEX1Z8=;
        b=W+T6mtHdPbffySyhnw/XuzG0Zy6Liya9OOPjRJ/JT8Io4UmZWXLkz3egc7HGc/Usnd
         SVLeeKKbAllS5uC25sraySpaX6shkmxa/p/tct9zAAJgsnhxSw6OLTutuAH3+YDPO1m/
         HR1eCUQmbeQc0//y9vPRwnbrncEmUXp2t9qOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khU1cAVk4EfbUtMNUUlU+YJYPAHt9vlCeGewDGEX1Z8=;
        b=uUgb9gLJ5R7Ggm3FC7FqfDZBvgCVTaQcT+HuwY56AOIg8lvPJM9W1aJ9f7U8gNE90c
         kwikBi8pwo5uJTqGNzBoASXl3CeLlIM8yWIhoy23xAHyt3Sj6Eg8o2BI790xQOxO1yc5
         hqHd1zcinMyc+GYk0vgC/sDJYQfh3FJ+b08XBXLaprkt/PxcWHOSb4ynU+2PbAVgvV3f
         APaM5tk14SwWc0sRCV7wyx2aLKrc41bRrnRJ7QFUSay/DRM1TvAKKJlYicEd03aZwdNX
         6xnmo69jrRzP6dbgIAaCrJKC4DKeLS4Q2OPBZqnq3zc3j3qcrPPsplQwW7jDt0pP0q2u
         OsMQ==
X-Gm-Message-State: AO0yUKVZamjrLcfDVujXXvpLVt1AL8rsxnQIHjN+7NhRleHJrqSIirww
	smUHLiLw16G7PNEUflb/QitZRuEvP5TuOKmuM54=
X-Google-Smtp-Source: AK7set89gZ9GPx/jQlUK6u+FVgM9aynZzGJy5wOkh+Mi9qhvSPdHoTB9ulP7NsRFkBK2Vw9Ri2AI1A==
X-Received: by 2002:a05:600c:3c8a:b0:3ea:dc39:e8b1 with SMTP id bg10-20020a05600c3c8a00b003eadc39e8b1mr12663646wmb.12.1678193519264;
        Tue, 07 Mar 2023 04:51:59 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e718:9e1:49a8:9d75])
        by smtp.gmail.com with ESMTPSA id s25-20020a05600c319900b003db03725e86sm12848078wmp.8.2023.03.07.04.51.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:51:59 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/xmlrpc: Fix after currentAsyncCommand locking changes
Date: Tue,  7 Mar 2023 12:51:58 +0000
Message-Id: <20230307125158.2534985-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Mar 2023 12:52:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14524

After changes in bitbake b5215887d2f8ea3f28f1ebda721bd5b8f93ec7f3,
"process/cooker/command: Fix currentAsyncCommand locking/races", command.py
assumes it has access to the process server but the xmlrpc backend was
passing in the xmlrpc server object leading to errors like:

xmlrpc.client.Fault: <Fault 1: "<class 'AttributeError'>:'BitBakeXMLRPCServer' object has no attribute 'set_async_cmd'">

Fixing to pass the process server to command.py resolves this issue.

[YOCTO #15008]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/xmlrpcserver.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index 2e65dc34a9..04b0b17db1 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -118,7 +118,7 @@ class BitBakeXMLRPCServerCommands():
         """
         Run a cooker command on the server
         """
-        return self.server.cooker.command.runCommand(command, self.server, self.server.readonly)
+        return self.server.cooker.command.runCommand(command, self.server.parent, self.server.readonly)
 
     def getEventHandle(self):
         return self.event_handle
-- 
2.38.1


