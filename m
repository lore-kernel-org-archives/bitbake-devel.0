Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC33E63F35
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 07:56:40 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15195.1771228599100246746
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Feb 2026 23:56:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=qHp8lAOz;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6B95D1A0F9F
	for <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 07:56:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 355F3606CF;
	Mon, 16 Feb 2026 07:56:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A766610369057;
	Mon, 16 Feb 2026 08:56:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771228595; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HPKKz0a9Lgf4GNRQp4ut+Uepe/4122y9lMwJhzMiUBQ=;
	b=qHp8lAOzm1rbU9n+suhD/7cWkGjKFjI1p4AZiNq295PQrkfktJPg+yav+96Pwj1cuoLLGG
	OgwFdI7cf067AB7R5oV0sXEXeubFXGZ+4eW8CNZR3RsPEy9x247i4Yr8d26Uqdr1rDKlcP
	2LoHiVvK4v3g0GZpXKFfn5U8HB6WZFxiMBxZGsOIfzrYgrLgqN7A6VshsJFErfZlBajo4S
	Qif5H4O99vP/mPmxQf+9l0HOp3/2qtDMGwkGt/gooSJD0SdUIFteh4n8N8O93PD2nHSaVA
	ZSMyuNjmgRF4YQHpBANpcIFe7rZQfc/I+wGElp4J/6j/5jdr5SqvUmhX451RfQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 08:56:34 +0100
Message-Id: <DGG84UYJBB6C.6SDW57KWFV03@bootlin.com>
To: <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch: Drop Bazaar/bzr fetcher
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260213155953.1751687-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20260213155953.1751687-1-richard.purdie@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 07:56:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19031

Hi,

On Fri Feb 13, 2026 at 4:59 PM CET, Richard Purdie via lists.openembedded.o=
rg wrote:
[...]
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 4b3b10d4662..c75f2c27b32 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst

The SRCREV definition also needs updating:

   :term:`SRCREV`
      The revision of the source code used to build the package. This
      variable applies only when using Subversion, Git, Mercurial and
      Bazaar.

Antonin

