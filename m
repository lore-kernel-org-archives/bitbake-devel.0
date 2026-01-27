Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9BFD2D8EF
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:29:08 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7454.1769509739509603020
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:28:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Hs3YQ3cR;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C8FD44E422CE;
	Tue, 27 Jan 2026 10:28:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A02B0606F5;
	Tue, 27 Jan 2026 10:28:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB1EC119A8686;
	Tue, 27 Jan 2026 11:28:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769509737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iv1sqYv2zBm/BZbNIk2y0kQJ9jkcvO8iuk+jChDShh8=;
	b=Hs3YQ3cRmSxDs+heBGO4LboLTTpUdN2GNWNQHqahBpVsLx/cvLWpN8L1YGIX2nUuWZXpYp
	n94wbqX2TO2Q0YIhNyPMg4LPn89kEwo2dLJeQ7dQLgyEfx+6JqSoXfustOoTS7t6orjWmO
	CCLQQFtmso0reerSKA7h/MV89tUSB0i6HwQ5TV1tgNwx7qX95+lNC1foyTKWpDZYA5rTPl
	kbxjIqXj9r+weGnWGekS0Aj8FNwYzs56J2Zw0PXarlZWNbSJhLYIRww4F7mzdwidH3pH62
	ZHmyiqCClASBjV0DCMKWC4O2vwYtXcprwOoygtQ9BwVajz+19tt9cSb3Y2sPKA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:28:56 +0100
Message-Id: <DFZAUMTS82AH.ZQEHCQSFT7EU@bootlin.com>
To: <daiane.angolini@foundries.io>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs][PATCH 4/5] doc: Add the term Variant
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-4-daiane.angolini@foundries.io>
In-Reply-To: <20260126222743.411405-4-daiane.angolini@foundries.io>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:29:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18879

Hi,

On Mon Jan 26, 2026 at 11:27 PM CET, Daiane Angolini via lists.yoctoproject=
.org wrote:
> It also add a description for the term based on the concept that a
> variant is a fragment or a set of fragments.
>
> Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> ---
>  .../bitbake-user-manual-environment-setup.rst          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index e316ead56..700e02216 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -212,6 +212,16 @@ The following components are involved to create the =
content of these directories
>        It is also a Git repository, that contains a history of the setup =
instance
>        and updates made to it via :ref:`ref-bbsetup-command-update`.
> =20
> +   :term:`Variant`
> +      A Variant is a fragment or a set of fragments grouped under a name=
 that

I think multiple variants could contains different set of layers too
(bb-layers). So it's not limited to fragments?
Also bb-env-passthrough-additions, etc.

> +      makes sense for a project. It is a nested configuration within a
> +      :term:`BitBake Setup Template`.
> +
> +      A :term:`BitBake Setup Template` can contain multiple variants. Us=
ers
> +      select among them during the :ref:`ref-bbsetup-command-init` comma=
nd to
> +      customize the :term:`Setup`. Variants enable scaling configuration=
s by
> +      sharing common parameters in a parent while differing in specific =
settings.
> +
>     :term:`Registry`
>        A configuration registry is a place where one or more :term:`BitBa=
ke
>        Setup Templates <BitBake Setup Template>` are stored.


Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


