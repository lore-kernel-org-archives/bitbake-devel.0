Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F156CD1284
	for <webhook@archiver.kernel.org>; Tue,  2 Apr 2024 21:29:44 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by mx.groups.io with SMTP id smtpd.web11.6988.1712091078591142481
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Apr 2024 13:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@posteo.net header.s=2017 header.b=EYgs68ai;
 spf=pass (domain: posteo.net, ip: 185.67.36.66, mailfrom: simone.weiss@posteo.net)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 967BE240101
	for <bitbake-devel@lists.openembedded.org>; Tue,  2 Apr 2024 22:51:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1712091076; bh=MO8wuiGWYfGOt5CuCjXy9pAcHKi9xI38ggyhDUIlpPE=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=EYgs68aiawXLIxGUOGbrGyCKrAzGv7fTpD1+vrw68ISLrGtLji9l5cv7ms11ZpoqW
	 vY7yjOduv/Vmmsnr7KdDm1UeiwoecGRlFXQ7uwpSvUdi1W5PnOPdnt+oAIPWwMg75e
	 Vdnw0o96KVFxxos/r7UXZWieQFEVEFtGemkgjrs/xRWYidylUY8Z+IWIQf+W51yqxJ
	 uNojuZB7XvEoXC+rzd4hEzB9MYuq2pXeWmVjz8WbLSqfeFRjUMzTK+cmEnk/jQhczj
	 tpM+ufaxBF4AYgNBaFGK6qKGfRd+2kzVV/1B2jqMoGccpDslQ9rPrwKJq3GxnUok9v
	 3K+RdtF/5Td2A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4V8KmM4wn5z6twS;
	Tue,  2 Apr 2024 22:51:15 +0200 (CEST)
Message-ID: <402bbf30a0b90189286bb157271ab675d6e2e2d2.camel@posteo.net>
Subject: Re: [bitbake-devel] [PATCH] bitbake-layers: add/remove option to not use tinfoil
From: =?UTF-8?B?U2ltb25lIFdlacOf?= <simone.weiss@posteo.net>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Simone
 =?ISO-8859-1?Q?Wei=DF?= <simone.p.weiss@posteo.com>,
 bitbake-devel@lists.openembedded.org
Date: Tue, 02 Apr 2024 20:51:15 +0000
In-Reply-To: <9fa62770febe3e4cb8f8099d3cf9c65ca3c96886.camel@linuxfoundation.org>
References: <20240330164640.7270-1-simone.p.weiss@posteo.com>
	 <9fa62770febe3e4cb8f8099d3cf9c65ca3c96886.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Apr 2024 21:29:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16041

On Tue, 2024-04-02 at 14:29 +0100, Richard Purdie wrote:
> On Sat, 2024-03-30 at 16:46 +0000, Simone Wei=C3=9F wrote:
> > From: Simone Wei=C3=9F <simone.p.weiss@posteo.com>
> >=20
> > Fixes [YOCTO #15417]
> >=20
> > When a layer adds a new dependency after it was added to a conf, it
> > can not be
> > removed w/o this dependency in the setup. Even the dependent layer can
> > not be
> > added, as the tinfoil setup will fail.
> > Add an option to not perform the tinfoil at all, the use will be at
> > own risk,
> > i.e. the added layers might not parse properly afterwards.
> > This is not merged into the force options as it even changes the
> > loading of
> > plugins from other layers and is hence even more invasive as force.
>=20
> Could you expand a bit more about this difference to the force option
> please?
>=20
The force option skips the recipe parse verification, this means after all
other setup is done the recipes are not parsed before whatever subcommand
is executed.

When a layer dependency is causing problems, this will not work.  bitbake-
layers first sets up tinfoil to find further plugins
for itself via getVar(BBPATH). This would already be causing issues when -
for example - a layer with dependency issues should be removed via
bitbake-layers. As this restricts also which plugins can be found for
bitbake-layers to those under the the topdir, I separated it from force.=
=20

Best,
Simone



