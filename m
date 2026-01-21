Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8361DC44501
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 10:02:00 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8462.1768989713454134458
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 02:01:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TSE8hUQM;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4BB374E421CB
	for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 10:01:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 131126070A;
	Wed, 21 Jan 2026 10:01:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8958C119B10F9;
	Wed, 21 Jan 2026 11:01:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768989710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uw7di3DQWopLRApv7x0p1CCPdqQWkr49i7T2ktqD5jo=;
	b=TSE8hUQM9qh26YTOYv6eOV5gw24vMeLjg9q6pONXOlJgjCoZsY08t3tb1KP5SL3Q2BFLBa
	4xhYFipsbKyyK+1QIn0BTVu8DHRVTSWSPo4kqQsHCGaDfIKOiroh7qDoIeR4tUXIp9WyvN
	Mcuae6GJmfvyyg+YTMKgqbjpRtqHqSH2BE0vnrfXH/gddXXRT03JI+WnHrj3do3QcNBml6
	ZwXxi7HFsuQlZlMc2UCM/2hYI63FZNOKQQ2zwwxbad0FB/WLsWGWaHJorOVz+Z4P6kEsxK
	2664fw48L7/701UJ4tEzpEa3CPoPuRuXFBiKe4IGRgYGFutAb3aV+w3khdSyYQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 11:01:48 +0100
Message-Id: <DFU6IL0O110G.ITYY9X55VEPV@bootlin.com>
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <rob.woolley@windriver.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
 <20260121024723.2634264-5-rob.woolley@windriver.com>
In-Reply-To: <20260121024723.2634264-5-rob.woolley@windriver.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 10:02:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18835

Hi,

On Wed Jan 21, 2026 at 3:47 AM CET, Rob Woolley via lists.openembedded.org =
wrote:
> This enables creating a pip package for PyPI with:
>
>     python3 -m build
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  pyproject.toml |  3 +++
>  setup.cfg      | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 pyproject.toml
>  create mode 100644 setup.cfg
>
> diff --git a/pyproject.toml b/pyproject.toml
> new file mode 100644
> index 00000000..4aff98bb
> --- /dev/null
> +++ b/pyproject.toml
> @@ -0,0 +1,3 @@
> +[build-system]
> +requires =3D ["setuptools>=3D61.0.0", "wheel"]
> +build-backend =3D "setuptools.build_meta"
> diff --git a/setup.cfg b/setup.cfg
> new file mode 100644
> index 00000000..3eaa3c49
> --- /dev/null
> +++ b/setup.cfg
> @@ -0,0 +1,40 @@
> +[metadata]
> +name =3D bitbake-setup
> +version =3D 2.16.0a1
> +author =3D OpenEmbedded BitBake Developers
> +author_email =3D bitbake-devel@lists.openembedded.org
> +description =3D bitbake-setup
> +long_description =3D file: README.md

I don't think we have a README.md file? Perhaps
doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst would be =
a
better candidate here?

> +long_description_content_type =3D text/markdown

This would be text/x-rst then.

> +url =3D https://github.com/openembedded/bitbake.git

It should probably be https://git.openembedded.org/bitbake/? The github ver=
sion
is supposed to be a mirror only I think.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


