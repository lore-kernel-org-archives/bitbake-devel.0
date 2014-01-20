Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f54.google.com (mail-ee0-f54.google.com [74.125.83.54])
	by mail.openembedded.org (Postfix) with ESMTP id 3C7FD6CB7C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 16:39:16 +0000 (UTC)
Received: by mail-ee0-f54.google.com with SMTP id e53so2841529eek.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 08:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=6ymy0oIXVItUrVLBubtYaZANs3ujajTy85ltq3Z2SjI=;
	b=uh9tG9XRYZTXFGnMd1KYgFTn8RKLFXWh1Wau6FyEBMCZybCHQZtPfRvlgcoEIUZuT+
	yWy0QVD32VqxG0M1xYY09yWA7r7HHu7ajh0WlI2Qvn144NzvkYW9MvTMunOgcrHoRneG
	W4pxcivemEjLqsl4RvqXhtgRlwzqy40kue+IkLiZrrJQNZ0a34Q/dwdeM33zvXA/v6+z
	yCbXPii3jm2N8ZBxkU/HdmlUHd7CaBzQ4dEqCdFB22xvJBxzWQ2XeNDoZJms/pq95AI0
	e/X0vHeGHAJbP99ORDaXl+eI2JlIkFv/amByL4JdFFtqjPPDAB5gP3iUeQ3PKNnpRjFi
	4l9w==
X-Received: by 10.14.177.200 with SMTP id d48mr18853277eem.8.1390235956711;
	Mon, 20 Jan 2014 08:39:16 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id d43sm4861399eeo.12.2014.01.20.08.39.12
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 Jan 2014 08:39:15 -0800 (PST)
Date: Mon, 20 Jan 2014 17:39:12 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140120163912.GH5565@jama>
References: <1390231311.874.37.camel@ted> <20140120155734.GI6520@axis.com>
	<20140120161805.GG5565@jama> <1390235296.874.39.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1390235296.874.39.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Mon, 20 Jan 2014 16:39:16 -0000
X-Groupsio-MsgNum: 4345
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FUFe+yI/t+r3nyH4"
Content-Disposition: inline

--FUFe+yI/t+r3nyH4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 04:28:16PM +0000, Richard Purdie wrote:
> On Mon, 2014-01-20 at 17:18 +0100, Martin Jansa wrote:
> > On Mon, Jan 20, 2014 at 04:57:34PM +0100, Olof Johansson wrote:
> > > On 14-01-20 16:21 +0100, Richard Purdie wrote:
> > > > When specifying tags, they're searched for unanchored so foo/bar co=
uld
> > > > match:
> > > >=20
> > > > refs/heads/abc/foo/bar
> > > > refs/heads/xyz/foo/bar
> > > > refs/heads/foo/bar
> > > >=20
> > > > This change anchors the expressions so they are based against heads
> > > > or tags (or any other base level tree that has been created).
> > >=20
> > > Afaict, ls-remote matches the wildcard character against any
> > > character, including /.
> > >=20
> > > $ git ls-remote gittest refs/*/foo/bar
> > > 69ab4bdbb5f3725ca594a2abdb636ee8fc25e1c4        refs/tags/abc/foo/bar
> > > c8647b027d88af180e90d842577518b73ef6a167        refs/tags/foo/bar
> > > 149c3c329515086af1ae4e24b12b17100ae16256        refs/tags/xyz/foo/bar
> >=20
> > Yes, I've seen the same behavior:
> >=20
> > http://lists.openembedded.org/pipermail/bitbake-devel/2013-August/00372=
4.html
> >=20
>=20
> Hmm, ok, we can explicitly do:
>=20
> git ls-remote xxx refs/heads/X refs/tags/X
>=20
> which should resolve this...

Looks better to me.

Or if we can be very strict we could use refs/heads/ only when there
isn't tag param and refs/tags/ when there is, which would prevent using
tag=3Ddead8928392 (as git revision not name of tag).

I don't know how many recipes are using tag=3D param like this, we do in
meta-webos, but I would rather fixed that before upgrading to next
release.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--FUFe+yI/t+r3nyH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLdUTAACgkQN1Ujt2V2gBydCQCfQzn+U3Axfn2CdCRd/GZkTIyo
HjkAnixT5ZY+en7bFm6AaRfqqkpkS+z4
=Obwc
-----END PGP SIGNATURE-----

--FUFe+yI/t+r3nyH4--
