Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8789F33836
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 10:08:57 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.72661.1773742128624868012
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Mar 2026 03:08:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=lzOEHYlZ;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 997614E42629
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:08:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D2815FC9A;
	Tue, 17 Mar 2026 10:08:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C07B1045044A;
	Tue, 17 Mar 2026 11:08:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773742125; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=aIH9bTAYfZLosTHH6kxHSV7Wux9Sc27SbYw+i+GApkc=;
	b=lzOEHYlZQrcBLLp9wQL21/UOhq9O4so5nnU3+jMNLTnBWl+m8GR40K4Ssj2KTA5Wj43uxP
	45TlWIOaaFUd4P5bUrHDyxE9Dawkkx3qAZPgvNJZBOegcgLTFXfEEfUE7J1Jj7NZB7LxNV
	emM9JB65Hv0sAfBM3hmNO47Y0INmRHfOFGntn3v+65EKG6eelN8BtYmNCTpRo8Y6NgrJot
	gvFihjj1ggbiBhHXnIUrTo/gEWri8fMTpXjTu8kUY2If2iBJmCiLf20KnDSU87Y0+u4utC
	CYYUdgbK6J5PG+YAJNsyMCoru1KTHcvyoHIp7uYA8x8jxbxIzxQnXSiJ8c+VMg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/5] Docs build cleanup and automations
Date: Tue, 17 Mar 2026 11:08:35 +0100
Message-Id: <20260317-docs-releases-json-v1-0-492d0b256349@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTvJCAbUqxgXpfyVIaY1HTUkh
 LtbcPkt3lvIkBVG12qhjK+aplhwPFTkRxcfYB2KqZa6lUZOPCRvnPGEMxhPliIHEe9Cc27RXai
 Er4yg8z693f+2Tz/Bv7cTresPEEnqlXYAAAA=
X-Change-ID: 20260304-docs-releases-json-f00caf386e79
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=2JegcHd+HUpKbk2NQ4lTnVL2+aYy5Lp2wYRfCgYCuYs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpuSgqFyehRGlyRN8Tf3/3eG6stCEkTB8jwE7/A
 azu1MfrvMOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCabkoKgAKCRDRgEFAKaOo
 NnunEACbskbR2Lm0aiIy3ZoPQAR1G1UEGh/h5pRmYQV2Dk7mzntrQcPgPiEOhpiEo4iU8JJOxGc
 16JBUCWCp6San/YT4c/4dMtp1TV8qdtL5UtkN+A1tWC65ZQqE76aUNvltnwFAB25xMHlJ+CY68D
 PipVLpvEhdHItNp2zxjciQkxrALIEMQRvWGBLBAyir/7OIkB4bg3EACvqcyg2ledWYxCTPJ+cKm
 J4CBaM0NsGNZPXPgDrwyg1WEQC+bRjLVZ5Ixdlwj2t4CFpA/EJLWSmT4WfQXlWTNlqWgvNCFVf7
 yqBZ84kd9dLqXKrR4PYwwQFQS0KrAVSQ1w1b5KiAxLCa3fSzy7L4XoJcqepscNJXBQCheTMGOds
 fIwksymIEgOUZNA1zInSC2V2xBH0Ot/1OqpOHF2NmtFp/tofzwz7qBMmYcovH5mdlPXptaSFk5t
 Xt2fEkyIMNao8c/+0HF2tD+yVoZXue1kwaFnZFJGTK5PLIA7W/qTZWnkWdYkxTEUZwDI4885NUs
 0ITArDe2xCU1iUVsJeqHLfbGadDWp5MiJz2wa1ge59bUmYBgEJ6tuYUKgRwN+jrvhc/mHTvNLQo
 i++EGUGMOta1QhcXySA6rG7BuuCwcbhNKGDGzLqT3X6SGKvQMVZJp/VKMJrkkRrT0SWIPiGczCp
 12jP4jM71J3GYXw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Mar 2026 10:08:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19159

This series aims at first simplifying some of the recent code
surrounding the documentation build, and second at automatically
fetching the supported/outdated versions of bitbake from the
releases.json file[1] and outputting a releases.rst document from that.

The remote releases.json file is downloaded once when launching a build,
and re-used on subsequent builds. `make clean` will remove it.

The output is unchanged compared to before. It will only change once the
remote releases.json file gets updated.

[1]: https://dashboard.yoctoproject.org/releases.json

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (5):
      doc: move the Git repo check to the conf.py file
      doc/setversions.py: simplify the get_current_version() function
      doc/setversions.py: fix an f-string without placeholders
      doc: build using remote releases.json
      doc: generate the releases.rst file

 doc/.gitignore     |   2 +
 doc/Makefile       |   2 +-
 doc/conf.py        |  13 ++
 doc/releases.rst   | 199 ------------------------------
 doc/setversions.py | 355 ++++++++++++++++++++++++++++++++++++++++++-----------
 5 files changed, 300 insertions(+), 271 deletions(-)
---
base-commit: e8ace6e16c78ddbc2cfe985b88b66800d99282b3
change-id: 20260304-docs-releases-json-f00caf386e79


