Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E00CCA490
	for <webhook@archiver.kernel.org>; Fri, 16 Oct 2026 22:56:03 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.349.1792191360683407445
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Oct 2026 15:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=aVpzDnsr;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48de72fc832so236818f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 15:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1792191359; x=1792796159; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LV6lYM/mWOS3gNaZh2Ton/RSTbaYuXGQ88S3/OQKRuQ=;
        b=aVpzDnsrCWpPkMZUOjA7ALRAP2yQVcWdiYvybEO5M8cLONPD2A9wt57cqwmPZBf0ml
         gzk26SXmwOwC1VXkiXcHHt+doG4GsYw/iLSDaI9pYMJuGRFtyRlW84Ebi9jzfqluZYdg
         6mnRh91X6mR2alsgmZw9BbE29Sps9D57GsCmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792191359; x=1792796159;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LV6lYM/mWOS3gNaZh2Ton/RSTbaYuXGQ88S3/OQKRuQ=;
        b=CrqIBQHmGizlWrc6JCwmZh7mR2ctUQ55JsotI0BvQy/HVZFKY7ald+buUzOgc8IHTE
         hoTNUVC6uV18KpHIZyH1ya5Bk6vCbraHTxfULl6/iaLUjIfYDnDcuHSA3wC7PSQG7keN
         ajKq10aE403szVaHYJ7RV5uDCNscYilqcngitvjnWTiqlPHoYdGHvTgw7mtrntlwt7+t
         VmryuWjL7bsE0O4/ZthOfm0i9veXL1UISk/Y/XIpl3wYdJ+73xJnNoM75Ftu8OUGVnBK
         NRqBBrryp2iJj1TLQc7TvNJg8Umguj0RFwX3dN9hrJy1c8+L5SpNcosrvsVdOvKbPSUH
         i4NQ==
X-Gm-Message-State: AFq9FYJ9ScfwBG4iqjKHaTSF9ol6LRd8kRp4EbGmYcR0E+ARGzlpolR0
	VaeuwYf+5pE9XyiueHwPFGoT7qOIBbglWWdnWlqetqYCsYXDKLUOVaB1pq5HrnXQz53MLM90CD1
	i0L/wZlc=
X-Gm-Gg: AYBFou11UYu06Y/ClBhHMOZ3u0ly173HByf/2jfF5k5SFVGm0ooutFSFwgokh6Wqe47
	2MDQoxkW5oaadv+72SAo7HOvt9Xpyb1fE/OUUkTVwocbaWuElLdVcW4XTSzOOENDmbMkmzaBHr8
	0xL61/G8VgIewOKlJOrawVMt2IQOQL+NaZcVY9dDpjSr0jRKm5sMlXF6fCRahTSSLH25AuuHYdQ
	5s8gluL8RWatRAxHXrvqd6XqO4fdfKEnLZhUOX8H4SDVij0vvvgas0aJWQgR9AVsBSRdRWsGIqb
	LumEu3st/T6unJ1VLUZFW+nS5z4Hc7WNlzphssoAIK93jayraUaPmJVtP1KTkotqqEX6tv1jqtD
	5iXrw5KBpTfNZ8Z2m3ZhykxIuIa4Ki0E60sTSeHzDXKbC1Q5dUt5dMLBboPrcDNpjCHY4vxv8Oo
	I5gxLp8CWj6W35ZMf8u51e4L6gPM0xjkx6YuKb650iqNu9WjEFcxCog9rlwIlFryFEttszOWOrg
	SRJ2GX8upcgZR+4Qzy/mnx2SuqJxJQErwUsCc6XJkdl3PCyJJvUHlNYwWpv2x+lL6ME+Pbs4Q==
X-Received: by 2002:a5d:584f:0:b0:48b:123e:2f60 with SMTP id ffacd0b85a97d-48e07fa71c4mr1785328f8f.39.1792191358786;
        Fri, 16 Oct 2026 15:55:58 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5ad06bsm8052886f8f.14.2026.10.16.15.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 15:55:58 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter only)
Date: Sat, 17 Oct 2026 00:55:50 +0200
Message-ID: <cover.1792191269.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Oct 2026 22:56:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20353

This is the patch from the last patch review:
https://lore.kernel.org/all/cover.1792020468.git.yoann.congal@smile.fr/

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4934
* reproducible failed with #15898 – New sstate.yp.org CDN revealed partial sstate reproducibility tests false-positive error
  But the test warns about a missing sstate object from the reproducibleB
  build that is supposed to rebuild everything anyway, then, rebuilds the
  recipe. So, there is no issue with the series.


The following changes since commit d3b32587c2314febf96897f97e0172790b4fc1cf:

  toastergui/views: Replace os.system call with improved parameter handling (2026-09-28 22:25:53 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to 6b443060ee96a62efb94723c97f22b51c9b20507:

  prserv: commit new revisions when a request succeeds (2026-10-11 23:40:57 +0200)

----------------------------------------------------------------

Wadim Mueller (1):
  prserv: commit new revisions when a request succeeds

 lib/prserv/serv.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


