Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62772C001B0
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:58 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web11.10742.1698853378065166136
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TUv4MxFN;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2e73a17a0so4389289b6e.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853377; x=1699458177; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmv0nnOBWU+1/KLQu6MWkwgLc5RM4zELn3J1P+yjhEc=;
        b=TUv4MxFN99sv+LrJxgi2FlPTwldhUwaOyyJVgDM1TuU/AIHPDfnVzQW5oe2zh56SUl
         YLASQ7ry5SWGTMfcvpv4Jq6hN7G3QifHKJJmk+gbe1JuNzR8dCbBTThBXLJucLxyl5tl
         qYSovWfaxP2GCm2VOOWNa7CiSpcy06SHgE1iiJL5zLKr9lR78zW0r4resQ/1AUAvgBRS
         oCUFZHt1xxbLDV1fjuHnSQ+uQvl8QzQNLVYlcYnjKWYwgRTNJksp8P+SkPljiLnrQ2gn
         3R8DaSJxK//yOLc1GCbi9QgTKwOgoQUSlA6Y2t490KQZyzukV25niAYkuwtt1DGuVl9z
         474Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853377; x=1699458177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmv0nnOBWU+1/KLQu6MWkwgLc5RM4zELn3J1P+yjhEc=;
        b=kpC8JUyZuSG+KxIMeoqHGtzWjXxOuaQL4dyXED/1uJd2TvvBBaQc5Ax/TFJGxXq87W
         OHH/ivTiqV1puEC/6/PDfyjlarpklboEKnriR1+asUKGqpeJT7I2AhPRqXV1W4Jvhs1a
         ENZkg3Wjoa7FnSHRtfR1yFHUoxW4sA+zLmTCk+xYa0Qf5vEY7au24exKv0VwuA1Qdmvv
         GryPlOZpcJ0b2ap9YvLhelYpctRofArvtU+c874KRhfU0G/kdIFsR3n0gh5zDtJ4N5Se
         jpcSmvPrBBaMHRxhxWtGEUivvaegWnJMjhCkoSPl7k6bb60g4Jnw9F6qH7KooA0H2cz6
         c3qA==
X-Gm-Message-State: AOJu0YxCGtBYtxl1BuC2ssHsYCw/D5wNA3xPl3DyN4IrZ7Nn3bKhjPpd
	fpuR5tjw4tOu0H0KZB2aI2KfLVlhOR4=
X-Google-Smtp-Source: AGHT+IFG3MGPGpP6VX5K8OtdqIra5Jo0YauM/y5JlbqxhU6M/FsZMNW0NX/7sTiMuPEiaRXa8nVIeQ==
X-Received: by 2002:a05:6808:689:b0:3b2:ee75:31f with SMTP id k9-20020a056808068900b003b2ee75031fmr17963857oig.49.1698853376835;
        Wed, 01 Nov 2023 08:42:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 22/22] hashserv: server: Add owner if user is logged in
Date: Wed,  1 Nov 2023 09:42:16 -0600
Message-Id: <20231101154216.2758185-23-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15404

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


