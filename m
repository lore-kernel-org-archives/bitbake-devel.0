Received: from mail-ea0-f176.google.com ([209.85.215.176])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TmseF-0004fw-MU
	for bitbake-devel@lists.openembedded.org;
	Sun, 23 Dec 2012 21:59:52 +0100
Received: by mail-ea0-f176.google.com with SMTP id d13so2721011eaa.21
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Dec 2012 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=/txwBgWo2WztAR/vVZYygaUDnHAhshn1LNcmbjC8xRM=;
	b=xuss2snHq+pc6qNxl3YJO+WhqSjXQYWKwhI0+TjKQXOTgwl2WAFDTsa95mgHSg+YLF
	GxOdII28zWg79h680ZUX8RREPyG0tlY7pD4w+arWOmwbbbGZzYKvnbroIg5zX0Nzzuri
	4y8+P/pq19aSyMlt7xzbse7pjM8+ytHcRqH7uqDHX0O8ZoD3HBHcYP5FFynVjwjaRwrQ
	1faZpwJm8mP+J4ifmYk1IAqD1of2mRUqR7j9IwKVZwpcBQTR/QoElxPuhLi+TYPIXXNe
	rlCJ/TVbn3zSm9L80VZ1mSQrnT8gvZuw0sdRJ8DmNALUAWr9xLzYH6tFSTD+mS0jjbq2
	yWcA==
X-Received: by 10.14.219.3 with SMTP id l3mr50168445eep.5.1356295502739;
	Sun, 23 Dec 2012 12:45:02 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id 43sm36982667eed.10.2012.12.23.12.45.01
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sun, 23 Dec 2012 12:45:02 -0800 (PST)
Date: Sun, 23 Dec 2012 21:45:00 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Message-ID: <20121223204500.GO8988@jama.palm1.palmone.com>
References: <1356294176-12058-1-git-send-email-Martin.Jansa@gmail.com>
	<CABcZANmR7JKetymVnVD4TorB+DoMXPPN-sQ-BDsDegeWWwph5w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZANmR7JKetymVnVD4TorB+DoMXPPN-sQ-BDsDegeWWwph5w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cache: allow to set EXCLUDE_FROM_WORLD outside recipe
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
X-List-Received-Date: Sun, 23 Dec 2012 20:59:52 -0000
X-Groupsio-MsgNum: 3061
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YC8Ek3FeOE8ywfXk"
Content-Disposition: inline

--YC8Ek3FeOE8ywfXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2012 at 01:36:42PM -0700, Chris Larson wrote:
> On Sun, Dec 23, 2012 at 1:22 PM, Martin Jansa <martin.jansa@gmail.com>wro=
te:
>=20
> > * sometimes it's useful for distro/builder to set EXCLUDE_FROM_WORLD_fo=
o =3D
> > "1"
> >   to exclude recipes not supported by distro/builder in some include fi=
le
> >
> > Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> >
>=20
> EXCLUDE_FROM_WORLD_pn-foo =3D "1"

I've used what LOCALCOUNT is using, but I can change it to _pn-foo if
wanted.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--YC8Ek3FeOE8ywfXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlDXbUwACgkQN1Ujt2V2gByoFQCgt52fqEMyQc5h1H+IFosl99OA
5AwAn0OqpuQSnWvFXIrGB+JNy0sTV5/6
=OmsR
-----END PGP SIGNATURE-----

--YC8Ek3FeOE8ywfXk--
