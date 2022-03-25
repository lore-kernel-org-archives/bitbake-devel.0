Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC7C433EF
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 09:29:18 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.3103.1648200556822153533
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 02:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=caVKy5nS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id t11so10025130wrm.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2i1V81xIb+SLb5DJbFAyAjfhSiQZMK7KmDRHGM2gIYk=;
        b=caVKy5nS2GlIrH4uDgZnjysAbPYpLzq3elGBdWQ+cpeFSGQ15bWYtENoRQhg13ntYd
         haiPsrJwM54XTGzcWAggarTl/AaHk+n7mBhjjxdmza6HlLRM6vdd7+BZzfKdNLdYZI5r
         Wiz51NrCl5HSLWFqXaD3Gonnvd/BZP8lED3gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2i1V81xIb+SLb5DJbFAyAjfhSiQZMK7KmDRHGM2gIYk=;
        b=1AvNXk8ogD4L6mE1OwYvj/6TeMBLWDrVc8CIy1/weswgoNqMQtB2D2jq6kucgM4U9L
         yPYyrDESfhoz1L7IQjdvnYBp829H3AyhOt9ASPnGOFwV1IaoEVa+xhX/7ct8JgRUQzWy
         fTEAyH63EUruBNPE8Pf6A/RfoPzuGj90iHg+RmCEKaVXwzNPQSnUUBKb+samWj3UPCXH
         X1/sIq+nuJcdF/jR6I1E2poUhrGOV1fWTJKXdv5lBkYwa13UDsR5InIvsr8nVLh695gp
         BU4S6qS1cyF2xcJ3rFh38OwHDxhmuKuTvJvsJHGfqPQvt0BseYHDtJElMqWhy42Doz8A
         d2Kg==
X-Gm-Message-State: AOAM5331pBmCHNw7s3VZ1IYJ6Ni+SLO2yk6BVnK1/XEN+BKk8nZJaB+5
	p/kaZUnlCiMBGmGFTZ7kWOoG4kJwUa028t2E
X-Google-Smtp-Source: 
 ABdhPJxm2d3UBqyeaHG5z0T1YEaSmJt6YPzGenEf2EaShmZFXg63byMHtefYN/gaOZGRDtHIq8Szfw==
X-Received: by 2002:adf:ec04:0:b0:205:8537:af5c with SMTP id
 x4-20020adfec04000000b002058537af5cmr8066017wrn.357.1648200555052;
        Fri, 25 Mar 2022 02:29:15 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f167:7010:a0cc:679f])
        by smtp.gmail.com with ESMTPSA id
 p8-20020a5d4e08000000b002054b5437f2sm4478904wrt.115.2022.03.25.02.29.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 02:29:14 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] server/process: Move threads left debug to after cooker
 shutdown
Date: Fri, 25 Mar 2022 09:29:12 +0000
Message-Id: <20220325092912.1350321-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220325092912.1350321-1-richard.purdie@linuxfoundation.org>
References: <20220325092912.1350321-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Mar 2022 09:29:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13505

This debug is useful but the cooker shutdown or post_serve() may have cleanup
left so run after those.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 1636616660..efc3f04b4c 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -243,9 +243,6 @@ class ProcessServer():
 
             ready = self.idle_commands(.1, fds)
 
-        if len(threading.enumerate()) != 1:
-            serverlog("More than one thread left?: " + str(threading.enumerate()))
-
         serverlog("Exiting")
         # Remove the socket file so we don't get any more connections to avoid races
         try:
@@ -263,6 +260,9 @@ class ProcessServer():
 
         self.cooker.post_serve()
 
+        if len(threading.enumerate()) != 1:
+            serverlog("More than one thread left?: " + str(threading.enumerate()))
+
         # Flush logs before we release the lock
         sys.stdout.flush()
         sys.stderr.flush()
-- 
2.32.0


