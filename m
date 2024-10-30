Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059B4D6B6B4
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:50 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.19872.1730306985459919216
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:49:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=b2FglBus;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.179, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so11628b3a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730306985; x=1730911785; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/62kCElPE1Xlg+BWDwTrmHRV55+XGVYSiWANNAnW64=;
        b=b2FglBusBIC8PWlubUkNxYnAoqt9EeArsLWFyrNyXERW2Gz+J+7IKuRrgMCUzS83j1
         yGklzUR6oIB4Q334xKny1GLQrvtlCUKj89ID0XbZZV0RDCma3wv1mFxmSl/ihODRrQ9t
         sj9Jn1/QRWl+1lmp8axdOyd2ovVsEzil+u7bVvrGUzxgOX05NPpUvz2+wItTSOfvEaRC
         BXvd5sG+V+uZlvSmieHxE1wZk7VF7gRorKnPutjARQY9xW0asj26lNiCcyUEXx7X/Lae
         rvEJ0HgiOYKUf4t06vvLj1vRO5pI3JzmXwHQjsP0LbMUwqNwB5SpaSTmQnXKNzhobLlp
         Klxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306985; x=1730911785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/62kCElPE1Xlg+BWDwTrmHRV55+XGVYSiWANNAnW64=;
        b=sklUWz/YlfUlSvzNeNlHBKI2CDr2J4a2tjVPIbH8pazNrnmvNZoqVI3ImelDTrMhD1
         oR3W4E+Kx+wSyZAaQqX4ulJ793cjHXOR52JpE+AiErEwRS/gEzD/PUl51JTcrrV6hEfX
         gqarzPSbIlL3GCysxkrImUJ+oLGDrXi/QvkmyGVuunRA+THRmFdWeZSRGjwbaiQwz4I6
         yUKQwtwcN94t162/9szTui5fT9e97WVebe43qcO3KT2h8J972X7P2tR+CrIeTRcFxftD
         dRLGhKM30OTM10wh8AC8ph8reXIKpTxeTvMMHTxMTEqfSt0/sLwYHTdzhSM9AjjIPnrt
         rimQ==
X-Gm-Message-State: AOJu0YwKPxo/2F8ZhrCBg55n9RS6WNPDUGHdncRnYoLigCy0SMo0MyBI
	PwUSdwDDz87EcRGkC5wWRDR4mA+noZFDdrMZ78uFq3dGuU5D1cG2wUR9mpMiwnvQiVAkAEbRLkl
	X
X-Google-Smtp-Source: AGHT+IFrh8puREtBAH2q3hK6DHs0h+4rqYRUMCBD7+S91LxTPAdIGQY3WJi4wlsB8kvZHc9LR9kR0A==
X-Received: by 2002:a05:6a00:2d17:b0:71e:79a9:ec55 with SMTP id d2e1a72fcca58-72062f860dfmr23258089b3a.7.1730306984496;
        Wed, 30 Oct 2024 09:49:44 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e49asm9466200b3a.32.2024.10.30.09.49.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:49:44 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 4/5] tests/fetch: Use our own mirror of mobile-broadband-provider to decouple from gnome gitlab
Date: Wed, 30 Oct 2024 09:49:28 -0700
Message-Id: <99115618e0752700ff857c450d46fc384723ffc6.1730306845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730306845.git.steve@sakoman.com>
References: <cover.1730306845.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:49:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16754

From: Richard Purdie <richard.purdie@linuxfoundation.org>

GNOME gitlab has occasional downtime which impacts bitbake-selftest
and causes autobuilder failures. Switch to our own mirror for test
purposes to avoid those issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 91e268b11ed683bd197026f9b36001f6d54ee05c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 8595d9295..9f0f00fff 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1338,7 +1338,7 @@ class FetchLatestVersionTest(FetcherTest):
         ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
             : "2014.01",
         # version pattern "yyyymmdd"
-        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
+        ("mobile-broadband-provider-info", "git://git.yoctoproject.org/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86-video-omap since network issues interfered with testing
-- 
2.34.1


