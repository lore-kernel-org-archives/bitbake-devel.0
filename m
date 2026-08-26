Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BEEC61DBD
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 13:15:09 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12362.1787750102176137901
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Aug 2026 06:15:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=JLhUWkSi;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1585C1A1841
	for <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 13:15:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D6ADB604ED;
	Wed, 26 Aug 2026 13:14:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40B6A11C7818A;
	Wed, 26 Aug 2026 15:14:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787750099; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SXG9JCMaaHm07+CKNL41I94nmKosPGNS/WvVfJq6Bbk=;
	b=JLhUWkSiamZe/7K8L45JySfJGHrS86swUKvlzYmMUwNnJ+hjnokjntgiLczChADKUXMtGx
	KL1f6CNnr1kZ6JIAeR+oadPZDMhVnxEJwZpIcgUzcwAzPKLNuo1fPfbP5JbHsHgK3gwsvp
	tq4Xa3IoYNScJvQMkng5XQnF6jO1pCvGnJYuJgRy3BjiKZR4ozGBXkIlZqL5McKPIjaeMP
	A9AHDw6iBGdTfEMq5vE7wejD47ycC3gx84LFM8+iaGGAbHWECqTDqZh3viR1ar6uVRHwL7
	5R4BCQMMV+CbbqJ23F/3HCNTI8n7qG76e5yO5lPy6Vn/xZ/y4BCy8hD6sFgwdg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 15:14:57 +0200
Message-Id: <DKYWIOYEX0OL.2QJXYJ5C6KS3V@bootlin.com>
Cc: <bitbake-devel@lists.openembedded.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <twoerner@gmail.com>, <docs@lists.yoctoproject.org>
Subject: Re: [docs] [PATCH] doc: state the language of six Python blocks
 explicitly
X-Mailer: aerc 0.21.0-139-g69cc59f49d35
References: <20260826013113.2673355-1-twoerner@gmail.com>
In-Reply-To: <20260826013113.2673355-1-twoerner@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 13:15:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20056

On Wed Aug 26, 2026 at 3:31 AM CEST, Trevor Woerner via lists.yoctoproject.=
org wrote:
> Six blocks show BitBake datastore and library calls - d.getVar,
> d.getVarFlags, bb.fetch2.Fetch, bb.fatal - written in Python, and carry
> no language:
>
>   fetching.rst              "the code to execute the first part of this
>                             process", the fetcher instantiation and the
>                             two unpack calls
>   metadata.rst              the BB_ORIGENV datastore example and the
>                             getVarFlags/setVarFlags pair
>   library-functions.rst     the f-string example, introduced with
>                             "Python f-strings may also be used"
[...]

Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>

Thanks!
Antonin

