Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5B8F55121
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 22:56:07 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19086.1772924160181514508
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 07 Mar 2026 14:56:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=b24+UMkn;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso97145245e9.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 07 Mar 2026 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772924158; x=1773528958; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTzaJC8dYY5Yei64G+t4IE8TWAAgF+1lW43oda/666o=;
        b=b24+UMknyr89CYORdbuMJNWGBdtpcqjZmxJdocjAX6UbtdPPOeb7cHp+o50G2SjgfA
         2FcvAOXYESSnYIXPC366JXJAOZXMBXaivNJvfYMBmSDPqLkfF/b7sh8isaQ79y/78loK
         fN6Z5TfhE7bVhBDp/xAQGToBMiKjqAynbwXmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772924158; x=1773528958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTzaJC8dYY5Yei64G+t4IE8TWAAgF+1lW43oda/666o=;
        b=PeI0+f24f7GOSMut0o49OtAP89y3re6JRRzP2H6WIycIsS2LnX21guxy0lA2dCL/Nq
         HOhTajYg9VWgJc8/1KTp20OhM+xB6TUuryWJSgrrkiiNByqZUg+GgB6YDAC086DiFcUX
         CfkudYnnJlYvDK6gaiv3ybovnKtfxsKiFrzmE0tPqYrmq+bLkOdrajabz6VW7fl3PZAf
         4vWkSqzEvYMXRGSpcmhFgczAlp5+f0B7RwRyJU0ex/vFtHZvQ4iqsyTAUD7xXFSaFgKz
         oMmwUE8L6j9aO8W7CUwJQZrwo68JMVhtAtY5FjxcHy6AT6F194wVJbDiUVcw1QOLxWxg
         oo0w==
X-Gm-Message-State: AOJu0YybxwcXmm9vk0ndNKLKKZik27p7Y83jsL+vMvZpPRfp/XFjkvi3
	PzcomOa9KoIM2f86UPHVY7Z4z/fbcGydW7caC2PYWxVoQFulX7x8p5vRi6FGTcJB4T+V/UwDprB
	mrTWC
X-Gm-Gg: ATEYQzwbbxPP78qyP1PJRNrdK4/s6Op3aRbHHzPqGD2CnZdpVlcz3NxZZtlLFHNj2bh
	zx9U9U0yAuUy4HNGoiWV7ZTP1QNbxkxuRMdfpKbzE9Cu7cR9XRlBzb8fOW2Tfvfu4eQhCP/8RMN
	HhOfY5EjzACiLUcSDXgWlJqt5717EbEdyTIXldzj4sKjMpyOWIwoAgJtssOfxo7eEjL/0HYvpVm
	GgN7yYE6A0g/0qAYcGB9KIwpp6mup7c7V/Faj3VV/jfwGPdlETI3HvLufvN5Qygd8Ldhw7190hb
	6NTyIhkzVAcpY1rXZW6etRqC31CufiknueJxVHITQAmFAYEaztxQ/gwHeXrn7hJguWG9I6TcTnl
	iNyekHoVHX9YZBKivsQgo5LqYTunbbiF9l28wlQ4296wYJhcGMyr52Z/ymP/q1FDcK66homNb/E
	2+4tFab+ir4NftLfqzq/FdI5b+n1DgAe6mKJVEG2RFXp6qmEMDRVqTjF2c7LOPOmJ0rUHG4xbD+
	pvPcVc2twira8HIdoTyFHbu9Bk=
X-Received: by 2002:a05:600c:c16d:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-485269581camr122647665e9.21.1772924158361;
        Sat, 07 Mar 2026 14:55:58 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b09casm243831915e9.11.2026.03.07.14.55.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 14:55:57 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Patch review
Date: Sat,  7 Mar 2026 23:55:46 +0100
Message-ID: <cover.1772924048.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 07 Mar 2026 22:56:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19120

Please review this set of changes for 2.8/scarthgap and have comments back by
end of day Tuesday, March 10.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3349
(Ignore the warning about Centos Stream9, its support is a work in progress)

The following changes since commit 10118785e4a670bce4980e1044c0888a8b6e84af:

  knotty: Make sure getTerminalColumns() returns two integers (2026-02-13 08:48:40 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to bebecffef63a3ac60420b5347d549f71b00dc151:

  COW: Fix hardcoded magic numbers and work with python 3.13 (2026-03-06 21:15:02 +0100)

----------------------------------------------------------------

Richard Purdie (1):
  COW: Fix hardcoded magic numbers and work with python 3.13

 lib/bb/COW.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)


