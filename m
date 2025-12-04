Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1957D20680
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 12:57:25 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42764.1764853038846815692
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Dec 2025 04:57:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=CH/4yuY0;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 72995C1784C;
	Thu,  4 Dec 2025 12:56:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C8E446068C;
	Thu,  4 Dec 2025 12:57:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E9C4A11922531;
	Thu,  4 Dec 2025 13:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764853036; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LptVDrsc5OFLxi5QM1u/9O02ZdJeKLWjExND0Cs/T7Q=;
	b=CH/4yuY04CK0Cn8zcWu9cOd4xvYH39b4aWPVCz+lo3jOH4QzxHHQE3ZU1Gh8n6cYqnq5Aa
	0nCXjm3U0d4aibmrZTLGg78L/79Uq9FkvPX8vO9GJDNg+UHQcowlepJX+VpGtonO4+KUPE
	GTsUCzkFuJYfsfPTBaDwp3QqTDOpiqYRnEXnbFt2rUOooWodZOQosgTECSVml2iCnaXBf8
	f/lwjZTs5WXQySwkf0znkx7dJCQlHo99UEAkj2dumvX/ZKLlIcoSsquGbxgx3Z9KRxQ4AW
	SP59necf3Hc9RKhojHNnzm0QxN8LCgNTe+QWt4V4HAjghytXIXo62jQFBOmKig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Dec 2025 13:57:14 +0100
Message-Id: <DEPG6R9444HV.37PEKFWSS5JCP@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v5] bitbake-user-manual: Documenting
 BB_CMDLINE
Cc: <bitbake-devel@lists.openembedded.org>, <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <swami310@gmail.com>, "Michael Opdenacker"
 <michael.opdenacker@rootcommit.com>
References: <20251204002531.7660-1-swami310@gmail.com>
 <af10c84c-1bda-42f4-ace0-74e7d3306cfb@rootcommit.com>
 <CA+-_CqnmcJ1txe-AuECK-sJ+N-+itruvAtQAkpNPQh4ckhPFFw@mail.gmail.com>
In-Reply-To: <CA+-_CqnmcJ1txe-AuECK-sJ+N-+itruvAtQAkpNPQh4ckhPFFw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 12:57:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18539

Hi Swani,

On Thu Dec 4, 2025 at 12:19 PM CET, Swami via lists.openembedded.org wrote:
> Thanks Michael,
> I will do the changes and submit a new patch.
> I picked up documentation assuming it would be easy :)
> Many thanks to you,Antonin, for bearing with my endless patches for such =
a
> small change.
> On the positive side, I am getting comfortable with the steps by this
> repetition.
> Unfortunately , that is adding to much back and forth
> Hope I can nail it with the next patch.

No problem, that's part of the learning process and once that's settled in,
you'll have less and less iterations on patches. :) We are happy to welcome=
 new
contributors.

I can also suggest b4 which does makes things a bit easier to manage patche=
s:
https://b4.docs.kernel.org/en/latest/

I can't make the modifications locally though, as I don't merge things on t=
he
bitbake (only yocto-docs). Please send a new version of the patch, that's f=
ine!

Thank you,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


