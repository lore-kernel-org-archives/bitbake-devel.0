Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987DAC77B7F
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 11:18:15 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.56124.1683803885999358035
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 May 2023 04:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=AJykafv6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f315712406so280809765e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 04:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683803884; x=1686395884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fz38Zax3d06PaNwmf+YB+V1SUVOwrM872yo3Ds+REk8=;
        b=AJykafv6g7+zSqCbC4iws4CUhmXcX5fABkgbnIH+aic6WWVx8gDjx8JSWTJr/F7Gkb
         9KL5Z/ZDD7RWEE4ZhWsH+VcavyrON4XrVhjbX8nFacs7pSSOiyvL4I+IL7brKqT/0xkO
         5uRsQec0VcDY3D9MP3zon9vb7xb+GXx9zzx3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683803884; x=1686395884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz38Zax3d06PaNwmf+YB+V1SUVOwrM872yo3Ds+REk8=;
        b=KsJT0MqnqUTllGxjA3khvFeH+vF5sXh51m90o18CpWWQ15Smqo2yJkFOgi7IaFZyJd
         KAksa0T0gQPOrBYkbB2HQ+mFHLRBTp+e8ZOHoVJ9ejOTsYF/8jB30En8GZYrCLpz0gDU
         L5QAulxs+JtcVBx9+AIPNfIAxFbHe90GLuf07hbWPz0KMYo1gaXxzoEM0AIfUFDeeIWZ
         lMnpAQjQ0OHJJcEVeuRCuS2bwHOq1UxlXwXDW5SK4RDGYtb4ESM6Ps0qqzslYTa8AHSW
         Dgp4itb06We+7H/fA4TT1Bkd8/VsVSmtthWXJys/+Yykhvmw3rfTWwr5HWLXdq6d7XA6
         8udA==
X-Gm-Message-State: AC+VfDzy3D75cFFwg1wvblHvx4gSIE2p2mDTNu+ka1mDQMpHq9CysPgu
	R4RZih6IrCvrzG94cwVwf2eBfvZxL0GGkgdZTas=
X-Google-Smtp-Source: ACHHUZ5sch6+D6/IpYyVKQrbcYYfezULIoTXzXRUn1D63EI6vLFLThI4aUVgcuvADMDfYkg8USUqmA==
X-Received: by 2002:a05:600c:8507:b0:3f4:e432:7589 with SMTP id gw7-20020a05600c850700b003f4e4327589mr3169955wmb.10.1683803884183;
        Thu, 11 May 2023 04:18:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b4cd:cc57:565e:2ba8])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc40e000000b003f4272c2d0csm10580337wmi.36.2023.05.11.04.18.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:18:03 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/local: Add debug to include chosen path
Date: Thu, 11 May 2023 12:18:03 +0100
Message-Id: <20230511111803.1799016-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 11:18:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14782

The current debug lists all the potential search paths but not the end result
which isn't helpful for debugging. Tweak to include the end result.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/local.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 8baec7d2e8..7d7668110e 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -51,11 +51,13 @@ class Local(FetchMethod):
         path = urldata.decodedurl
         newpath = path
         if path[0] == "/":
+            logger.debug2("Using absolute %s" % (path))
             return [path]
         filespath = d.getVar('FILESPATH')
         if filespath:
             logger.debug2("Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
             newpath, hist = bb.utils.which(filespath, path, history=True)
+            logger.debug2("Using %s for %s" % (newpath, path))
             searched.extend(hist)
         return searched
 
-- 
2.39.2


