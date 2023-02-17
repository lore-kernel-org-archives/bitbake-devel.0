Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9286FC05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:01:44 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.8367.1676646097197805419
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 07:01:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IYQ8ZxGo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id bt27so928302wrb.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 07:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdhmnTiUgo37199bKGLcXioFgUBvAKBV9dMSboxiD2M=;
        b=IYQ8ZxGoX4uQ8py3oBg2zZCu/saWmM31r5DQiKngW2LdbK69MIgMNAjBt+kb0knsxb
         0ZO2Juw/EwpXAGufQ7p/6ims6Lhh3hNYkxWt+cE96TtaabvN6r3Tcl29iq4ulzCCbbQX
         q4b4kMPu6jxA2XZcHvMH8sZWO7+gqFYgYtj30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdhmnTiUgo37199bKGLcXioFgUBvAKBV9dMSboxiD2M=;
        b=Q6r8T5YaH2jQdKV8kgpdqDPAg/jzJ0wtZLpjoEEPV8T/p5BcfOTuFE5Iv9yp+pVCGs
         2d3eGpr5+4MLcdOdIHCe8cDop1/s4oghSMWa+55t2079VcDO7tZG/cALKxR4O8ejbP2r
         ENSGiQSWnn7SNrfRmN53e/T8RnLn/1Tvo9XhARxld2ZTOPQU+JqOszU+3cMKT5emyhun
         UR6PFHoq/YaeIwqZWf73IiAE7VXN1mvMmQ9NC64LbwdpXoXyeZNR84/0NZCG/Cabxk6m
         5RgLtz7Hz+ktA7pvguMMFKnz/8auutWx1yf0VMSb7Ym4GOkwohi3EkBHHGgZ1my1mUKs
         6GHQ==
X-Gm-Message-State: AO0yUKWyqWBZs16dGI8WwMb9Y+/rNHtEbsO7lR3UnDJaqbyS3Oh2AtYq
	BkHsxz5JeL3xHEXL/xpzcbQwojidDvPYeEz2
X-Google-Smtp-Source: AK7set/CTnQ27ghCbB9WSC7cerRtSFpNBl3iaHWhtfGXK2l7tteL94fJm1kPbwIf5euEUy2qFrOJdQ==
X-Received: by 2002:a5d:4387:0:b0:2c6:e7f2:6e83 with SMTP id i7-20020a5d4387000000b002c6e7f26e83mr1550223wrq.42.1676646095185;
        Fri, 17 Feb 2023 07:01:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab])
        by smtp.gmail.com with ESMTPSA id f2-20020adffcc2000000b002c5691f13eesm4615995wrs.50.2023.02.17.07.01.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:01:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Remove incorrect SystemExit usage
Date: Fri, 17 Feb 2023 15:01:34 +0000
Message-Id: <20230217150134.349184-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 15:01:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14456

Calling SystemExit doesn't work well with server/client usage since the string
isn't printed to the right place. Use bb.fatal() instead which prints the right
log output and raises and handled exception which then shows correctly on the
UI.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1658bee93c..d93760c1c1 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -473,7 +473,7 @@ class CookerDataBuilder(object):
                 msg += (" and bitbake did not find a conf/bblayers.conf file in"
                         " the expected location.\nMaybe you accidentally"
                         " invoked bitbake from the wrong directory?")
-            raise SystemExit(msg)
+            bb.fatal(msg)
 
         if not data.getVar("TOPDIR"):
             data.setVar("TOPDIR", os.path.abspath(os.getcwd()))
-- 
2.37.2


