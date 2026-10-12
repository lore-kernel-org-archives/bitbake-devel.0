Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7D8CA9EC5
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 13:08:13 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12864.1791810489459952278
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Oct 2026 06:08:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=i0mIDbe0;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 224091A1044
	for <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2026 13:08:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EA0EB601A6;
	Mon, 12 Oct 2026 13:08:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77CBC11D70CE8;
	Mon, 12 Oct 2026 15:08:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791810482; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c0aP+rXXDv2UsyWYnRnHqiFSIOgCBtWxdcTyY2KTCzE=;
	b=i0mIDbe0bgVDuvq5TDqQoqvb22pEqbaO9nofHaZmoy2EXNTZczpcUHYOIUtS4hCSd1NO8g
	KQKvtroCGXSbJxhlNJk2CpV3TRzZZVwACf+Z6yiHBbvFR6hOsK1C+c7by9p8Lm6Axq5hME
	YwEeu44oSK0jn+1qR/wt4pzBh3/C3mxgeJfCPqxw7NBs0SGvL1z0+VW68wCyHvUqf1wx9R
	SaVx1skBacCGa9Lk4K7MGTeHu9x/TqvEA14PodKKwVr/6Xd8sQSFGKPH9HWWv+BuuV2Uot
	Bfgt7EMgOWIUa1XeQvo8ulGFhItWLZ5xf7AQhJeEhsfrT4PkyJ6EY5KSiu/f8g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 12 Oct 2026 15:08:00 +0200
Message-Id: <DM2VSZ91PNOJ.YXQAWC84B6NR@bootlin.com>
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <yann.dirson@vates.tech>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] doc: document dependency tracking
 associated with addpylib
References: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech>
In-Reply-To: <1791793541.8631fc262581453bbf619ec5b2062170.1a12f37b16e00080d7@vates.tech>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Oct 2026 13:08:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20320

Hi,

On Mon Oct 12, 2026 at 10:25 AM CEST, Yann Dirson via lists.openembedded.or=
g wrote:
> Reported-by: Claude Opus 5.5
> Signed-off-by: Yann Dirson <yann.dirson@vates.tech>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 621aab253..eef1f9624 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -2264,6 +2264,14 @@ The specified <namespace> is imported automaticall=
y, and if the imported
>  module specifies an attribute named ``BBIMPORTS``, that list of
>  sub-modules is iterated and imported too.
> =20
> +Additionally, Bitbake will detect usage of functions from such a
> +library and include them in task hashes, so changes in those functions
> +trigger task rebuilds.  Note that only functions inside modules
> +declared using ``BBIMPORTS`` benefit from this dependency tracking,
> +any name defined directly in the specified namespace (e.g. in
> +`<namespace>/__init__.py`, or in a library hat would be defined as

s/hat/that/

> +`<namespace>.py`) would *not* benefit from this tracking.

Otherwise, this is clear to me. I did not know about this limitation/featur=
e,
and this is definitely important to document, thanks!

Antonin

