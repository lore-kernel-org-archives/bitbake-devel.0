Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76784E95A8E
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 14:16:40 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web11.62595.1696860994877128394
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Oct 2023 07:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y6j+EbTd;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1dd54aca17cso3422028fac.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696860993; x=1697465793; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpEMtn8acfIwTHcmO45zmc44Zs94LR9/LqRY2ushHKE=;
        b=Y6j+EbTdt0V1HwZWHOV251MCjMoV0HGhLLwV+/d9zGM/9vf9Dsy1cpETX4k4PJWlHj
         O1CZkbuqXfuDNoRsIP+bg72IrM5rAlXGVFrHxzBhH6QozLb4odmJTkhX7oP5PL4/Sq2B
         PzBWI3eRo55QX9xfK1uLN2s80WsTollaV/jeU0VTIZUVSbP9vbKIMlt0qB8CPm+cE3dC
         QrteSfYSV+jj/XIJ3Z2UOobsbay5IMlR/bHA0WxKDM7rgGMrewWOLVqWNDnZFWjYJeH7
         Vpgy6Qfpp1C2wXNcgsnnsu5s+l8c3OILzu6SSPF3YmA0aHarYZFPZ+7d9LqUw/NQX/uv
         kQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696860993; x=1697465793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpEMtn8acfIwTHcmO45zmc44Zs94LR9/LqRY2ushHKE=;
        b=p9aZ6zMt965wHE7Gli8Z9CSk6v3hIpf2aktGv69z+QayGYE0ya7y5WT8VAOgr1rchr
         +a4ZpiAAqdyhEE/R5hgpbCLn2NdeACreTxZoi5ejtpb5JiC1hnTySxOh3IQYG8XD5dhU
         zC6HlNr/H5GnFdZPz/0N2uV69739RVXHsIJDOcJ1h0mvkON5FHb9fgG/SPXddlwia9Mu
         4/0vmpk1epv3vEX/KdyJ9COd8iIRA46qhJTmBz7WXdNP2zlekGsZWxK11q673bpI0IOK
         ZEyilp8IrMkwLxjq53jZdQx90xqVI1dJwUFiFzhA1lVHRRGXorMyEHJA8jGFGyJcBxG9
         QxQA==
X-Gm-Message-State: AOJu0YzoRfxv95YRvQcgZ7aXIC62ySty1Ts52QVaTZR7P0i73q6cpDOq
	XeZNaKHpPfIOQFRt9D3Ipv92LV3eFrs=
X-Google-Smtp-Source: AGHT+IEnwY+AN+josWVbq/12ZJ06jHEuychO2pPxPo9lnKjjLfX9k7EJDThjXWhgX/bgPcqMHDNsfw==
X-Received: by 2002:a05:6871:514:b0:1d6:4b84:c7ea with SMTP id s20-20020a056871051400b001d64b84c7eamr15983262oal.11.1696860991664;
        Mon, 09 Oct 2023 07:16:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id hj15-20020a056870c90f00b001e5866deb6asm1486315oab.17.2023.10.09.07.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 07:16:30 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: Rename clean_unused -> clean-unused
Date: Mon,  9 Oct 2023 08:15:21 -0600
Message-Id: <20231009141521.2491155-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Oct 2023 14:16:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15193

Because it will bother me that it doesn't match the others

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 2 +-
 bitbake/lib/hashserv/server.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index d5c981864a2..f676d267fac 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -107,7 +107,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
 
     async def clean_unused(self, max_age):
         await self._set_mode(self.MODE_NORMAL)
-        return await self.send_message({"clean_unused": {"max_age_seconds": max_age}})
+        return await self.send_message({"clean-unused": {"max_age_seconds": max_age}})
 
 
 class Client(bb.asyncrpc.Client):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index b2ca357b2b1..45bf476bfef 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -187,7 +187,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 'reset-stats': self.handle_reset_stats,
                 'backfill-wait': self.handle_backfill_wait,
                 'remove': self.handle_remove,
-                'clean_unused': self.handle_clean_unused,
+                'clean-unused': self.handle_clean_unused,
             })
 
     def validate_proto_version(self):
-- 
2.34.1


