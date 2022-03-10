Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6423DC433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 13:11:50 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web12.9275.1646917908846157668
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 05:11:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JkTy60Np;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id
 l1-20020a05600c4f0100b00389645443d2so3363344wmq.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 05:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cqzmcjk5x71pas/d/gpPgGH6/8kOVzXItAJJqGYnD90=;
        b=JkTy60NpAiQxDMUMWx5sw5cxBOxlkw2siMkpcbt0QyqENmGScc63uYcMhNSw1qI6U7
         laUPk/6v6obuE8rcHCAhbCKg9QS93eCKYwJwHflyOaz4HmGnYKOf+VThTzk7vxGTTmza
         mWZyCh8dCBuOJzADqtsw2SVFaLQx2rX/d9IzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cqzmcjk5x71pas/d/gpPgGH6/8kOVzXItAJJqGYnD90=;
        b=EYQXKISB2SkDai5v8i2854MC4gjdB1K1D+mQgX2Y9/b7iAVRpZ+PVJGX1WGSmfMt1f
         nbYW14clTmy+dxmy/UAcIaF4DIAQGfrIH2ULUcC/UfKOz/Hj8la6Dpx4ua8IHtXB5O/S
         NyQ0283lxbi2yBGJB/cGQd7+qJyOHTYxdqd4MWrIJlYYt60Hm3WFTFnqZQd+6m5o7/bB
         +yqB+NvOksQULl13xTnyzLI6zL8ikYZ4KKCBXl2YSAzok1dtmPafW9Q2W8uD2ye4e5zH
         RM68AwG4nKwzF7ppinCRYF6ohiPGgkQehMPHvXqqfHcDVmdriLL6UIJNfPQQk/72X+Us
         IHXg==
X-Gm-Message-State: AOAM5327C54W7bUBLFStt1vDjt1GiPmMw7mdaqYnFzDywAWZfKiLFoAY
	91R8me0gcDmPVdVmUt/yzj+xzQ8E10Wsi9Pg
X-Google-Smtp-Source: 
 ABdhPJzrG7vwZep/pPMuwLsQIqmi3eXl9hrOb4KHJLfmOy7Ce+ixIu9ZWyGKsL2TJ9qXY3EonHPPxQ==
X-Received: by 2002:a7b:c954:0:b0:385:6e61:aea6 with SMTP id
 i20-20020a7bc954000000b003856e61aea6mr3531335wml.91.1646917906756;
        Thu, 10 Mar 2022 05:11:46 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4dd4:e08f:40b6:a45e])
        by smtp.gmail.com with ESMTPSA id
 r1-20020a5d4941000000b001ed89dcacbbsm4168235wrs.23.2022.03.10.05.11.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:11:46 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Fix environment history printing
Date: Thu, 10 Mar 2022 13:11:45 +0000
Message-Id: <20220310131145.609187-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 13:11:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13463

bitbake -e is not showing variable history correctly for all variables.
The issue was triggered by the change to knotty to default to enabling
variable tracking in the base datastore but that exposed another issue.

The real problem is that calling reset() inside cooker reverts to the
data tracking enabled by the UI for the base datastore, then turns
off tracking. In the case of the environment printing code, it needs
it to be left on.

Tweak the code to ensure data store tracking really is enabled.

The code here is clearly a bit of a mess but this at least fixes a
clear regression until more invasive improvements can be made.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6996e62375..f79dc2770d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -555,6 +555,8 @@ class BBCooker:
         if not orig_tracking:
             self.enableDataTracking()
             self.reset()
+            # reset() resets to the UI requested value so we have to redo this
+            self.enableDataTracking()
 
         def mc_base(p):
             if p.startswith('mc:'):
-- 
2.32.0


