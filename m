Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBFAD1266D
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 08:15:35 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10093.1764749719565041215
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 00:15:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=XMseaF3/;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 101D5C13572;
	Wed,  3 Dec 2025 08:14:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42C4D60706;
	Wed,  3 Dec 2025 08:15:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80D7B119201BD;
	Wed,  3 Dec 2025 09:15:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764749716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JH54zuq2sGOfE7Nn7Gh95rjnARR/Klw0VxpGiNtAuIY=;
	b=XMseaF3/z+aid8cFGn1QKVlj47vpnoWl1pyQpUwyE+JP3MXpJVj64o7f+eiHbvRSYQNF6H
	khjwUbOJqC0KrqzXuOk8TELlN7s/ohLyXfMsR7qjfk6Gwj4QlxfoAgXpK32lr46NRnjLQk
	69rsVEVUATnj+StPa51pogCqiaCdd6ys68RbviubA1MRKsS7NjBaaDvxJDOB93C5EU8iI1
	FmR8uYpUI5lvvdPpQ/T4we6Fz2ad6H2CrWgaQT/sUzTreHohE5FSc/KWvRQWd1Md04Gr3i
	3YoqayPLdb+C3lnl1Ef5TuLfLHc5ygwX8EgkeTyeczvcC4lrAzcK6aBvS5/ddw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Dec 2025 09:15:15 +0100
Message-Id: <DEOFKB1VZQVN.2HH4TFQI4TMSZ@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <swami310@gmail.com>, <bitbake-devel@lists.openembedded.org>,
 <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: Documenting
 BB_CMDLINE Add documentation for the internal read-only variable
 :term:'BB_CMDLINE'. Fixes [Yocto #15746] Signed-off-by: Swaminathan K
 <swami310@gmail.com>
Cc: <michael.opdenacker@rootcommit.com>
References: <20251203012343.15709-1-swami310@gmail.com>
In-Reply-To: <20251203012343.15709-1-swami310@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 08:15:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18518

Hi,

It looks like your commit message body went in the subject of your patch. P=
lease
resend with this fixed. Perhaps send it to yourself first before the mailin=
g
list, to make sure the formatting is correct.

Please put the bug ID in capital: [YOCTO #15746], as shown in the
contributor guide.

Please include that this is a v2 of the patch: read
https://docs.yoctoproject.org/contributor-guide/submit-changes.html#taking-=
patch-review-into-account.
So next will be v3.

On Wed Dec 3, 2025 at 2:23 AM CET, Swami via lists.openembedded.org wrote:
> ---
>  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 734c7858a..f756c436d 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -116,6 +116,10 @@ overview of their function and contents.
>        Specifies if SSL certificates should be checked when fetching. The=
 default
>        value is ``1`` and certificates are not checked if the value is se=
t to ``0``.
> =20
> +   :term:`BB_CMDLINE`
> +        :term:'BB_CMDLINE' is an internal variable and is read-only.It c=
aptures the exact

:term:`BB_CMDLINE` with backticks here, not :term:'BB_CMDLINE'. We compile
documentation with Sphinx and this is how Sphinx understands that this is a
cross-reference.

Also missing a space: "read-only.It" -> "read-only. It"

> +        command line used for the current invocation of BitBake.
> +     =20

Please remove spurious whitespaces here.

>     :term:`BB_HASH_CODEPARSER_VALS`
>        Specifies values for variables to use when populating the codepars=
er cache.
>        This can be used selectively to set dummy values for variables to =
avoid

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


