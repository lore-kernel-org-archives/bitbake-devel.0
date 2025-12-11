Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434FD41C00
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 07:48:51 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4211.1765439328290812514
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Dec 2025 23:48:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=Av5iIfsB;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id ACC95C19348;
	Thu, 11 Dec 2025 07:48:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A9AEB6068C;
	Thu, 11 Dec 2025 07:48:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCD15103C8C1E;
	Thu, 11 Dec 2025 08:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765439325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ADbyebdT/T6n+n8WYQitxGuCFegpJCndXIE4HlKCGZ0=;
	b=Av5iIfsBqw8IaWEurBvt8rlnqh+LRT3okQsCMscBAXbwbtYDxnmU4/RnXkLTpA8PBHGZeB
	HXR22BXHk/ZkrfnQ19aRxbXIiVsMnqoyzrSf0N0bMZmBEfBabkqf85PvMSKhrvelddm+ol
	WpkatSb9oH6sz9vqw9Z1iU+rx4C5l8J0aqjegjpwmVukcJ6XSnjT5LSFr3esFXz6mAeE9E
	Bf+aUic2jNN4iDY7TWCVrDBRnR6p7ItDHk92MnY3XFFKuuVnlAan/9HdaJ+foVw3SUUgU4
	1lcutldB7Qvyuqam5mwLyOa6t2QPR7+kTVw+0pY9c+qEqOIG9ycnv4xlg1jN2Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Dec 2025 08:48:42 +0100
Message-Id: <DEV80C51V5UL.SAJTRX0OMS4C@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH v7] bitbake-user-manual: Document
 BB_CMDLINE
Cc: <michael.opdenacker@rootcommit.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <swami310@gmail.com>, <bitbake-devel@lists.openembedded.org>,
 <docs@lists.yoctoproject.org>
References: <20251205234033.6363-1-swami310@gmail.com>
 <CA+-_CqnqT4roapfisF_6gt2P-OJ8gkw9GvRNEnWh9FQX6HU7Sw@mail.gmail.com>
In-Reply-To: <CA+-_CqnqT4roapfisF_6gt2P-OJ8gkw9GvRNEnWh9FQX6HU7Sw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Dec 2025 07:48:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18562

Hi,

On Thu Dec 11, 2025 at 6:15 AM CET, Swami via lists.openembedded.org wrote:
> Hi,
> I have not heard anything after I submitted Patch V7. Is it accepted ?
> How can I know the latest status ?
> Please help me understand.

There is no strict workflow regarding patch statuses on this list.

You can refresh the master-next and master branches of bitbake to know whet=
her it
is merged or not. A patch being on master-next means it is queued up for
testing. If your patch is rejected someone will let you know (but for yours=
 I
don't see any apparent reasons).

Cheers,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


