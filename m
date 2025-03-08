Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37DCC282EC
	for <webhook@archiver.kernel.org>; Sat,  8 Mar 2025 14:34:22 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.9769.1741444456426389751
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Mar 2025 06:34:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=YlNfBZis;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223959039f4so56912455ad.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 08 Mar 2025 06:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741444456; x=1742049256; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yZk5ynPYYEpgx1NV9aaeX9YBV7t7cEMJa9gD8b25nBA=;
        b=YlNfBZisZlS55JNcv/1sbt1uaTj8SuHej1TokrVHeYizJJceuxKaCA6Bfxih09BGp0
         Qrqv7PrZFe+jrxoGAlEFE75zBCLET8+it8Q23Au8RwE5hbD+zofzqsHw7Jw9dClxnwU9
         J4CHUSdvwZpAKU1YOh4u39a4gSSDjGD5kyOxeLlYYmdtgdRnOM8zdNkx89S2wwdlVvz6
         0gqoRVQYnwUsOt3s1jdNTY1f8kaeMVwCGHzEDrNOqtXY3NsQH8ARJAi5hY84L+Bu8EUQ
         YMB+SLdDdMseOoeBBFa19TFVmxW3NnL47xBZcWPLfc0i8sq53iL7tDRjmT3YiuLeJL2o
         wjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741444456; x=1742049256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZk5ynPYYEpgx1NV9aaeX9YBV7t7cEMJa9gD8b25nBA=;
        b=N46Lk8g5Urw7hD2/iYjh+PfJMm02+LRj+aA0fYQPFhy2I+YavUO77tx98FiXuMxahy
         dcqqXifnJdR/QZl1L177Pvx5wbExqOWSgbmi6TtsIEVDMN/naAGpofLQ/Cl4caDIreqM
         bdxpa+SuGr9mird1UmBMHOK/zMPOuZyrqDIncNG6xX9tDgbQTI1ytn5r3knT60rZK/UV
         7pVTVdy1gKqI59sDWKJQXVfWP/NHI3muNunk6D/5ER90qgU1q1QHLLS1Ud4sdHo7nhN6
         L4NWeL5q6+lHUz6FX8tDpDjWx0HzsIesLAQfNZoN7XGxGt6IiGWZDMN+l0INMBmMG5Wk
         O5NA==
X-Gm-Message-State: AOJu0YxcC6LED9OLFXdePHOgxogNzdyuH+JnNhquvfKRiyLhMCcJ7e1k
	ghYYJ3T5tIesMud6gQ1fDVng+WofOMo56h87WkRtvPwt4K9o7J27bNhwhg/J8E/vm5xEhh04Njz
	0
X-Gm-Gg: ASbGncummRjs4cldGsbbwws0oG96pi86Tjd6/TT2ZTiGhfp/ABS696L6JgvJ1x2T0fO
	MEhx/0rT7I2uh0Bq3VFHMKlGFIGAIORQGpiwQp9n6dbZOa5NVnlzO1vCf62vj3F4LW2CPGN0uS+
	8APixrEyuazGpNLIWaMC1srGiBFeQXWAU4APRBDmXQ13Ox1/kExa99OPGJuPj+C47E/bC1OqbIW
	jleKLghtJs1AXRZPBHj2h6NxegupUlxdjDfHESJk7r+L3qMg5Kgz48LqkCj0JGWpm1LCPoBpqtS
	OIOZ4aJLAli2nuSkEj/7JXiuwPOBawGnGYn0
X-Google-Smtp-Source: AGHT+IGNfPBDcthKp94WnYWmPulM4D+cis9ZSdxQzQ5cs/r02+6ZNHgSExriCSaLh3I428pdP3Pw3Q==
X-Received: by 2002:a17:902:cecd:b0:224:122d:d2de with SMTP id d9443c01a7336-2242888beffmr91421735ad.16.1741444455486;
        Sat, 08 Mar 2025 06:34:15 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:9d8d:e34e:be82:3ffd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e9850sm47455315ad.86.2025.03.08.06.34.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 06:34:14 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Pull request (cover letter only)
Date: Sat,  8 Mar 2025 06:34:09 -0800
Message-ID: <cover.1741444400.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 08 Mar 2025 14:34:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17416

The following changes since commit 7375d32e8c1af20c51abec4eb3b072b4ca58b239:

  data_smart.py: clear expand_cache in _setvar_update_overridevars (2025-03-05 19:10:43 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Richard Purdie (4):
  utils: Print information about lock issue before exiting
  utils: Tweak lock_timeout logic
  utils: Add signal blocking for lock_timeout
  event/utils: Avoid deadlock from lock_timeout() and recursive events

 lib/bb/event.py | 10 +++++++++-
 lib/bb/utils.py | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.43.0


