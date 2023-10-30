Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0CAC4167B
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:24 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web11.158505.1698693502863020017
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eijR83QY;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce31c4a653so3250248a34.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693501; x=1699298301; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3oSLM8FoWJdRGxDajV2BJx8pDQU3/Qx5klaEYYXV5o=;
        b=eijR83QYVQ8VIefU0vc37pefPVJ+zKI20Pla+JQ6Ik9GDGR/Lvydc+7XqG40wZosm6
         15SCLfNeVCQ1ccD6FdR6nTJhd9MOaSCt0W1efuhrZT22BDTvUJBJSYo7YIm9kgdgLpy/
         J+arZBxbtqqDfCHkasyegBK/PXR2qTciYTcOTkK62x3woenhvyjU6j+iXlx1Ll67MeHE
         XAY6KpBqLkwfJMLjBiRuKAqYvaPWWyeumHosd3RTdkTt9PbJEV3gqK9B22u08JAC+7MW
         V+qsEu0gRShVNzGQyih42zWIEDNhlxAsCZGTTYyJM/VM6B7ELkL7ZTx6GWPX+EDKE+ex
         0QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693501; x=1699298301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3oSLM8FoWJdRGxDajV2BJx8pDQU3/Qx5klaEYYXV5o=;
        b=b87a8wU/OZ4ol6hGyT8QNYsRAsv/u4vc3gklszdFPe3Q/nsIKbO5PSuARrDuRsb40z
         FA0kNIx9M1EAxuriPb9AwHby7nrF6ro7DHuxSnbLXx6X8k9fX6dS51rutbhYjDMkSgmg
         jfN5jU9+E1HblcAO5+oxO0+I5CrojderYjwEcx/0OVmEcmBnUFY/9UlEu0My9fncBakd
         ys7ihtB6OzcZ+oj6QgjjuB/jVNUetqJIT7KuMGIdNL5hgQzwq1zCiBBHehCTwjKYEm8b
         k1RPFbUhHiWPk3NlfofnTwkfZ/jXyishQHAaExjsUafahMF9+BTiz7PgflRst0UQZzF6
         F3aQ==
X-Gm-Message-State: AOJu0YxnTLiRwmhmHeP6VI5rlkubousUZ+F1VbOL7QCZkF9mPSionwAy
	CyjCdR4rc2UNVItF9DKwPIxIuiy7eOE=
X-Google-Smtp-Source: AGHT+IF7/FFmpv5EWQ2a1iGQMGFLmUKgwCxB+Szcq9cyUD+hbCA5Hw7FYJIPBaBsFlu0SUXjBDKCLw==
X-Received: by 2002:a05:6830:3494:b0:6b8:82ed:ea2e with SMTP id c20-20020a056830349400b006b882edea2emr14238779otu.4.1698693501668;
        Mon, 30 Oct 2023 12:18:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:20 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 21/22] hashserv: Allow self-service deletion
Date: Mon, 30 Oct 2023 13:17:27 -0600
Message-Id: <20231030191728.1276805-22-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15323

Allows users to self-service deletion of their own user accounts
(meaning, they can delete their own accounts without special
permissions).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 2 +-
 lib/hashserv/tests.py  | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 3bbcfcf2..5362457e 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -708,7 +708,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             "token": token,
         }
 
-    @permissions(USER_ADMIN_PERM, allow_anon=False)
+    @permissions(USER_ADMIN_PERM, allow_self_service=True, allow_anon=False)
     async def handle_delete_user(self, request):
         username = str(request["username"])
 
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 5d209ffb..f0be8679 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -683,10 +683,13 @@ class HashEquivalenceCommonTests(object):
 
         user = self.create_user("test-user", [])
 
-        # No self service
-        with self.auth_client(user) as client, self.assertRaises(InvokeError):
+        # self service
+        with self.auth_client(user) as client:
             client.delete_user(user["username"])
 
+        self.assertIsNone(admin_client.get_user(user["username"]))
+        user = self.create_user("test-user", [])
+
         with self.auth_perms() as client, self.assertRaises(InvokeError):
             client.delete_user(user["username"])
 
-- 
2.34.1


