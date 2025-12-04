Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25826D2068D
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 13:17:06 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43161.1764854221068745322
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 05:17:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=GeBL6SJ7;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5F492C1784C;
	Thu,  4 Dec 2025 13:16:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BED4F6068C;
	Thu,  4 Dec 2025 13:16:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F2621192257C;
	Thu,  4 Dec 2025 14:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764854218; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aDkbj372FVXO6zbmLAXQxSBEXJU9sDdyKub4PQXHxwg=;
	b=GeBL6SJ7zhQOL9F3hOECE+YDwqGU750XbnHsrPbdQUAmwZjLHpy0IT8C+cLnsXkRDetnoT
	Iapw5t04CduzzKrz9jXjyorlB0GGzVVvjJyf3wHJXNtL0cP3oslM42A7v1synSOOZII1yC
	9IUSbG4b76Im/5rMBbmNpSVySmXGYq0qSv1gAzUXPnNvexwDq+H4YgOfuaxgjI4Z+9Qvrq
	9U8wQRWCiX43TZrEZS6Yj26M5hRgEYXCs+9Ww/E7HiKEdBH3d+X0ZlefjEwmdqKxDSYytC
	o67aNIAjYo7kdJIrW1e/+fWWN+fzvfoDO9eceOrPIvMJ154GZ6JVIaQQ8smozA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 14:16:56 +0100
Message-Id: <DEPGLUKGZXSZ.1CSSAYH72Y1IB@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <quentin.schulz@cherry.de>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH] doc: extend classes and include/require
 documentation
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <docs@lists.yoctoproject.org>
References: <20250918-classes-order-v1-1-3b8b75e9cf10@bootlin.com>
 <d8437f3b-effb-4aef-973d-0f01edece738@cherry.de>
In-Reply-To: <d8437f3b-effb-4aef-973d-0f01edece738@cherry.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 13:17:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18541

Hi,

On Wed Dec 3, 2025 at 5:55 PM CET, Quentin Schulz via lists.yoctoproject.or=
g wrote:
[...]
> I think we should provide an example for include_all directive as well?=
=20
> After reading the code, I believe include_all does NOT search the local=
=20
> path first, it only searches paths in BBPATH so I think it's worth=20
> providing an example and maybe notes on how it differs from the other=20
> directives.
>
> What do you think?

That's a good point I forgot here, yes, we should explain it to be complete=
.
Can you send a patch of file a bug?

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


