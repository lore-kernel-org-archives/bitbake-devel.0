Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191F7C53210
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 11:52:01 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.10981.1672919519611793843
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Jan 2023 03:52:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dCMBvJlt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1108843wms.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Jan 2023 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6XHCO8udO82zSjxA1mD8t0o2seywuirYm+1+/fotRI=;
        b=dCMBvJltxBTZ8QUPp8Y3CBIYEAFz6n/wTS6BPyp6emcWRnGYLQLNBzmODTUTMfyqMB
         XWJ4sdH6NW00oHUPmM555Vl0ynIOZFOgH4KXVcpqGODzeyxwcsi+yzl65XVzB+W8VSBx
         8vskK6I+v7eMyYMPzxkz/A3nMVAZpSIxMDbtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6XHCO8udO82zSjxA1mD8t0o2seywuirYm+1+/fotRI=;
        b=0C9OiPvSHxgI6jXD8RVCIWxu0021+gFjt03+YjrAayBdA7OM1BqZCcD6G8dWt5bBu6
         0PFJq3SfRqsFidyTG/b8TskymE2SjIQTGQ02J9DahA6+uvBU8GxTEmUY/Xxl2lPeKqDE
         sXNWh2ss4M7o4xAfVIaeJybD8Jv7R+kruk0VAK1QFIlXp4S4Z3T/Cr3EWZSxszBgZKjb
         QcPzW3hVW/oc0EBPwrVdAuK12JSTk3MKbNbHDt+bdARYhdZ3OMj6emWYg+VNjsFC10Ff
         /+RQ69JX/STB8V2RzYWTLL9fDuNzLRBR7LpZzYmSrth86sJGDONxhMerttKxYD4DpEQu
         VW5g==
X-Gm-Message-State: AFqh2koHLffnaXQFEOyvaZ168BYOcF5Ejit0CZrpsi/diOl2dgsjRwQj
	ZZw8OdD/W6MidVKqFxQCx7ci/ihDojeutm0n
X-Google-Smtp-Source: AMrXdXuVgDdpSwG1h2IFMEGdEnrF6NZvcpdjVtgcZClV2wAEGsihd60KQtk8uIRV61kzW48mxnV9fQ==
X-Received: by 2002:a05:600c:34d0:b0:3d6:b691:b80d with SMTP id d16-20020a05600c34d000b003d6b691b80dmr35747648wmq.21.1672919517395;
        Thu, 05 Jan 2023 03:51:57 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:990c:167e:ef8f:7586])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm2363988wmn.28.2023.01.05.03.51.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 03:51:57 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Rework the parsing results submission
Date: Thu,  5 Jan 2023 11:51:55 +0000
Message-Id: <20230105115156.1212181-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Jan 2023 11:52:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14289

The loop submitting the parser results was not efficient on many core systems
as may of the parsers could block for a long time waiting to send the results.
While a result was pending, the code wouldn't parse further jobs.

Change the code to parse further jobs even if the results can't be submitted
and lower the result submission timeout to keep the parsers busy.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 738849d189..1d347ddc52 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2107,25 +2107,29 @@ class Parser(multiprocessing.Process):
         multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
 
         pending = []
+        havejobs = True
         try:
-            while True:
+            while havejobs or pending:
                 if self.quit.is_set():
                     break
 
-                if pending:
-                    result = pending.pop()
-                else:
-                    try:
-                        job = self.jobs.pop()
-                    except IndexError:
-                        break
+                job = None
+                try:
+                    job = self.jobs.pop()
+                except IndexError:
+                    havejobs = False
+                if job:
                     result = self.parse(*job)
                     # Clear the siggen cache after parsing to control memory usage, its huge
                     bb.parse.siggen.postparsing_clean_cache()
-                try:
-                    self.results.put(result, timeout=0.25)
-                except queue.Full:
                     pending.append(result)
+
+                if pending:
+                    try:
+                        result = pending.pop()
+                        self.results.put(result, timeout=0.05)
+                    except queue.Full:
+                        pending.append(result)
         finally:
             self.results.close()
             self.results.join_thread()
-- 
2.37.2


