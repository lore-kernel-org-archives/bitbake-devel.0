Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82566E6F084
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 10:59:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.98819.1766487554566392450
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Dec 2025 02:59:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Arli0E5E;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 76AE01A23A4;
	Tue, 23 Dec 2025 10:59:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4510460716;
	Tue, 23 Dec 2025 10:59:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE69010AB0A17;
	Tue, 23 Dec 2025 11:59:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766487551; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vK+vtM6eAeWuk7imbvBnQMZKv0I4Io0QkrSVeIgcLBQ=;
	b=Arli0E5E2x+Soglng1q7hj7akrk1K0C31REonQ98z8d/wf2KOWy2xYY/EwARFqgiH1oZLZ
	rbs/c+wOqD4Ce+C9hRCZohQ2oI4kl609lhO2yMDKMk6rmOP37j8u3hSH4f0SR4X9eWyygs
	tozCeaIWvSGXTyCY92MS/1hrBriuImuamcNV3Bctg6ErL6ARjDZinKFfa8gRTGnTt8wlt8
	18h6rs+RCNhnh3fpX+CzB5A/JDl1CpxG8lNoiz0ig7ZEJfAOsfSI9X5ALbTQZQFlTa3HdB
	Uh4aCcDPR8uitxk+L8RyLQ7pWxAoEsLIsw72MNvlVG6KvFLhJOAMbLdk6Ko+rg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Dec 2025 11:59:10 +0100
Message-Id: <DF5JKPLOIHB1.3B4RJC8E90CG@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v5 4/4] doc/bitbake-setup: document
 "uri" property
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <corentin.guillevic@smile.fr>, <bitbake-devel@lists.openembedded.org>
References: <20251223101757.1057188-1-corentin.guillevic@smile.fr>
 <20251223101757.1057188-4-corentin.guillevic@smile.fr>
In-Reply-To: <20251223101757.1057188-4-corentin.guillevic@smile.fr>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Dec 2025 10:59:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18647

Hi,

On Tue Dec 23, 2025 at 11:17 AM CET, Corentin Guillevic via lists.openembed=
ded.org wrote:
> The property 'uri' is a simplification of the property 'remotes'. It is
> used to provide only one URI.
>
> Signed-off-by: Corentin Guillevic <corentin.guillevic@smile.fr>
> ---
>  .../bitbake-user-manual-environment-setup.rst        | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index ec1bdeecd..b3588f27d 100644
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

Can you please port this deleted example under the description of the "remo=
tes"
property?

We still want to show how someone can configure this property. It would be =
nice
if you could showcase another remote name, so it highlights why this option
could be used instead of the simplified "uri" option.

Something like:

  "git-remote": {
      "remotes": {
          "origin": {
              "uri": "https://git.openembedded.org/bitbake"
          },
          "contrib": {
              "uri": "https://git.openembedded.org/bitbake-contrib"
          }
      },
  }

And then explain how one or the other can be used with bitbake-setup (I hav=
e no
clue).

This also makes the "remotes" option optional, so you need to update its
description.

> +                     "uri": "https://git.openembedded.org/bitbake",
>                       "branch": "master",
>                       "rev": "master"
>                   },
> @@ -716,6 +712,12 @@ They contain the following sections:
>        -  ``branch`` (**required**): the Git branch, used to check that t=
he
>           specified ``rev`` is indeed on that branch.
> =20
> +      -  ``uri`` (*optional*): a URI that follows the git URI syntax. Ca=
n replace the

s/Can/You can/

> +         ``remotes`` structure if only one URI is provided. Despite this=
, ``uri`` and
> +         ``remotes`` can still be used together.
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

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


