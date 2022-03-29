Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B790C433F5
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:28:02 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.7458.1648564080772424932
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h8CyEOUW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id w21so20533795wra.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JVbUVfXAYv56QT8+yrD8AwyJtTP1eOGwcft83b87yRo=;
        b=h8CyEOUWSdc9VMgXCDEfRnyd3qyUw5z2bAPS7rIGPz8RFJ7PejxpAdIKimWleFUUmW
         /0S4r7dI8njlub6oofn50Q2JgxVd7+b2VtVr6a0WlJeri0NGUdQ1lnvqPNJyDiQdi+nd
         WwpYzOve1BJxu9LM1t5DOOoyb07EPwgMzIi88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVbUVfXAYv56QT8+yrD8AwyJtTP1eOGwcft83b87yRo=;
        b=RxNIeJLlN2uhAqH3d9en8n0jRksptZUIJeB45J2V8RdVL0Wuo6qOrgK+My9rhgRh7r
         wHm48qwlbI6HsfftK8v3FEb6UV3ibKGtUX2uq1lrmxkE1GStfPY0/0UcsP0fN5Ss7pp1
         /IbPV5kGVNyyzi/PlmY8wUKjJSDrYyomOdNmzftQj50vxc0ik/nVsXYcBI8VYmCB+xip
         Xo3AuowYYym/mqmeCav0oc6JbIYf9cj0ue8JgaJ6RYFUl4Tzj+JLxqH5d2k8tlxCg1XV
         pIYVjETdZWO6BZytai5OFmvkoJZjkD09n90tar3diLGEejVq5IhgrT1fmpC604J4RFGW
         XXHA==
X-Gm-Message-State: AOAM533ZsTKVaBvk3y0BeckBJgv9LANJJZUBvaTERL79gFiLhgjFv4nk
	lB65cVHdB7XypNw3NLG/EclcNRJrlNzbqAL3
X-Google-Smtp-Source: 
 ABdhPJz4+kl14KPD8xMVPT0881PxiXsBRNevyhJ9KtIKmeeunZAPJefK5QDbnf4tfsqOrzNwNkZQ6A==
X-Received: by 2002:a5d:62c9:0:b0:205:c0ef:7cb4 with SMTP id
 o9-20020a5d62c9000000b00205c0ef7cb4mr15231349wrv.688.1648564079079;
        Tue, 29 Mar 2022 07:27:59 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm2529043wmb.1.2022.03.29.07.27.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:27:58 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/6] cooker: Improve exception handling in parsing process
Date: Tue, 29 Mar 2022 15:27:52 +0100
Message-Id: <20220329142755.1473185-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
References: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:28:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13541

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


