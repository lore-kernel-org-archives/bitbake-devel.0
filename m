Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1669DC41535
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:48 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web11.10730.1698853359752075805
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JgWdglT8;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b512dd7d5bso4722351b6e.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853358; x=1699458158; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=JgWdglT8t5FXyAkcz2E29qQpeEZDhFn4p0uEykPNpevl2xrc4GieosIP+7UlvZef0e
         cpmH0ykOl3lfyukrh3n5zyH3bjd5H8xEs60l9n3uxdwynqQoXSWH503PnXQzz6vm10zB
         Ntaw2MYmvLcAKPfhCpvBX82dlT6w8X85GKFd8Z8aZxgtKsKRx33DEFE0k7/03A5tzS9X
         6pV/UptRZtOFtBOQnDPEPj4MXJJYYqiJiY1t8RlqF2GVY5Qviolyvele7j5WFoR3s7OY
         mSSyzciQrGNi3uOobkdwXanD49Dhg71qKTDw8EJTnbDt7DYhES7nePrmpYd8MjvEgAH2
         pDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853358; x=1699458158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=OtC3wjwDYzOdVaC0ac+B8S6FE6GoTk7e0wlpt7gkKkxmuC1fpNQ9DqwddlPjA4nC0W
         nf3QLC5fmfYp77gXD9iKbXZg8gI/WYyZ50eyrDlwFUgu9/Kg1Kr8SSNmDUOGOqD/XIPg
         KevdzkHgXugpAmsm4NjbklUeFiFSbnCi9NL8qZ9KrNFr1Qof/xmRf7vbljcGiv9N4GnG
         NXisH0rM6p98JwbQx+SDiIfq1HC5oIBuKLxPP3I8DDrsMeGLbBmr1hyuY5sRDratDNuk
         TBbAVrLBsFUBZVWbFr8LnY3zO316yWMgZZIzW4fdfDQVSeFxmNZ4fnDJFU+k3d0yVobH
         hM3w==
X-Gm-Message-State: AOJu0YzUK7wKstVfXNybi/rBSpqrNNrppeg4KI7/POPB4EfFVFgIXsoS
	D51WqRLf1J4vv7OQUkbXbHtn9Ffxyq8=
X-Google-Smtp-Source: AGHT+IH8RrKYvxeIVH6uNIjzaHx/sdMlh1nwHNb6cj4vZz3oxy2Oy3kzxhJibEaOFjFQQeP6jxdOUw==
X-Received: by 2002:a05:6808:4409:b0:3b2:f3a6:a238 with SMTP id eo9-20020a056808440900b003b2f3a6a238mr18618615oib.19.1698853358075;
        Wed, 01 Nov 2023 08:42:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:37 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 11/22] asyncrpc: client: Prevent double closing of loop
Date: Wed,  1 Nov 2023 09:42:05 -0600
Message-Id: <20231101154216.2758185-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15393

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


