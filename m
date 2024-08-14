Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACC6C52D7B
	for <webhook@archiver.kernel.org>; Wed, 14 Aug 2024 12:06:10 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.96378.1723637162129810041
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Aug 2024 05:06:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=RIJ12XD5;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.177, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-712603f7ba5so1255499b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Aug 2024 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1723637161; x=1724241961; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPe4nIsz1EXCEucyi5kNCLJA6PBcbQwuSblj1gXsWr0=;
        b=RIJ12XD5tltFDzpqcjwyUYFly5QrbGdXjh6p+oLPtjQAwxymAZsAoVB59CRtGIxUXO
         X5AyeYofNurRpXKsBy5UUx5F5wyDIswiByfsx9pvEQFVs3t0008KbDLEYkxPV407jKxy
         rY3ngePugQGu0qNpJxWLBIjPLing1MXI8u8yRdT8q1HXTsH4c+/4ugjgSteAdH3go5wZ
         rnI9azXKN51sKlQh0Y4lrFsObTFWm+5d9Z5fj4gw0omcDs4y8NS0D3EPAFzAajVD1Nh9
         8jy7h/W9pbHyvSmVh32AgdYBS2sdWXTARQe8mwJPm0nWWLRbPb/3o5VHTgF6gCQ/7U3D
         dj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637161; x=1724241961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPe4nIsz1EXCEucyi5kNCLJA6PBcbQwuSblj1gXsWr0=;
        b=stY3ennddud99+Vn0zEGHqM7gETPMeT5N6b7SsBV89O5aVWlgw8K0rrqduYAeubHMe
         DYZ+B8GitRPeO/FMUmm/ErJkAtkFNEX+p1R4u3lobq3rcG4CNQ8tQSGhYaxWnvy8uHSF
         j43DlgMVIw0jz/IdWVtPp5AliMU+bx5VqFYQAC+r+G8EpZR2tamVCcVfvs63xP2tj0cU
         D73wCS7rNQu8PjHROIj33h4wscnp/nHiCkSYh7Ec2mbt+i2ZJqgzXtCMA/j1KclVIZMs
         /IC575wq8I6MGtuV9dyGaWq8mFLDG2+jpKYsrWc0SrOsGE44O6riSzpnC0OLCuThh6y5
         /wUg==
X-Gm-Message-State: AOJu0YxmN2Bfxpb9rpIcGRgYYTiGuNtNJbsqjF1tF3dB+s4TikQpNydM
	Oi1/RwTsFkLO34trlCwkd8/v9y6kLQH43TaiH4xv+Tneqd7RLmQy77KXp9G38Wt2PlCwp5beAKe
	Hp44=
X-Google-Smtp-Source: AGHT+IFZ3GzUDrO83lEtoZRt0/oG5qzikXCzXnGzlk24xwighsBRp3b1dyO4Y8j8zvmh9HyVJf8uVQ==
X-Received: by 2002:a05:6a20:43a8:b0:1c0:e629:3926 with SMTP id adf61e73a8af0-1c8eae86068mr3417600637.16.1723637161364;
        Wed, 14 Aug 2024 05:06:01 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7cf227sm1548930a91.3.2024.08.14.05.06.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:06:01 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Patch review
Date: Wed, 14 Aug 2024 05:05:50 -0700
Message-Id: <cover.1723637014.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Aug 2024 12:06:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16481

Please review this change for 2.8/scarthgap and have comments back by
end of day Friday, August 16

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/7241

The following changes since commit 11d83170922a2c6b9db1f6e8c23e533526984b2c:

  codeparser: Skip non-local functions for module dependencies (2024-07-17 06:24:29 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Robert Yang (1):
  data_smart: Improve performance for VariableHistory

 lib/bb/data_smart.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.34.1


