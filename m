Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53ACCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 07:59:04 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9882.1762415938481841500
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 23:58:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=BXpAmheH;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 35921C0FA81;
	Thu,  6 Nov 2025 07:58:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D2736068C;
	Thu,  6 Nov 2025 07:58:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B55AB102F2506;
	Thu,  6 Nov 2025 08:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762415935; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fHXPjc6ZiWa+o7kML6s2tMOIkz8yWig5OLuk5JItb6A=;
	b=BXpAmheH4nCYgCGRhjlMlWXDGJNClStDoAlOJsOgm+s3xnIBkDqG99PEpLPJXTdYdYuLEG
	sGkK3CUpDLM4CoWCFPmCUIvOKcm0vEICaBh4IaZiq+8BPQPoscN49TD+9w7/Y1/DFhhp2M
	uK4RJm5NNxjQQJDL0Om66yezV/J3JcW48SShFnlcTVX55n/TNhs6ggA4Ste411HvFcUPX8
	az4oUbcg/2bvb6nmLhw9g1d0O6imsDu079ixWuL93a+3/tZyKEqZu+0Uy7LzWqbEeSZR9o
	ajomm4FUESHY37vF+NGVrvg88BlDmv41ioBq+zRjPV8PRzeu8Osq7H2bia9NaQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 08:58:53 +0100
Message-Id: <DE1GB2U0LTRC.11DTXWB7ZUB7T@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Yoann Congal" <yoann.congal@smile.fr>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [master-next][PATCH] bitbake-user-manual-environment-setup:
 Document "{THISDIR}" in bb-layers
Cc: "Yocto Docs ML" <docs@lists.yoctoproject.org>
References: <20251105232718.2801446-1-yoann.congal@smile.fr>
In-Reply-To: <20251105232718.2801446-1-yoann.congal@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 07:59:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18278

Hi,

On Thu Nov 6, 2025 at 12:27 AM CET, Yoann Congal wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
>
> A "bb-layers" element can either:
> * start with "{THISDIR}/meta-xxx", then "meta-xxx" is found relative to
>   the configuration file,
> * or not, the layer is found where bitbake-setup has cloned
>   the layer from the "sources" list (usually a layers/ directory)
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Cc: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  .../bitbake-user-manual-environment-setup.rst                  | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index ad8143711..d9b7492b9 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -593,6 +593,9 @@ These files are written in the JSON file format and a=
re stored in a
>        variables to include in :term:`BB_ENV_PASSTHROUGH_ADDITIONS`.
> =20
>     -  ``bb-layers`` (*optional*): Layers to add to the ``bblayers.conf``=
 file.
> +      If the path starts by ``{THISDIR}/``, it will be relative to the d=
irectory
> +      containing the configuration file. If not, it will be relative to =
the
> +      directory used by ``bitbake-setup`` to store the sources.
>        This cannot be used in conjunction with the ``oe-template`` option=
.
> =20
>     -  ``oe-template`` (*optional*, OpenEmbedded specific): OpenEmbedded =
template

I actually did write something about it yesterday (not sent yet). I extende=
d it
a bit more, namely to show the common use-case. Your patch helped me clarif=
y it
further, thanks. Let me know if making what follows part of my patch if ok =
to
you:

   -  ``bb-layers`` (*optional*): Layers to add to the ``bblayers.conf`` fi=
le
      (paths are relative to the ``layers/`` directory of a :term:`Setup`,
      unless ``{THISDIR}`` is used, see below).

      The ``bb-layers`` option cannot be used in conjunction with the
      ``oe-template`` option where the ``bblayers.conf`` files comes from t=
he
      template itself.

      Local layers (layers not part of the ``sources``) can be added to
      ``bb-layers`` by specifying their path with the ``{THISDIR}`` special
      keyword. For example::

         {
            ...
            "bb-layers": [
               "{THISDIR}/meta-myproject"
            ],
            ...
         }

      ``{THISDIR}`` translates to the parent directory of the current
      :term:`Generic Configuration` file.

      This useful for a project that holds a single :term:`generic
      configuration` file next to a local layer::

         =E2=94=9C=E2=94=80=E2=94=80 meta-myproject/
         =E2=94=94=E2=94=80=E2=94=80 myproject.conf.json

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


