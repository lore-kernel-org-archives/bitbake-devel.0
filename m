Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32396C41535
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:58 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web10.10817.1698853376740258510
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S+VQnepG;
 spf=pass (domain: gmail.com, ip: 209.85.167.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b2b1af09c5so3569972b6e.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853375; x=1699458175; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xleCVOaiuk+jamuqyn17pFhqNMF2hNul8RH+LBR3ufk=;
        b=S+VQnepG6ZX1iKVdGlXchd8hshBlYegQNNkUNbD58YEVh2EqfT0+FVWQcRIeQO+rtl
         C9GF9TVUeNPjc9XPplEW1gAJSZ+aD1PUQWlS5nWdIhSJEk9FV5o2d0FujOtauF2strLO
         k7AJ1y6R1YnetQQ6KwaIilxV9pRm7Q59DsM1tysZKOyu2UeyFsekRjdbif8x+D0KvVyY
         PR/vMsrWn7oWJywoICnRKt5lKOL+KnIFT6/6m0fp3wpbLX4ROa88kNgFxzakIK2VBf/J
         N0CiFEhniR2gzStXqBk4XsXeTKSAPY/pdlm86ZEFj8i3X7yZlC0vIbYfEhcDBAipk/8e
         3ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853375; x=1699458175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xleCVOaiuk+jamuqyn17pFhqNMF2hNul8RH+LBR3ufk=;
        b=QDbOa8Xy6RXxyrOO08KT6XUavqrKvCHMz61HzyLYBzjjdYgWduJyY7PHABWfcrxolb
         T+tmRaTrd12P3fB7X/zXFvFqGhz+IkMTl/cvdR/r8Lk+6Knjr51/obrnyVS+eb2sK8LO
         VLDEaI28sZq5OTFwg9p9jjlYv/BvjXWTZk/l1c3C4fksqZszZBGuLKLrPgqFbZacnD9c
         qVUz+QQpO8pIR3kJuzZ23+3GeynlxRbpPpQE9sKb+UssrRZ0w4gwkRlJV9h89Kp4nSO3
         bfxCztbaZkDUHuEgLibeuYekPl7aVA9B8KGORrBAXWOzWVcVOzQORIU2+xz36O2UZ55e
         Q1kQ==
X-Gm-Message-State: AOJu0YxQKqgL9gXsXfrKRPNw0qko+LqkhONQDbwchWYS7HFjZAQch38s
	IlMoKkDQPwo2TzaO7ht0tUOnqUf8kuc=
X-Google-Smtp-Source: AGHT+IHib/o9iTEJ6sTiEcrs9yBiB+IDWDAjpCXTMVVIu6l3kcNBS5mzmp4pLRTWXvwhwIubqU7X8A==
X-Received: by 2002:a05:6808:68a:b0:3b2:e56d:b335 with SMTP id k10-20020a056808068a00b003b2e56db335mr14441656oig.4.1698853375040;
        Wed, 01 Nov 2023 08:42:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 21/22] hashserv: Allow self-service deletion
Date: Wed,  1 Nov 2023 09:42:15 -0600
Message-Id: <20231101154216.2758185-22-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15403

Allows users to self-service deletion of their own user accounts
(meaning, they can delete their own accounts without special
permissions).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 2 +-
 lib/hashserv/tests.py  | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index d2fd75df..6da56df7 100644
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


