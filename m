Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB56C41513
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:17:16 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.9322.1718111835042144553
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jun 2024 06:17:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=dkN/dhQI;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.172, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6bfd4b88608so765160a12.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1718111834; x=1718716634; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/K58u8OcGFg6Imv3O6HKJQl9rjShPm9A0VhiOzhXJfg=;
        b=dkN/dhQIhrY7TeVqX1rLWCQkhXGIbS+IC5wt8pxlY636a4yUYQItmSDOxE20AsJlqr
         rPShokoDZbO4GETeZkky8w4rx2TRNWeaNRiJ2lhrWHEMhinV0Ww9rftf/LhnLuh3PiOc
         qKdWxLLAoq684WaHXMJc0GMFvg/l6NZYD7B6uPU3iLYPW+LxfEhjp6XB8YY6/OLxR4QQ
         GfNk9ITQSZRcZbG6VsSLr1rtEG125XalsI7YIezaaySeiVYxcqKQ3n54gfoC3pjw3jAG
         pqwnOXP2GtDGmkJD+jdcVrpp3YJ6oZQnF8E3kDKYcxxD1buPgJzJtuXEW7eIQSdFZmYi
         eyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111834; x=1718716634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/K58u8OcGFg6Imv3O6HKJQl9rjShPm9A0VhiOzhXJfg=;
        b=R3gyP95c/Z4gPsH27pJjbj4Igl5dG8wIxNG+U2nroHK1mMgZOBCF9T+4XKdSv+YKH7
         OFuD+g8L+0VvOU1Xmit7t0Gxm0mE5IBuVXXDBoyMsG2cDyaE9GXYtLg9fpBThpGCSI6E
         at33D32dEf72rijyiHHZQ+MS7lyOxeikehBMrm5knel19ZGsvPUDKZN23Urt4gK8WZQB
         dEoRD5UiimKKNORsJiaJhOSt0YALay3hrJYz6VCWrPZF6nFfLrAwS/62Zwc5qfL+P2Bb
         pQv1zzm1SszKK7tH03aFCt2alWtx/P8If9frXMYdBgX264oVa1JXGW3yR7yNizowysks
         A7QQ==
X-Gm-Message-State: AOJu0YxhWPsFlkXy7kvub6Rv80HDSlJinurDNDaa1Y05adn47NLCJMiZ
	0JrpmqYhaF5odkAmBIhdn+ne50QjrEHeTdyFunCpBYWclIAmKH75bKKgzr4qsgv78o9PAnWoY2g
	N
X-Google-Smtp-Source: AGHT+IEgW+AGDCdUOOFCaXEmh6J6RLZz1AFjceBgGpCB4E3Pv3k3u1/mqtKAAgnxanCAEBwrIYH3KA==
X-Received: by 2002:a17:902:cf04:b0:1f7:26f:9185 with SMTP id d9443c01a7336-1f7026f932dmr86344275ad.10.1718111834230;
        Tue, 11 Jun 2024 06:17:14 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72110e4b5sm25996905ad.125.2024.06.11.06.17.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:17:13 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/1] tests/fetch: Tweak test to match upstream repo url change
Date: Tue, 11 Jun 2024 06:17:05 -0700
Message-Id: <0791e66a47185d6f202af6be0d39e36a8e41850a.1718111650.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718111650.git.steve@sakoman.com>
References: <cover.1718111650.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 13:17:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16348

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Upstream changed their urls, update our test to match.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit dc391b86540ec5e0a0f1d811c776a22d443b1c06)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 85c1f79ff..8a91f51d3 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1421,7 +1421,7 @@ class FetchLatestVersionTest(FetcherTest):
         # combination version pattern
         ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "", "")
             : "1.2.0",
-        ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=master;protocol=git", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
+        ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
             : "2014.01",
         # version pattern "yyyymmdd"
         ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "", "")
-- 
2.34.1


