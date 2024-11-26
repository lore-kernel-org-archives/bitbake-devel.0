Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB52FD66B85
	for <webhook@archiver.kernel.org>; Tue, 26 Nov 2024 22:18:45 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.58751.1732659517636115930
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Nov 2024 14:18:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y3fF87Ul;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71d4d0516e6so1518555a34.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Nov 2024 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732659516; x=1733264316; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIv9oVkMFVVl2hkX2xI8uBEDk9vfZJMo4RXXEoWzseQ=;
        b=Y3fF87UlWM2ovLI50mYugzMN1IO6ylHsWmZgQpXhaSS42n5maY5HpIidlABwmfROGd
         SZhETo5BTEccVxvK/QCVpJZbyMIcHIeE+hBOPdZ/7fZ++yBIa7zp50N2IQgLkB9V4kZM
         +FKBjJDw7IjiG/lp7VuSlXmsS9aarTSi8z2EVIhbTyebDNqMyCcCX75VvCUdPbiYnGJr
         M98nMQe1baqSEzftR4Z4yuXDhDvdFAt9TZfussTXixTl4k2Gkazbc1dXERWdwR+cNKS1
         KjtEjfJJWiZWASK3s7zlV3LmzVkK8T8WBRdzmopVnhOUTsGCGpQW6zti685/eaBQibKm
         ZJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659516; x=1733264316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIv9oVkMFVVl2hkX2xI8uBEDk9vfZJMo4RXXEoWzseQ=;
        b=NUXGADXdNAsc4Y6Akmmu0i4mQQEi0ALjjrIxS9w7/aE6qd+8tv8jAFJpFhSorgpqaP
         0RMou++egyZU8+xBxD83M5Ab9vPfZOyrfdcS4RrUpUXJjBZilIbH9AMWMMp2PTJsq3nl
         KYsX1fdfyNSdiMFB9ng5DuhBCcuutcc6DZXb1zQk5cNi5o3hPmHI3INY4bwcMFOAlggr
         43iXKzgSNV0dDStLI/vnI1Ng2d6RLJqMLoniZ1V+Jix9b7POuGyjCZr3rHvaCuLfadPD
         oYEEEQXDprjl3ZRa1BvKPmfP1x3RqRSuUqjcp6uHhxosL20sjqgb7RXiZVnK6WPXvY3K
         WJNg==
X-Gm-Message-State: AOJu0Yyrz7rwg1O8psknAVJtrPKbfU4olfzGM//yw8+k8AmL3C48Blku
	ueEa5K5A5RaX96L9KbA0OWFs7Ll/5YMv2fbg9j8qHKFws9QJhvk2jzB2aw==
X-Gm-Gg: ASbGncuiEN8smJyokbPotj8I2n65u4SS+BMarbg+BC2hkMbEEujgggwawM13dbp1elc
	EtG+f+vstVqDplHUVjSkVsobyIIWdkYvO48PWDw4broRVVasVgM9CucFwQQ+avsv2VTk19Gj4JG
	qzicHaGuvNXh2i0VxLpQ1Qz843IjFdNsjPiAVE2fIZh5rouUxNgkw05y5tWbmUxdbAF2xB04Mbe
	fmRTHephh6zqC9WUTth+5CRbJeEN7etkNmtiW/pYoUE1Nyf
X-Google-Smtp-Source: AGHT+IH1FZ7Vxo7FhW6sL64QVilBevHvoXjcQKslTdTXk2IMAaNBa1bPKmofMlNGkF7sFE0Sl93FQQ==
X-Received: by 2002:a05:6830:6a8d:b0:718:194d:8a6 with SMTP id 46e09a7af769-71d65d34cbbmr760748a34.28.1732659516179;
        Tue, 26 Nov 2024 14:18:36 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::dc1a])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d5bdf568fsm776133a34.41.2024.11.26.14.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:18:35 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/2] hashserv: Do not print passwords in exceptions
Date: Tue, 26 Nov 2024 15:16:02 -0700
Message-ID: <20241126221829.2825101-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241126221829.2825101-1-JPEWhacker@gmail.com>
References: <20241126221829.2825101-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Nov 2024 22:18:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16840

If an exception occurred in some of the function calls in the hash
server code, passwords could be leaked because bitbake tries to print
function arguments in its backtrace.

Add the flag that prevents bitbake from showing argument values in these
functions to prevent the password from leaking

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/__init__.py   | 6 ++++++
 bitbake/lib/hashserv/client.py     | 6 ++++++
 bitbake/lib/hashserv/server.py     | 2 ++
 bitbake/lib/hashserv/sqlalchemy.py | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index ac891e0174d..d2471fe7858 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -28,6 +28,8 @@ def create_server(
     admin_password=None,
     reuseport=False,
 ):
+    HIDE_FRAME_ARGS = True  # Do not leak password on exception
+
     def sqlite_engine():
         from .sqlite import DatabaseEngine
 
@@ -70,6 +72,8 @@ def create_server(
 
 
 def create_client(addr, username=None, password=None):
+    HIDE_FRAME_ARGS = True  # Do not leak password on exception
+
     from . import client
 
     c = client.Client(username, password)
@@ -89,6 +93,8 @@ def create_client(addr, username=None, password=None):
 
 
 async def create_async_client(addr, username=None, password=None):
+    HIDE_FRAME_ARGS = True  # Do not leak password on exception
+
     from . import client
 
     c = client.AsyncClient(username, password)
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index a510f3284fc..13a6e62e7fe 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -80,6 +80,8 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_EXIST_STREAM = 2
 
     def __init__(self, username=None, password=None):
+        HIDE_FRAME_ARGS = True  # Do not leak password on exception
+
         super().__init__("OEHASHEQUIV", "1.1", logger)
         self.mode = self.MODE_NORMAL
         self.username = username
@@ -236,6 +238,8 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         return await self.invoke({"clean-unused": {"max_age_seconds": max_age}})
 
     async def auth(self, username, token):
+        HIDE_FRAME_ARGS = True  # Do not leak token on exception
+
         result = await self.invoke({"auth": {"username": username, "token": token}})
         self.username = username
         self.password = token
@@ -319,6 +323,8 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
 
 class Client(bb.asyncrpc.Client):
     def __init__(self, username=None, password=None):
+        HIDE_FRAME_ARGS = True  # Do not leak password on exception
+
         self.username = username
         self.password = password
 
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index 68f64f983b2..61ddeaad80b 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -793,6 +793,8 @@ class Server(bb.asyncrpc.AsyncServer):
         admin_username=None,
         admin_password=None,
     ):
+        HIDE_FRAME_ARGS = True  # Do not leak password on exception
+
         if upstream and read_only:
             raise bb.asyncrpc.ServerError(
                 "Read-only hashserv cannot pull from an upstream server"
diff --git a/bitbake/lib/hashserv/sqlalchemy.py b/bitbake/lib/hashserv/sqlalchemy.py
index f7b0226a7a3..54aec55b24b 100644
--- a/bitbake/lib/hashserv/sqlalchemy.py
+++ b/bitbake/lib/hashserv/sqlalchemy.py
@@ -115,6 +115,8 @@ class UnihashesV2(DeprecatedBase):
 
 class DatabaseEngine(object):
     def __init__(self, url, username=None, password=None):
+        HIDE_FRAME_ARGS = True  # Do not leak password on exception
+
         self.logger = logging.getLogger("hashserv.sqlalchemy")
         self.url = sqlalchemy.engine.make_url(url)
 
-- 
2.47.1


