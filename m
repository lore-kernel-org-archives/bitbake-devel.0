Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6ECCAC5A5
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 07:12:37 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.web10.5464.1758784354846978986
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Sep 2025 00:12:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ZPDWnzxQ;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A8F4FC011DF;
	Thu, 25 Sep 2025 07:12:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6FF66062C;
	Thu, 25 Sep 2025 07:12:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EE75102F187B;
	Thu, 25 Sep 2025 09:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758784352; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=z6cpOtca3OuOnAkOhKHHfUO83rEHz0VdTeTUM9odfkQ=;
	b=ZPDWnzxQ9tcSs4iHXeAhzUUPtHc7F9Jxu1efG1eW9CyyIm2jdeOjEU1MvgfUj3v0Nvmukn
	leGhOaoeNuSz3qSwXXc5MoviR2DBtDMCYJ+pauv4iAsiYk8bATUHpigGQOfSgUZI8SJ8ew
	1MLS7j3Eus3LmxXbxYOEmYIoLnU5QFTq5fbPPuQFiD0NSwyn707G8Z7YT2bJCONaLjI4TE
	ksDAI+Lz41+oou0PfxdXityv58BFOo3mF/Paurvhqv+TkuPPbKlHrhlnShTd09545OioUf
	APyyL0aJv4Bly5b/P6XMnNYJQdze0Qk3l0EbT4BECwk7mpMY8a7er28pMpxZzQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 09:12:26 +0200
Message-Id: <DD1P0MENV808.21V0ZNWKO5149@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Alexander Kanavin" <alex.kanavin@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse/ast: avoid AttributeError when
 built-in fragment variable isn't defined
Cc: <bitbake-devel@lists.openembedded.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
References: <20250924-fix-no-builtin-fragment-v1-1-4d7f734b6d21@bootlin.com>
 <CANNYZj_MT-cC6xAy8nG=HdUJBa-NnwSOzaoGztDu4QaQLi=06g@mail.gmail.com>
In-Reply-To: <CANNYZj_MT-cC6xAy8nG=HdUJBa-NnwSOzaoGztDu4QaQLi=06g@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Sep 2025 07:12:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18091

On Wed Sep 24, 2025 at 4:22 PM CEST, Alexander Kanavin wrote:
> On Wed, 24 Sept 2025 at 15:48, Antonin Godard via
> lists.openembedded.org
> <antonin.godard=3Dbootlin.com@lists.openembedded.org> wrote:
>> -        builtin_fragments =3D {f[0]:f[1] for f in [f.split(':') for f i=
n data.getVar(self.builtin_fragments_variable).split()] }
>> +        builtin_fragments =3D {}
>> +        builtin_fragments_var =3D data.getVar(self.builtin_fragments_va=
riable)
>> +        if builtin_fragments_var is not None:
>> +            builtin_fragments =3D {f[0]:f[1] for f in [f.split(':') for=
 f in builtin_fragments_var.split()]}
>
> I'm not sure setting builtins to empty is the correct behavior.
> Perhaps an error should be raised instead?

I was thinking that there may be a case where you want to use addfragments
without specifying any built-in fragments. In this case you could either se=
t the
built-in fragment variable to an empty string, or not set it at all. The re=
sult
is the same with the above code: the dictionary will be empty.

> Also, do other items from addfragments need similar guards?

I don't think I have seen that behavior with "regular" fragments variables.=
 I
haven't tested it thoroughly though.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


