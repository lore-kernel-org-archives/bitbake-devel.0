Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1184AD1F9C0
	for <webhook@archiver.kernel.org>; Tue, 15 Oct 2024 18:53:51 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.4808.1729018424308366208
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Oct 2024 11:53:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=C1kl0C+y;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.42, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so4219356a91.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 15 Oct 2024 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1729018423; x=1729623223; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nwyxXOr6TMnByWuRFS6x/ktCptdHySNj83x3jhda14o=;
        b=C1kl0C+yco5VvsfzGQk+JvpIDy4+XkyRv+cRJ2OSNd7R0pVbJUsnaoZHDMdL+5MLEg
         jKlqyPfgFSLdMnMoNEeHTdvgnfonHxGhOieb1TrLfGIFA6cHzquyFMvTuovPQ0UHhjia
         +U9bbVi3LG4gNtREZ1oZYm1td15pyJvmCpKEj/snc110GNdjH0oq8FfBJZBQ9qXAWV6p
         RkH7JYcQSipIMuEzQt2mnEXX1KbeBObHy5qijDaQ2jdL4OBsss4Om6kAVy9oU5kh9OSZ
         PDeqpaUIIR//vv6HFDaUcSppVopg3ucHp0bK3Na2DldgQ2EKdNtgxObXwe7CUk8GjVOu
         VfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018423; x=1729623223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwyxXOr6TMnByWuRFS6x/ktCptdHySNj83x3jhda14o=;
        b=ivYcntvWXD913ZUn3ON+y18hYBsGFBLGsNoJzCm1ukRGMSdk3Xycp4IH5E8DT5qPhT
         trmyiiiQug83vaWKIMHPFXrmsPSonAr58odndtnZLllJHc3xpV5TBhGkG0MewS5iUWtC
         ntsi69PMiyidCT/lhiMlQYWOjsH0xAVZ92iGePWHS7lb6YzdGJnFdKvRsggR8XQgIHkX
         JBtCz16M09pzisqm62M3SMmKTSbQC3VahT3wt46pXZJX+Y27OQbNyYJsNJS30P+bata2
         ydSM7ogZKXWFWNlqfr17pDHg6sIkdbSAh2495gP0B+MH218n0cdgsaz1A1Wis9IJOh6F
         45nQ==
X-Gm-Message-State: AOJu0Ywhi/O6Gyqpqo9fEiOm74euLXi9cPLCJgszpxC6Q3JSNNMCdpxL
	dVe9g+/uuRQFbHWzxiM/bmaE1psg3QSpss75E/Oj6ZkCTzRAo4xsxJESslSd7FUi/jV27OHqb4B
	w
X-Google-Smtp-Source: AGHT+IGYhn+xN5skxSBp4MuM5DXD5q/3j/dDQX0A6IOmc3Z+0HJd7sV/xS4y3uzAWc8n+wEFiCfx+A==
X-Received: by 2002:a17:90a:4e47:b0:2e3:171e:3b8c with SMTP id 98e67ed59e1d1-2e3171e3d84mr13640891a91.25.1729018423632;
        Tue, 15 Oct 2024 11:53:43 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f62b58sm2192768a91.41.2024.10.15.11.53.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:53:43 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH] asyncrpc: Use client timeout for websocket open timeout
Date: Tue, 15 Oct 2024 11:53:36 -0700
Message-Id: <270c0c8bdc802c04fd3021c082d58cf8e8d68d82.1729018312.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729018312.git.steve@sakoman.com>
References: <cover.1729018312.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Oct 2024 18:53:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16687

From: Joshua Watt <JPEWhacker@gmail.com>

The default connection timeout for websockets is 10 seconds, so use the
provided client timeout instead (which defaults to 30 seconds).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 23681775e5941e54ebead469addf708fca1e6beb)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/asyncrpc/client.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index a350b4fb1..6fa2839f4 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -87,7 +87,11 @@ class AsyncClient(object):
         import websockets
 
         async def connect_sock():
-            websocket = await websockets.connect(uri, ping_interval=None)
+            websocket = await websockets.connect(
+                uri,
+                ping_interval=None,
+                open_timeout=self.timeout,
+            )
             return WebsocketConnection(websocket, self.timeout)
 
         self._connect_sock = connect_sock
-- 
2.34.1


