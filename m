Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0472EC28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 19:48:17 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.4548.1741808892918788015
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Mar 2025 12:48:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=H9/xBSns;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22337bc9ac3so4332785ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741808892; x=1742413692; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=irN5E80SzyUM+x2Q04KjMbXdlwxDGbmcFKdWLQwYU64=;
        b=H9/xBSnsfbdSDoBlcDa5A1lbXwJVrf483PO8c/PZHuHKQW79odVVSgbLadX/wy9jOv
         acypuSPOnyoLbkZ/gTRBq/gRu0sEV+ZnFfrZht1EDL42VIGvl+1GkM0U99YkzoYkcN3X
         geqJZ0IoBEq7R7SRx6pjOyobuAmALkU1Mv0vTzFybd7Zc6LcUAds1wozI9EWvRfqrD7b
         DM8LRxJa6STweS4EjQvzuEE0h8t9mu4KahmbqctwmEd0Sz9TnrguQQBEovAPODrYoKDm
         AbR1ZY8fcsThZsuNuAE09i/M80mRz/2O2icyO8kvqCW9xfIvMYf5Zc12c4q62f+fgFO4
         zxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741808892; x=1742413692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irN5E80SzyUM+x2Q04KjMbXdlwxDGbmcFKdWLQwYU64=;
        b=PDeV5X1/TaZ1YOSnTtmyZfrp3gtnui9ptRCzcWQWG9FwR+aJl/SoLo/QbbaE5fVyml
         XeoijauCBRe5WY/q81Zq/PZo4+qQkhLCXkXzahP8T0Ks2TvfYy2+zjQrrIqBL1bqOXOk
         EDVMlK2CExWu3fIKs8ltoibD25dxSjYVBOshzhcUEd5G13gZfV5KA6ipR0DY6TSF9akF
         tFIZhPPlw9je0d2I8AWNHd7IeCOJp6XXra4nbosEemz5Bud3U5hnySGeN43Gy5EsW4pd
         nWkJ0HN05YubyUzc7nUJsWIxTuR+LBe3o/5QJ6PSgrqan8RN2jNs7cfc8gBN7LRBNIop
         enig==
X-Gm-Message-State: AOJu0YxfvXPWj4HoKWwDSRc6f5PZYxwv31M9sQ7Gp3LuEQjylRsJHnmx
	JKvC+oQnA2ZGidb5MUe6vP+3TjESvvfhxa7tM3kZXHNLdaltvbLx5OdA6sZ3SGQIAc6euZfq8+X
	D
X-Gm-Gg: ASbGncuOR6IJePW4AyhcsMM7gBYWRR9NYm/nD4HGkz4Sb/QcSEHr19dRTo/EG5hLibm
	r2dYM5S+9nwV4EdeH8P8ejYvx7g9CRHsjmr/9/4UQe/BU8ack1U96j3srxN6TF+5i1PiVW1Prjj
	rW38e3eyjAoQquJvBSkz3TyA15OqRX8U+j3t4neBUwPpHthvZvf2QBCPZ5KRyOXsoTzqW/xwgKx
	FXhupwk/YYzqq9L0TVBEatNAms2P+87EbXnBElwu9wdG5/xLAsFgZmq2BClssSrzXqZPye1T2lK
	jNlT6OyLLLnSKBFaCthAQKqYQQphuPvoz5g=
X-Google-Smtp-Source: AGHT+IFzNvhiEg8RAOoygLP/Fj2zOY/tvB6OLzIRltNEDPnR5QjuMkeg7uUK3UDMaqEFUoYjRNJ2UQ==
X-Received: by 2002:a17:902:e841:b0:220:c813:dfd1 with SMTP id d9443c01a7336-22593183e20mr132364895ad.36.1741808892021;
        Wed, 12 Mar 2025 12:48:12 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5779:a397:ba1c:2b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e98adsm120700855ad.90.2025.03.12.12.48.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 12:48:11 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Patch review
Date: Wed, 12 Mar 2025 12:48:06 -0700
Message-ID: <cover.1741808747.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 19:48:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17437

Please review this change for 2.0/kirkstone and have comments back by
end of day Friday, March 14

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1177

The following changes since commit e71f1ce53cf3b8320caa481ae62d1ce2900c4670:

  tests/fetch: Fix git shallow test failure with git >= 2.48 (2025-01-24 16:17:43 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Paulo Neves (1):
  siggen.py: Improve taskhash reproducibility

 lib/bb/siggen.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.43.0


