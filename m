Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77966E9A74F
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 09:44:55 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15861.1774345491737306950
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Mar 2026 02:44:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=tEsUClrX;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso8805645e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774345490; x=1774950290; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZzLBZog4R3KCKfIHzVNGgfFdcOemQid3U8xfeXxkzg=;
        b=tEsUClrXn0HB0/v72G7bon612xtIVwCd2AGEldK6i22fuj6P+y5yRLdbZfwcFux0R0
         4OZdd8vxR/KZ7k7v2swXeEnkupn1ylqG6ikZdZ2I+ofYAxT8oJMsUviAsquObySkyBdX
         d2qJztbuDQYbBiSug3qiPzyeSV3718YlZn3iHYTqqxRvdm0oBGRpyEUOPZiyThWghAtw
         q7DmIntgyrNQoIPBlVW6YOS+G4wJzJQ0enpVeg7mYrb0PVgzhezSOa8SqnT/x6FjLmLX
         gmB+CT1NgaLmq9xvCRhNqwhrvOVHPc9uUWlwc+fQzwlSlFulTF1DmC0vkN5wFqgBTNMv
         r6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345490; x=1774950290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZzLBZog4R3KCKfIHzVNGgfFdcOemQid3U8xfeXxkzg=;
        b=dYCrlCKEKqXAFeisnJLgpjHkCeDPduDxctLmsBN6fA0oRaGsV2K4llvIoO8L1IVvB+
         RBdnL2QRSQ+GLympHOE8vpaskpKPKnPOJ3nZudIc8YWLPQBQRkWHW/Ut1q/sV9jB7QRa
         L25/4PYypFmuVYxko0uQvx+SUnlM5s2mAEHx/rQrjMI6MJfUZEbCFjyb5vYlyg8jc1BU
         GAhXWBWry8u5lgLtgSk9KllYiMPYJLxuEFawxS8sQ3An/ONAxuxveHaEv++GuJkJJg62
         yF2rVQdlfsjS5TZLcYRBxE8JhFVBy4Gp4fEErEfb8JLeEFgaRGQj94GPqMc/ybLOl3yX
         oZ5A==
X-Gm-Message-State: AOJu0YwSBJpudvC3sNUyn1H4m7HMwS4MkqntdntEA3shWiTlGOn2TmuV
	LLszu2A7Zt+Oi1G9mBqX/tUN05Ww7Pw6a/uvMjmxuNfmtBpsnYImBIE078tqPQ==
X-Gm-Gg: ATEYQzwShC7Ooi9m/FmbXcXToHRlAPNEpTDBbMJr2V5wvaVusZ5AFgGfGpScSEC2NnH
	qwHAy2I2tkYtVRHRfPYAJRbjuHMYo3ubtXnZagRlc3UOOM0Aw6PsJBIF2l8MNoZMpBxJkacEVjg
	DjBD2bO16r6osg8LZgemQeP8vu9RypPmXBRA8LyanNaXH7O3yiyghlNH+isJCX+Btr2a8OUbaNR
	vftsmqd+qHK+g2HvkhDdqVlc5OUI9rZQlkh+V9trTz9rQr9TeUTz3j0mLdo3mRpE56TvrIJ2khK
	4stygoqx41aaHbxrMZNpr9nENnt4E2mMyDTU3KvLVdymtJ5RUzM4et2gzWUwo0uJq5kPIWx8+CG
	cHqxUofYwHXUuc19vd7IusBAD37r+afJBKtuTAAfRbNdmn/de5OkbfXgG8eN7OtFEpdai9qTrcL
	S1hxa/sCZxs8dDOgLHwAIt0SAPXKu0uV8G/H/ogZpkMJisjPySPzCUYVG6C8s=
X-Received: by 2002:a05:600c:c083:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-486fedf9be6mr166090815e9.10.1774345489780;
        Tue, 24 Mar 2026 02:44:49 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c094csm29821835e9.1.2026.03.24.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:44:49 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: ensure args.setup_dir is an absolute path
Date: Tue, 24 Mar 2026 10:44:46 +0100
Message-ID: <20260324094446.876081-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 09:44:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19213

From: Alexander Kanavin <alex@linutronix.de>

This fixes another corner case:
'bitbake-setup update --setup-dir ./relative/path'

Normally setup-dir is deduced from bitbake environment, but when
it is passed in on the command line as a relative path, and there
is something to update, new bblayer.conf is created with relative
paths in it, causing breakage.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index dcad9c169..db44b7727 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -746,7 +746,7 @@ def are_layers_changed(layers, layerdir, d):
     return changed
 
 def build_status(top_dir, settings, args, d, update=False):
-    setupdir = args.setup_dir
+    setupdir = os.path.abspath(args.setup_dir)
 
     confdir = os.path.join(setupdir, "config")
     layerdir = os.path.join(setupdir, "layers")
-- 
2.47.3


