Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CA6C4332F
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:33 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.209992.1672333652428022454
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T+VQfoC0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id w1so5778313wrt.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Touq52SotAOn0qhLlACHQaacjfMd05+VLjI7h38+LSw=;
        b=T+VQfoC0qLRGqH3/RCakbopZDQamLpgL4uaBoi8OyxPOXYhf5/dq6O4N/JgM8Ex4d8
         dQXX+tQcu93espZLew/wHqG+4h5y5rUd9f+/u4Tz2c36bp35fWw6FvsNk9CFrWwJezPr
         +UjjS9bFdGJIlGlCpwAN9TVAQG1J1vLtEPvbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Touq52SotAOn0qhLlACHQaacjfMd05+VLjI7h38+LSw=;
        b=YBf0EC55vGObRhBNeYLY8ezFrjMPrXgnEp9wVpcJSnGE3Zw5ru1vg+bewVps01Hdx9
         Fa1GNkLFbMwEsRoPgHDn1CmXPWXrame6uLYJgpLs5PawEL9WXrH6i0sVKywKGqhpOGfa
         3x9pvH+MigzV3c04ULkW60xCqGWmfIiBu7xBBnZXmA+aiit4TngKlz6T+KnA3ku2AqiN
         RdG5rmR1wA7TF+VTJ26xoIFmhCAHif89OZ+hI55X2kRZ+FEb1hFwzBHz8nikzVKCnZyW
         XrPwMatphYFeI8Ii2qgRWw+hahHXhqUP5PWzgJ5qaWge/R1o+LQZKJJqBInYQ4JmgwMS
         3xkA==
X-Gm-Message-State: AFqh2koPx8jFG+nHcxI4uvmIgbOicwPbr30pHfUgAFO59bajngIoQf6/
	N25fnPior4A864KN17yVlSqm/ahqrE194ZDR
X-Google-Smtp-Source: AMrXdXu8vfDYGw7GoZIwB6y5OB6vKXNyB5kpS3zLTrsAWJYvFH9V9Xt1tHvQQCJJW+Dui8ueCh4rbg==
X-Received: by 2002:a5d:6e8f:0:b0:276:473f:7120 with SMTP id k15-20020a5d6e8f000000b00276473f7120mr14714563wrz.26.1672333650792;
        Thu, 29 Dec 2022 09:07:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 01/15] command: Tweak finishAsyncCommand ordering to avoid races
Date: Thu, 29 Dec 2022 17:07:14 +0000
Message-Id: <20221229170728.880367-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14244

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 0208e30ec4..cbac07f516 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -152,8 +152,8 @@ class Command:
             bb.event.fire(CommandExit(code), self.cooker.data)
         else:
             bb.event.fire(CommandCompleted(), self.cooker.data)
-        self.currentAsyncCommand = None
         self.cooker.finishcommand()
+        self.currentAsyncCommand = None
 
     def reset(self):
         if self.remotedatastores:
-- 
2.37.2


