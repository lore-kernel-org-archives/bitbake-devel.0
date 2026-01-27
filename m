Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C14D2D8F1
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:29:08 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7455.1769509743310882547
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 02:29:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=BaicFyWG;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CB2B81A2A6F
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:29:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9C695606F5;
	Tue, 27 Jan 2026 10:29:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 877CE119A8686;
	Tue, 27 Jan 2026 11:29:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769509741; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EeaY/DYCXyysnN9MOb3gQQUn9z0gOZwMr7W7qDZqutQ=;
	b=BaicFyWGx5YdTMWQpIAEgX6BSWd1ewARe85Fp4K5UCuE9fZ2j33Ni2h53GXDZQ1T67YWzV
	anx90U6TDAOACu6TZD28R8VlOp8TdT9S4J9r0hLVwPPKWzKD+d1outfA+7+1/Mf/U9RB5r
	Jl/E/kK/zaZP3hzdnf0K08RwLk9KUBfPpnixQMpWuxk5LjQxuxLdQiY/+h5xjUxRCoKOYQ
	hmpAT90NXhO0AZdp9ESy84sq1GCFS3laZF7FXjOKj86XQcEb/KSSMbAxzdQk7zwS250iVC
	VmTtPIQ0d1Xa8w2KK6rpY2rzPyIwJwztpDdzrVA4zN9WJgTkEjV56oiv300zbA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 11:29:00 +0100
Message-Id: <DFZAUOEWOS1H.14T46F1J7RX3A@bootlin.com>
Subject: Re: [docs][PATCH 3/5] docs: Fix leading text for bitbake-setup init
Cc: <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <daiane.angolini@foundries.io>, <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.21.0-63-gbde0bca3c3bc
References: <20260126222743.411405-1-daiane.angolini@foundries.io>
 <20260126222743.411405-3-daiane.angolini@foundries.io>
In-Reply-To: <20260126222743.411405-3-daiane.angolini@foundries.io>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 10:29:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18880

On Mon Jan 26, 2026 at 11:27 PM CET, Daiane Angolini via lists.yoctoproject=
.org wrote:
> If we use the default of bitbake-setut init we may not create anything
> (as the first default for an empty directory is N).
>
> If user does not chose a number, the script asks again for a number.
>
> Signed-off-by: Daiane Angolini <daiane.angolini@foundries.io>
> ---
>  .../bitbake-user-manual-environment-setup.rst                   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index 7bbe7cc75..e316ead56 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -50,7 +50,7 @@ Quick Start
>        See the :ref:`ref-bbsetup-section-config-reference` section to lea=
rn more
>        about ``bitbake-setup`` input configuration files.
> =20
> -#. With the default choices, the ``bitbake-setup init`` command creates =
the
> +#. One example of ``bitbake-setup init`` possible command creates the
>     following files and directories::
> =20
>        ./bitbake-builds/

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


