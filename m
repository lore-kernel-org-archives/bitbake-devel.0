Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7598C00142
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:12 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web10.1622.1698772927650683278
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O9HxFJzW;
 spf=pass (domain: gmail.com, ip: 209.85.210.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce2c71c61fso3428013a34.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772926; x=1699377726; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=O9HxFJzWzENP7et18r7rAtFRHTvrQxfKf4ilhVzqKqtejUpSYNHpm9/S5ae+uczHcj
         tkp59lzgWsV9AVOZCpTft/d9XbLveV3cjoSZUzGonFnDTlFFd2Ls+5S8ZZSMl2tetl7t
         xwHh7TZzypll6lpV5f5CrP17RxeE3KW+AsrFUnKjUn3VWvh4g3WyikYhIG+ZtV2HQAOH
         DwC+GSoTWcgLgRFzbpW3U91rkiNwWJXwKacNoPv8jmlmcgILwNLdwOjSgjykEKlx6Vmw
         /55Trh1dn2cFnE8Abo4iqzie1bBz1+TWFtcZhN6CosHuZRERehxqz0RMuHO+7snlA869
         eJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772926; x=1699377726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=CXpPpGqmQVoTkfS0g2zf+HorgwRC4+d8WA7ZYxkk454RMBqRMR/qEuK7YEUkjF5AD4
         C3feVKXEvAIJF6K87SO0ewIYTOGl+Y5Gaz0BHxCt2NjwmHHU1CK0TBQS8q5UWyc8OiTw
         GMn7dhvKhvvJ+lLhykrTDX0H9MXbB7n3pNCb+03qrbNTI5SPkv/SPG/DH+VVCT5it//5
         5iwn+dMh65uQI9Ux0CI+4L2YVx9+yXVGfYSNIUxb9i60J6/PKaKpfGQvl6U4rMEu/DEm
         pKSjgiU9WD9Bi3kFGKXZi4h4oxIbQ+1f0qusa9soRrJjzZkMAsU2VtxjU31aOTHy4njr
         RedQ==
X-Gm-Message-State: AOJu0YxRrCtKxR8m3IovyvroxKb+QtApU5eqZSv16cxm7x4QROm5VlOR
	dYIAj4OJd4oTiDyzb1uNOPgduelJg3U=
X-Google-Smtp-Source: AGHT+IGCWfgpDUg4mZjekSR9sEqlQkCyyitOPnfCC+HhAcOFi7yWo/Me4kKjlW9btTBFvHj8AVuzIw==
X-Received: by 2002:a05:6830:10c8:b0:6b8:8f20:4cbc with SMTP id z8-20020a05683010c800b006b88f204cbcmr12263451oto.13.1698772925789;
        Tue, 31 Oct 2023 10:22:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:04 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 11/22] asyncrpc: client: Prevent double closing of loop
Date: Tue, 31 Oct 2023 11:21:27 -0600
Message-Id: <20231031172138.3577199-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15361

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


