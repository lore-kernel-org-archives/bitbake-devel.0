Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63599C982FA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 09:11:13 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2908.1790154671275847189
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 02:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=NH7rs+gX;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so3740025e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 02:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790154669; x=1790759469; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NDDhJ8xQoSkQ44+QLmTqNrZF19DJs4OhnZZn/uXjKM4=;
        b=NH7rs+gXy0Rr6pPvIO3Z3q9/eu2zS3UHDdSvogcS/4IDILxlX0t8w2XXNqjQNNUYGj
         7us8hFb+QvfEP7Udq1+hh1uIGgNhZuaT8UYyixvbPXTJjqPbYVr4GYyLqFC/E5UBG8S9
         1p9kj/u1sAqsnlVzz/CQR0JnQDwI5qWKVG3Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790154669; x=1790759469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NDDhJ8xQoSkQ44+QLmTqNrZF19DJs4OhnZZn/uXjKM4=;
        b=Uykh+uWkB0EHyG5pH55yuR94SOREwO/h6n0tmGcjVUYkBIeWPnvjogCNLsGM03vBq9
         00SxrFKUFTrZrSvY52Av5HNAYGlJndqMDQjbaxLLxLUiu5xkpmcLw3JJfP3Ft/9gYkpi
         ZxCeOS5rt+Zj9a9hnm9t6PlZF5LfyWi/7grhWV1tTJulu2LeY1unjTLXuPWvsWA8qxBU
         IHOjdsBooryaOmwY3gXhtmhAOP8Vl2MY/UovGBBw0mb4gv/+F4dhI2AOJxpRJ2oxfdhN
         sYBFNiRIM+CGDcX2iK2gvQGVZ28l3drIqGmzJMXKyiort/jSphrU+NII40acSxod9PBC
         dZVQ==
X-Gm-Message-State: AFuF++kDBhHbRSL813cdj/EB0fowX5s2urRK4yQlzMJiAFHRIubHxSB2
	tNKW/J6To5sFkG8thwtIKYdWWN5NGyLKxyW6dzA8BFZkE0DmBizukGicyrj1D1rxFc1N/JPs7+9
	Shk5+u2s=
X-Gm-Gg: AYBFou1NsUpl24qoJLQ/TdoZUaUC8H9SEFPW3V9e9NvAcCbYCo2x2lTrTGfqz7QfxA+
	3tQL/kNDOs62Vvq7/3UzaDuTqn8ULchQWZckzZVFue9eulNEBzKjV1/7xZJl4z84/OjBqJchkJR
	qeMp1+9qaaWTGVXu6Pm7hp74IiIjcJJ3iOcIJdejrJF+EJGxmWN1uHjXqGbZMy8mvtSDSpshbr2
	ZDwLFBt2ym3v8kl+gYmW+aPYBt4J+jKfFkBZdzx29grWbZzsFd/VYqhlioxRmYYG3Bo0H2zY14w
	TnlzQyJEIiwYp6XstJiel0R/lxcvGWbmZmnWEopw0O4+Xw+trU/1eN5ls3P2jUPjo3bVaNJE/GP
	/27MwcD6+jDH9X4N0Zry3EKPMxgD8i99lC49Cj2M+1nFC5DyME2X/EVs6nmqAsxhr9Oqn8ej4ZL
	qNxH2b/QlS5CCd3y7FjHxWziOihFd6Tre7VBZMKjLCZiYFn6u07WtuJ9OE3Wp+pGZpWDyuU9hjU
	o85XTVio1Wh9afyZNI/E+2A7ngDR+W70ayPi65cgXX/lGj7OaoSdzleVrdh3AA+1DJItfqa
X-Received: by 2002:a05:600c:1c01:b0:49f:dc8e:6211 with SMTP id 5b1f17b1804b1-49fdf12f377mr30668755e9.16.1790154669397;
        Wed, 23 Sep 2026 02:11:09 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a02-8440-b519-f416-8bed-8817-19fd-ccf7.rev.sfr.net. [2a02:8440:b519:f416:8bed:8817:19fd:ccf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe14322c0sm48384135e9.5.2026.09.23.02.11.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:11:09 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/3] tests/fetch: Drop github url from testing
Date: Wed, 23 Sep 2026 11:10:17 +0200
Message-ID: <1b619d136c01c97ab1b76a75e8845cddc5e49735.1790154568.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790154568.git.yoann.congal@smile.fr>
References: <cover.1790154568.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 09:11:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20240

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This was introduced as a test for the fix in 6ec70d5d2e330b41b932b0a655b838a5f37df01e
however the way github works has changed in the decade since and this
test is no longer testing what was intended.

The test is failing intermittently on our infrastructure thanks to spam
and IP block throttling restrictions which lead to occasional failures.

At this point it is probably simplest just to drop the url from testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit b59bdcf8134e6f5935e8f7b0ed8033cbb745e0ff)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 087ebb7db..a62fa16a7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1605,8 +1605,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://docs.yoctoproject.org",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
-                      # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
-                      "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
 
     def _start_checkstatus_server(self):

