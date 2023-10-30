Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED71C4167D
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:14 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web10.158341.1698693488953434286
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NbFx0uVT;
 spf=pass (domain: gmail.com, ip: 209.85.161.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-586beb5e6a7so2496643eaf.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693487; x=1699298287; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=NbFx0uVTpqpA9aRR+HtKbhOQbiXByIV6zcvEED4aVIl/s1sC+crUmNn3XnbAKbXv8z
         6G6Ykvg1betZkZWI717zBLaM+DXCqrvJW6+MyQuT+DjZsc61vlUkkwySSqnY2zPyxHYL
         rzKUhRtfHGFaUYySZhy/0dOdu1ysQfPE+CqaySJ4HKVv+ctJ/Tl/zBtjzgPpfzAE8fZj
         cpqDKTq1yYTHD3xzz924v4ShaxkhBbpNzrBeZ3UbRQZwt4s4fq4a37nS1ap6v68CG9pE
         MahthB+syYZlkhufXEQIDiPlxEqNQeqEmmJA7QYEz8N5NvXmN52EudkspSd0GzRqOKpE
         f8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693487; x=1699298287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=AOlwRkY7mnqZEcq9aF3k53veB7t7alfz0hmv5wp5WY5Pa8QbEBP5QIZXTe2t5WqdzM
         Io7aRdA72e/LJOVqrDeghxDarbw2V/wTyQU8Fjs3arCUVksJaKj2uCVcf/DU4l2dUPAU
         pXFJAHmI+X+UYckS0ylYKdnN8QX5Pd73x4pKhq7L8gy1o3xlJERasuChNBtZiiBgq9RZ
         OYRjorI7ht7GXSYE0av+H+eDBv5JfFSkPBDr1zwle3s64rdnYwLbVTy0jjUFk+md78d4
         A8yL//s+RbfF5uRgNY76ajO8wNRblyTwUOWCQFC6TvMRp3qayENoiN7J+RCd1xjOyWQ+
         zKGA==
X-Gm-Message-State: AOJu0Yzl8uFEcmOcxJBb8pOTk21h3e/V421txkOnY8wUvOOkLbjBWtFv
	F1mR+85WQiTh/yYmtjwlEnhUDQ8uWHU=
X-Google-Smtp-Source: AGHT+IF0LAmkvKQLu9P0hljPxKgEAZF9qfim1KsfXDUTbdxJAeylpwJQABUn3d8i27li1F6oBuhFlw==
X-Received: by 2002:a05:6820:138d:b0:581:d7b1:786f with SMTP id i13-20020a056820138d00b00581d7b1786fmr10560334oow.7.1698693487640;
        Mon, 30 Oct 2023 12:18:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:07 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 11/22] asyncrpc: client: Prevent double closing of loop
Date: Mon, 30 Oct 2023 13:17:17 -0600
Message-Id: <20231030191728.1276805-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15313

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


