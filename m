Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26293C0018A
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:48 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web10.10811.1698853361088881493
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZUmMXVtF;
 spf=pass (domain: gmail.com, ip: 209.85.167.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b566ee5f1dso1108175b6e.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853360; x=1699458160; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=ZUmMXVtFZh6NgRY1VAQCK8ohajbi8H0S6/N9wGNEL2xBI1gWSOTSKeNVJanGpcX24j
         xJF+PG0rTEbYrgf0fmJ6GP4Tqcig/tO6ccmfF4LecNsxM10XzP3/8OC4A5tkUjzvpSff
         ZQEk9t8Z5t2e7awACgUs55HR/X36Z3eKOS33sXwxXyfqhB6Z2ouYEaqllVmNa57xzThN
         z0/dmXH3mUcoLYpbIOJSb3vI7S1tat13y1V89syaKA/xLh7R0zV9vkm3BxM4wcEaSU+H
         MzZUUNzeavc8Ha3VYnrN55d3+IeToViC7xpCvSAIck2xgo8ZijIb2txVvaV8NDpk1zGA
         XHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853360; x=1699458160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=JKYJXohPxBEHo2IydXUqb4ZA+8fqcM+GYQKskJEn7w/pEfGIbAzIRCPcTVAg5qMqVP
         3spK8KbDb3HD4fNOYX7Sf4paK9lU07G/RkNxuFNkyD141RCqqHgOpcK+QoBNyJll2Esw
         OMFewZga/XDOMgTd/Sbrp0V715rt9kjRzBL5QhIdwH8k+B0mjOtLi0s7KLsaV85tdzjH
         NTP2FBa106f+n3NySjjVCJu/eRqfLXE/tQZuLuanRIHQbLQ3j0RiSrlECuSt1GDvlmsf
         GvRfct5410ZRjvIhAMLdphAbSeIT7twqBCMQvh2bVlneH2jStHiI96b1MvBll8CHIY8/
         U3xg==
X-Gm-Message-State: AOJu0YwJEoNuehDbXnW99lA4rMDYC3IBoWHhzdE9Qsqh0a8bYIrwEWyu
	P0ytRslpJnBf7yPgD50ohwk7muOmtZw=
X-Google-Smtp-Source: AGHT+IHvdWPMN/XjuZHPnpf0XZAzGiIxyrEjwEM7kD90f1HOqZdBFtR4I3WGrFI5W8ENxX4HTKPqZA==
X-Received: by 2002:a05:6808:3a97:b0:3ae:5c89:dcc2 with SMTP id fb23-20020a0568083a9700b003ae5c89dcc2mr16829256oib.34.1698853359857;
        Wed, 01 Nov 2023 08:42:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:38 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 12/22] asyncrpc: client: Add disconnect API
Date: Wed,  1 Nov 2023 09:42:06 -0600
Message-Id: <20231101154216.2758185-13-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15394

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


