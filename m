Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A987FF60E7
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 08:15:14 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15382.1774944912912216863
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 01:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=bn1kvVi+;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3ECE81A30AB
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 08:15:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D62B6029D;
	Tue, 31 Mar 2026 08:15:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9929E10450EF5;
	Tue, 31 Mar 2026 10:15:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774944910; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QbGoiQyBB0JljI9FwMnrn1Eg5NL80Zk3kAlQHHGGPFI=;
	b=bn1kvVi+ZpRpSTAUZE5Thl4tXVfHRNdAjL/GJiUHbz/gu5pAtUKYZQyGPRaPhX0wYbr1lo
	s+qswPpteGq0gQX93WGcy/ZSGoqA/7AAAlOSRX7DVEa/iSua6HcFEH348djDZtvTki+0WZ
	Uyw58u6gu8WfGejdmItOed40PrR+0HL6xlL33tsIUzydhqi2nCe8Sa8npgzS50Svht+t3m
	sNVadPJpRmo95uwXixnxzMDMTD4WDxi2JYVE+bDhjHMN0l12AtbJR+cLG0GdGVBL4FDV+X
	Age2qrbiNlGsUxSQlGTSzYq8L4e3QQL2LhcSyJ/2pbRzOydhejXCnGoiaIor9w==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] bitbake-setup docs fixes
Date: Tue, 31 Mar 2026 10:14:50 +0200
Message-Id: <20260331-docs-fixes-v1-0-45ee34341e72@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBAG0KvIrDVplSZcRSy0HYwF0kEk0rsrl
 i/fzw2MgZChyW4IeBLTuiSoPAM39cuIgnwyFLIwUmsl/OpYDHQhC+mdLbGurDIDpMEW8AtSv+1
 +82FndPv7ADE+2q0aTG4AAAA=
X-Change-ID: 20260331-docs-fixes-0dcb4e95b16f
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=674;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Ptd3iAbvmKPmNPkP8FmVFnif0mfI0mvMb+cIPmdqf1E=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpy4KNyZFUgjNfMpY9ecKcWusnHMU/pl73oneee
 FVHUGprKvSJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCacuCjQAKCRDRgEFAKaOo
 NppJD/4q6iXhEDPK68J+Bvy5x5pgWr02hEZyXDJYSReuCsn6wQoawRgrSFn8W8ZW1pdqeeYnets
 MR3BIpLmrFeTGdZ3nX4mkTgFdlG8DKj9V3RZWybNoLcs9qUmpb/BJsBabHPJSAsa9dd6ihQCj0N
 DFqBY0QYm6k+rC5VvevwLxf03BiOmd0EIXPsP9NXc7LNnoo8im4HQzMNaqM1zfApqIlkOnAWYo7
 QMlpI4TZnsz/P6EShYmRVC2DkUvvu0/eU4xoBh5lar5jjjnaIL4NCL/DDyQWHn3QlxaCVeZ4hfy
 j9OVIY3IzIFAl6y2roojo8TKF7I4GSrXUjAGill5RwIJhubZolsXB5rIcRxcZBqnd8NNqU0Wnnz
 kXCXHcQxZUXXqdZZomZNutOEMpf7ZecoSXlJX2tKfp0VTMHU95ITIIKHP5EAcfyhGBdD008F6Jw
 qxaEPpAnZUWTtafSURSDFbqYKLjdrdAH0seW2aNLaX3QbDGVAQHH5jIK1lcBgeWKTy6ySDLVupK
 Nxkhbn+fytRNzh+WcqG5FyRHKab+UX3hh4RjwLj0QJTwIIxNfmqTsBWQkcyi4iV5L3LdKMbVtbD
 Z3vszoRKL5V7YGC/YWIjbBr4tqWjTfdgt+ZUu2cY0vgNGDxDncsm9UdgypjQsU+lCTnfMmEQVnP
 5WtSxcw8QuLrrdQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 08:15:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19286

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      bitbake-setup: rename "abort" rebase conflict stragegy to "halt"
      doc/bitbake-user-manual-environment-setup.rst: replace shell blocks by console

 bin/bitbake-setup                                  |  8 ++---
 .../bitbake-user-manual-environment-setup.rst      | 36 +++++++++++-----------
 .../bitbake-user-manual-fetching.rst               |  2 +-
 lib/bb/tests/setup.py                              |  8 ++---
 4 files changed, 27 insertions(+), 27 deletions(-)
---
base-commit: 7cf11787ee7942a00ba7e8fa2c590a2563070c38
change-id: 20260331-docs-fixes-0dcb4e95b16f


