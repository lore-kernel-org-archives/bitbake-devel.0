Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ED2C61DD3
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 08:26:43 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25197.1788164798573248945
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Aug 2026 01:26:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=bO+1KCSz;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B348A4E41464;
	Mon, 31 Aug 2026 08:26:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D539601E1;
	Mon, 31 Aug 2026 08:26:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FA3711C789DA;
	Mon, 31 Aug 2026 10:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788164792; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uPRfj09+gxlAdgXOYa8sUJU/7xRrzH/z7O1VdKqX+NM=;
	b=bO+1KCSz6UFz0anTJtHTrPcGLPAfCe1JmM4JVykJlFj3zghvj4Ou3qdxxqNfDWrBMRfIBd
	I6NcpFVRQtGrOmc2dly8683yN2kMkEBlN+7HXv2HCor2gBh0J/Oix8dHDlWY7qdnX7ERwL
	CN1REx5zeF60lsPIyLPVdXXaoTv4gZ1NjA3zomLVaixdxbBRD3I/cpgj6bLTUUReOONB4m
	DijX9WPlbPfn/a6y6cjeV1HwoT0TKBxEVxMR09DOeONlKNhfQ57iFe9p8Lv9r/Dx366CKX
	2B8d6mUb/uIhbMCeqxAcCvI8yjCkDdr1ujidvt2zAbaNCQvAuwCpOgDClng/5A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 10:26:30 +0200
Message-Id: <DL2ZIK7TQ8WL.W6B1D1LECK18@bootlin.com>
Subject: Re: [docs] [PATCH] doc: document the conventions used in the manual
Cc: <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <twoerner@gmail.com>, <docs@lists.yoctoproject.org>
References: <20260831031444.4070152-1-twoerner@gmail.com>
In-Reply-To: <20260831031444.4070152-1-twoerner@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 08:26:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20133

Hi,

On Mon Aug 31, 2026 at 5:14 AM CEST, Trevor Woerner via lists.yoctoproject.=
org wrote:
> The manual uses angle brackets for placeholders and a prompt to mark a
> command, and says so nowhere. A reader can only infer both.

This only adds the document at the bottom of the main page, which I don't t=
hink
is a proper place for it. We should either have a section dedicated to this=
, or
make this a separate document (similar to standards.md in yocto-docs).

I'm leaning towards a separate document (named "standards.md"?), because th=
ese
instructions are not related to Bitbake itself. This document should be eas=
ily
found though, so perhaps we should mention it in the main README, under the
Contributing section.

Thanks,
Antonin

