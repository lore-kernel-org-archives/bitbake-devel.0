Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C7EC88E74
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 08:37:35 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15273.1769416645432253329
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jan 2026 00:37:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=fNrA4gCK;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 59D671A2A4E
	for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 08:37:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 314ED60717;
	Mon, 26 Jan 2026 08:37:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8BB8119A8627;
	Mon, 26 Jan 2026 09:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769416642; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Rycx6qhy0s5SmBezaM+ajDHM23OMr/ct3YUSSXxRKM4=;
	b=fNrA4gCKTJlNG+gSHHri1t9RWCNP0H521g13jOkjszoMS98RJAMiURNHyn0PSv+kbWfBt5
	As8kzyw/3pAJxn0SRNDj93mIjncklckPZR0wn1+MSctJW26evqD8G0mlgs4gIzWSllkP13
	xHP18hLrD5AlpAMyvTtt9bOGVxpdQW8ngIpqG/3DQ+D32hUAeZsaIkp4g15pwI1ZwoTsdw
	zlZP2B1FT/0SxjypFkel1swye2h6PJs3cMtT+ymK2luVzmNBf8uxf61GxBLJOM+YHx4VRF
	yzp7k0bgJu05mOOWaS1sWP3lJtc8k1rziAlEk40Ve+fC/QpkKy79Yd3kkHJdXA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 09:37:21 +0100
Message-Id: <DFYDUNC8OHDG.32QQB3NWAR7PX@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH v6 4/4] doc/bitbake-setup: document
 "uri" property
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260123172422.3304682-1-corentin.guillevic@smile.fr>
 <20260123172422.3304682-4-corentin.guillevic@smile.fr>
In-Reply-To: <20260123172422.3304682-4-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jan 2026 08:37:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18868

Hi,

On Fri Jan 23, 2026 at 6:24 PM CET, Corentin Guillevic via lists.openembedd=
ed.org wrote:
> The property 'uri' is a simplification of the property 'remotes'. It is
> used to provide only one URI.
>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---
>  .../bitbake-user-manual-environment-setup.rst | 42 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 6 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 3b6a73fd8..d20ddcaea 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -673,11 +673,7 @@ They contain the following sections:
>           "sources": {
>               "bitbake": {
>                   "git-remote": {
> -                     "remotes": {
> -                         "origin": {
> -                             "uri": "https://git.openembedded.org/bitbak=
e"
> -                         }
> -                     },
> +                     "uri": "https://git.openembedded.org/bitbake",
>                       "branch": "master",
>                       "rev": "master"
>                   },
> @@ -714,10 +710,38 @@ They contain the following sections:
> =20
>        ``git-remote`` entries are specified with the following options:
> =20
> -      -  ``remotes`` (**required**): a dictionary of git remote names, e=
ach containing a ``uri`` property
> +      -  ``remotes`` (*optional*): a dictionary of git remote names, eac=
h containing a ``uri`` property
>           with a URI that follows the git URI syntax. See https://git-scm=
.com/docs/git-clone#_git_urls
>           and https://git-scm.com/docs/git-remote for more information.
> =20
> +         This structure is useful if you want to provide several remotes=
. Please
> +         note that each URI will be cloned, but only the the last treate=
d one
> +         will be used in the unpacked source.

Indeed, it doesn't have much purpose then at the moment I guess, but that's=
 what
it does! I guess the code should be adjusted to crate a repository with mul=
tiple
remotes, I think that's what someone would expect=E2=80=A6

Anyway it's not part of your series. Thanks for trying it out.

> +
> +         Example:
> +
> +         .. code-block:: json
> +            :force:
> +
> +            {
> +               "sources": {
> +                   "bitbake": {
> +                       "git-remote": {
> +                           "remotes": {
> +                               "origin": {
> +                                   "uri": "https://git.openembedded.org/=
bitbake"
> +                               },
> +                               "contrib": {
> +                                   "uri": "https://git.openembedded.org/=
bitbake-contrib"
> +                               }
> +                           },
> +                           "branch": "master",
> +                           "rev": "master"
> +                       },
> +                       "path": "bitbake"
> +                   }
> +               }
> +            }
>        -  ``rev`` (**required**): the revision to checkout. Can be the na=
me of the
>           branch to checkout on the latest revision of the specified ``br=
anch``.
> =20
> @@ -728,6 +752,12 @@ They contain the following sections:
>        -  ``branch`` (**required**): the Git branch, used to check that t=
he
>           specified ``rev`` is indeed on that branch.
> =20
> +      -  ``uri`` (*optional*): a URI that follows the git URI syntax. Yo=
u can replace
> +         the ``remotes`` structure if only one URI is provided. Despite =
this, ``uri``
> +         and ``remotes`` can still be used together.
> +
> +         See https://git-scm.com/docs/git-clone#_git_urls for more infor=
mation.
> +
>     -  ``local`` (*optional*): specifies a path on local disk that should=
 be symlinked
>        to under ``layers/``. This is useful for local development, where =
some layer
>        or other component used in a build is managed separately, but shou=
ld still be

This looks good to me, thanks

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


