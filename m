Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A03DE7BD85
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 10:02:51 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16718.1771236169062626426
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Feb 2026 02:02:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=vpPBQG50;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5A7F71A0F83
	for <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 10:02:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2861B606CF;
	Mon, 16 Feb 2026 10:02:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B2F81036907D;
	Mon, 16 Feb 2026 11:02:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771236166; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B6akxMK5FvNLsM2EDJ8GpR12iMYCMEdJrVmC0msdDaQ=;
	b=vpPBQG50yTGgsIoL2LmsHxLSPJjtp8WMFSrrzB+8fhfODZCYgC0XCfASScZ6yuFdpuumcf
	xhHFN02Ms0uppXda5HtXuHmtcL3AgIN3hHTx+iy1qAxARB9iDrlh5yNyDb+IP8P2XHYHnI
	VIFUnmIqMnk6n9vKVLLMHxcjF5dr7vf1545a5I3moCSR/D6PzvROZMtIRH6+RhWCkY9rc5
	+mcwgnYitezqnEyRZR9vFt/SBF4ZO4YcE6Mz8T6Bg62CmUK7l1dXqBK4Fqu0Vm4vWaAWh5
	aVEa1Kc5cZAYCDWVVekQ3SX60Ge3sBLfL39esUuK0OKoDvgGEFuMJ4R/ulCmLg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 11:02:45 +0100
Message-Id: <DGGATH7W9PBI.DPHYQZZ3CKAH@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH] fetch: Drop Bazaar/bzr fetcher
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <richard.purdie@linuxfoundation.org>,
 <bitbake-devel@lists.openembedded.org>
References: <20260213155953.1751687-1-richard.purdie@linuxfoundation.org>
 <DGG84UYJBB6C.6SDW57KWFV03@bootlin.com>
 <21b5becc8144a7fd22f6796907255281506dc210.camel@linuxfoundation.org>
In-Reply-To: <21b5becc8144a7fd22f6796907255281506dc210.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Feb 2026 10:02:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19034

Hi,

On Mon Feb 16, 2026 at 10:57 AM CET, Richard Purdie via lists.openembedded.=
org wrote:
> On Mon, 2026-02-16 at 08:56 +0100, Antonin Godard wrote:
>> Hi,
>>=20
>> On Fri Feb 13, 2026 at 4:59 PM CET, Richard Purdie via
>> lists.openembedded.org wrote:
>> [...]
>> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-
>> > variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-
>> > variables.rst
>> > index 4b3b10d4662..c75f2c27b32 100644
>> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
>>=20
>> The SRCREV definition also needs updating:
>>=20
>> =C2=A0=C2=A0 :term:`SRCREV`
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The revision of the source code used to b=
uild the package. This
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 variable applies only when using Subversi=
on, Git, Mercurial and
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Bazaar.
>
> Thanks, I've added a tweak to the patch to remove that. I have a
> feeling we might find a few more old references in one form or another
> over time...

I've quickly tried to grep for bzr/bazaar, and the other two fetchers you'v=
e
sent and couldn't find anymore. But yocto-docs will probably have some of t=
hose,
which I'll take care of.

Antonin

