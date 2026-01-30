Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFF5E6BF11
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 14:15:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11338.1769782494850588102
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jan 2026 06:14:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=AiCpQKv0;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 72188C22F5F;
	Fri, 30 Jan 2026 14:14:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 084816075A;
	Fri, 30 Jan 2026 14:14:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E600B119A885C;
	Fri, 30 Jan 2026 15:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769782492; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=02v9P8FCd2Ra8glibBcid6Y8fV6nFf2rY9E/hznMQtc=;
	b=AiCpQKv0VDjFeLUdZZDkSQ4Nl0L6LgOs2q4IYvAJFrtp5jLUpPhS4cG9XopbLQb/jxcDvf
	/51ESGS3Fqg5Dgjc9n+OTo5xY/ja7GkUcOQwj1DypBCduhKuw/nyt2xTp0P6ZNLRpHkIFs
	ZWS1a0mLN6wtX/NPDGqTwDR6l6orJqxneOwr+2Bq9xSHecvhaXWXLm19wgzrEJL1NOVkVv
	xuKQqW5H9eu0uxn1h7HRAjLnSiksuPOIwpDTmjvPM6Ledq2zfzJIeUInmUH5LfSZ9PC3zs
	FQRGg3S9HU481Ha3/0XDhcvSNV1WkbyrojD/Witahq2FceYcLGnhKk7kXXxDBQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Jan 2026 15:14:50 +0100
Message-Id: <DG1ZJ8CYFUY1.1H1URV3JO5VDY@bootlin.com>
Subject: Re: [docs][PATCH v2 0/4] Change terminology
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <daiane.angolini@foundries.io>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-63-gbde0bca3c3bc
References: <20260127215303.512936-1-daiane.angolini@foundries.io>
In-Reply-To: <20260127215303.512936-1-daiane.angolini@foundries.io>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jan 2026 14:15:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18938

On Tue Jan 27, 2026 at 10:52 PM CET, Daiane Angolini via lists.yoctoproject=
.org wrote:
> The goal is to replace some terminology used in the documentation and ref=
lect
> that in the script output.
>
> Change in v1:
>   Generic Configuration  -> BitBake Setup Template
>   Specific Configuration -> BitBake Setup Instance
>   nested configurations  -> Variant
>      =20
> Change in v2:
>   Generic Configuration  -> Configuration Template
>   Specific Configuration -> Configuration Instance
>   (no change for variant or nested configuration)
>
> In addition to that, there are a fix in a leading text and "sources" is f=
ixed
> from **optional** to **required**.
>
> The commit adding the "Variant" term into glossary was removed.
>
> Daiane Angolini (4):
>   doc: change some terminology around bitbake-setup
>   bitbake-setup: Change the output to match the terminology in the docs
>   docs: Fix leading text for bitbake-setup init
>   docs: Fix sources as required
>
>  bin/bitbake-setup                             |  6 +-
>  .../configurations/poky-master.conf.json      |  2 +-
>  .../configurations/poky-whinlatter.conf.json  |  2 +-
>  .../bitbake-user-manual-environment-setup.rst | 97 ++++++++++---------
>  4 files changed, 54 insertions(+), 53 deletions(-)

For the series:

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


