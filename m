Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8955DCCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 13:10:15 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web11.8923.1761138611021772432
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 06:10:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=R9EElwFs;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 616C6C0AFCD
	for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 13:09:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0BF15606DC;
	Wed, 22 Oct 2025 13:10:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21849102F2436;
	Wed, 22 Oct 2025 15:10:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761138608; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9N6ZPaFl6k1G0IysKdgy0VBsQaKFK4bUhBCA47/Xpp8=;
	b=R9EElwFsrdBPzO+GjEp4DWYDvu0WpX6EBrh0dEYzohtpcZJgwOgIjm+vdyjSsTE/d5PSGw
	N7KI2EULE2XcQko9zEQJRB/qIYsriyDibQ/+MCR3wEvhAoHrL5y3iUmaX3A3aXtLyuIpsX
	1hPOyYZUxyGMGn8Epy9RGMEmFtz6kK1UJWDE76MQa1spLb4JCVEKP+aSO+IoJRAZ03CJIG
	gfj0csa32K2Ff9Ks9v6RkdX0xlLGZY/pye6K5DM0z2eUgD6XxfeYc+5IUIM2zOq3R2gjG9
	AbGZI5zROiFnpybm4PFXmzUjbETxQ6NyCafBQmVtkJY337GIVnytlYZ3KSSIIA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 15:10:05 +0200
Message-Id: <DDOVJ68IEKN3.2JSTGRVGLOMZF@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <adam.blank.g@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 3/3] doc: bitbake-user-manual: style and
 completeness corrections
References: <20251021182834.11403-1-adam.blank.g@gmail.com>
 <20251021182834.11403-4-adam.blank.g@gmail.com>
In-Reply-To: <20251021182834.11403-4-adam.blank.g@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 13:10:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18208

On Tue Oct 21, 2025 at 8:28 PM CEST, Adam Blank via lists.openembedded.org =
wrote:
[...]
>  Following are options for the :term:`SRC_URI` statement:
> =20
> --  *vob*: The name, which must include the prepending "/" character,
> +-  *"vob":*: The name, which must include the prepending "/" character,

Extra ":" added here.

>     of the ClearCase VOB. This option is required.
> =20
> --  *module*: The module, which must include the prepending "/"
> +-  *"module":*: The module, which must include the prepending "/"

Extra ":" added here.

Otherwise looks good to me, thanks.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


