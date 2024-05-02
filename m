Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C2C04FFE
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 18:35:30 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web11.2300.1714674921463642092
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 May 2024 11:35:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UxKQQHAV;
 spf=pass (domain: gmail.com, ip: 209.85.166.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7da3ec3e044so378805439f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714674920; x=1715279720; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OormopJ55MP6fDVkkhYQBjQvxxp+BCBjAtr29/2vGIA=;
        b=UxKQQHAVy8Q0cVeYwadOKjBw/VeU9zGi3K9C0cs4REPifGJN3c+B5w1LQDs3JUGCBM
         vfNuxxR4cyhikcmERNtR6wImA8EX7PxuAatY9ZE/PjmJ2J/w+o2vqQA3KO2Nq6Pjl/Bp
         35VbjjKqrvLbDffbeT2Fh/1ND1MQGdLli5mKoBUrWJxidyqvr12YxuD+kyGpH6wHUd4K
         zDmCSRuB9aBhFJxjh+gFm3gmO02mpJPzPVAZL3Ox5OYTYNkiX50B3oZ3Q0TqT/6tUsp9
         pFLLpsTxpN91vZxtle0gVRszHFEvQp5uObKqCZnSyxuMLj6cQRWbMmD6VaI+g/EvG1Dq
         Xn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674920; x=1715279720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OormopJ55MP6fDVkkhYQBjQvxxp+BCBjAtr29/2vGIA=;
        b=itFNFTRSDHSKcPqwpoKqYUNBm8EJRIwXelz/GQ5cRpgqYMcUdaR9fTUiieHrQ6kmja
         /qqMHaOUT5f+WdTf1ZLo+8neUu7RjdI4TFYDceKJVC0w4e2KYn93IEx2QWxcjKLKHMnG
         3odhsO5qeRNegion6FtiggwBcXu2ZR8rtrcWqlotRYs43FTUOXvuICPt8CR2vB4EzVuj
         gfBQeYvY/1+hmwDxwT5HIsyEVdjhyg7MtMMKmT4c/ZqLxNM6HnhkB8J5ImsE7vcFyUgr
         Z1SoJtKvMQSFTEYMyrJq+hYnA4LyxNPEGUtzzkGl95cxZS9ocCzwdPKeYsZny8mwLwPZ
         yR8A==
X-Gm-Message-State: AOJu0YwAevfaUCaAvQB83p/zRfNyA8kimaY6rNxa3zzfcEzJhmX7Za3t
	Zngv+hvW11ECVWBI+scVdMjtJZJFy5rnwZfBETGBgIKCUaqhXnLPAJ3PsA==
X-Google-Smtp-Source: AGHT+IFR3fSzKNE5E1oAWbn2OhnMCblR9bcAtgdQeFVV6Rqufqy3GoGDvI511pWB/OGm4O1T45Kd8Q==
X-Received: by 2002:a05:6602:6d8b:b0:7de:d568:ef14 with SMTP id in11-20020a0566026d8b00b007ded568ef14mr722142iob.16.1714674920117;
        Thu, 02 May 2024 11:35:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::d802])
        by smtp.gmail.com with ESMTPSA id b5-20020a056638150500b0048791026142sm342490jat.34.2024.05.02.11.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 11:35:19 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] asyncrpc: Check websockets version
Date: Thu,  2 May 2024 12:35:16 -0600
Message-ID: <20240502183516.1216885-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 May 2024 18:35:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16184

Checks that the minimum version of the websockets module is present, and
if not raises an ImportError. This allows the user to get earlier
feedback if using websockets is going to succeed

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/client.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index a350b4fb126..65f3f8964da 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
@@ -24,6 +24,9 @@ ADDR_TYPE_UNIX = 0
 ADDR_TYPE_TCP = 1
 ADDR_TYPE_WS = 2
 
+WEBSOCKETS_MIN_VERSION = (9, 1)
+
+
 def parse_address(addr):
     if addr.startswith(UNIX_PREFIX):
         return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX) :],))
@@ -39,6 +42,7 @@ def parse_address(addr):
 
         return (ADDR_TYPE_TCP, (host, int(port)))
 
+
 class AsyncClient(object):
     def __init__(
         self,
@@ -86,6 +90,24 @@ class AsyncClient(object):
     async def connect_websocket(self, uri):
         import websockets
 
+        try:
+            version = tuple(
+                int(v)
+                for v in websockets.__version__.split(".")[
+                    0 : len(WEBSOCKETS_MIN_VERSION)
+                ]
+            )
+        except ValueError:
+            raise ImportError(
+                f"Unable to parse websockets version '{websockets.__version__}'"
+            )
+
+        if version < WEBSOCKETS_MIN_VERSION:
+            min_ver_str = ".".join(str(v) for v in WEBSOCKETS_MIN_VERSION)
+            raise ImportError(
+                f"Websockets version {websockets.__version__} is less than minimum required version {min_ver_str}"
+            )
+
         async def connect_sock():
             websocket = await websockets.connect(uri, ping_interval=None)
             return WebsocketConnection(websocket, self.timeout)
-- 
2.43.2


