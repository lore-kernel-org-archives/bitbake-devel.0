Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C463C54EBC
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.45723.1672505935437585692
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y48qjxxs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso17682753wmb.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Touq52SotAOn0qhLlACHQaacjfMd05+VLjI7h38+LSw=;
        b=Y48qjxxsqiz13HSaCZGYzbJ40dqb79oH03CZFbHsa1Uc2KNg573NMXozSMshlrBeY5
         J6G8AVcfaU7kDSiK1qAWR7Uq9ZbFPgXI3Z67szS2dj+Xn/rlFGvQiaufwRzhKLaW4MXi
         f70zbBK0bcyI7O18S6GydXTTYjoxSvSIdmZqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Touq52SotAOn0qhLlACHQaacjfMd05+VLjI7h38+LSw=;
        b=JTD1Ddf1ix0sTPusCsK9orWrWliwoP3MLYEEIF1FpTGeG0XH8Ok2Qb4aLC0dVLc9vz
         iGK38cQA5RFjwtdoPla1ACz51HVfXWyPW7m+idquWZV0ehKcOqt0kWTyIweyUFr6AUP2
         YI1XlVDINZLr0lzlYTtk7TH5fHd6Ql1TBRc8DS3RKuCGMD1k+JxTHozIRv9h0X4Fgaty
         Q8AS5KYqZL9oI/oyE0ts4JhUJQ6MmI7Td9GjceR1R/cGKRgX+GmBx0xvRiwPG/Ey+mXq
         L06G3TlVBWo06hmEKUHNAGYQAodSRwpruBETU4NL3Gk/yQAAzWvWa9JpTij++073tIKZ
         EGYQ==
X-Gm-Message-State: AFqh2koRyRCYoMGwZj/kw1SpmiARzC+cgNMrfoPNrlwU5yQkm0M6pWjS
	PSXnw1kViCyOC8hm4YFRpHXJyhDsh9/B9dkW
X-Google-Smtp-Source: AMrXdXvlZ82VRwX4h9+zeMynx/mmyX3CHFDb7j3Sxnf2+A7qbJRStBOO2hj+1KFpheMR6kw5eszeaw==
X-Received: by 2002:a05:600c:3ba4:b0:3cf:d428:21d6 with SMTP id n36-20020a05600c3ba400b003cfd42821d6mr24604956wms.3.1672505933819;
        Sat, 31 Dec 2022 08:58:53 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:53 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 05/11] command: Tweak finishAsyncCommand ordering to avoid races
Date: Sat, 31 Dec 2022 16:58:43 +0000
Message-Id: <20221231165849.964169-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14266

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


