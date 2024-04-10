Return-Path: <simone.p.weiss@posteo.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAADCD128A
	for <webhook@archiver.kernel.org>; Wed, 10 Apr 2024 20:13:22 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by mx.groups.io with SMTP id smtpd.web11.319.1712779995547566398
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Apr 2024 13:13:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@posteo.com header.s=2017 header.b=TX2BccYP;
 spf=pass (domain: posteo.com, ip: 185.67.36.65, mailfrom: simone.p.weiss@posteo.com)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4767024002A
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Apr 2024 22:13:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.com; s=2017;
	t=1712779993; bh=SAjVHYOc/RT28yCGudv8FfxhNZHwZQh3Coowf01aBrU=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=TX2BccYPpeW0SHXuz8EUWuymJd/nv9snX5059+v1106nEbHZTRa4eVFrEi7qrmNMh
	 VR43zz7QeLIQlM8JuTzH7zaoOd9OH5Lm6uYyrg/wZIdZiJWbPTN+g1gGozigF1cMf2
	 +/lh7pTCkonjueH1IfK2/SrPgP7V4bya++ToDiBohD9vA87yixxWA5VNmy1os0Xouk
	 EM2yBySHlN/tX5mZkcRwWUwBK+m3uW6aNZ1ZJjphNBVI2GuWV+ph0Waw+0m1Gy9E5x
	 3dw0sb4cwaD6JG+fw3jZtSR60Bb2my2sACMSCr95tA9ZdfFunYoQGta1J1ElcIN+Hf
	 iboiaKKiC4mnw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VFDXl643mz6twF;
	Wed, 10 Apr 2024 22:13:11 +0200 (CEST)
Message-ID: <84ce665a8d36f4b74ae2fd1f99fc265765549b5e.camel@posteo.net>
Subject: Re: [bitbake-devel] [PATCH] bitbake-layers: add/remove option to
 not use tinfoil
From: Simone =?ISO-8859-1?Q?Wei=DF?= <simone.p.weiss@posteo.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Simone
 =?ISO-8859-1?Q?Wei=DF?= <simone.p.weiss@posteo.com>,
 bitbake-devel@lists.openembedded.org
Date: Wed, 10 Apr 2024 20:13:11 +0000
In-Reply-To: <402bbf30a0b90189286bb157271ab675d6e2e2d2.camel@posteo.net>
References: <20240330164640.7270-1-simone.p.weiss@posteo.com>
	 <9fa62770febe3e4cb8f8099d3cf9c65ca3c96886.camel@linuxfoundation.org>
	 <402bbf30a0b90189286bb157271ab675d6e2e2d2.camel@posteo.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Apr 2024 20:13:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16069

On Tue, 2024-04-02 at 20:51 +0000, Simone Wei=C3=9F wrote:
> On Tue, 2024-04-02 at 14:29 +0100, Richard Purdie wrote:
> > On Sat, 2024-03-30 at 16:46 +0000, Simone Wei=C3=9F wrote:
> > > From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
> > >=20
> > > Fixes [YOCTO #15417]
> > >=20
> > > When a layer adds a new dependency after it was added to a conf, it
> > > can not be
> > > removed w/o this dependency in the setup. Even the dependent layer
> > > can
> > > not be
> > > added, as the tinfoil setup will fail.
> > > Add an option to not perform the tinfoil at all, the use will be at
> > > own risk,
> > > i.e. the added layers might not parse properly afterwards.
> > > This is not merged into the force options as it even changes the
> > > loading of
> > > plugins from other layers and is hence even more invasive as force.
> >=20
> > Could you expand a bit more about this difference to the force option
> > please?
> >=20
> The force option skips the recipe parse verification, this means after
> all
> other setup is done the recipes are not parsed before whatever
> subcommand
> is executed.
>=20
> When a layer dependency is causing problems, this will not work.=C2=A0
> bitbake-
> layers first sets up tinfoil to find further plugins
> for itself via getVar(BBPATH). This would already be causing issues when
> -
> for example - a layer with dependency issues should be removed via
> bitbake-layers. As this restricts also which plugins can be found for
> bitbake-layers to those under the the topdir, I separated it from force.
>=20
> Best,
> Simone
>=20
>=20
Any further thoughts/opinions?

