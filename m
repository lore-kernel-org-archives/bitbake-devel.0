Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D07D5B177
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 14:54:55 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50615.1765810488742480615
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Dec 2025 06:54:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=diqZlNRu;
 spf=pass (domain: gmail.com, ip: 209.85.208.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-647a3bca834so5434142a12.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765810487; x=1766415287; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2VDIxVGGiIgAVS6R6SPdgsEraFP+61kO4eZFrLDBBgk=;
        b=diqZlNRuAkPKlkgyBq/Wm55SJ2/7oCXTEfPrEirZtJheNFbBOAk2eVszg58Bw9zo7J
         /DKH0mQSjwFDBZF+ylexkdadWGuAW+SyxsMsoZOjconEnKspjrSUwvP1rhljoaKhVI2Q
         X9I0Nm42o0a3eQZSRqogzoFEB3olZm3svKKS9VWWY08bhbHbg0OjtPfs+4R4IIb9E0oA
         Cxvs3zHsD3EjuGnPKsprDzK6uj9dakS2NyIxyArrujjoe5MFPFtRwWxJEoOs+IBJfiFg
         X3o03MaAQGx1rhy0/f3cmljV5BpuHXSBHiO3SkjgfqpHMpg7WY8+lIUWga2VZdAc5T27
         uKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765810487; x=1766415287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VDIxVGGiIgAVS6R6SPdgsEraFP+61kO4eZFrLDBBgk=;
        b=iz2C5F5IEvFFDwOQND0UhFXlKsYjjbwGb0x7Yk630vZy4cPLTYbm+8wSW7HDOLa5mZ
         b0B0+pX/nnY5bEFII6ks9lPEcNvNL0K3urNYNAIFriDpAQwiMMZHUM7fUbX/jVSu/XTN
         oUeMjcRt9eoTCi6c0ZkV15tUoNU6wSAuEJzErleP4U7gg0DTDsgG3JnIE70UY7CFbK5R
         xy7UODNfzyCeXvRdy0acbCYXzIyPTsiRglU1XxBoWyPIx4P+kmnlKojl5oDmjPrxB3xP
         u1pmrvJv7kMs/fkeghKfnPcvh9sYHOMtdOnIIZbzwWot1RnaSOowunNFT1XAXkib0SbW
         kMAA==
X-Gm-Message-State: AOJu0Ywrn/SDz/97GdN4RcfTNzGnFpbAdKWo1vEM8RupTlI6tAguw9AW
	A8+WjM0XM9QsSMeKow/EdNL4AGl+Vv0g7Q+HIJ3vuRLupT/bxoUNUV/RgfsMSw==
X-Gm-Gg: AY/fxX6l4IL3wrHnqYmzrc0+1hkf6RX6YIu42hJb9qJn/kuPXaWd7oc2CHNGUD3vBIy
	hJJ6JyCn88UBl5xQ2X9wFl1mkVrReH5g1xQfS7nB5bcp1ZbYdHcpUdQ29diTP76iq0MCmi7+s7g
	RppZTtQnK9He8SJFpVmW/vwiZIKSfC0TVb9yfOBgWT/HBU654136LZGvvTSTcToiGjfz4Z+FN0K
	Q5zG1aH9b1zuZu26DF7G7XbpI/qqQ9x+KFObc8JOstUsaC1OmoV6mHM+cnymYfzKxj8/CR4iVd4
	YZPbrQxDhNDGFaKoXWWo2ilTF82+s1f+M6pDwFrfy1eqUn1TqXwyvg1/tnALwc90iAAxGIxX039
	aToXqdnEMuBaApd9ezVirsXZUlaywCw8+pbk3G+1i6gp5hwnBEyBl07BTjaC+DfsqyFkdin6fxd
	8qAlKvP4hWwmxOF3l+EVsuiS7M+UEQ0ccZDUH0CDMEMxdhSNU=
X-Google-Smtp-Source: AGHT+IGwBgk5f/tD9J7YF908kDSPLVSTnDBBv9LzVYvrJo8AI/BI/j0RwsreEJ6u8toeo8kob3dJzw==
X-Received: by 2002:a05:6402:84a:b0:643:18db:1d82 with SMTP id 4fb4d7f45d1cf-6499b186101mr10373044a12.11.1765810486807;
        Mon, 15 Dec 2025 06:54:46 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498204fbb3sm13589812a12.8.2025.12.15.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:54:46 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH 1/2] cooker: use BB_HASHSERVE_DB_DIR for hash server database location
Date: Mon, 15 Dec 2025 15:54:17 +0100
Message-ID: <20251215145418.2680311-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Dec 2025 14:54:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18596

From: Alexander Kanavin <alex@linutronix.de>

If unset, the existing behavior is preseved.

The use case is sharing the database in bitbake-setup's driven builds
without having to set up/start/stop a common single server shared
between them (this is added to bitbake-setup in the next commit).

Also create the specified directory if it doesn't yet exist.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index fa7747d64..c1281a847 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -328,7 +328,9 @@ class BBCooker:
         if self.data.getVar("BB_HASHSERVE") == "auto":
             # Create a new hash server bound to a unix domain socket
             if not self.hashserv:
-                dbfile = (self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")) + "/hashserv.db"
+                dbdir = self.data.getVar("BB_HASHSERVE_DB_DIR") or self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")
+                os.makedirs(dbdir, exist_ok=True)
+                dbfile = dbdir + "/hashserv.db"
                 upstream = self.data.getVar("BB_HASHSERVE_UPSTREAM") or None
                 if upstream:
                     try:
-- 
2.47.3


