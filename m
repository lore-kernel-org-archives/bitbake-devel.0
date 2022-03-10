Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A181C433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 15:22:36 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web08.10638.1646925755334500663
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 07:22:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cWfC32Ou;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id q20so3461456wmq.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 10 Mar 2022 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waDOA867ANhiwAiT3Vk9E2zB1vUzfKfcufTXA6l+tDs=;
        b=cWfC32OuAk10oVaGBQ/j77/yxbJv0ZJgHE+8hY+iuvrLaI178Qc+z0AxNYDfEphwzV
         WlBVS1ET7PPOSmVpcZgRQC3q+A8+1o14D6TMqHYy4tq9YgBbSBwUoAln5p+atuk5Cxvk
         cOGFVxGHoQX8G6hOhs+RO47ZaO3PnKnfRmnV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=waDOA867ANhiwAiT3Vk9E2zB1vUzfKfcufTXA6l+tDs=;
        b=HUEnLwShSDoCwOaAQbIraKm/aHx0fdnbu9I2psZ8hY4apIJ5nUfN3voRW2j6HkhFLZ
         9Za+1ylcpg0EFrEoyGdemXNIfLFf5XTngDj+8Cgn5HOOfZTZHWpklF3cx6AWqpEIfSOh
         gl71fIskTqenNri4jxuCXBH4lV3zrjyrGwEogqP7rFXwc920nTe8OZl4bGDipXOGOcwA
         0WWUQ/vOH5AZGItqK4Q92FZ1pHkCVMv8JMGbNy2+ScfOxG9zDWd0nX4pZR4oRn3su7MN
         6wagFcnPTiI7vm+sfRzDHenL/pXcmAct+U3FIjc4Ym52EBjf1IuOr+dFrIWBXV/2eqm7
         f3Qw==
X-Gm-Message-State: AOAM530DlLlo5pkVqliSNIAf9tsjswiv9yygH7Owny9pnP2Fw+Ow0Qoh
	kSMpDUAI2jKHdZtdf96GT/nxZoaWCrvnroeY
X-Google-Smtp-Source: 
 ABdhPJyjgtCvCMKPPm5ux9viCUSOiitVuSCdk21Mggh3GUexlWbDtu4kDDlniKI8bjucPjY+gB4yXQ==
X-Received: by 2002:a05:600c:3ac3:b0:389:d6f7:907b with SMTP id
 d3-20020a05600c3ac300b00389d6f7907bmr4569809wms.93.1646925753393;
        Thu, 10 Mar 2022 07:22:33 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4dd4:e08f:40b6:a45e])
        by smtp.gmail.com with ESMTPSA id
 f7-20020a5d4dc7000000b001f1d99e9441sm4706684wru.106.2022.03.10.07.22.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 07:22:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] uievent: Fix import warning for python 3.10
Date: Thu, 10 Mar 2022 15:22:32 +0000
Message-Id: <20220310152232.614543-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 10 Mar 2022 15:22:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13467

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/uievent.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index e19c770bc9..d595f172ac 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -44,7 +44,7 @@ class BBUIEventQueue:
         for count_tries in range(5):
             ret = self.BBServer.registerEventHandler(self.host, self.port)
 
-            if isinstance(ret, collections.Iterable):
+            if isinstance(ret, collections.abc.Iterable):
                 self.EventHandle, error = ret
             else:
                 self.EventHandle = ret
-- 
2.32.0


