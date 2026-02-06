Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC23EB28F1
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 08:40:50 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7403.1770367242776051679
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Feb 2026 00:40:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ZIm1P2LD;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B23714E42431
	for <bitbake-devel@lists.openembedded.org>; Fri,  6 Feb 2026 08:40:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A45760729;
	Fri,  6 Feb 2026 08:40:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2809119D17B1;
	Fri,  6 Feb 2026 09:40:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770367240; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=J151b4t0BgMBv96LemtRcN/GW9PS9gyRyfgouEY29ts=;
	b=ZIm1P2LDeSjkVFVzc666H3LJwJJluvKocMIQzIp5KRhGGRSwXJS2mPPeM+kQKLCMyh2sO3
	J5jxAvnM4nEf+UTVhwErujhHS+AWUjWfLvkNCWoktQj6N0NkScJ0SzQYAa2aA36KW60DpZ
	u5LQu/sxB/bJ14dR0fK5punfQHdfa05QC6GymHzO27kMtRWbK5uzT0cBu5tx5eZ62wmcBl
	Fe7hB9FlY6v6JJWDFxqv9QYrG2r9D3SQVpdJ9bGKs2o+HdQv/qGZ2bYkJvCfBb9SfsEwqp
	qlQRfAOTY1drki17SzI4H2wzekG7thz5L5zfGxXR+0NCYiHTxu6sUajK5i2smg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v5 0/2] bitbake-setup: add descriptions for fragment
 choices
Date: Fri, 06 Feb 2026 09:40:16 +0100
Message-Id: <20260206-bitbake-setup-choose-builtin-v5-0-3038da12dd2f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NwU7EIBQF0F+ZsBbDexQcXPkfxgXQh0VnyqTQR
 jPpvwvjpmYW9e5ucnPulWWaImX2fLiyiZaYYxprUQ8H5gc7vhOPfe0MBWoBoLmLxdlP4pnKfOF
 +SCkTd3M8lTjy4MAYoTrvUbFKXCYK8evGv7799jy7D/KlmW0xxFzS9H37X6Dt/nm1ABf82OsWa
 yj0Ly6lcorjo09n1s4W3HAodjisnO1Jiy4ElAruObnlcIeTlfNKoQHrPdine67bcnKH6ypnjNQ
 QEPAY9F9uXdcfQbPiD8kBAAA=
X-Change-ID: 20260116-bitbake-setup-choose-builtin-fb199054cc25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=XPdDPi3/+B3ouYGCxvW1NiWpoEI2ZCHmVE8Xu536Uf0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBphakGHhdS0xrhb8Wqe0cVHqondvaUuKXm+dW/9
 vVrzpC56KaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYWpBgAKCRDRgEFAKaOo
 NliXD/9YoukXKHoVAwBi2zfNlX9MYJ6RL69P8MukJ0TL2LPJixnTAsQjWA2pewORWs2NDj5Nsh0
 CX4fFdMOWKbPmeXB/Tye8uTbYhUHjteVTFEIBRN6qXlQkMdS/8w2Q0fa+675kC8dnzC48vWo/iu
 DsiVLtuYwgEeBrsxoBngMwEHPxMbg+hxgh4+ixu0dhbGoD6/f2omj90itBhGTZFFy7VRqOcpWLg
 tOf9Hv7ixE8qpa8uCtR65JfSI5+2RwPkn8MTuSU0eW598Zc1vEm0YLXoOvlnlJiDU/Md221qyVT
 fuKLKoeBq/nOzzqvwYtDKl0/1AW7XloIbnrhzbrhiXVDYmKoJgjaxLg/kyUSLLNbY3x4XeqQ681
 gksiZsCnj5v7IK7Jz6STYIuPzECQzGRbVKQTqsmTIn24hRyAdN36F7oxJd+Odr37V3aTb4Drif/
 qZXc/M/088JuYBDfv6jw+9LF2YUYAE99XyfSeZj90MW8yRlwYNvYtF/p9lyFRNeLeYecO432NGV
 n3bRYc9jCPpgPoyXeU521aZdnZiP8o/IM2x5TWQ2ds+rbI9rQnHwbE0snzAOkFRl+PvwqhwUKSf
 OGqHxM2D8luNQ0uNusfp8Tkt45X9yIyIDpmP3H3OauMQf0Jjpg5z66WEV2jFOYlRZ2dEWVw1Fpf
 evNlo3OOhbZui/Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 08:40:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18977

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v5:
- Rebase on master, which makes me drop PATCH 1 from v4, which was
  merged.
- This is also based on https://lore.kernel.org/r/20260205115414.3956729-1-alex.kanavin@gmail.com
  to avoid conflicts
- Shorten fragment descriptions
- Link to v4: https://patch.msgid.link/20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com

Changes in v4:
- setup.py: move the fragments to gizmo-notemplate, add a second option
  (that isn't used, but it doesn't make much sense otherwise)
- rebase on top of https://lore.kernel.org/r/20260116095741.3654153-1-alex.kanavin@gmail.com
- Link to v3: https://patch.msgid.link/20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com

Changes in v3:
- Rework logic as suggested by Alex
- Remove modifications of {oe-nodistro,poky}-whinlatter.conf.json
- Add a test case for oe-fragments-one-of
- Link to v2: https://patch.msgid.link/20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com

Changes in v2:
- As suggested by Alex, change the new way of specifying fragments to
  remain a dictionary so they can be extended in the future
- Link to v1: https://patch.msgid.link/20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com

---
Antonin Godard (2):
      default-registry: update fragments choices with descriptions
      lib/bb/tests/setup.py: add tests for oe-fragments-one-of

 .../configurations/oe-nodistro-master.conf.json    |  6 ++++-
 .../configurations/poky-master.conf.json           | 16 ++++++++---
 lib/bb/tests/setup.py                              | 31 +++++++++++++++++++---
 3 files changed, 45 insertions(+), 8 deletions(-)
---
base-commit: 1ee053e1b1f9f8f008fbf7d7a5c93ebc8718d4b5
change-id: 20260116-bitbake-setup-choose-builtin-fb199054cc25


