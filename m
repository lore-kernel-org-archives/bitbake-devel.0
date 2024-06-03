Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E2C25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 16:44:08 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.88889.1717433048011037438
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Jun 2024 09:44:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mZvISu1r;
 spf=pass (domain: gmail.com, ip: 209.85.160.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-24cbb884377so2732074fac.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Jun 2024 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717433047; x=1718037847; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ8lOlN38bDpePnC7V9iwzXadkR0JhIrLEpJbsJ1wzE=;
        b=mZvISu1rgaw9gGIZblPG60XStiomPpmd8AX328VfQ7YxGRTESLvkKc3MNVCGCuRXMa
         nhSSs0HOCiW/4n2tLWUZJQTLrV7kRKv/eOanguQtf8YG/HGrq5GeJxIi36BtPFtm0Yk5
         DuSm2MIotxsH+kgSyuQeRVjsW3N46XrOJ/a417q9HEBnJp6kMJmkDeVAEbZMsjEAr39A
         o05JHFuSDziTkdHgMlRBeXVGMRuRF6MvPu2vmaT5gOR8ND2hhsSkiQplDg9WbLCsdqSX
         xDoTiXQyrkNXi3+MIM35FofqGqUKpXD6ps/usava0tQoO6X/ha7P1zdNdzNecI1RoGAQ
         wiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433047; x=1718037847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ8lOlN38bDpePnC7V9iwzXadkR0JhIrLEpJbsJ1wzE=;
        b=NZ496j499BBdUwAg+Z+m/xHG2YWnF3hCWZoVHHZ4h2DfbdgpV4NQoheVKBwZVUXIRo
         2l2nGAGyQ25PRj4/x3giyaGqUvVX3qU7D4yzFFEVXaYlC65h4sHm6YKAxIwLaShbStiG
         K5clDqtK1YDZ5bMY69+4wtOvRzx7Xx7oc5PYmjvof99GUeY+kAafLa91RWGHvnvbobNW
         HXCs1OFmE0nuINAi/J7I8ksQQkVIVmduupEoRHtX+RcCb8e5sPeScp+3uaVJw+fv82OU
         hNCJVPraWrFyUVJzLxtA0S2CrOnFXkmwNxKfFxDeGXpzCN+/cRnw/K6Xlx9o5ZdLLeCF
         qhog==
X-Gm-Message-State: AOJu0YwlDyfslgXb5YbaawNQCOL9V6T+LCm8xOeDV00iPBaLvRrw7ezb
	SdJ08+RoDC927SRVviLYLY/ZBxisJcixBGUUsSBWa8AvUUcyJpzztIC+8w==
X-Google-Smtp-Source: AGHT+IG/rwnmvOgRjWzBsbb0fa9orfduL0V7jsPpiTTBOPVkp2SofDEdjK5zSqQvg/U3dckeoRnOWQ==
X-Received: by 2002:a05:6870:b486:b0:24f:dba0:46d3 with SMTP id 586e51a60fabf-2508be171d6mr10621132fac.10.1717433046491;
        Mon, 03 Jun 2024 09:44:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::3969])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25085000afasm2517049fac.23.2024.06.03.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:44:05 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] asyncrpc: Use client timeout for websocket open timeout
Date: Mon,  3 Jun 2024 10:44:03 -0600
Message-ID: <20240603164403.662265-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Jun 2024 16:44:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16313

The default connection timeout for websockets is 10 seconds, so use the
provided client timeout instead (which defaults to 30 seconds).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/client.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index 11179b0fcbe..9be49261c0f 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
@@ -112,7 +112,11 @@ class AsyncClient(object):
             )
 
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
2.43.2


