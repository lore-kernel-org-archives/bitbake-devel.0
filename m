Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4495C54EED
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:23:18 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.6417.1674336189937221351
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:23:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RFDTL/Nw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso6617637wmn.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8rthqTUt6TlNN5L+CmC3N/1qS3TLrn4JBva87s4vig=;
        b=RFDTL/NwFRuRPHakBlZlmyn23OgGfkrhpYKCyw3K04OGrd8nB2+4std731KiruI0RM
         OX6RZAorBMlj9xPxDm20+fA6G2qaQwR4DRZgDKtu57Q9MgeKqiWo89NQCiCpTAj99Iko
         HGBi8EwQJnp/EjUsrj9xUupfNJix/W00Iu7L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8rthqTUt6TlNN5L+CmC3N/1qS3TLrn4JBva87s4vig=;
        b=w9PdT3A3ByTJke4ze5SUVsFShzCJYkJBMEjI2mua2YLuLcdl2NaD+5VPOWSVnwE17O
         svmf/LNqdR6CD3BOpLKk1VsMwukjej1iWMp0xj2ZHAGhFdz+YDVdqaRadbblJ8geyq4A
         yDPRk44epuecu6AWt3raL0Q2I1qkHxceEr75xknFTmVDNGMDz0ZYWj0Jo1FcH8nIEmWz
         /mtBpmo++romcvqxyFDy4VRo411arHdkdP0DzKM/djd+ay8xLElGi+YVozzk0cERAkrG
         lM3+wnysfc516Nc2qZPybmUHY21dwXchQi35mlSSNT8E0lUPiSom3C87qumbC1hURP0E
         c8sw==
X-Gm-Message-State: AFqh2koz0gLHrvUqqx1cr423UB48wH0F/i+B6WLqi4ZEIiGah2x/N7d+
	FtC49rUhGfzZ+NxbqzKuRVbOfDMIkcGoDKQj
X-Google-Smtp-Source: AMrXdXsxqEO5ei3Gu8Jo3bK4IA4tDizliAQZnq3ChVTRSqHcn39Qo5cIqImEHOjOG5Zt80sYbFgJuA==
X-Received: by 2002:a05:600c:3c83:b0:3d9:e5d3:bf with SMTP id bg3-20020a05600c3c8300b003d9e5d300bfmr18644747wmb.32.1674336188224;
        Sat, 21 Jan 2023 13:23:08 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm6713089wmq.29.2023.01.21.13.23.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:23:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6] cooker: Fix parsing race around cache handling
Date: Sat, 21 Jan 2023 21:23:03 +0000
Message-Id: <20230121212305.2171310-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
References: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:23:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14332

When draining the result queue from the parsing processes, cache objects
can be created even if they are then immediately destroyed. The reset
in the sync code needs to happen after any objects have been created.

Change the ordering to fix this. This ordering has caused various
cache errors, particularly when interrupting parsing with Ctrl+C.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d15ad2fb2e..527f6a0421 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2233,6 +2233,14 @@ class CookerParser(object):
         else:
             bb.error("Parsing halted due to errors, see error messages above")
 
+        # Cleanup the queue before call process.join(), otherwise there might be
+        # deadlocks.
+        while True:
+            try:
+               self.result_queue.get(timeout=0.25)
+            except queue.Empty:
+                break
+
         def sync_caches():
             for c in self.bb_caches.values():
                 bb.cache.SiggenRecipeInfo.reset()
@@ -2243,14 +2251,6 @@ class CookerParser(object):
 
         self.parser_quit.set()
 
-        # Cleanup the queue before call process.join(), otherwise there might be
-        # deadlocks.
-        while True:
-            try:
-               self.result_queue.get(timeout=0.25)
-            except queue.Empty:
-                break
-
         for process in self.processes:
             process.join(0.5)
 
-- 
2.37.2


