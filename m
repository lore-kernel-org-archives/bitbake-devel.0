Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E612CC27C43
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 14:27:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.10338.1717079218157626602
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 07:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EPUiegt2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42121d27861so9432095e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717079216; x=1717684016; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkahyX8u6JGzvIeilItTJthc9WtmLgJJAVhcv6F2DV4=;
        b=EPUiegt2ZDq2IhAyWSY5Fg385G1E+lEgcFrvAb1DJ7hz31SwIzX4yqtyBAfCku5dCl
         Ty2F1H9hLUio8ssfUEYYXlFRgMlfFExpgsQjIGNg9h3OxOrqEsl3dgQ7VBeFq0k472vv
         1oDow602YO5GDzMMKWwomOa+7nLCgLDB5U6nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079216; x=1717684016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkahyX8u6JGzvIeilItTJthc9WtmLgJJAVhcv6F2DV4=;
        b=Y97b0px6JUT60jGwohpjy4scBYswnsn/ACIkH43Vm3DAswxXTbhv9i5L8R466kS3n7
         yL5nM1lM9rbN42Zu2yByQGqFeMjYB2TBM2yqi9l/Pbi0/H7LP6yRzlLZ8SQuafSpT7Z3
         yqqrU4OwgryyBwp3jKPjQe1aZvmAUWA6dGPUIfCTEzN7oDBBVRbnql+ikF787IzhhQmZ
         WxGdJJitleHPB5IWG+pEgIUY5H6ReMaxz97A5JkEOdDWc02ys0sJqtoL7G13BsoVTq1w
         N4fmXFfcvJiTvA+cbDQfNhCIH4q8ngYCR3DVpkKAxAZUmVkH8OSxBsciGfxka9iPFGCM
         m6cA==
X-Gm-Message-State: AOJu0Yzvpww+G2TlQ9JvMPRCTsBNLj0rhwKaOgm0bC42++HSFLDoMDjr
	Vz0iXtMRSy/mxfOkSIEfsEA9I3jugjfLapIN4wwh+7fWZxdEC9Sx+3QmQhKXb/pomuqF3FJjfvS
	z
X-Google-Smtp-Source: AGHT+IFLLKqSrovK8cQJRFxomB13UN6bVYbMe6++DVEB/EWoh+bXvGd8O+uUMm9X6huLGkfUX+y5bg==
X-Received: by 2002:a05:600c:5246:b0:418:fe93:22d0 with SMTP id 5b1f17b1804b1-4212781631dmr22041765e9.11.1717079216144;
        Thu, 30 May 2024 07:26:56 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2db:3695:26f3:1f11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270791c7sm26684295e9.31.2024.05.30.07.26.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:26:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Improve handling errors during parsing when profiling
Date: Thu, 30 May 2024 15:26:53 +0100
Message-Id: <20240530142654.3095813-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 14:27:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16287

We've seeing profiling tracebacks when parse errors occur during
profiling. Try and avoid these but not processing invalid profiles.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 255b9f199a..673af8daec 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2236,12 +2236,13 @@ class CookerParser(object):
             profiles = []
             for i in self.process_names:
                 logfile = "profile-parse-%s.log" % i
-                if os.path.exists(logfile):
+                if os.path.exists(logfile) and os.path.getsize(logfile):
                     profiles.append(logfile)
 
-            pout = "profile-parse.log.processed"
-            bb.utils.process_profilelog(profiles, pout = pout)
-            print("Processed parsing statistics saved to %s" % (pout))
+            if profiles:
+                pout = "profile-parse.log.processed"
+                bb.utils.process_profilelog(profiles, pout = pout)
+                print("Processed parsing statistics saved to %s" % (pout))
 
     def final_cleanup(self):
         if self.syncthread:

