Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE818CE8D5B
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 16:44:45 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2771.1763138682137436582
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 08:44:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TAauz4Zb;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 018381A1AA7
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 16:44:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CB9036060E;
	Fri, 14 Nov 2025 16:44:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFEDB10371C68;
	Fri, 14 Nov 2025 17:44:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763138679; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=GCVuJw4n2d3UgzF3LtmF3D63HcelppFKUzf3pLZq+wQ=;
	b=TAauz4ZbErUnYAgqfOz4Y+ckkGslZN7r57+XY3ieMjqZlc7DvbjnaxNo3heBFkdPQD4/yt
	gryaGJ/pYze6y29FuwWmjxNOpJ40gsOfEjqDNi6VMTowDa9gtprSCyFosQWMXi4Q5UXumf
	IJnp/NDcpqbWiL1LMu4GsmW7ftdA3UVztZ6yYPYz5rqJgYdu/vHWMA6r3qNpGVxpw/re2I
	IE6KavonQgn7fA5T1y8k7jETao6wqeL61CSdrlRBvRx1FRiK3RzzhlmgejWpq3rz2YnE0q
	E9/f1zaIJFki++NVP0DCTkpUdAZpB/SVktNsDNz8TikEtVtZJVgX+a1gOzB6XA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] bitbake-setup: update: add a --update-bb-conf option
Date: Fri, 14 Nov 2025 17:44:19 +0100
Message-Id: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNcF2kC/yXMQQrCMBAF0KuUWTtgShX1KuJikv7qKKQhkxSh9
 O5GXb7NW8mQFUaXbqWMRU3n2OB2HYWHxDtYx2bq9/3BOTew1+LlBTaUmjjMceKaRikwPjvBgEl
 ORwG1IGVM+v7l19vfVv0ToXxH2rYPNCcmxn4AAAA=
X-Change-ID: 20251114-bitbake-setup-conf-updates-91ae4efa86ae
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=606;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=mgqd3D17p7tZf2Xg9mqZRQcT9RhNBOzullUxfUnXFOw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpF1x19JMJIb1rptSvG14tq5dhOGejALhADMuez
 JyZnTQ2IjOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRdcdQAKCRDRgEFAKaOo
 NgbtD/9K4CqXfJyKNf97+od/sNPx7j+qH1NdElan+MvGfCH8BwerwZGLbpfjc/osH9CsJbfqs++
 bBBlJSkwkOAclvbFUVzogCICRGQDRanBA+zDBnabKJWCbwuv+aGFb4nQp23+6CsBYLtFpS5NhpR
 FXBWRporTLQBk0vTQTK/TB7DSqP30IB9TPT9bXkCrfQtxTQ6Nkmpd51N4SvzkQfpkx2cv6lQAIe
 KMsMMjNiQuDOOxWX1HW4WFTFkPNE8UTcyGeL3fTfQtZEZz/IKZM77vyPLYGUS02yZz50OAghe6M
 /3gJ0Yb4R93qttfj9rlpdt1sYqk1mqtlx5QPUw9swTPXUZGb1EyWGd4DLbUpaT9CkjAYCwWL9AN
 0rDCdTFzI5rhsqYqkmH1paViWE5Q6nhBMZpmNrtWs8gro1VO7paYsRXdUwe68xw3gyRZNaL6fMa
 9sm3Lky8Jq5E84ZDWm6teAGrqCBMjcQYB6uQX3u8TznDc/viskbfsM6rQCNsuSHGxao5vYNeK+p
 gEaCR2dbuQy3hRCPtGm2W+bvOHEYteBguzbDI00GC+6kmza/b57lpdBVVyPBcoBvz8zaSQPDkUc
 1hbISlAdBLs4p/vy6A3kXzyvJIUoaLRdTzBSCUzIMsZ8VLV72qckMEA35wNP7uFgK++0HQiyD1I
 GAE8+DmpO26wGmA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 16:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18405

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      bitbake-setup: update: add a --update-bb-conf option
      bitbake-selftest: setup: add test for --update-bb-conf=no

 bin/bitbake-setup                                  | 28 +++++++++++----
 .../bitbake-user-manual-environment-setup.rst      |  8 +++++
 lib/bb/tests/setup.py                              | 41 ++++++++++++++++++++--
 3 files changed, 67 insertions(+), 10 deletions(-)
---
base-commit: 1949f6afed0e21758006aa8a7339ebc0f7b5b963
change-id: 20251114-bitbake-setup-conf-updates-91ae4efa86ae


