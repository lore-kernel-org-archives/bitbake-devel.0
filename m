Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E91C982EA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 09:11:13 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2905.1790154669231305725
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 02:11:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=qceeabh2;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so3531045e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790154667; x=1790759467; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pAsx20X5ix/6w3rRe7ufXzXbgJ/RFnOgDkrqrmmOZv0=;
        b=qceeabh2m0JmJ4r/463yXFBhrKY2z6H010ZfFdro9oxnYQRiq0cNQQ65tZrf93UFDw
         pdEZfUv7IOaoOX14PU+mjSfAlF6FkJcgwhynmG2ZvXOfO71+Orvtu0KE9G3tw8GRcOgz
         xCmeXu/ZDnU9mFVVjySlINLlQH2rPmt2H9xR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790154667; x=1790759467;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pAsx20X5ix/6w3rRe7ufXzXbgJ/RFnOgDkrqrmmOZv0=;
        b=bcm/Sjo5NOfoReQQH/5DDfwlK1JZG2Yb3JQY9cwWzHT/WLwVAqIeabhZIRR+LseZN1
         Us6CkcHPdqmzGczkEx5sd6J202BC+s0ZNX1ypC/gXHLKohmDEDRhm1zjWgZJieP0cnYh
         bLYyy1693bx7E+/Nj1KoBDsJ3erti5XP+QkiGkbkgasKLZay6wpye4GCJ4MIhzo8Ii2M
         vj1wEuylQaVA8YJSTMLAtzgh5fQTv+fOHVib1Twscn5AMStvLhTZ3NLepxkI0Ngyn8d9
         46CAq5OiUEREp1JgCFc7yJ0Ey+FLs4u14oCL7A2HzdVX9WdBEFLOnZzZKAiiwTsHxAMy
         5qbA==
X-Gm-Message-State: AFuF++nZlOZCczRdzaQlMUspuTt2+z1q3R9IWbTn839KuAcX0LJUNoPa
	K1uLzXuFqApbo9Gf+Fyn5cAJWOxbCN9vRG/vjDk5/3cVM7vY4spBmjJo+3+jHHq+ya+mZmxKgkS
	mGlmGo8E=
X-Gm-Gg: AYBFou08VAQOetKr91J/GfE9aBcFqd1hvGpYYCCZFkoB/uE8/UsPhMhtotJjM+jAoIQ
	U9BoUipGhJYslGniFlipevTpi7OaNKPs/hC2ZHFVExcMjg5KufXxWj/EWfG2ohKEJW3F5ZTIwpt
	j88RU+Mk4i2o3pz5buXeo/ITSRrQaTtvAF5/8mv1occIbz3hOyQ93aqpjcG3YkC2n2yn5SVyxln
	oZ6Np1IeCL0yONU2K5GQ+cXGONx638cOeKL3VR85tNRyciYmqshIn6aUqXsa8MfldQxSMw8Db55
	SEu2x17I3Akhq9LQcEqMY7M3xgQsf8CeqLtJOPCJJ+MScAN6r2qC2t/L/oJ+DT9w989clS/arJt
	HALP8gMBiGGEyNiIRN0+0Quaq0AkkofSTZ6Di+oPvPKKJfvb/WHk4YONIpfZfvOXp22vWXHweKB
	Ca3vd3396CaL7xRf2d+PFjX1PMo5MiBKebsZIrWEaLCY9l++uSPpV5Aj3MCqag4Gif4h5bZ2QBT
	BUGH1qRFw3C050vlb2JwvwIpzP4uaPb4V3RawiJaWJZoKatz7hSDKwsz2QbhMJBLhQdnVRuDHxf
	qCvYFz0=
X-Received: by 2002:a05:600c:4f0c:b0:49e:69f8:e846 with SMTP id 5b1f17b1804b1-49fdf000073mr26900735e9.9.1790154667135;
        Wed, 23 Sep 2026 02:11:07 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a02-8440-b519-f416-8bed-8817-19fd-ccf7.rev.sfr.net. [2a02:8440:b519:f416:8bed:8817:19fd:ccf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe14322c0sm48384135e9.5.2026.09.23.02.11.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:11:06 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Patch review
Date: Wed, 23 Sep 2026 11:10:14 +0200
Message-ID: <cover.1790154568.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 09:11:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20237

Please review this set of changes for scarthgap and have comments back by
end of day Friday, September 25.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4792
oe-selftest-fedora failed with 16206 – [scarthgap] AB-INT: runtime_test.SystemTap.test_crosstap_* failures
retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/48/builds/4720

The following changes since commit cd50c3481e32afff995a143c3459cfa5ae25abd5:

  tests/fetch: Swap bitbake github mirror for YP one (2026-09-09 17:57:33 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to 1b619d136c01c97ab1b76a75e8845cddc5e49735:

  tests/fetch: Drop github url from testing (2026-09-18 15:48:17 +0200)

----------------------------------------------------------------

Richard Purdie (3):
  tests/fetch: Drop ftp checkstatus test
  tests/fetch: Switch to YP mirror repos instead of github
  tests/fetch: Drop github url from testing

 lib/bb/tests/fetch.py | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)


