Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA12E7E0B2
	for <webhook@archiver.kernel.org>; Mon,  9 Feb 2026 09:33:17 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44030.1770629593480357201
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Feb 2026 01:33:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=s6Xlp7F+;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359a16a400so3941544f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770629591; x=1771234391; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPpkaEdXMfBYpL56Wg+IgHBfhT95xNoxkrql0UbQChQ=;
        b=s6Xlp7F+nKh2ZxpkuIDHxEMecNZ386vFZmbQYQT9CeNsuY3peJS5xIknZT9Lhh/r8O
         imfekeUkMcVvznK0rnd8sWf1sJA3PY0KvmYKUnJautr3ebEsVNjgmNgPVB0QV1pFPRS1
         NGCYrF7dkdmsVuWvK7sYUa9LFNKuGRwl2MJhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770629591; x=1771234391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPpkaEdXMfBYpL56Wg+IgHBfhT95xNoxkrql0UbQChQ=;
        b=WvTHCWM11IQFmbjWm+MKOikC3LF6XDvFE6Yi1dF66wbdZFI8+K/vocbr76GB9poLib
         CMeicABlh8DEjkk+2izamUwAChqkqNgw2JYolGbUHJypj6VlvMZUlb9LbLET5oKJ3gEZ
         4hB46ZwxERey47BQXFcCdKT8j0e5CdZweR5or5aO5T4WaGGHpQLU3GhzyYRBXl4snoER
         zI7qt8SHvwi5bud/nZgF6yeXFGd3uGosEC6ZsvaevVkJr5lW44kx7ImNmEGuNHho6hm7
         ea22nSz0rgjc7zeS4WpsTX5aQUnmlXIok3DVU80hEoF4IGiNwZfWsZNW/1ftYUgwzLMI
         wLIg==
X-Gm-Message-State: AOJu0YwRPcfy5OIAbLh8R0vDKQA8Bz/phMHYaqCK1x2ocTloscwEVO6j
	XhRQlFp5zcmzYtC6CV57m1R2VuMEfRNc8bAeZvsmCxOTjrb8vUIjw1yQvovMuz0Vp2hrhSUVfid
	THr4yaqE=
X-Gm-Gg: AZuq6aIGCgyf/fQekWrrcCq6kp1ZKwGC/G2o20edZxfoz2U+vRBCAR9yeCWqXobZw+g
	hopvrrzQjSuFOJEsuvo/52PBQbgCjlMlp8w3bQr+uLEvJ4bby5pRJ6FjH7TGdJOXojftbKKle/0
	RQF0P15bNaaSx3AjnpKRtkH9wZzBVXrMxvNf8wpNt8F89TwoPEyQDRAj3ClxvbDfz8p7URLiF4R
	VYl3viwQLJ5z4fZZG73kYPzS9XiOE1qDNZMNK43EL6OOcH2xM5aEOo6wvilPKISQ7WEKA/O0JSM
	t5dSpThNIWt7/tBbESTxtXR19BydNfBEU91J53L6DMr18BCn0b8L6U3YW5nxU0UT2ebBwvPExV5
	mLFp80Qfe8vJ+1dQrUsEULw4D8muE8yIyybSY4yHQtgMDO+yl5X8jvomIQ7hPFTnwkjVzec+9M7
	tYe+ERzGE3KlQF1Gx1SpoQpuNtIFX6bcv0eVXPT+cgQBERkyKarABrNwRbV9NbizpK1Zm741Ein
	rj77BNFkVfHf3Y=
X-Received: by 2002:a05:6000:186c:b0:436:da9:4371 with SMTP id ffacd0b85a97d-4362933a9c0mr19026185f8f.5.1770629591430;
        Mon, 09 Feb 2026 01:33:11 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376b62b835sm11321718f8f.12.2026.02.09.01.33.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:33:11 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Patch review
Date: Mon,  9 Feb 2026 10:33:00 +0100
Message-ID: <cover.1770629479.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Feb 2026 09:33:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18985

Please review this set of changes for scarthgap and have comments back by
end of day Wednesday, February 11.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3183

The following changes since commit 8dcf084522b9c66a6639b5f117f554fde9b6b45a:

  fetch2/wget: Keep query parameters in URL during checkstatus (2025-11-12 15:53:31 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to 1b923cdd50449aaa41152b72eac8669f27ec7ec2:

  knotty: Make sure getTerminalColumns() returns two integers (2026-02-09 01:22:13 +0100)

----------------------------------------------------------------

Enrico Scholz (1):
  knotty: fix TIOCGWINSZ call for Python 3.14 and later

Zoltan Boszormenyi (1):
  knotty: Make sure getTerminalColumns() returns two integers

 lib/bb/ui/knotty.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


