Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43265FF8873
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 15:22:56 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1229.1777562570404384833
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2026 08:22:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=YseK2Qk1;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ABE01C5CD6D
	for <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 15:23:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D39560495;
	Thu, 30 Apr 2026 15:22:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32BAC11AC983B;
	Thu, 30 Apr 2026 17:22:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777562564; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l54tXiSmT1NKzknjHX1C1E3iw/w9MKxQo/AvsDoRaAA=;
	b=YseK2Qk1kZBvxqW/KmU2NUYQSUzdlw/5RkVwaNA38L54wjR8WjC3OsCwFeyPjBuYfPIr03
	HJQTGq+VFa5L/efByKW/PBnfUk4Crn/jt8c2+b/T9fccN4iIEQio5wQPqCyNoqyWtQrsjM
	5+uIwyi/QMQlLFti4/e8w+/nimL4N4Fv6Sdp2PD6Qw2AjWrMziKhXSKtNciDqZhtS0BDj9
	dG2ZQb+bDyF6D6ysaZnRjf1I/KTke8DYNuwD8QKKA/QXPHn1B53+uOVG5OkgfkjrkJmAeb
	z3D7tSUw5A5CtkWW0IXjgM4tj1j7jjOzwba/GTlBApHhqE94tiM1EWPlwg/HGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 17:22:42 +0200
Message-Id: <DI6LC7WABV84.285L0VIK1RR6G@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: add
 BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode
Cc: "Marcio Henriques" <marcio.henriques@ctw.bmwgroup.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <marciohenriques84@gmail.com>, <bitbake-devel@lists.openembedded.org>
References: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com>
 <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com>
In-Reply-To: <20260430123847.25046-2-marcio.henriques@ctw.bmwgroup.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 15:22:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19424

Hi,

On Thu Apr 30, 2026 at 2:38 PM CEST, Marcio Henriques via lists.openembedde=
d.org wrote:
[...]
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 8d8e8b8b..1def16e7 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -390,6 +390,25 @@ overview of their function and contents.
>           # This defaults to enabled if both BB_GIT_SHALLOW and
>           # BB_GENERATE_MIRROR_TARBALLS are enabled
>           BB_GENERATE_SHALLOW_TARBALLS ?=3D "1"
> +  =20

There are some whitespaces here you can remove.

> +      :term:`BB_GIT_SHALLOW_SKIP_FAST`
> +      When :term:`BB_GIT_SHALLOW` is enabled, BitBake will by default at=
tempt a
> +      fast initial shallow clone directly from the upstream repository, =
bypassing
> +      the creation of a local full clone in :term:`DL_DIR`. Setting this=
 variable
> +      to ``"1"`` disables that fast path so the fetcher always creates a=
nd
> +      maintains a local clone in :term:`DL_DIR`, allowing subsequent bui=
lds to
> +      fetch only the delta of changes rather than re-downloading the ful=
l shallow
> +      history.
> +
> +      This is useful in CI environments where shallow tarballs are treat=
ed as
> +      fallback artifacts and incremental network efficiency is preferred=
.
> +
> +      Example usage::
> +
> +         BB_GIT_SHALLOW ?=3D "1"
> +         BB_GIT_SHALLOW_SKIP_FAST ?=3D "1"
> +
> +      See also :term:`BB_GIT_SHALLOW` and :term:`BB_GIT_SHALLOW_DEPTH`.

This paragraph should be indented with 3 spaces below
:term:`BB_GIT_SHALLOW_SKIP_FAST`.

Antonin

