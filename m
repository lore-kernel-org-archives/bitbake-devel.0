Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by mail.openembedded.org (Postfix) with ESMTP id 4387D6C765
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 13:39:01 +0000 (UTC)
Received: by mail-ee0-f51.google.com with SMTP id b57so2254303eek.24
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2014 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=zMVVAi4TNSs+7Py4rQIyB9ZkaMVqEOsWxY8bSUKC3hI=;
	b=AEdwfrNBPCeXIhm/RK8gfHynlKcKXotSIaaW4/8GX3exjWpGUL1GrSs5CePV8DXG0G
	XtRguNtd3+64quS8dwBWZTT1xJuQhSMeHGz0x+m4sqJZddaBRCJWXI5mvs2jYOLahvLk
	H9KkpwWIp+nIEi1XmpFHz7lSDcY5++UFBAm3DJ6QDXxDD/+X0+ZTUzYJnGEGUC3O1E2N
	1BpJ+J0DYl7R4we0IeKlWipBKiSUB+M1IFYJ1UP4SOMKcaFkOg6j/RN1Hx9T9tzTv0ba
	00YdukpBuzK1RbR16rEfbPJIVWtKcI4sHPL27C/gpxZPuvtLM2aCjNntx3wEcaiHa6B8
	7GqQ==
X-Received: by 10.14.7.5 with SMTP id 5mr805544eeo.104.1390829941839;
	Mon, 27 Jan 2014 05:39:01 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id z46sm42622072een.1.2014.01.27.05.39.00
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 Jan 2014 05:39:00 -0800 (PST)
Date: Mon, 27 Jan 2014 14:39:06 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140127133906.GH3718@jama>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
	<CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
	<1388619481.11527.98.camel@ted> <1390343853.874.130.camel@ted>
	<1390829005.17424.238.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1390829005.17424.238.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Mon, 27 Jan 2014 13:39:01 -0000
X-Groupsio-MsgNum: 4371
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Content-Disposition: inline

--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 01:23:25PM +0000, Richard Purdie wrote:
> On Tue, 2014-01-21 at 22:37 +0000, Richard Purdie wrote:
> > I appreciate its taken me a while to loop back around on this but I do
> > now have an idea. What I'm proposing we do is add an optional parameter
> > to -S. Without any parameter it would behave as it did classically.
> >=20
> > With a parameter, it could trigger the current "debug sstate" behaviour
> > to stdout and it also allows it to trigger an sstate siggen specific
> > behaviour as appripriate. I have some prototype code with writes out a
> > "locked-sigs.inc" file for example, triggered from this same code block.
> >=20
> > I think this should let us do more creative things with sstate (even
> > from the OE siggen class) yet also let it remain useful for different
> > people.
>=20
> So we have a small potential issue here. We use python's optparse which
> doesn't allow optional arguments. This means we can make -S take options
> but the options must always be specified.
>=20
> It has good reason for this as its near impossible for optparse to tell
> the difference between:
>=20
> bitbake image -S tracesigs
> and
> bitbake image -S image2
>=20
> So our options are:
>=20
> a) Require a new parameter to -S always
> b) Hack it to use the option after -S as a parameter (meaning -S should
> always be last on the commandline). I do have a proof of concept but it
> makes me uneasy
> c) Add a new option with a different name
>=20
> In the interests of not doing something which binds us into a problem in
> future, I'm thinking -S should start to always take a parameter. The
> only issue is I'd like that parameter to be metadata (siggen) definable
> so we can't validate the option passed.
>=20
> Any opinions?

What about using some existing parameter in combination with -S?

-S + -v shows tracesigs
-S without -v old behavior

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLmYXoACgkQN1Ujt2V2gBzXzwCgrS4J3QgC7BdsTdmcKDuj4J+6
8C4An284RojvybU5NzxfchnPQPg8imVR
=/Vp7
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--
