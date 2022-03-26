Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4065EC433FE
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 20:35:06 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web09.7396.1648326905291493609
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OQWsSl76;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id d7so15076925wrb.7
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JVbUVfXAYv56QT8+yrD8AwyJtTP1eOGwcft83b87yRo=;
        b=OQWsSl76la173OdHIkNgnaohgOQKZVsvgOhg1yLOA1PHn9RVkzyoe5HMELmZAn7qrk
         +WmagXaPjuUDKs7cSskW7PGigQV6uEc+XuMuUqw0MzjJyU7vlXltBhmZQSf4Su3gnP0O
         pHbABOwgA2iITDyYoJ0ZNhSZSiBogmKW3XM4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVbUVfXAYv56QT8+yrD8AwyJtTP1eOGwcft83b87yRo=;
        b=m+9X/0tOxRgOoVkDGhD2AZraBpTYcxxJCokgO5qOHyrEuNkc1qQdF226kvCmm9O5eJ
         utGYyhri0HauZAYEutTAmf0nGj2WkG/hjKTQNyM2QsXbHcfFnlSq3FR0MH8M32FVjVHK
         xKRSnA9dGdjSez4SoJIUU1hzh18eTvc0FhK0ZQVaG4d9+V0NtEwYCkz45Wap29do+tJC
         wIJVYdq6HaIXOE52t65ezziVoo2mBMT/3iU1ih4bwzmZaZOcmN/aoySj5Sv1a8so17/N
         /GgFjwgJWqqvimN890YcnRO1QH9tPv/xZazWqcwCX0aoYAwVkZtTNwSrHqwSD91x9bAx
         SegQ==
X-Gm-Message-State: AOAM531bAH1LwUW+djxjw+KhwfTg517FzQI/mPk6AjjAH6hXds3eMAo4
	btT7tz3J/8MMRVu2QIUP89F7DJ9MuObxnjVZ
X-Google-Smtp-Source: 
 ABdhPJwq9nRuYC74DdCIMES9KrTKdyEIpJTndY57Um8TJxn5JgDmQBSXSB7++xBbDsghGogRUVudqQ==
X-Received: by 2002:adf:fc43:0:b0:203:d867:9fe5 with SMTP id
 e3-20020adffc43000000b00203d8679fe5mr14631924wrs.272.1648326903285;
        Sat, 26 Mar 2022 13:35:03 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3949:59d4:6f55:52f])
        by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0038ca453a887sm12242586wmq.19.2022.03.26.13.35.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 13:35:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/6] cooker: Improve exception handling in parsing process
Date: Sat, 26 Mar 2022 20:34:55 +0000
Message-Id: <20220326203458.1391301-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
References: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 20:35:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13515

If an exception occurs in the parsing process, ensure the cleanup
is called via all codepaths using a try/finally.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fb71a968f2..2264b18c54 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2041,32 +2041,32 @@ class Parser(multiprocessing.Process):
             self.init()
 
         pending = []
-        while True:
-            try:
-                self.quit.get_nowait()
-            except queue.Empty:
-                pass
-            else:
-                self.results.close()
-                self.results.join_thread()
-                break
-
-            if pending:
-                result = pending.pop()
-            else:
+        try:
+            while True:
                 try:
-                    job = self.jobs.pop()
-                except IndexError:
-                    self.results.close()
-                    self.results.join_thread()
+                    self.quit.get_nowait()
+                except queue.Empty:
+                    pass
+                else:
                     break
-                result = self.parse(*job)
-                # Clear the siggen cache after parsing to control memory usage, its huge
-                bb.parse.siggen.postparsing_clean_cache()
-            try:
-                self.results.put(result, timeout=0.25)
-            except queue.Full:
-                pending.append(result)
+
+                if pending:
+                    result = pending.pop()
+                else:
+                    try:
+                        job = self.jobs.pop()
+                    except IndexError:
+                        break
+                    result = self.parse(*job)
+                    # Clear the siggen cache after parsing to control memory usage, its huge
+                    bb.parse.siggen.postparsing_clean_cache()
+                try:
+                    self.results.put(result, timeout=0.25)
+                except queue.Full:
+                    pending.append(result)
+        finally:
+            self.results.close()
+            self.results.join_thread()
 
     def parse(self, mc, cache, filename, appends):
         try:
-- 
2.32.0


