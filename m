Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D00E909BA
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 14:41:07 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13556.1771339260783188634
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Feb 2026 06:41:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ZoEzS/UQ;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2C18AC1356F
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 14:41:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78265606D1;
	Tue, 17 Feb 2026 14:40:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FC83103689C0;
	Tue, 17 Feb 2026 15:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771339257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LZwD5iHwTzj+hbrkj5JFiRSUwGypyDoWzFQlCPfEuuU=;
	b=ZoEzS/UQfAldhTpLhBE120rA6nUrUIkry79OoGP/p4S515mA95ZX/KYOnW+PoyJKpaXETe
	whvXsonlrHA+hPq5LDI6CcG6xtZsrpsrcTefeWPDpklwPqiKSCMBeq0s4Klq7C/4CsNZon
	02TIaOrnrl4JSi7JSH6lh30bjPYVBscFif38wFi3Mmt6ybxJZfdXgB8EShbkAwUp6SC9EN
	OOjZZmQ6vNkEent9c0b9AwbSO3WamI8oN2q3tkpyltiDUYhT2p2aaL4YjRoNAUyeqt3wDw
	3vQ3tBvz9Bqe7CpykjkQucFDInGyXoPGkqlLxhW0gw2HuF+FuXTR+Unb8gsb9A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 15:40:55 +0100
Message-Id: <DGHBD066AVRO.1CJM3E6IW1GIK@bootlin.com>
To: <foss@0leil.net>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH v3 0/5] doc: bitbake-user-manual-ref-variables:
 clarify BBMASK examples
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>,
 <docs@lists.yoctoproject.org>, "Quentin Schulz" <quentin.schulz@cherry.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
X-Mailer: aerc 0.21.0-108-g19019ffa8554
References: <20260217-bbmask-slashes-v3-0-6a02cde9fdab@cherry.de>
In-Reply-To: <20260217-bbmask-slashes-v3-0-6a02cde9fdab@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 17 Feb 2026 14:41:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19056

For the series:

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

