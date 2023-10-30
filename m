Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10845C41535
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:14 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web10.158342.1698693490567107671
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O+MoIqNM;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso3340683a34.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693489; x=1699298289; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=O+MoIqNMnkRm6CbgKSG2ws2d0Tk+RSohRKxzu6gvgPsxA/r63icTopEBNNP0vYOxVN
         CLQ6VfZwRUesG1yfj10j+FFEVGIf9Wu38zWvFOYw+Sw3A/VRBT09123MMRax4vt8XxEK
         Djf7HCZTCn0Yns4+4bZtuzUqAoJ+95WpQyFa2sf/TGBs1eVn6517yx/7hOAth1jfBdBW
         YfW86uQZGS/wLYNoWtfB/plfHl9LptTTpT6926GsPupbfmYmbyK//uBFxwWKqNwXzEQk
         o1CHRvIc/QQ7Shk11Pwq8/fQOShPp0a43s/HYvcF07cUR3uyhn0pvZMIWgp9kOWC3Ajn
         4Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693489; x=1699298289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBoF9jzhrTH8y4QaAGhK+D6ntMYK/OqwEm3pJB0/qQQ=;
        b=dCZDaKoZLTPyZoEfY28FDqt2G1YNdxy/Qky1pw86wnF06iIXfwiinkn15zLaWSuMZz
         HBIBbiNZ96jE1lIC/4twX8Nl4ce5l++ej3Ezko2IazOfYSjf+56nGtbSlQ4b3QzqdXkU
         bcEoNi3/dNKX+7Tj/K6DXu+fHr5YVqeV2RJ1UYrFOi2WU/FZXW+hJ8uWuMx/sXIOOTwo
         01xNVcpLWB/XP+nvynPi10h90qBl3ZJ+WM6iH5R23/LhCTvHhjMG6M2pWszch85CRcjz
         XKygrXlMZ8bzzvw0ka6qHeb0l1Gtxgc1Sjj+wgZi/NWXUsmKpehjY06bVIiDPjXxHPln
         BG8A==
X-Gm-Message-State: AOJu0YxHuY05uJz5QvPHcW35h6UcXMLuvicKJKdTAXnwi/HnIDlvwiVH
	VKn9Yt4akFLcfqBHAV6KOkG832qWxa8=
X-Google-Smtp-Source: AGHT+IFFF24c/B4ZERuzA9KeftDwEGzZQVZpipydd2bOzaQi4jy5wZOVywzxap4KjixjkjwUKkkmfg==
X-Received: by 2002:a05:6830:14c6:b0:6bd:b0c9:a8d with SMTP id t6-20020a05683014c600b006bdb0c90a8dmr10408007otq.25.1698693489198;
        Mon, 30 Oct 2023 12:18:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:08 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 12/22] asyncrpc: client: Add disconnect API
Date: Mon, 30 Oct 2023 13:17:18 -0600
Message-Id: <20231030191728.1276805-13-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15314

Adds an API to explicitly disconnect a client. This can be useful for
testing the auto-reconnect behavior of clients

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/client.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 628b90ee..0d7cd857 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -67,11 +67,14 @@ class AsyncClient(object):
             self.socket = await self._connect_sock()
             await self.setup_connection()
 
-    async def close(self):
+    async def disconnect(self):
         if self.socket is not None:
             await self.socket.close()
             self.socket = None
 
+    async def close(self):
+        await self.disconnect()
+
     async def _send_wrapper(self, proc):
         count = 0
         while True:
@@ -160,6 +163,9 @@ class Client(object):
     def max_chunk(self, value):
         self.client.max_chunk = value
 
+    def disconnect(self):
+        self.loop.run_until_complete(self.client.close())
+
     def close(self):
         if self.loop:
             self.loop.run_until_complete(self.client.close())
-- 
2.34.1


