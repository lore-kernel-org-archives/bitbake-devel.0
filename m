Return-Path: <joe@deserted.net>
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com
	[209.85.219.46])
	by mail.openembedded.org (Postfix) with ESMTP id 5C9876EE45
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 14:07:15 +0000 (UTC)
Received: by mail-oa0-f46.google.com with SMTP id i7so11049196oag.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 01 Apr 2014 07:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent;
	bh=Gcv6X1twYmDlpA/dT9PzcwHVg3V5+FPi5ecmikacO+M=;
	b=XjB3lrvCGFWtmuS+96YQBd9JGp8lULhtbYPoEmL0P88ENdOQFRsa7Sshp0Yug5ucEd
	HJjw7K/15fJ0H4MA9RERPRE23Joo8NebsHPRsbuKtak436BtsimOeMzW+gm4zhya53/R
	+P1W1yRes85fCB0QOGIBZ/ORPrpfEZuUw9OXyacLWxgGz2QaFWjhdJ5h50CSdEjDWR8A
	iJVHUq+UNufl9buf2ORireoAu8bU7aL4Omi+aH3e3hUJxCptJuYAIBp/fVbnjsMllHky
	ILJIv84EwwIxcohkGyofHJdtYc46tVZiID5xjxGkGTS0OeMHWq3AzkwSmgFKcBfbMolQ
	k3gQ==
X-Gm-Message-State: ALoCoQnSTJM/oWlfJids9VgzdDOkFnEpbwT8dpG8Xhjm33TbHolmAi8dXTM+ytc7cEorhc43qvq/
X-Received: by 10.60.141.70 with SMTP id rm6mr22780951oeb.27.1396361236425;
	Tue, 01 Apr 2014 07:07:16 -0700 (PDT)
Received: from deserted.net (24-246-4-250.cable.teksavvy.com. [24.246.4.250])
	by mx.google.com with ESMTPSA id
	pr4sm75654450oeb.8.2014.04.01.07.07.14 for <multiple recipients>
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Tue, 01 Apr 2014 07:07:15 -0700 (PDT)
Date: Tue, 1 Apr 2014 10:07:12 -0400
From: Joe MacDonald <joe@deserted.net>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140401140710.GB16104@deserted.net>
References: <1396298667-17975-1-git-send-email-joe@deserted.net>
	<1396342711.14790.92.camel@ted>
	<20140401135024.GA16104@deserted.net>
	<1396360607.2910.22.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1396360607.2910.22.camel@ted>
X-URL: http://github.com/joeythesaint/joe-s-common-environment/tree/master
X-Configuration: git://github.com/joeythesaint/joe-s-common-environment.git
X-Editor: Vim-703 http://www.vim.org
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: parse: allow vars_from_file to consider inc files as recipes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 01 Apr 2014 14:07:18 -0000
X-Groupsio-MsgNum: 4613
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Re: [bitbake-devel] [PATCH] bitbake: parse: allow vars_from_file to consid=
er inc files as recipes] On 14.04.01 (Tue 14:56) Richard Purdie wrote:

> On Tue, 2014-04-01 at 09:50 -0400, Joe MacDonald wrote:
> > > On Mon, 2014-03-31 at 16:44 -0400, joe@deserted.net wrote:
>=20
> > I don't want to keep using meta-selinux as an example here, (since it
> > mostly ends up looking bad for meta-selinux, I suppose) but I can
> > actually see a case where -common would be organizationally desirable.
> > Or at least not ugly.  recipies-security/selinux has a collection of
> > core selinux recipes, each has their own patches directory which
> > potentially co-mingles patches for versioned and git-based recipes or
> > both.  Right now none of the recipes in there are doing the
> > <specific> -> <versioned> -> <common> include thing, but it's not a huge
> > stretch to imagine it being useful.
> >=20
> > In other cases that'd be done with a versioned directory name and a
> > files/ directory, but that would make things less clear, not more in
> > this scenario.  So having a <recipie>-common directory would be kind of
> > good.
>=20
> Well, you can do that, but you should name it as such in the variable,
> not abuse the PV variable like this! :)
>=20
> > > I'd therefore much rather figure out what is happening to cause the
> > > expansion of PV in the .inc file and see if we can't avoid that.
> > >=20
> > > Looking at the layer, the issue is:
> > >=20
> > > FILESEXTRAPATHS_prepend :=3D "${THISDIR}/refpolicy-${PV}:"
> > >=20
> > > and I'd suggest that line move to the .bb files in this case.
> >=20
> > That's what I'll do if you're not convinced on this patch, but when I
> > started down that path yesterday afternoon I got thinking about what I'd
> > laid out above and that I would be duplicating the exact same line in
> > three recipes right now (-mcs, -mls and -standard) and adding it to any
> > other new policies that get submitted.  That really is a common piece
> > shared among all the variants and it seemed like the right thing to do
> > was have it only in one place.
>=20
> I understand the concern there, you could do this with a "common" name
> in the variable instead of PV though.

Sure, but implementing that solution here amounts to having two
variables (well, one for now, but potentially adding a second one down
the road for functionality that would otherwise have been a beneficial
side effect of variable expansion) one of which contains ${PV}.  That
was actually the very first thing I did in tracking this back to the
source, but that really seemed like a wink and a nod and I frankly felt
kind of dumb for doing something that I could already get from ${PV}.

--=20
-Joe MacDonald.
:wq

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlM6yA4ACgkQwFvcllog0XwvFgCfdNMUjh4p7dq9lvUskHTwKOpn
2DYAn1GV6kLw7yTRKX90Rdc+OfRqbS1s
=KAFm
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
