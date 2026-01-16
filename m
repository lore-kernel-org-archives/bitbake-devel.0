Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9E1C982D4
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 15:49:25 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51.1768578561013331189
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 07:49:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=G9C9fFsy;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E0AA01A28C1
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 15:49:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE82E60732;
	Fri, 16 Jan 2026 15:49:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E122A10B68C28;
	Fri, 16 Jan 2026 16:49:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768578556; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=SP94X3IWK51dNYDoh28Uj3FcCExcj2HaBGKhsZwDNLM=;
	b=G9C9fFsyUJiZ+XAewJmbfirdjvvmy8NmlH0/7xFN/AN+cbZyOik6CPdoXGWfrNUUfyMBUy
	5HSVnJWfxS73LwPpBeDVxaunPt+DhlInZNd+4HvR8WEqf50fuZnzVcs7LFklG7qrM03pc2
	ljaWdhzS09z7EL7Xrrj271WWjqXa8/krH7iTs2PWobB9jZQGbSQL9Zylc6XJwLTLeMlOIN
	+f99OntER+dRNW+6w+Hk4sn3zZZxC60diDIn08vuY4DPD2353fQoPLSeBG0PcAhXNpVBGr
	kOINzCIFodUbRAe+dNH0w2+We3Kal3fz60oDl+EbOJlVjeXqEHG2CyfK70bGfw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] bitbake-setup: add descriptions for fragment choices
Date: Fri, 16 Jan 2026 16:48:55 +0100
Message-Id: <20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOhdamkC/yXMwQrCMAwA0F8ZORtoixvMXxEPS8xcVNrRtCKM/
 btVj+/yNjDJKganboMsLzVNscEfOuBlijdBvTZDcGFw3g9IWmh6CJqUuiIvKZkgVX0WjTiTH0f
 XH5lDD61Ys8z6/vXny99W6S5cvifs+wf9l34SgAAAAA==
X-Change-ID: 20260116-bitbake-setup-choose-builtin-fb199054cc25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=902;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ng3MvndMqTAkZnpwy58RcSl0w62CnYBB58ojpzttpg4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpal36AacWnpwQXyj/hibz1Id70cwErk9OD0H76
 94mS6ZDs7GJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWpd+gAKCRDRgEFAKaOo
 NqLgEAC/3dhQNTMQnlQmNt08DS3j/fed82XHbpKTh2pjrZ1NR6P03JfDllYH+v2iP8jgXkghSgu
 I+2JHy6CjUeydva4qBGzU7kYYU6T5PW7Bm47jrl2h3MU8yAhodoUUSgH/EwpqfBINbEdwxAmZl3
 ryQxElV760vWC6v60LChDbgXJoLPlzvuDviUmS41SdsNERHb7BVi9Ax1gkCqLP+oIFX5FfcjpzW
 5msNHCqcBVv/06Nodh7bIyijQaYrz2e87Ofq4RCGxy9O0zZtkObFQOxniXdxlAxmj896UKP/qGh
 YIyno8nAW0rRzt298ikmEiMZftysB9+7O7L3c8WvHz/PvMqObxqkjvjFHk023ZMSaGkCT2Yc557
 AxySThT6SWvOsEwAFnHVVr/wqKggvThZZmjsyO4LULm2xCvXZu7RVRLM6Sh3GMidljhT3d8PkdG
 XrHQMPt2K25ZXQ/fRqwJFIW5Pk+Lp3bTJMgWHgpfntpHkBarJLLk+JSiJsi1/7Q6xuedachCntP
 bW/+9Sg2fvg2lKqHLcY+hzJE4txSnt2/VTGmfS+wmmfCAi+frrQFe765aYQd1Z4qfhlGbukX1oj
 VSp0v9YGbxZcLA3kxsUAFZDUiWhmyayJS2pZnuaIg23UZjBczbZ9Ngw66xx8McpYIchoBBNZYrl
 nJYHFYvAm54UKAw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 15:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18799

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      bin/bitbake-setup: add descriptions for fragment choices
      default-registry: update fragments choices with descriptions

 bin/bitbake-setup                                  | 14 ++++++++-----
 .../configurations/oe-nodistro-master.conf.json    |  6 +++++-
 .../oe-nodistro-whinlatter.conf.json               |  6 +++++-
 .../configurations/poky-master.conf.json           | 14 +++++++++++--
 .../configurations/poky-whinlatter.conf.json       | 14 +++++++++++--
 .../bitbake-user-manual-environment-setup.rst      | 21 ++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json             | 23 +++++++++++++++++-----
 7 files changed, 80 insertions(+), 18 deletions(-)
---
base-commit: c16e7ba2088dcd119e93bad6cf22d9026ec1736b
change-id: 20260116-bitbake-setup-choose-builtin-fb199054cc25


