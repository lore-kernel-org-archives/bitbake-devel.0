Return-Path: <belouargamohamed@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3EBC7EE24
	for <webhook@archiver.kernel.org>; Sun,  4 Jun 2023 01:39:39 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web10.10226.1685842773693235627
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 03 Jun 2023 18:39:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=bIThevTr;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: belouargamohamed@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-973f78329e3so551627166b.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 03 Jun 2023 18:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685842772; x=1688434772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hC6HqyLjuwyvhLu0LLpZSDlo2wvGtic/KhURRPHCg0=;
        b=bIThevTrVJaiwVxoqm5XMMVPIIW/KH9VVTJ7yiQHFdN4novtClAifnf+Ketvys0WtQ
         4ksSkI9r8uyCJsJL0YzAp7/Zz1fcDbWQS6vlx1vpNScEcGoeBjPuUg1KRw6Oqgk1IGCy
         NMZZCvOljqJQlWMpIa4PrroL8SR3iYgACQL0h2No1d//iAgFcgk41t+DyQv3L/K74hrr
         pwZwlIAXBvBaHsyP5SodoUXpcU1c0rufUAfrJO4Z8zC+4BeQRKo/klNwJc/1PKRXA5wV
         8iusjJOBAiq7pZInFqMuMM1WWFoGgxxTYzzFXkcgm0h/9GJurCStVE6Sd2+LOaE3OY/A
         34zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685842772; x=1688434772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hC6HqyLjuwyvhLu0LLpZSDlo2wvGtic/KhURRPHCg0=;
        b=e66380Gq0WnU60xQqZ5GsCB/t1xkmB3xxb2MuVnjClHlj0p1fGmY/nKEh8tRvlR8Ia
         sbHrFRb55jG5ETw5gaBs9qXMttYyG0Uj/KgbWg387jpBH6YNEofXcwbd40ZasPPslb2j
         mbiMhdCVCbf4SJ2vH73bPfqH/xjYvLRIRoYoEIbEKfBQbe7BFLoUkyrPtSHo4pfpr82o
         LPBi1yeTre68K8ig4PAEY/aXTF9of7SJICEw99jEz2GbMcVVr1m3eOrtAfa6zTC8Kn60
         PfwH5mcMvXKk9Z92JjbKTGnLGqgAp8JfRACrTEavCry1UF5/JnWsm/3AmxRFGpcgwjVq
         BvaA==
X-Gm-Message-State: AC+VfDzy8dPsYXZXkItpKsmwj3w9Iaybb3ex2h2zYc8U0LOGyNZZDflQ
	UbXrEdQsUyc7MliJfxae9Mg9TGfcboKn3g==
X-Google-Smtp-Source: ACHHUZ724LjPFyIwOs24r3/RMOxqmYFypaCVsUYHu5As735EZrjs4SwxSYVBV741QxvLGZ+mnNlylw==
X-Received: by 2002:a17:907:72c3:b0:96a:928c:d382 with SMTP id du3-20020a17090772c300b0096a928cd382mr2701680ejc.48.1685842771437;
        Sat, 03 Jun 2023 18:39:31 -0700 (PDT)
Received: from localhost.localdomain (2a02-842a-002e-7001-0180-174c-8c1b-346b.rev.sfr.net. [2a02:842a:2e:7001:180:174c:8c1b:346b])
        by smtp.gmail.com with ESMTPSA id i8-20020adfdec8000000b0030796e103a1sm5825474wrn.5.2023.06.03.18.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 18:39:30 -0700 (PDT)
From: belouargamohamed@gmail.com
X-Google-Original-From: m.belouarga@technologyandstrategy.com
To: bitbake-devel@lists.openembedded.org
Cc: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
Subject: [master][PATCH v2 3/3] fetch2: npm: Remove special caracters that causes recipe tool to fail
Date: Sun,  4 Jun 2023 03:39:19 +0200
Message-Id: <20230604013919.13904-3-m.belouarga@technologyandstrategy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230604013919.13904-1-m.belouarga@technologyandstrategy.com>
References: <20230604013919.13904-1-m.belouarga@technologyandstrategy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 04 Jun 2023 01:39:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14829

From: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>

Packages like @(._.)/execute causes problems because they generate names
that are not supported by yocto

Signed-off-by: BELOUARGA Mohamed <m.belouarga@technologyandstrategy.com>
---
 lib/bb/fetch2/npm.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e6d0598f5d..f83485ad85 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -44,9 +44,12 @@ def npm_package(package):
     """Convert the npm package name to remove unsupported character"""
     # Scoped package names (with the @) use the same naming convention
     # as the 'npm pack' command.
-    if package.startswith("@"):
-        return re.sub("/", "-", package[1:])
-    return package
+    name = re.sub("/", "-", package)
+    name = name.lower()
+    name = re.sub(r"[^\-a-z0-9]", "", name)
+    name = name.strip("-")
+    return name
+
 
 def npm_filename(package, version):
     """Get the filename of a npm package"""
-- 
2.25.1


