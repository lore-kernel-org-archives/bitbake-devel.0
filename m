Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3E4C27C53
	for <webhook@archiver.kernel.org>; Sat, 22 Jun 2024 12:20:47 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.96228.1719058846881283714
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 22 Jun 2024 05:20:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=sUbz5jWu;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.181, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70633f0812dso2447179b3a.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 22 Jun 2024 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1719058846; x=1719663646; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDbHHmH6Dniq13YppYEV5O6jLVODV6abyZm8YuOfenc=;
        b=sUbz5jWuYgxcZvgj6l1hfeXvkeae7LLvK0rSVx1R3TmDKqZDcdkueypVUSwjr08dov
         PY34XxculQ0lgfoyotI94ZiZM3OB6pJUdmYcr06sVRz7fiA3nGWh7ld9+KuPCZOOLuaG
         VsiEnTV27VTjWGMfbK/3Ny3MFQM7rgn5gBmNqYppLaoegjGzqjH4Zzcps2zT9hF2dSzv
         qU0RLtnWrUJ1WS7wJVBurZNhbSpE9rVo4ehAsJKsU5NAOQdwZQrTELV5OrvLnSCFvcdK
         mEjoVM/xyRtqX4azpnV0fg3Lw3tU1Trlc5LVk6Gg7nYCAG66G4+IAuQhvIcNWk3orIxs
         /M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719058846; x=1719663646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDbHHmH6Dniq13YppYEV5O6jLVODV6abyZm8YuOfenc=;
        b=v0HVHKSwX9cK8YT7DABgK12QvW1t2x9zDVQsR2VZ4R+fA8Lo6Eqin87Ch73eS8a0hz
         8sy8nhpjCpBhQamehvue00rjKL95O7wLVV5GKDoX2sk8r13P6JI8rOkraaW/89EOOxo8
         P6CjdDsVUo5ocpRdRljILNTKcaVx+eqLMM3UqrTEFBTIyWYbobbHTmnKMgPlsJ4RLPrw
         h2h3B15W2P9wj+CtCfzpZG+fh4/9Dyc1P1/prOyWiVTZW6QyvYddrRgRDCFKiqYPlBDq
         NZTHJuKmRma+5+KUjaPYdCWlwzspXe3PUa+FGhG+YPFQFzA2ITzinNLx+063JD33SKk2
         1bSw==
X-Gm-Message-State: AOJu0Yztv6sRKQKCMu0c4x2OuKdjS+coEidO3ppgZAd/PF6QRzdv/inh
	fTZUigTLCQuP7668A4ZcQkiiqIK4ON8zqvtJU8Y2OTiDYQCKyx4rBXDa/+aFS/JtS4Ff1wLCERK
	J
X-Google-Smtp-Source: AGHT+IFrDSqLOZgmWYSu62sPPRPNiN4Ju9rcPI3dkeycPA7kqELW8/IkHuSnCzzwjfl4IjpiE6QHng==
X-Received: by 2002:a05:6a20:a723:b0:1b5:fd58:30e8 with SMTP id adf61e73a8af0-1bcbb3f0b1emr10775142637.18.1719058846072;
        Sat, 22 Jun 2024 05:20:46 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7065130573esm2952762b3a.205.2024.06.22.05.20.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 05:20:45 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/1] tests/fetch: Tweak test to match upstream repo url change Upstream changed their urls, update our test to match.
Date: Sat, 22 Jun 2024 05:20:36 -0700
Message-Id: <734b0ea3dfe45eb16ee60f0c2c388e22af4040e0.1719058713.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719058713.git.steve@sakoman.com>
References: <cover.1719058713.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Jun 2024 12:20:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16375

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5aa3e464d..a7d9d5e88 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1335,7 +1335,7 @@ class FetchLatestVersionTest(FetcherTest):
         # combination version pattern
         ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
             : "1.2.0",
-        ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=master;protocol=git", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
+        ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
             : "2014.01",
         # version pattern "yyyymmdd"
         ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
-- 
2.34.1


