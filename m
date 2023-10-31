Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED358C4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:12 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.1623.1698772928906366354
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=c7LKSo9l;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6cd09f51fe0so3432196a34.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772927; x=1699377727; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=c7LKSo9l0h/dRUS16P5KfEKAjHpf2w1jNkhJjdqjkW1gUXLUw1mMjogbM9+95QRxbd
         50xe5eQ3yYPt+6gbKsf9SSNAC1bJRuT1VzpbjAH5FrWFrfrScigiW1pB9bR+ZtT2bew5
         XXmYYUPYdbVc7cwNzG/vqhLHi0BAOJCsjdU+JIkPU47J2myMpW97IXoK/nS8w1xZ2yGc
         4uXp1UkRePJpMaBMk/A8bBuOQPrLW6/Tj+yDVdHkcIwt3vUUTWmZMYV2QEQw+BGhPKbA
         1Mqp1ZZcx5oBlhjWpgTK8dNR6liF2BBluYl2MU6WQYffYalpFL7o7FngmLfUpkRqOPX5
         1Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772927; x=1699377727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=ZBHHm/je6yi6EqUaQuDNtjd/6JQkiibfeHb8S8BmWvYfrPKnGYrXeGgqP3rC7eoV0y
         KyPlzXMWT7DfgXWjpr0miMekJq4SszD/xTSxVHQqISTAceAYDFPCoAVme4bjquYL8BUb
         Mvq5hs1l+iUCxZGBZfzLOt5PW5qy8uJ2tbEa70ylwwJFmzWA+RfkbkAmBCuOotTMCORP
         fKqAnrC8GWnQnAwRXNBPBvZO0rF52ZLoKZGhTYE0YTJHwWCg+1a7YRQ7Mj3AAxFHMUoj
         Lp4vdsUI+zboK5FFfmIyDiD6Eu6tk0RuQDmapHCBmUeka0b76N8Qk3MBaF3OqhaEBZTj
         ln/A==
X-Gm-Message-State: AOJu0Ywfe5iyZM8M2/jwDWyMFnnAUNgzXQNTrnqi54JSsjQjl4GJc+Ww
	xXZL0e/oN6+ISwRlYJFD9pZqKSATXMw=
X-Google-Smtp-Source: AGHT+IF9iH/YcTeJkgSAcOZkitN8gw+dDiV03C4qEX4Pq9jA8Fn3PCmR1XRNscwe416+Kc4cnDSJ9A==
X-Received: by 2002:a9d:7d06:0:b0:6d3:15e5:c698 with SMTP id v6-20020a9d7d06000000b006d315e5c698mr985570otn.18.1698772927632;
        Tue, 31 Oct 2023 10:22:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:06 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 12/22] asyncrpc: client: Add disconnect API
Date: Tue, 31 Oct 2023 11:21:28 -0600
Message-Id: <20231031172138.3577199-13-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15362

Adds an API to explicitly disconnect a client. This can be useful for
testing the auto-reconnect behavior of clients

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/client.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 628b90ee..0d7cd857 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -67,11 +67,14 @@ class AsyncClient(object):
             self.socket = await self._connect_sock()
             await self.setup_connection()
 
-    async def close(self):
+    async def disconnect(self):
         if self.socket is not None:
             await self.socket.close()
             self.socket = None
 
+    async def close(self):
+        await self.disconnect()
+
     async def _send_wrapper(self, proc):
         count = 0
         while True:
@@ -160,6 +163,9 @@ class Client(object):
     def max_chunk(self, value):
         self.client.max_chunk = value
 
+    def disconnect(self):
+        self.loop.run_until_complete(self.client.close())
+
     def close(self):
         if self.loop:
             self.loop.run_until_complete(self.client.close())
-- 
2.34.1


