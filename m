Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F0C5B549
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 15:37:04 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.19804.1749051423438086704
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Jun 2025 08:37:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=xpNlyr36;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.171, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4404148a12.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1749051423; x=1749656223; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp4Ni3CW5XprWBXAWj/QMfBy8rxjU0SLmQn1wm3fdr4=;
        b=xpNlyr36xZYz4YG8tTjOSdDPaKJ+ToHCvu0FdGhbf2auouPBC+qQdE5FVb8vT2fQz9
         oSMaALS19HBHdgPJp9IEIIiMwIRsn9O8IIayaDX6qbetIykeYUX5pIsDH0gYREoRaLzo
         jEm9qCilaZQnGtZPaFAZZrDEnA0so38K2h4QKMpNx3U8jyksxAPHR5coMY7d0uTssmbF
         TB4AUz2YDqd5cU7jHi40GUs6W05GQkg8d/XAt8n7vHz8KxXiDguYAOQ3rLLFNtnaK1Qn
         /FwbtVEWBkInn+DJtoIrvhas7rSqJIDi097NLrgzrzgN7w+DITg1iLqlG3Ibv5BPxdjW
         pE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749051423; x=1749656223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fp4Ni3CW5XprWBXAWj/QMfBy8rxjU0SLmQn1wm3fdr4=;
        b=gxnF3+sZIqXYKH7ZXpCTm2htZgl+RTTZgE0ZOmm7UOstj8WJDvmv2xJch5961o05N3
         r7kR8oOCHfXq9bEUNbFKUxsgFI2ix78rN6hqsqZaWrfJEub7bjEf5nLiyN8uW9Cm/OJO
         Pc162nqaDA6ZJeJSSqEZBpyDkMveujzDSxEV4rYE5Zzhg4obq4La/zrMOLOWV3WAKham
         wykJqA8NQJisx8QMZ/hPAX1UjIbnM7L7h2HA79TGuIfJ0fvHi4MXIjOBy2EkgkubnKxs
         kV+LLQylZJrg2r1em5TWXu69N6YyTwdW3auYnM7qKhs2vihE0+6khbO17Puju1MJfqzB
         qkLg==
X-Gm-Message-State: AOJu0YzYN00Iup3freh7+j7Sl71Jz5NKqfVdsiR2NgvfNMTxLpcXsVT+
	+MOWMhu5TG2JoprfRLT83CJfL61p4y0ldJn6kBjBOOYXa1hu6cNHCzK2lGag3BbmsKAgKwVRyby
	re4qx
X-Gm-Gg: ASbGnctk/lM2XgGewndDaM3ButFq62GNbvDhhbLLhoUe3IG9+WRsSnoMFT0ICH/gfmI
	i/M4zwHZh/W8xZhh9saA6nXg6yv4haaNL6p+wAEX3ZUquNpMfXp+uLG3OdRedMofunn3eonBBnC
	Ghl2AMHj/nV9tTyLDJQiB0OwB9jNcY5+Tlh9ojsHrBspqtPwZSrIVOkHXtvH2z/yXko+7oitu+x
	/9K+aHmNKMwt9NSafgX2ahdJ8Iex01D+H/s+aQEFmKjE3iP/ftRFRJnwQP81pybgwjjyAr0lJZl
	pFVsk6S4oZkRfqmofOkTLqgzJ9iJvo30sOSdr8tSmkFth/fpwdkBOQ==
X-Google-Smtp-Source: AGHT+IGNvM9rp1McVEcXODnHiJ/Peu0rshSgBIv5LOVEDn6hvrkSm1+WGWQZkWSnRvS5tIwUMEemXA==
X-Received: by 2002:a17:90b:278f:b0:311:b0ec:1360 with SMTP id 98e67ed59e1d1-3130cd680a6mr4967424a91.29.1749051422525;
        Wed, 04 Jun 2025 08:37:02 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:e528:5fba:6ca8:ee3c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e8e6asm9111272a91.22.2025.06.04.08.37.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 08:37:02 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter only)
Date: Wed,  4 Jun 2025 08:36:58 -0700
Message-ID: <cover.1749051352.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Jun 2025 15:37:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17681

The following changes since commit 696c2c1ef095f8b11c7d2eff36fae50f58c62e5e:

  event/utils: Avoid deadlock from lock_timeout() and recursive events (2025-03-08 06:27:00 -0800)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Richard Purdie (1):
  toaster/tests/buildtest: Switch to new CDN

 lib/toaster/tests/builds/buildtest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


