Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1RoHxK-0004oZ-0x
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 18:08:50 +0100
Received: by eekd41 with SMTP id d41so244471eek.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jan 2012 09:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=hB034kChRoyHMeRd8YQuuhhZPypNej5VArmTtAq/G3Y=;
	b=a2MtDSUlAjEZLhPY8npxHwdISEZzu4vSULSE3n1GQUWXzUu1BSVC2VrV/HivhCUFtW
	I+9OCnDF/PIIyxoNpZvlSB9PXOfzGmQLZVIUWfB3TIphZMx2lVtgdsEJy/ZXQomCo6Gr
	vRmq+m2llhinRSHglwcG351ZNnZDO2w0VBhvE=
Received: by 10.14.123.198 with SMTP id v46mr3603803eeh.79.1327078869003;
	Fri, 20 Jan 2012 09:01:09 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id r2sm13615678eef.7.2012.01.20.09.01.07
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 20 Jan 2012 09:01:07 -0800 (PST)
Date: Fri, 20 Jan 2012 18:01:06 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120120170106.GC3645@jama.jama.net>
References: <1326661433-26379-1-git-send-email-Martin.Jansa@gmail.com>
	<1326661433-26379-2-git-send-email-Martin.Jansa@gmail.com>
	<1327077887.4268.18.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1327077887.4268.18.camel@ted>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] prserv: fix import of sqlite3
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
X-List-Received-Date: Fri, 20 Jan 2012 17:08:50 -0000
X-Groupsio-MsgNum: 896
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline

--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2012 at 04:44:47PM +0000, Richard Purdie wrote:
> On Sun, 2012-01-15 at 22:03 +0100, Martin Jansa wrote:
> > * this is used in all other bitbake parts where sqlite3 is used, don't
> >   know why it wasn't used here, but it fails e.g. on Gentoo
> >   Traceback (most recent call last):
> >     File "bin/bitbake", line 39, in <module>
> >       from bb import cooker
> >     File "lib/bb/cooker.py", line 39, in <module>
> >       import prserv.serv
> >     File "lib/prserv/serv.py", line 4, in <module>
> >       import xmlrpclib,sqlite3
> >   ImportError: No module named sqlite3
> >=20
> > Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> > ---
> >  lib/prserv/serv.py |    7 ++++++-
> >  1 files changed, 6 insertions(+), 1 deletions(-)
>=20
> Merged to master along with 1/2.
>=20
> Why this is needed I'm not sure since I thought sqlite3 was included in
> python 2.6 onwards. Since you're running into it and it doesn't hurt
> anything I've merged it though.

In gentoo there is USE flag for sqlite support which is off by default,
so it's easy to get even newer python like 2.7 or 3* without sqlite
enabled by default and extra package dev-python/pysqlite providing
alternative.

I guess correct fix would be to change bitbake .ebuild to depend on
python with sqlite USE flag enabled, but as it was catched and fixed in
other places in bitbake code I've added it here too.

Cheers,

>=20
> Cheers,
>=20
> Richard
>=20

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk8ZndIACgkQN1Ujt2V2gBwN8ACfZBNjPWwRPElcUMCzDnuApL2p
zEIAn2MvCbshtfVeNClkDaeGgvn3/q7z
=tu7J
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
