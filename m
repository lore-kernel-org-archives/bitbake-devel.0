Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA2CDB47E
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:25 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.25723.1697149043302302000
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SaVq5k6t;
 spf=pass (domain: gmail.com, ip: 209.85.160.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1e58a522e41so792840fac.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149042; x=1697753842; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=SaVq5k6tDiLSsqzJYyXK2LEapj0wO7e85rwHwnR3jODBL/gVRON4nDSp2OOnxkgjJM
         Fimlv//5SSHOXDEm9NLgzn3mRPZ/eb0GAObUC0B4dP0T70+kZUwIwNgYihcrZPsSFgZ+
         vviWEIOkLyvFhVRbR2YiZg7udRDPFC2gUdHA2rJ4ilCxGj/CU/4QLLPISYPSUbyP6ecy
         lhQtd85+nJGWdLWEJjhEBj4VeLyt0414RohYzm7z4isJ9LeDzZDxZL6kJW1zSFJXumWU
         B5FUhcVh1KL9goDtf3eVAqthbBD6JxpYPTJkrqPmzbw9nnz7dK11QVaYCk5BfIulCL6Y
         Siug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149042; x=1697753842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=XiHRaySb5g9y1GW5/Upeb6bfwDcU9arwbkjwWaHKNfTyGWHV+WWDpJpFNZgmw59rnD
         g2aYYCfn5z335aJQoo7csHDrkLUL+VWgeBxi3KLlOxuW9bZXOsDRjvkekPVCa/hP6nr5
         wMdoKQSBJLHBX60RdB4Uzy69YSIKYc1VwMfvT0074L3jHOQU9WMPEPD9+za+FkbWP2m+
         7PTLP72zOV5x0sp3t16rpXpOEm5bh//O4U3Ue88IJUFesuUUq0NAE/T1pvCTVC0QbgSV
         b09uhydp65a/RDdP/ZzHK9lNWH8O2ChM5XxcCnL5eTUCLcBWR9SYAzKW3/9epfYujt6k
         N8aA==
X-Gm-Message-State: AOJu0Yys8vSd9LlAwyo+Qy4Dd/qdRrNtmJjpbmda1OncrIl8VPQpHPz5
	2QriloBcIDUrp44yiVi4dl+vlAUj4uI=
X-Google-Smtp-Source: AGHT+IEkZP4hGleBh72WOo6FAfuTOL1gEJ8VyCtBobbTpMvY/MoFW6ttV0OmJW+7irU2OK7FDsl6Ag==
X-Received: by 2002:a05:6870:12d1:b0:1e9:d4fd:6554 with SMTP id 17-20020a05687012d100b001e9d4fd6554mr1119636oam.39.1697149041850;
        Thu, 12 Oct 2023 15:17:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:20 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 13/18] asyncrpc: client: Prevent double closing of loop
Date: Thu, 12 Oct 2023 16:16:50 -0600
Message-Id: <20231012221655.632637-14-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15231

Invalidate the loop in the client close() call so that it is not closed
twice (which is an error in the asyncio code)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/client.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index d27dbf71..628b90ee 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -161,10 +161,12 @@ class Client(object):
         self.client.max_chunk = value
 
     def close(self):
-        self.loop.run_until_complete(self.client.close())
-        if sys.version_info >= (3, 6):
-            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
-        self.loop.close()
+        if self.loop:
+            self.loop.run_until_complete(self.client.close())
+            if sys.version_info >= (3, 6):
+                self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+            self.loop.close()
+        self.loop = None
 
     def __enter__(self):
         return self
-- 
2.34.1


