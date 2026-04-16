Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDE3F8808C
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 06:56:44 +0000 (UTC)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7709.1776322600329020245
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Apr 2026 23:56:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=tHZE2/Tp;
 spf=pass (domain: smile.fr, ip: 209.85.128.65, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso124670675e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Apr 2026 23:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776322598; x=1776927398; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQhpJBdbqrvSiulNLyKUhMVkhdH5CeX81jw4Bg8jPKU=;
        b=tHZE2/Tp4lY25AWA2UbzGPy+2a4JSuA+8cVzzy1uuunmMw+MIl8FPgUcRmMslf3tSV
         wD2rV/CJMvz8z3WT+srfcgeItLpzLqmTtHzxJTfQY/bIkaZh+vZ1IkXCuDlkWKp03HUg
         T7Tfa7iVI7jWPQqKMUnwBOJCO+yHWup6Zyb2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322598; x=1776927398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQhpJBdbqrvSiulNLyKUhMVkhdH5CeX81jw4Bg8jPKU=;
        b=aF+MtLdJJ+qULUrP5kzm64Fv08d4coniBlcUoH3eQk+OYH1KM/0ac05P5AxQgu3QAy
         JsxDEasRFfEmaTOAmXs6G8/FVJnC1vrk7EX3nPoeL2voSzDRYNJQhRZtJBWJei1MCsNX
         0wVauPG/LLNxwsE5ceATuOXsWi4px8KdqitcV7GLunAxL0MJpLzTOWWmUQxni2Yvx2Zd
         N1Fit1kKL2DdA74WyWeysHs3IVRioNYKXpdCLzOP3aGpL656IKUFh9l6RZ0/pSFo4Tv3
         yQHUYkKCwqzHmOJ3Ieg/0c+8oNZh0/oxJH5xnB2e/ynh2gjpQDi2gXIv5ICxnabMAtxK
         390g==
X-Gm-Message-State: AOJu0YwUH7rt+ylXVSG/T3jplQOeNXhR/yYc44CL8pQavy4bOTlNP981
	sj6TfYj8XV3LA3yC2ouOk+nifezjc1tm32fdbkUGBcv2v7rRkpiJO/Een5ZXp/cGa0NHAhniGVy
	br6dDpdhvTk9F
X-Gm-Gg: AeBDieujKfmrtWCjcTYS2JTy/eK5oQPahw97c6cGpbE2mYkxPmmCUqEtBRwW+YJLbI3
	dzEBDVW3OadJPeAXEIfddkvrRuKK65SnR2xXWG4wqfeiSHSMMPxKKJEMcjsfrvJ00GLu+5+3Nsf
	0jXDIGCOIdk1+ERsOV/x/KU9jzLtp0zXYycFiWJlUujhjkSElKiA8UFXqN31+SC+8ZN4mudCJhR
	Eg8xWHJuIUHqIwU+q3G3LTC6gnHdKE/+b8M/J8tpYTQsgiCU+EWFnLlDuC/spPdQZ18B0oxr7j+
	wx9Ug3R+rUaB+nITZ0wV3eHGFVAHu6Es4j9LM0ba8ZXafpgWU8lLYLPhFL1p2SDtmvlDpp88dIw
	tsL+40UMl6bWMgIYUTsWlAVS26HKyu/OQQWxEkF+oFE30z8WBb6jYF22fNnm73Gat2Stle1chLl
	IeV+8iYAUANmZ4HwN0PJoa9lU6HYDgAJs6jcleFT+cv8ScuODFrWfCviYPiMD9H8fts/dnMn2wR
	aYy6Oo+ov6DcfRY0YOYhJNlYKPfZA2PISSJTw==
X-Received: by 2002:a05:600c:45ce:b0:488:a8f0:35bd with SMTP id 5b1f17b1804b1-488d67df745mr343471155e9.8.1776322598214;
        Wed, 15 Apr 2026 23:56:38 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e0091sm9838195f8f.25.2026.04.15.23.56.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:56:37 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 0/2] Patch review
Date: Thu, 16 Apr 2026 08:56:30 +0200
Message-ID: <cover.1776322491.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Apr 2026 06:56:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19367

Please review this set of changes for whinlatter and have comments back by
end of day Sunday, April 19. I plan to do the release build on Monday.

Please note: This will be the last review cycle for whinlatter.
If you expect a patch to get merged and it is not in this series ping
me as soon as possible.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3670

The following changes since commit 7af7e04f3adc8ba144d9e2e6b37ed4ddb3b59df0:

  bitbake-setup: ensure paths with timestamps in them are unique (2026-01-26 09:06:04 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.16-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.16-nut

for you to fetch changes up to 713fbbdb9ecc195ceb2216a2345e0d79dbee2135:

  runqueue.py: make sure we use bb multiprocessing (2026-04-13 16:17:31 +0200)

----------------------------------------------------------------

Richard Purdie (1):
  tests/fetch: Avoid using git protocol in tests

Trevor Gamblin (1):
  runqueue.py: make sure we use bb multiprocessing

 lib/bb/runqueue.py    | 3 ++-
 lib/bb/tests/fetch.py | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)


