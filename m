Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22102C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:33 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web10.1635.1698772946750058308
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cJ0ug4Sx;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1eb39505ba4so3932074fac.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772945; x=1699377745; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmv0nnOBWU+1/KLQu6MWkwgLc5RM4zELn3J1P+yjhEc=;
        b=cJ0ug4Sx/D9rQxuw3EfA6CLvc1NhGHnyr2uKrh/ajaKC2D2ajZA1U+hUFcOvFBzV3z
         OSOw9KrTVat5M9kiZ1StGXO7nDgOn/VZk9mJTGNWoyvFSQ3Et7CH2PEUBs/WCvnLkYMJ
         tdFrA5NNkF4zJSGELuovArF0OoroMyQ4BCygbVuTcB3v1jzqpHHRUeMB4fdfDrpcqez+
         TaGytKKYiBzNuTt2Bh0KdkJPDj2VLVVM9/KYiaTBoCliUXUX6mMKv0qpWcqULZuF8WLM
         rATkmu+gQ7aMqAGfhotHgJtc0A2cTFxcMBE6SQ7L/9P4OsD46K/gfjFFYcjcbavngMKg
         or3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772945; x=1699377745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmv0nnOBWU+1/KLQu6MWkwgLc5RM4zELn3J1P+yjhEc=;
        b=n5Y7DSgtcZ8RLUWsOiosw/0aB89QUNosPm1mwSqVarzhNdNQpg8N9IrHkkl8KrDQma
         rM4z6RLZ8Fj/ZbmF1/dPXpT5H63K6fFWFpnUqoxBhzIpJmVG6Y4cvWgvkSHT+qql2W1y
         qDFds14c+GAjyvSy9Qr+LWVonOBqeh/iAirdXLd1gDZgZFwdtV7vlNfrHo+4kpkcirM7
         lC7TqN9W4RMZWvyi9RdsM4oYqjw5Lbwi9C2exVnRoiazTgFluQey1cGEc7JguIeez+ec
         +eQ4+4Qnm4hpZ58aLZlSa1sbN+ygvNUnpbDQjuVrsxX+8zkVMzVwK3w+WgcxKgYCcGJ7
         KOGw==
X-Gm-Message-State: AOJu0YzZjizf6hW/DB93OLMCebTRYXQ6R63KndCR4G6gwuuRObxz7wKv
	7I4giuZ+Sjx2H+cxtM1wWKPCqA/x0qo=
X-Google-Smtp-Source: AGHT+IFGKwrF1cwuK2yj9v0uRqyYqboJcxpxH7YZniVUfGEnEuPfJkDvBIyoPiMGyiui4N9sk86Iow==
X-Received: by 2002:a05:6870:a108:b0:1e9:bda8:ba79 with SMTP id m8-20020a056870a10800b001e9bda8ba79mr15340417oae.27.1698772945080;
        Tue, 31 Oct 2023 10:22:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:23 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 22/22] hashserv: server: Add owner if user is logged in
Date: Tue, 31 Oct 2023 11:21:38 -0600
Message-Id: <20231031172138.3577199-23-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15372

If a user is authenticated with the server, report them as the owner of
a report

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 3 +++
 lib/hashserv/tests.py  | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 6da56df7..a9714b5b 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -474,6 +474,9 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             if k in data:
                 outhash_data[k] = data[k]
 
+        if self.user:
+            outhash_data["owner"] = self.user.username
+
         # Insert the new entry, unless it already exists
         if await self.db.insert_outhash(outhash_data):
             # If this row is new, check if it is equivalent to another
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index f0be8679..a9e6fdf9 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -828,6 +828,15 @@ class HashEquivalenceCommonTests(object):
         for col in columns:
             self.client.remove({col: ""})
 
+    def test_auth_is_owner(self):
+        admin_client = self.start_auth_server()
+
+        user = self.create_user("test-user", ["@read", "@report"])
+        with self.auth_client(user) as client:
+            taskhash, outhash, unihash = self.create_test_hash(client)
+            data = client.get_taskhash(self.METHOD, taskhash, True)
+            self.assertEqual(data["owner"], user["username"])
+
 
 class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.34.1


