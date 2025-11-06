Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A66CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 09:12:46 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10754.1762420362212524134
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 01:12:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=0lzjqGCl;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D835FC0FA83;
	Thu,  6 Nov 2025 09:12:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2F5B6068C;
	Thu,  6 Nov 2025 09:12:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 883D4102F2506;
	Thu,  6 Nov 2025 10:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762420359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=W3GNbvA3EjOANNHox28IES5w6JKu1c26/VUWEIpsn20=;
	b=0lzjqGCltnkL4bWWtfTjwPiuxEHxUBBPfkcOkBuHfl8W01Cb+G+dBOTzxdJitKRsXf9MOR
	bFdDFe6zLTo8l78qFm5HsY19qJYDm8Iyiw97KU6cL74Zf+MnRGbzQldE1Jp/FHkNvtM1Kw
	73SXqB+Wjrl57waBM/NOK/L1GKlYgQ2lqKBxJOAWV6xbxCPmA1O8wGkfJX/vshmxtyPckc
	FAYCOe1trYQSu7FeA8BCA2adjQrF2M4f2419a38rRTybtUfzuD8mvi4UOMB2IYAFZIIQR7
	v5VKggUz6E45+xKhp5N7xJ7d0tewgquuTuaWyHkfpJBuQDZ7dPJV1OLR7/46tw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Nov 2025 10:12:38 +0100
Message-Id: <DE1HVJAH8J7U.29XUESHFLVEGD@bootlin.com>
To: <alex.kanavin@gmail.com>
Subject: Re: [docs] [master-next][PATCH]
 bitbake-user-manual-environment-setup: Document "{THISDIR}" in bb-layers
Cc: "Yoann Congal" <yoann.congal@smile.fr>,
 <bitbake-devel@lists.openembedded.org>, "Yocto Docs ML"
 <docs@lists.yoctoproject.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
References: <20251105232718.2801446-1-yoann.congal@smile.fr>
 <DE1GB2U0LTRC.11DTXWB7ZUB7T@bootlin.com>
 <CANNYZj_KS5BKsGMiQkLSyCKtma_BYcqJ+W3_jw80SzR6D-80Pw@mail.gmail.com>
In-Reply-To: <CANNYZj_KS5BKsGMiQkLSyCKtma_BYcqJ+W3_jw80SzR6D-80Pw@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 09:12:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18281

Hi,

On Thu Nov 6, 2025 at 9:28 AM CET, Alexander Kanavin via lists.yoctoproject=
.org wrote:
> On Thu, 6 Nov 2025 at 08:59, Antonin Godard via lists.yoctoproject.org
> <antonin.godard=3Dbootlin.com@lists.yoctoproject.org> wrote:
>>       This useful for a project that holds a single :term:`generic
>>       configuration` file next to a local layer::
>>
>>          =E2=94=9C=E2=94=80=E2=94=80 meta-myproject/
>>          =E2=94=94=E2=94=80=E2=94=80 myproject.conf.json
>
> I thought the use case should be described along these lines:
>
> This is useful when (one or more) configuration files and (one or
> more) layers are hosted in the same git repository, which is cloned
> and managed independently from bitbake-setup workflows.

Rephrased, thanks. I'm about to send the v2.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


