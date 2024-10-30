Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A82D6B6C4
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 19:12:30 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web11.23491.1730315548528091123
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 12:12:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=sJRr5Vx0;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c7edf2872so10160775ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730315548; x=1730920348; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdPiGlSsqRBkcYiit3vG+h2ayRtNjEEIE0Bx7djS8A0=;
        b=sJRr5Vx0OE5Qezr9scejhmMr30cmsBZnyluiF3shX/3nwilULloWGVnXBOEu0pq3mL
         QXGI0reJ35CBZQWB9c3H0YYbZTowoas9hXteuNQ3tzJUr6nYMiTIUrglNMU+d61qiM+v
         dLax5GrOpDLv/MEKPfX0BA3JRC7Dv98PxcrUUNduu7BJ5IxHCC5j9Di6GK2gzdfA63Iw
         1CTlNgEsjTvsZDZxG985L48jArlFOWfMFzqWTFAvTHVxV5RxcbdTbn4R1e9pN5FIXE3i
         f5qARLldIHGTTfvXLXknnsycIeOax5zLjTu9yp76DU9ZOReWkAyv8yGfHveyuBFnvHNU
         0qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730315548; x=1730920348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdPiGlSsqRBkcYiit3vG+h2ayRtNjEEIE0Bx7djS8A0=;
        b=pE2CkIpV/mzo9rWdB/joV8vdO8Vm/NIbjLFm8Onq8yz/ZUsBe267ryoB5TbzX2CB/d
         HGgFvqcIVbDj1YzHdf39+eVtkjTAnUgEmlyqGaBrOLWoWE8MGzGncbOMf/2JipcFJ6aS
         +ulMe+NZxhq2G6uvUGm64Q6N7B0exnFCQBVHoiR5tiX6yoKNvTaU6n7rvBxG4jB65bt0
         THi42aRxC05sqNADDoDNJw91PY1YR/BoKPMV95wGQUezLOuMTMapewnbBYEMkup70FZw
         h+swoUELOO5UnvkbN7QEa0T896NcrbqmnT0BPimPAmTI7Q8U8mdwL+GfaemM9Qwm7+hQ
         4ALQ==
X-Gm-Message-State: AOJu0YyP3HtsvZaFnjLbaYmsoKOPLPigyet551oSooWb0Xh91s8QQTq5
	Pwz9qIPa+Og7Kd0C4uNvqUtEYRukJ9IZF6TI+YZE3RMI+kT/M9fuwNg3mBIIQDnR0pYSJAms6qY
	3
X-Google-Smtp-Source: AGHT+IGuJROMl/1US6ZcjzEzgUv36JgtUsmzMc63kdRSN48FACdwI7oXo2oRSAT6+W6SQUZ1hJl1mA==
X-Received: by 2002:a17:90a:780c:b0:2d8:3f7a:edf2 with SMTP id 98e67ed59e1d1-2e92f9742demr5137842a91.12.1730315547649;
        Wed, 30 Oct 2024 12:12:27 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa36672sm2248203a91.14.2024.10.30.12.12.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:12:27 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 4/4] tests/fetch: Use our own mirror of mobile-broadband-provider to decouple from gnome gitlab
Date: Wed, 30 Oct 2024 12:12:08 -0700
Message-Id: <b89214bdfb974a94500373e15659f8937b6d7da8.1730315315.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730315315.git.steve@sakoman.com>
References: <cover.1730315315.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 19:12:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16760

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
index 70494693a..231da669e 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1424,7 +1424,7 @@ class FetchLatestVersionTest(FetcherTest):
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


