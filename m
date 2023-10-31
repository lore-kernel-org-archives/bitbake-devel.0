Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FECEC4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:33 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web11.1690.1698772945042904539
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ILmOHcdh;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b40d5ea323so3599881b6e.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772943; x=1699377743; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xleCVOaiuk+jamuqyn17pFhqNMF2hNul8RH+LBR3ufk=;
        b=ILmOHcdhm3SzmQud9OmeTljfPyl7zwtBgW4EP6ktkCxZ63YkeXhoYMTTmcow8d1gRx
         8XllycOPxNDbhqle7NCgLadYZiMPWxTar+GJpqIiIVkSh5gZ/FhVseMOcwb6HHKlPzCA
         qYAaLUQLWVsvzdNDJhuXPVXOf6vZ/u6N6ZJGHS5tDD4svFRbP8sl7RDxJl3U8LLaA4db
         6VTNvbfBArSJzjG93F8h9tC/9lM2WcKBRPE4vQ7Ot/4p0XCu2IiMDew12QswJ2zKEeA4
         sNyF93pLZ1k7FEERg/bISvQORLUi2caVFMkSI04pYUWGnj+vhApRM/O945NZIQl5eplp
         D7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772943; x=1699377743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xleCVOaiuk+jamuqyn17pFhqNMF2hNul8RH+LBR3ufk=;
        b=jro5xb+jehO42xh4fVUEg/R+h8n0o4u5pQw0cuCw/FT7PmJjQ7f3r/3YrZLMqJk+OE
         v+8tEpOo2xHWPIFBQtyw9dheGBwUz3m+va2YxmCz7s7iK3j3hUL8fP7In37YWz0C4cRX
         a5CUHDgtTH+aLziKa9zzAzX0ZCalgFgE7j1bF99AGflaxfSTVNP1XVl3OGwYGolnRB/z
         XqN6H29XEJW9tiYGcRsF0ueoC6jDSC+qJFcc0I9njybb2rTW3471fb6k50T53XyelO5u
         3AZ+mKj+FSuD6IlJx/nJpWCMIcilCZNE37wUJLC43716tFCi1hZd+2Bi3aiLCgsrPUXI
         XbbQ==
X-Gm-Message-State: AOJu0Yz359b0Dlzv1xWmlBqY+TmDsbSjtoYLtQpur3YYckzi4yhBKaAx
	w4NRUq8vKzX4MqFCMb2XyfSsySeUZJg=
X-Google-Smtp-Source: AGHT+IE0CZTg3ZoBVfjKaZSCaxQg2pXrOMADSKiGLCzs+LOEVfqZyrtAOcJUaOv3Vw0wOkqU2Rk35A==
X-Received: by 2002:a05:6870:114f:b0:1c5:56f:ac08 with SMTP id 15-20020a056870114f00b001c5056fac08mr14299557oag.12.1698772943159;
        Tue, 31 Oct 2023 10:22:23 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:21 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 21/22] hashserv: Allow self-service deletion
Date: Tue, 31 Oct 2023 11:21:37 -0600
Message-Id: <20231031172138.3577199-22-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15371

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


