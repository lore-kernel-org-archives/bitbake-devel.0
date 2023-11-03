Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7596BC0018A
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:16 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web11.52766.1699021629976670173
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gunkGnVo;
 spf=pass (domain: gmail.com, ip: 209.85.210.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d319933f9fso1206151a34.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021628; x=1699626428; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=gunkGnVoUr7xJmp3YxNp/KavcKjbxi9ftkJVlft7cXTHsjoQnolacx9JpTZpd4wC8f
         GPIERU3BuJDTZXfA6ug/5pZ4/PyP7QyuRZCsRCieuzp6dVVYXZWgf0NDCoNub4u+8DZ/
         uP08Rwq4+luQwXRaOn4kkLYvbQ5ZOu2pkdFr5uNC0asrMpz17Tb58AYtMM3ylRSBGoWy
         90M0+qlpE06DPzTrAk0wfbF++QlwIdVCWKBFvy0XygFuwGtTn33xzm7/vqOvYIWWJdha
         anVIgyV6ws154jzMoSj5gJwrwrE550qibEroz5BAJg0O3Ys2MsE1oPsHPjl4lnxJxTlz
         1Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021628; x=1699626428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTKPh9sj2EDbdVhywQexu2hR6Tp9+rmuqUmdyEKNXms=;
        b=pSFTUFCzXYMvwaXo84b+bQQ4pGSJRs0+TgCF8ylMM+xT23+tsc2X2Iknnaqn6tCEXu
         6D7mA4ZjpQ5vsBLjjmf48tc+AWnD8cDHsB55MUEa7o7ljc0cmX1dQ/Y1zFGvZlKUdOaL
         oHPTMr3wG4uI3k/fAHwCVkfh5lMFXvPg801DEmwR8t76m4o3os2BzlrYo3Rmglw4tNTK
         0RVWNK5EVIpj9bnaBFn1Ba3CeYo5vw/dFmjkgBJLzLZGpIomsw7bcf5YqEv3ssmacIYh
         o18bWf3xG6L1tqBKW2/fpZuU4ak3ewTC2EJGK5bPha6LXVwLmk0TdtuJ8TRGEGXl5owz
         1B6w==
X-Gm-Message-State: AOJu0YxMd6PFn8gWGM4+hIVvyLY57YGyXKi2E6BBpdkhOTyNAELVEyz4
	0KnH0cfG7aTuH8Q/BstDtqUN2y3s5yk=
X-Google-Smtp-Source: AGHT+IFTApAo9SrgZdjch1BXuSQ9vVTS0F19SWAFWDbwj0xyd8B4uKou+TM4xvj+nFeOAtzX9Qonlw==
X-Received: by 2002:a05:6870:13d5:b0:1f0:5248:c6a6 with SMTP id 21-20020a05687013d500b001f05248c6a6mr4134344oat.51.1699021628690;
        Fri, 03 Nov 2023 07:27:08 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:07 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 11/22] asyncrpc: client: Prevent double closing of loop
Date: Fri,  3 Nov 2023 08:26:29 -0600
Message-Id: <20231103142640.1936827-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15432

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


