Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C30D6B6A4
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:49 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.18846.1730304101490489598
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:01:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=k2wJspum;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e3fca72a41so5548825a91.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730304101; x=1730908901; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CahoeJVmiWmE37At7qqgyTsjjL5eG33diq3z3/ZBiyo=;
        b=k2wJspumwYfb39tQXEyfmpIPortXU9WBuPUbgEZIDim3JfaXhIz6T1FpYHU4S2wlR/
         S+pMggHDyxt7RmF6XIkDXGpjwR4gVv6xs7ZC0yPOLRXALzLUM9lPlRgSOwB6n4xdk2uG
         FLSbVfqPWKKR01UuM0CYw8NEk8fWaYNtL2wwdEomJWmK6xkHAhUHHccbWrNzUS2li/EI
         tlXJIHyw5otP9tA/XD0jxz8l8VmOoPy+H8UjW9qWXQ3mkybdfHaVV5BDSEROey1J7mxq
         3FtXZvg+RA9wchOJHp0SjYlVk+wZZawj3SAuxBrXL3DFKhJW3exx2i/PvFbnqKBrPJxv
         0klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304101; x=1730908901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CahoeJVmiWmE37At7qqgyTsjjL5eG33diq3z3/ZBiyo=;
        b=Jgv+DFXVLGKeqWShUVF/pFqEoRcu91FZO7pwrCDnhunvsQsYny9GVEzdfbmgdFIY8a
         1BHleOuVe6+6DtV+uuPzweBnwu4S75t6UACes8v3NmOppfn5q12fYGGfw509Qcx0A51v
         hWdbO54DdNGy7LA0rIPGSsHfM/jSquEIdkZA99qLzQY/21acKaZkIjpTPSj9fgiq5dpc
         xfXI7xP8EdSnnoEprE+2IXNWQ6/q71GiBzwmcsn2XV3sPFoN+NaX1OIZIUK0xYas3HGU
         YNH0fcmSK8l2tb9Oo+n0G/wPfpe3Z7DKXRWbgIpdpUz12qz5lOv/pgJrz9sOHRVtbc21
         Z7AA==
X-Gm-Message-State: AOJu0YyKfue/cZacGQbSHmrJYd2RSspvzMyopjCehZ04qOnyuI41TjKM
	Bsur82J/iFOf9dD9n378pvhU8OzPtyacn9sJRvVnZ5iCAXZdcZkR2XR2LAPtNleIKZGRJgIbjy2
	8
X-Google-Smtp-Source: AGHT+IF2xmFwtp6rHrHRl4DJTSNFiINTGpAcNPryFVkSyXdLyL9qcoEPYsytV891Sjd4veHRvJsdxQ==
X-Received: by 2002:a17:90a:fa8c:b0:2e2:8f39:98d9 with SMTP id 98e67ed59e1d1-2e8f10723d3mr18661831a91.18.1730304100606;
        Wed, 30 Oct 2024 09:01:40 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa26a4fsm1911814a91.23.2024.10.30.09.01.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:01:40 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 4/4] tests/fetch: Use our own mirror of mobile-broadband-provider to decouple from gnome gitlab
Date: Wed, 30 Oct 2024 09:01:24 -0700
Message-Id: <74e9f83c4b102a95aca7211f2bf4b70af3d1872f.1730303370.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730303370.git.steve@sakoman.com>
References: <cover.1730303370.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:01:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16749

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
index d9883e12a..363f3a218 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1432,7 +1432,7 @@ class FetchLatestVersionTest(FetcherTest):
         ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
             : "2014.01",
         # version pattern "yyyymmdd"
-        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "", "")
+        ("mobile-broadband-provider-info", "git://git.yoctoproject.org/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "", "")
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86-video-omap since network issues interfered with testing
-- 
2.34.1


