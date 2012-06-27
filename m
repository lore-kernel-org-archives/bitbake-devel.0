Received: from mail-bk0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1SjqFO-0000Av-MS; Wed, 27 Jun 2012 13:17:22 +0200
Received: by bkcjm2 with SMTP id jm2so744822bkc.6
	for <multiple recipients>; Wed, 27 Jun 2012 04:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=OnhYXcQ4FGGGBu8tdEUREbmK5N89ps/SdXv6a8Gb93Y=;
	b=WDXSxOEpfh7Aaz1icLlgkWOXrD3/mOYGsDVct17hW9sAOS8kC7qk3cWRZeMxbQN3aw
	ZTr1Pa9BS0KUHK8ayqBl4/i4zbcRzl4kKjQsFA+awlCJm4rTVGx7Njb8T4fxJWOdKUiQ
	gRAjR9PdRsJzsc0wB0HPyZTQZ8a6ihSQG5AM+JWrUx81PYXR9geE6n+2SADhAfjl45vv
	c2wC1bCH5j2pggq9KynNHiu/otavpq++X2FI9hLYqtL3JpLnCdni34yDqGobMtFfi5+h
	ldRgXKGcKq6uKMLFkWnTcYz8cIuGkup3rmbCU7sqUAokAMbzTdFfgfvPZFEnNX+z0hLO
	kEKw==
Received: by 10.204.154.140 with SMTP id o12mr6917562bkw.139.1340795189438;
	Wed, 27 Jun 2012 04:06:29 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id x23sm54424548bkw.12.2012.06.27.04.06.27
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 27 Jun 2012 04:06:28 -0700 (PDT)
Date: Wed, 27 Jun 2012 13:06:26 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120627110626.GA11927@jama.jama.net>
References: <1340289297.1640.122.camel@ted>
	<20120626173118.GB3169@jama.jama.net>
	<1340793253.23146.19.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1340793253.23146.19.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	openembedded-core@lists.openembedded.org
Subject: Re: (PRE)MIRRORS doesn't work with https?$:// anymore Was: [PATCH] fetch2: Add new mirror syntax to simplify mirror specifications
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 27 Jun 2012 11:17:22 -0000
X-Groupsio-MsgNum: 2382
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 11:34:13AM +0100, Richard Purdie wrote:
> On Tue, 2012-06-26 at 19:31 +0200, Martin Jansa wrote:
> > On Thu, Jun 21, 2012 at 03:34:57PM +0100, Richard Purdie wrote:
> > > When writing mirror specifications, the current regexp syntax can be =
awkward
> > > and hard to get it to do what you want. For example, extracting the '=
basename'
> > > of a repository:
> > >=20
> > > PREMIRRORS =3D "git://.*/([^/]+/)*([^/]*) git://somewhere.org/somedir=
/\\2;protocol=3Dfile"
> > >=20
> > > can now become:
> > >=20
> > > PREMIRRORS =3D "git://.*/.* git://somewhere.org/somedir/BASENAME;prot=
ocol=3Dfile"
> > >=20
> > > which is much clearer. A MIRRORNAME substitution is also added which =
contains
> > > an encoded form of both host and path. One of the problems with the e=
xisting
> > > regexp syntax is you couldn't access HOST information from PATH and v=
ice-versa
> > > which is an issue this patch also addresses.
> >=20
> > One of this fetch2 patches break https?:// in MIRRORS
> >=20
> > It's used e.g in openembedded-core/meta/classes/mirrors.bbclass:
> > https?$://.*/.* http://downloads.yoctoproject.org/mirror/sources/
> > https?$://.*/.* http://sources.openembedded.org/
> >=20
> > I've tested it with older bitbake in PREMIRRORS (to make log.do_fetch
> > log shorter) on libcap (which doesn't exist on upstream URL).
> >=20
> > PREMIRRORS_append () {
> > cvs://.*/.* http://build.shr-project.org/sources/
> > svn://.*/.* http://build.shr-project.org/sources/
> > git://.*/.* http://build.shr-project.org/sources/
> > hg://.*/.* http://build.shr-project.org/sources/
> > bzr://.*/.* http://build.shr-project.org/sources/
> > https?$://.*/.* http://build.shr-project.org/sources/
> > }
>=20
> This is almost certainly a result of:
>=20
> http://git.openembedded.org/bitbake/commit/?id=3D604df1b25cf114e083f52917=
df2df64e01279c25
>=20
> since I didn't believe anyone was using the regexp syntax in the base
> url type. The bug I wanted to fix was where if you did:
>=20
> https://.*/.* file:///some/path/
>=20
> which seems reasonable enough, it would access:
>=20
> files:///some/path/
>=20
> which is clearly not what anyone would want.
>=20
> I'm not sure what to do about fixing this...

oe-core mirrors.bbclass is using that..
http://git.openembedded.org/openembedded-core/tree/meta/classes/mirrors.bbc=
lass
so maybe someone should fix mirrors.bbclass if this is expected behavior
with new bitbake..

Cheers,

>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/q6TIACgkQN1Ujt2V2gByIjwCeJa84eH6wDN8o1QX5dl0MAW7/
P80AoISCaDS+z/CmPnawm9Q9rtnjoHKV
=d8ER
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
