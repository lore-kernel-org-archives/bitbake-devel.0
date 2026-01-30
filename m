Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A34AE6BF17
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 14:06:10 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11039.1769781965516315957
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jan 2026 06:06:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iQEnNxzc;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A32014E42352;
	Fri, 30 Jan 2026 14:06:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 613B56075A;
	Fri, 30 Jan 2026 14:06:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50CFA119A885C;
	Fri, 30 Jan 2026 15:06:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769781962; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WTq54cgUrkBl/XN4ybLoxtqb5IhQEzO8zXgd8j2ZeyE=;
	b=iQEnNxzcuvzgSobf39uWBHCZ24iwhuxqartSeR4KXhWCMff5XFlit2p1MZoBfqIlPMVZa7
	ecaGiEE5BKthIWK0pIcWj/KUeeMtQoeD3sOa1L+v8fThtEXWnheUoQzaY/fUP2TX4lVBo9
	LVbkvQ0x9fzQAXgpYRcFvletPDKX+u6XVbeJXxM/43cWiK3I1eMOaxTvdpin707y+fBPm/
	TmKih3SEfCu7Cuvdv7rHJFU1f1hEI/Xwt62R+ZoWvEkfjxq/bWF7ZNgR6LPIK8pClKP8Lo
	AnXseHK3oZ/RVA9ekoHRDCyDEVqBzdtdYPu7WzPHtaOicCf3mx9OfqhSHmh6Iw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Jan 2026 15:06:00 +0100
Message-Id: <DG1ZCGR9A4OJ.3918WSIWBKUDI@bootlin.com>
Subject: Re: [docs] [PATCH v2] doc: bitbake-user-manual-intro: improve
 bbappend file matching doc
Cc: <docs@lists.yoctoproject.org>, "Quentin Schulz"
 <quentin.schulz@cherry.de>, "Robert P. J. Day" <rpjday@crashcourse.ca>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Quentin Schulz" <foss@0leil.net>,
 <bitbake-devel@lists.openembedded.org>
References: <20260129-bbappend-matching-v2-1-4041afca3c82@cherry.de>
In-Reply-To: <20260129-bbappend-matching-v2-1-4041afca3c82@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jan 2026 14:06:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18937

Hi,

On Thu Jan 29, 2026 at 11:07 AM CET, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> The recipe name matching wasn't fully explained and were missing a few
> important corner cases such as recipes without a version, or using the %
> character outside of the version part of the filename for example.
>
> This adds the last missing bits to cover every append naming scenario
> that exist today.

Thanks, this was indeed missing!

> This was derived from lib/bb/cooker.py:get_file_appends().
>
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Changes in v2:
> - fixed typo for bbappend named bb,
> - added "a" before "``mesa.bb`` recipe",
> - Link to v1: https://patch.msgid.link/20260128-bbappend-matching-v1-1-29=
fef2d63489@cherry.de
> ---
>  .../bitbake-user-manual-intro.rst                  | 51 ++++++++++++++++=
+-----
>  1 file changed, 40 insertions(+), 11 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst b/doc/=
bitbake-user-manual/bitbake-user-manual-intro.rst
> index baad71304..69ad6037b 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.rst
> @@ -271,12 +271,9 @@ same root filename. The filenames can differ only in=
 the file type
>  suffix used (e.g. ``formfactor_0.0.bb`` and
>  ``formfactor_0.0.bbappend``).
> =20
> -Information in append files extends or overrides the information in the
> -underlying, similarly-named recipe files.
> -
>  When you name an append file, you can use the "``%``" wildcard character
> -to allow for matching recipe names. For example, suppose you have an
> -append file named as follows::
> +to allow for a less strict recipe name matching. For example, suppose yo=
u have
> +an append file named as follows::
> =20
>    busybox_1.21.%.bbappend
> =20
> @@ -290,12 +287,6 @@ the append file would match the following recipe nam=
es::
>    busybox_1.21.10.bb
>    busybox_1.21.11.bb
> =20
> -.. note::
> -
> -   The use of the " % " character is limited in that it only works direc=
tly in
> -   front of the .bbappend portion of the append file's name. You cannot =
use the
> -   wildcard character in any other location of the name.
> -
>  If the ``busybox`` recipe was updated to ``busybox_1.3.0.bb``, the
>  append name would not match. However, if you named the append file
>  ``busybox_1.%.bbappend``, then you would have a match.
> @@ -303,6 +294,44 @@ append name would not match. However, if you named t=
he append file
>  In the most general case, you could name the append file something as
>  simple as ``busybox_%.bbappend`` to be entirely version independent.
> =20

I would wrap from here...

> +The "``%``" character is a marker for BitBake, and everything after that=
 marker
> +will not be used for matching recipe names. That is, an append file name=
d::
> +
> +   busybox_1.%.11.bbappend
> +
> +will match recipes named::
> +
> +   busybox_1.0.11.bb
> +   busybox_1.2.bb
> +   busybox_1.3.48.bb
> +
> +Note that the "``%``" character is not specific to the version part of t=
he
> +recipe name. That is, an append file named::
> +
> +   linux-yocto%.bbappend
> +
> +will match recipes named::
> +
> +   linux-yocto.bb
> +   linux-yocto_6.18.bb
> +   linux-yocto-tiny_6.12.bb
> +   linux-yocto-rt_6.16.bb
> +
> +While it can be useful to append to similar recipes with slightly differ=
ent
> +names, it is highly discouraged to do so as recipes from other layers ma=
y be
> +named similarly enough that the append file would unwittingly match them=
.

...to there under a .. note:: block. First because it will make it separate=
 from
the first part of this section, and second because it will highlight that t=
his
is an in-depth explanation of this percent sign, not really a standard use.

I would however move what's below from here...

> +A recipe named without a version may only be appended by an append file =
named
> +exactly the same. That is, a recipe named::
> +
> +   mesa.bb
> +
> +can only be appended by an append file named::
> +
> +   mesa.bbappend
> +
> +That is, ``mesa_%.bbappend`` append file will not match a ``mesa.bb`` re=
cipe.
> +

...to there _above_ the ..note block as this is a pretty standard bbappend
use-case.

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


