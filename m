Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE58C27C43
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 15:03:00 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.16605.1716994975692149488
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 May 2024 08:02:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RbFHSUa0;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f89b16d081so1140182a34.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716994974; x=1717599774; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT+AVGUa2wX5QYMKVOCLG26C/Mn7UPSO6/Qnb1NRMRo=;
        b=RbFHSUa0Ja2V91F+L9ph1E07Thx53/t8vTimd85ICykZf97U5EXVrV8gLNWTT6CkR/
         COKCTS8eUp0pvlvN4r3Q4Km5OTxoHGJHZM/EuSGOobHYCW6SglFmC5bg/l3HVuI4b/Qi
         iyjdCCFp3LVov4bqRJXKbh5BcrBGucF607ui5ICIGcE9jYVN726DcdTxAPZoNE7qiH7i
         2K8Y2Lr4+Y2nQ0YvpwKhA5lJtp+AbaSg4SCaRW9hLqF1tnjoP/trcS4iR+pe2bppm7vq
         FasJTY0qSUJ7w0yKUbS2s/CRCv3b9RQnyruQOlhyGU1tumHlfC69zuwaAJzi+Ejy7Vgi
         at8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994974; x=1717599774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT+AVGUa2wX5QYMKVOCLG26C/Mn7UPSO6/Qnb1NRMRo=;
        b=Xq9wcRL3BwptbbhRvYd8PL5fC6MC+Ga3sI9ATcZPe2hXKND92JxInSYK4Q1KIXdJqx
         bKCPMVNBbZbjIJD61h9v9GblfICBvY7Nh2v0mpJusf5habpxRl6kcNJfPi0dZDf1A9Nv
         +GMyc3XVZ9TSBtHqhFqNrCe/eC0F/dzk2t5XtwXifbqMCbOQO26KeZ/4AvYUrVk9AMQO
         +gMXFS/SHC28ehCPFgWYEv4PtbV5DU1iHlA6i051HZ6rr0KzonmaUAUtkKVXzwVVacK7
         Ly4mwR/kBW4Jw0km0HIr8YhKRH5GO8RMJZUxNqTYvgf7AziywTbEgsj+t7r9Yq6j6JDV
         0oWw==
X-Gm-Message-State: AOJu0YwAPv9uAn+IrZFWvumVGEeXSrrYyciF+V8KLVM4kcZkXTXIdboX
	Fd7Fgwvfd957NCzl9KI6FIcYL4Wd3CIxIcxta5S6SQQivvUn4kZNsUvFxA==
X-Google-Smtp-Source: AGHT+IElELk9vG9gSQaVQIIWHrZVdTeIZxVnNrX+innL1E6GpjK4+nyfGfAi+cFepjOcCPNkNjPfXw==
X-Received: by 2002:a05:6871:694:b0:24f:dd26:1e0b with SMTP id 586e51a60fabf-24fdd263090mr12237416fac.51.1716994973498;
        Wed, 29 May 2024 08:02:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::980])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0daf302sm2338944a34.20.2024.05.29.08.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:02:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/2] siggen: Enable batching of unihash queries
Date: Wed, 29 May 2024 09:00:11 -0600
Message-ID: <20240529150234.3321732-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240529150234.3321732-1-JPEWhacker@gmail.com>
References: <20240529150234.3321732-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 15:03:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16281

Uses the batching API of the client to reduce the effect of latency when
making multiple queries to the server

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 03dfda6f3c4..65ca0811d58 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -726,10 +726,13 @@ class SignatureGeneratorUniHashMixIn(object):
             return result
 
         if self.max_parallel <= 1 or len(queries) <= 1:
-            # No parallelism required. Make the query serially with the single client
+            # No parallelism required. Make the query using a single client
             with self.client() as client:
-                for tid, args in queries.items():
-                    query_result[tid] = client.get_unihash(*args)
+                keys = list(queries.keys())
+                unihashes = client.get_unihash_batch(queries[k] for k in keys)
+
+                for idx, k in enumerate(keys):
+                    query_result[k] = unihashes[idx]
         else:
             with self.client_pool() as client_pool:
                 query_result = client_pool.get_unihashes(queries)
-- 
2.43.2


