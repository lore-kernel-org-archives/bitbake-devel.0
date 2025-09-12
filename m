Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4ECA101F
	for <webhook@archiver.kernel.org>; Fri, 12 Sep 2025 15:02:56 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.19095.1757689373577400093
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Sep 2025 08:02:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=aXgplc3l;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1B1331A0DCD;
	Fri, 12 Sep 2025 15:02:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA72560638;
	Fri, 12 Sep 2025 15:02:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 499F2102F29EA;
	Fri, 12 Sep 2025 17:02:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757689371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jWSJWxKYdF4RpfPo6DWGmagDFaLSuF3Dis/rGSS99Yc=;
	b=aXgplc3lbtHai5d9UFYKQHzxzbsD32IGRGkrwqovMzo+rxbKLqELk+oA2YvsllemnM8p8h
	jtbQJuROU597vnUGXbD9UF3UN6WzH3dwBGreLHWYzaMQZok3ZpAfDhPR3IAVMpcMSLRm6y
	Rl30KWZk+Pg3bhOKITQL1qGGGkX12CtKIeOJK+6hSsRI20EWnOdYkJ3UNOdaW4RuV7pGdh
	fZPQFeLudcCVnbqonrWnp4gfS07dU6eamNetjgrQlCIp4pK7J+yeRLSdFoOTrbBNlv16NM
	BYXHqEKiMDIa2Td1Q8AgI3vyJjLqk1XHG6Wzydbg2iWNabm+i1xt1/ZUV73jTg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 17:02:46 +0200
Message-Id: <DCQWVNMF7OTP.2YR0N4S0VTCCE@bootlin.com>
To: <patrick.vogelaar.dev@mailbox.org>,
 <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs][PATCH] doc: enhance SRCREV_FORMAT description
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20250910145400.232143-1-patrick.vogelaar.dev@mailbox.org>
In-Reply-To: <20250910145400.232143-1-patrick.vogelaar.dev@mailbox.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Sep 2025 15:02:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18012

On Wed Sep 10, 2025 at 4:54 PM CEST, Patrick Vogelaar via lists.yoctoprojec=
t.org wrote:
> Adding documentation for having an empty first component for the
> SRCREV_FORMAT.
>
> Signed-off-by: Patrick Vogelaar <patrick.vogelaar.dev@mailbox.org>
> ---
>  .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 810f88689..07e754096 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1670,6 +1670,12 @@ overview of their function and contents.
>        ``AUTOINC`` placeholder is added and if needed. And, this placehol=
der
>        is placed at the start of the returned string.
> =20
> +      The :term:`SRCREV_FORMAT` can also take the form "_component2".
> +      This assumes that there is a component in the :term:`SRC_URI` that=
 does not
> +      have a name assigned. While this is not considered good practice, =
it can be
> +      usefull if a ``.bbappend`` file needs to extend the :term:`SRC_URI=
` with

s/usefull/useful/

> +      an additional repository.
> +
>     :term:`STAMP`
>        Specifies the base path used to create recipe stamp files. The pat=
h
>        to an actual stamp file is constructed by evaluating this string a=
nd

This is not a good practice, albeit useful. So what is the good practice, i=
n the
case where I _do_ want an additional git remote source to be fetched? Modif=
y
the original SRC_URI to include a name for the first component, and do=20

SRCREV_FORMAT =3D "component1_component2"

as usual?

This doesn't sound practical so I'm leaning towards your solution. But if t=
his
is something we should really never do, then I'm wondering if we should doc=
ument
it here=E2=80=A6

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


