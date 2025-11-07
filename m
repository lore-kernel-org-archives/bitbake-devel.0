Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7DCCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 11:16:59 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9041.1762514217307812788
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 03:16:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=zp1KoSxp;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 78CDC1A191B
	for <bitbake-devel@lists.openembedded.org>; Fri,  7 Nov 2025 11:16:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 48EA2606A6;
	Fri,  7 Nov 2025 11:16:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1560D1185236F;
	Fri,  7 Nov 2025 12:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762514214; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=EEr4BmdbfMiQ8giHXBdq8RZ1QdIMZzv2nP+e2lteh/w=;
	b=zp1KoSxpr+QLJ98W90dPCSr15wp/pq8C9jNXzF+uEam4ijFnHGOvlZKsRal3qt+egFKCk7
	/JErT0obXjzPNGU/aCa/V9JJkncBao44K1E03JjqBGdGf+v+MwRb+rmCtDhP0/41VTgJQm
	l+M5tfJwHkiezPYz6tSA9q5mPqYcjT6RzKnY1oTSBc2wSpraaNEffji6wOxXOtIf+ZBeKh
	SgXoNZD+0i2glRCFf7OYrDHo9tqzIVdTIHUonLDKzbgx5hxGxdx7Dfud4K4teXNsLP9FlZ
	vD8bC0mUWXMawXLGjZ2wG+horz2CmeIido2HLoAM5zC1276+QnL/4GJCVgjw3g==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v3 0/2] Add bitbake-setup documentation
Date: Fri, 07 Nov 2025 12:16:43 +0100
Message-Id: <20251107-bitbake-setup-v3-0-9aa227ade002@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzVDWkC/12NTQ6DIBgFr9KwLo1AFemq92i6APys9EcMIGljv
 HtBN63LSd7Mm5AHZ8Cj025CDqLxxvYJ2H6HdCf7G2DTJEa0oCUpGMHKBCUfgD2EccCgaiWFFNB
 wjZIzOGjNe+ldriv7Ud1BhxzJi874YN1nOYwk79Z2im/akeACV6yUXNdUyKM6K2vD0/QHbV8o1
 yP99autT5NPOaXQ8lJoVv778zx/AfODnt7+AAAA
X-Change-ID: 20251031-bitbake-setup-eb8ba9a9ed7c
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=GLfhhJzhhN4TfZjF/adSs9a0inZiUsKjstzpWTk6f6Q=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpDdUlkxSZy8hSI7JtaDAdmZCSsmXsgjBEpiTit
 dNeTbnk3LiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQ3VJQAKCRDRgEFAKaOo
 Nh6zEAC9FPUkyrTj3C+3SMCQx2z/tt+Z+6g617Ibvw3BpFUM5QIzlnV6aMeEIFWQ/iG+MEa4LxJ
 k7KDvy7Se96K9yTCe+StfLY4cYgcmdq05b4zXbY1NxHlRR4/EHAi3cNy/vbSj7jxG0joaSDBM5l
 y6566bOJ/Y8i0yh7ChoyLjwev6AZmo5jlS6qxxFOyTiURSq8eTVzG7BoiEgth1pHgL5OudZgXp7
 ioj5d416cOaJCvZrd3NVCyixGroFBISjuOoycNokjd4Q4rM1Z1yyQoinm7Jrmw2aM8U7sIdMrxb
 5aMdVj1K2ojGK3fsxcnMU3qZae8FxMjgL/XYUx0bLUCVp0IfjAf5mS4mwa+v2UCyfLGhM6UXRRU
 bfiUO/Sl92OEWVDsLLXyADkfxYBHlHWLfD0YXEGKVF4PZleYWKGOYsoYnF01H/TEJUhTAxNQdG9
 iddrRSLXqGrCMs0zBG98B22BIGQHWu2cNyOVgqppUes6JGxpVoL+O8JIJ6nj3+dFIoRcrx6uDrZ
 ROHGcm5v76iWk16pBg6MI5nHF6uVTieD8JE+AfDuwnhd7RPn6mrb7MBdlCr8/XQfiPpq9F6HuPR
 2lLIDnjuv7HSqskRjBE2fVSo92fxvh1V4ZP1wQsy4crJIshFs0eZhPdVhYbQmLE6jfSUnCPmSo9
 vzYXS8zUDy1FdsQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 11:16:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18307

Add the reference documentation for bitbake-setup, in a new
bitbake-user-manual-environment-setup.rst document.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v3:
- Suggestions and corrections from Alex (thanks!)
- I've added documentation for bb-layers-file-relative.
- I've updated the bitbake-setup init section and enumerated the
  different ways to pass a config to init.
  I've also added an example on how to pass a URL to the init command to
  fetch a configuration.
- Link to v2: https://lore.kernel.org/r/20251106-bitbake-setup-v2-0-2722ef759c35@bootlin.com

Changes in v2:
- Apply suggestions/corrections from Alex and Johannes (thanks!)
- Add missing 'expires' generic config.
- Add the doc for {THISDIR}
- Reorganize the terminology a bit. Start from the directories, unroll
  the terminology from there.
- Add definition for the Specific Configuration.
- Link to v1: https://lore.kernel.org/r/20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com

---
Antonin Godard (2):
      doc/conf.py: add wikipedia extlink
      Add bitbake-setup documentation

 .../bitbake-user-manual-environment-setup.rst      | 822 +++++++++++++++++++++
 doc/conf.py                                        |   1 +
 doc/index.rst                                      |   1 +
 3 files changed, 824 insertions(+)
---
base-commit: dcb17758b99767ab6da4172cf60eabc9269082dd
change-id: 20251031-bitbake-setup-eb8ba9a9ed7c

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


