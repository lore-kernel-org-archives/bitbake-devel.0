Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94509D2E021
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 07:49:19 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.907.1764920955316254685
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 23:49:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=sMR7rnBJ;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1B97B4E41A52;
	Fri,  5 Dec 2025 07:49:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6F7F60731;
	Fri,  5 Dec 2025 07:49:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C94E310B60549;
	Fri,  5 Dec 2025 08:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764920952; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NdK5n0mu8SF5yZqnKvaqR6D1pmvX0juxEvDuXFLHfhw=;
	b=sMR7rnBJ4HHCLGAywkpK3wHsAn5tVdZ0vLRsMY0AHHcwpDUW/sF4jcNf4g2LB0dicLzq0J
	KEd6UsTZPqQD4uFB2dhLWT0sU4bdWHR1Uw9A+cDE5EfldP08WVzMsu3LDQraK1VCxFICM5
	j9omPgRUd11URTlKqD8F8W+kuCPMbrplqVHaAueik7Sccajx9Ocw1PWC2R5fG2SG+4JDd8
	dB6d5MUJpJ4Qi36fcrUMuDKnnhaNL5TcKR6fF5kRyfBsd729yhPZWAh9hSugPX1rljq1gC
	Cp4Vt7mJTM33ORQ6XQmkcadSw+CcPWCUvMq/MsfAV6+AQDepjiqOOjdKZJSPWw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Dec 2025 08:49:10 +0100
Message-Id: <DEQ49FICZ0QX.2FVRZ8Q3SVWZR@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v6] bitbake-user-manual: Documenting
 BB_CMDLINE
Cc: <michael.opdenacker@rootcommit.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <swami310@gmail.com>, <bitbake-devel@lists.openembedded.org>,
 <docs@lists.yoctoproject.org>
X-Mailer: aerc 0.21.0-30-g0177c1d31447
References: <20251204234240.7224-1-swami310@gmail.com>
In-Reply-To: <20251204234240.7224-1-swami310@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Dec 2025 07:49:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18546

On Fri Dec 5, 2025 at 12:42 AM CET, Swami via lists.openembedded.org wrote:
> Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
> Fixes [YOCTO #15746]
> Signed-off-by: Swaminathan K <swami310@gmail.com>
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..32860ec0c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>        Specifies if SSL certificates should be checked when fetching. The=
 default
>        value is ``1`` and certificates are not checked if the value is se=
t to ``0``.
> =20
> +   :term:`BB_CMDLINE`
> +      :term:`BB_CMDLINE` is an internal variable and is read-only. It ca=
ptures
> +      the exact command line used for the current invocation of BitBake.
> +
>     :term:`BB_HASH_CODEPARSER_VALS`
>        Specifies values for variables to use when populating the codepars=
er cache.
>        This can be used selectively to set dummy values for variables to =
avoid

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thank you!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


