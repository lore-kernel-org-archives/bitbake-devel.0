Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E0C0018A
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:36 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web10.53518.1699021650416318110
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gf5fJjdu;
 spf=pass (domain: gmail.com, ip: 209.85.160.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1dd5b98d9aeso1049709fac.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021649; x=1699626449; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVTBMHtw+uH3r7jWecPdi7Vx0WaVCrAE6gHZopCXLfU=;
        b=Gf5fJjdufYhXz5x4stqypkFHIRGW6IPM4dRyXQ5N0m0avKRoBduDYHvfJ6OPlftNzJ
         gH/iycXwWmy06d3VvlwmDaBdOD5t8fPSnlIlJ8W4DK7wGNNc6X0miOE1Xkq5riUtk9kV
         F8w8r4JpEtEN3muUdqJVM4j85NVaDx839QdgkPKYnR83SLYLafrDRujKqIEOXzuyxw/o
         pe414E3hg4oqWXfP76ZKbMR3z/cQkuC9iEuIcujD7QBk28qBRNa0v2ZNL7W/2LVQnA0l
         Ieg79Ix7T7AmGlv+X+aHOfA8cvCyBOZShE3HM5j4IfQK710niaK8RHR98wSKDfWTlpS5
         hB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021649; x=1699626449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVTBMHtw+uH3r7jWecPdi7Vx0WaVCrAE6gHZopCXLfU=;
        b=OGk/+nZHFPNToChSmcvT6XLaI8pRBQQ/E7lEwQlN/h2af3213Grc+7k/HkQrJdP2ph
         TxOauKihf0e1QHX1WMhQMzed9W16obTRH0slzmfixsxGwLWN2A7wkAUxbnhpPvu96stL
         2ltsH4A3iKKTS+wao/IfWTyK4pxCeNAXkkf3t797WZLDoDQrgFAo2HNcoP2+9OuMsflM
         2A+vlVtbSuJthodUdkE9/sqxpQWiEymIZ+IuGNV12JpYiSLX/XPmvqf2RuY/nj+X8q1S
         vZvRqHzPJRxc16Kz1Tc5aLE8X4U3A93zmLaCEMYT5MZ5W74VridC4uq13LrdpBaopyCl
         WCsg==
X-Gm-Message-State: AOJu0Ywo256yY0Joom6jyoclBhDnRqDvvIBe3eEU2ObKrJ954WR8ucbu
	Zk4InzHlmVGWVhRHkdW2OguWVa73D7E=
X-Google-Smtp-Source: AGHT+IE4bqXcCgUGQS/NKbf58AKIuGHxSSYAK3WyVXKiJbnjZ7AlNZUGraKC2fDu0H7OTXfX/ZetWQ==
X-Received: by 2002:a05:6870:47a4:b0:1e9:7caa:896 with SMTP id c36-20020a05687047a400b001e97caa0896mr1329415oaq.13.1699021647784;
        Fri, 03 Nov 2023 07:27:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:26 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 21/22] hashserv: Allow self-service deletion
Date: Fri,  3 Nov 2023 08:26:39 -0600
Message-Id: <20231103142640.1936827-22-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15443

Allows users to self-service deletion of their own user accounts
(meaning, they can delete their own accounts without special
permissions).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 2 +-
 lib/hashserv/tests.py  | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 8c3d20b6..439962f7 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -709,7 +709,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
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


