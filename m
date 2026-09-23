Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEEEC98307
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 09:11:13 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2906.1790154669563121872
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 02:11:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=AcpcFFx2;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so3531105e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790154668; x=1790759468; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3Z1ZVY30WX20Z56Nd3eWOVOmppv4e9TzMwmKpWc39K4=;
        b=AcpcFFx2rqIhEhPT7O7BQ1vhWcspgZBv1lqD86h0JAywvelEvFQDgarDD/ne/4sJ8c
         vrLR4xWWC9BuRKzJOFbuFXw2vFm3kgj6gsuS8vJzgLJHJQbR+AsURryh+gZISCkHCRjj
         GxOLCLwd2JSaaeqMORmoAVyvo4f8BZ5JUTCV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790154668; x=1790759468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3Z1ZVY30WX20Z56Nd3eWOVOmppv4e9TzMwmKpWc39K4=;
        b=yURuzTpwRNyiDNBA1IY+RB7w0jkxD9/oFPPFAVC1h3irjjnzImMSQ2hhngDsonli4U
         kIHtDledQA0MXox3YEKJsInayxopHEzZk8wT8S45q+sTUJW/SqAwVWVVU50q5iKb4ydz
         DFm1eNkYqg0PLQrunlokoV+vQoLetq03OG0wpFonX0tRuETyOnXmokxPWwdagNCJl82S
         eM+p8Ej95+wiIrwwUQ9Xp6ReRCuetlssQPZW21hi9uhwCY3M1b5TDTgKfOv0CdvaxhMb
         9N0byIJFBdwjxlvFaeXSNuBmlA0k2I1b5ql7+JJlNl0nO9porNTDJV/w7f5VPLlv1uT7
         CpSw==
X-Gm-Message-State: AFuF++mtNnQEeehKgXnnP4Yw6UwogM24FF8SLjx9x26YNjVR6WlTQykK
	rw20NUZX2IeHzvBrkAdE0pGU1lGr92ak3Bm/RUjOjWnEd3V8wq76J7WLW3hUDiaprDcIkNBk6Nu
	TMemcHns=
X-Gm-Gg: AYBFou2KkaU5ByvEgKjiULHuqMh7tGYIQyV/ln4+PMs5PR6HnRZGTH6kXCv3pVLYrZl
	Sn9HoCiHc3KhwE163cwBo7tFILsMTTrpOdassyKl0zhddaWNY3UV6lJnxGAkppiC6OU9vS03IvM
	kw4gslrgcm6/Im5zEX0BITFvngrON9dTlmm8uK4smLULucqT6EJLNmVUM8ExE/m2qLpvbrv+sc8
	SwgshzKCS9lYojLcl6pSQv78Z3zN+5ScUUj5ab9G5e9mj+PR6dccw8coe7kLdB3t2hD/1rCCRMC
	sMLeEoFWrWAqVpqzeteDfop7wClhC2ZxwsgARq+IXmkPWYLDONfcUmweQY0o1SCjE/WC/N5lsQK
	QQ83iTIJZKf3P1IprLzGGM1p0khbhjCylyBbODXOesANz9YtdaSgagvn28TkZzcP7F27rZh2oaO
	CWgoKXnGHNkpVXsNcuAPT9DMVoggLPYoGu/WjjOykt96PTpaE67uy2oZn4MU9FDXfFj4cm8rL/H
	2C4LGXPxWBkSC1z2ClyFO2QrB5qWF49UcBfalnH21iyMy0qbLKqlDbpuaBYlTgdAVOdWwuR
X-Received: by 2002:a05:600c:4455:b0:49f:c18a:61c8 with SMTP id 5b1f17b1804b1-49fdf15100bmr22442045e9.29.1790154667755;
        Wed, 23 Sep 2026 02:11:07 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a02-8440-b519-f416-8bed-8817-19fd-ccf7.rev.sfr.net. [2a02:8440:b519:f416:8bed:8817:19fd:ccf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe14322c0sm48384135e9.5.2026.09.23.02.11.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:11:07 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/3] tests/fetch: Drop ftp checkstatus test
Date: Wed, 23 Sep 2026 11:10:15 +0200
Message-ID: <4b8695f0708f4da5ed16e97ae7bcfb69fdd1e3ed.1790154568.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790154568.git.yoann.congal@smile.fr>
References: <cover.1790154568.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 09:11:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20238

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This single url takes 100s in each of the two tests it is used in,
compared to the fraction of a second for the other urls. Nobody
should really be using ftp any more anyway, drop this test url.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit a181827fa0fe6738441b40b5206cc2cadb5f7dce)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3e2c6f8c1..d47e3cd29 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1607,7 +1607,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://docs.yoctoproject.org",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
-                      "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
                       # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
                       "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]

