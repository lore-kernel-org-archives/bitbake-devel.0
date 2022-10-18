Return-Path: <quantenkeks@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CDFC4332F
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 17:46:34 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.28.1666115190144433907
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Oct 2022 10:46:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=JDHyV9r7;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: quantenkeks@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id q19so21614984edd.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Oct 2022 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k+wSYxkuE1rwBG+8uMmDyLy4eNNZ7jj3ENMtheaKgf4=;
        b=JDHyV9r7eGSRzBDr5uuw8c1/pK+rsnQvCBstG551M4+gFt34F05N0lN0wRlsuL8tzn
         i9g+10FujoX5TcYTeVuS/+C0nT1Wyz529x+uQX7+IR5Iywc/F96t7fv70M1YoH6dEC9U
         imoNYJr2OJeqV5ksJ8iU622YuI8Q+xsgbTv20muMIJeIPOj2H5G+YfUX/NXGEqRICT9c
         MQJgtHfbSKpWuko9h9mA5ymqdqrqfT8NRt0oVo5ATSDHCq0VdXXIUm2l0tE+NS7xGtpQ
         zLpM3pVOnTd+nwlaTSLf2+Ey3sbnq5xNFJuH/Rm5ZxIxiOxHHKK5OaBOJ+SMkvVFyIT4
         Eugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+wSYxkuE1rwBG+8uMmDyLy4eNNZ7jj3ENMtheaKgf4=;
        b=QLgVkbQd5wfKlJDQT9iJYg66D93fX7CvXKRtnKnOCwbe/1+qENMi78/KbdRBPIUJV5
         0QipDYu9duc7apIhWj+UlPWMsLLmcpLBHdGacBJUE1NhupsWZAn2bFmiZ6ENaR04d1hj
         +MiztP94YGi2CprEPTB7UcqK//ID5uSOYP3LVU0KqD4uRVjlth7i/NBGMHg1w3M6Qi9k
         /tVErNxteGTlF8uLRH6ZtFLEco96YxEb2n5TYq/aNaDKXaCwcx8tcm3N4AL3U7N6WeYB
         1BvMZXA80ddQhZp+s4F2oCHjUQfgRfnAsty5aE/kb+C7vUf6PV0Xos9ZHWG4WOMFTeFs
         O8Zg==
X-Gm-Message-State: ACrzQf1DMTlPWTXRGBMy0MGfxPelNElgQTSFnYC/EJ2AoUc3LmJ7Z/7+
	XNYDqdJ1H7Oa0YbU3HLPfsrrTWoJgx3F2Q==
X-Google-Smtp-Source: AMsMyM7+rg/pF6LER0veDxUKrDDQyThp5UthYS9hi8FFFdlF+jywS9OmmAYsEZ45WQc5b+zu7oCwgw==
X-Received: by 2002:a05:6402:1ccd:b0:459:aa70:9e12 with SMTP id ds13-20020a0564021ccd00b00459aa709e12mr3681333edb.206.1666115188443;
        Tue, 18 Oct 2022 10:46:28 -0700 (PDT)
Received: from apu.fritz.box (p200300d0ff191200c3bc5fa022caa84e.dip0.t-ipconnect.de. [2003:d0:ff19:1200:c3bc:5fa0:22ca:a84e])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b0078ddb518a90sm7713147ejt.223.2022.10.18.10.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:46:28 -0700 (PDT)
From: Oliver Lang <quantenkeks@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Oliver Lang <quantenkeks@gmail.com>
Subject: [PATCH 1/2] cooker: fix a typo
Date: Tue, 18 Oct 2022 19:46:11 +0200
Message-Id: <20221018174612.98621-1-quantenkeks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Oct 2022 17:46:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14040

Signed-off-by: Oliver Lang <quantenkeks@gmail.com>
---
 lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 32a529f0..1da2f031 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -250,7 +250,7 @@ class BBCooker:
     def process_inotify_updates(self):
         for n in [self.confignotifier, self.notifier]:
             if n and n.check_events(timeout=0):
-                # read notified events and enqeue them
+                # read notified events and enqueue them
                 n.read_events()
                 n.process_events()
 
-- 
2.25.1


