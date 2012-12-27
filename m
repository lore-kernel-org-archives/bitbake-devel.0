Received: from mail-da0-f44.google.com ([209.85.210.44])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1ToCxv-0008Si-9A
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Dec 2012 13:53:40 +0100
Received: by mail-da0-f44.google.com with SMTP id z20so4333241dae.17
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Dec 2012 04:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:cc:subject:message-id:references
	:mime-version:content-type:content-disposition:in-reply-to
	:user-agent; bh=Zdr2D+E4wtJX/f4oN7q1NFFGHPTlHnH58X1cCVZR7wQ=;
	b=AKtWeoitTPcyNHEnzsPwiKioyv4MsPjCobRvI0IqN/O1nv9tGs3Banu6+c/x+iiCWt
	QewqncCjkmEIiIQWhsgco718G6y19pD/3ol4QhAcm7rcpnNl+Lj/zdUDXF1Z1f8y/I0P
	MeqWThPSDV3is2idW1oTk19UROd26l4SSzG9P4Rkgmjspu1xMkfcpl18EJ7nLq8EI8U4
	1x+q8O5OHGzAsH9YhI5+8plBdIqEf1zsU2/h909ZQuE6EfsTKeyKKQXJYddzCE2cg5ej
	jfQxva1LbclX109g9bShOJEtRtWdAQ6Zy4QcMuUTe/jBTnyyW+lBLnO0CszPqKJBjT4H
	/Dxw==
X-Received: by 10.68.232.201 with SMTP id tq9mr94671372pbc.12.1356611924375;
	Thu, 27 Dec 2012 04:38:44 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id qn3sm15600272pbb.56.2012.12.27.04.38.41
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 27 Dec 2012 04:38:43 -0800 (PST)
Date: Thu, 27 Dec 2012 13:38:39 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Message-ID: <20121227123839.GC3777@jama>
References: <1356294176-12058-1-git-send-email-Martin.Jansa@gmail.com>
	<CABcZANmR7JKetymVnVD4TorB+DoMXPPN-sQ-BDsDegeWWwph5w@mail.gmail.com>
	<20121223204500.GO8988@jama.palm1.palmone.com>
	<CABcZANmLfGp7WZ2TK9whLq+mn-Sda2wy1E5nGLF5jEPREiFFtQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABcZANmLfGp7WZ2TK9whLq+mn-Sda2wy1E5nGLF5jEPREiFFtQ@mail.gmail.com>
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
X-List-Received-Date: Thu, 27 Dec 2012 12:53:40 -0000
X-Groupsio-MsgNum: 3065
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline

--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 23, 2012 at 04:48:30PM -0700, Chris Larson wrote:
> On Sun, Dec 23, 2012 at 1:45 PM, Martin Jansa <martin.jansa@gmail.com>wro=
te:
>=20
> > On Sun, Dec 23, 2012 at 01:36:42PM -0700, Chris Larson wrote:
> > > On Sun, Dec 23, 2012 at 1:22 PM, Martin Jansa <martin.jansa@gmail.com
> > >wrote:
> > >
> > > > * sometimes it's useful for distro/builder to set
> > EXCLUDE_FROM_WORLD_foo =3D
> > > > "1"
> > > >   to exclude recipes not supported by distro/builder in some include
> > file
> > > >
> > > > Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> > > >
> > >
> > > EXCLUDE_FROM_WORLD_pn-foo =3D "1"
> >
> > I've used what LOCALCOUNT is using, but I can change it to _pn-foo if
> > wanted.
>=20
>=20
> The point was, you shouldn't need to patch anything in at all. pn-${PN} is
> in OVERRIDES. The above line should work fine as is with no bitbake chang=
es.

Ah, right, thanks!

No idea why that didn't work when I've tried it before this patch, but
now it works fine.

Cheers,
--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlDcQU8ACgkQN1Ujt2V2gBzzWACcD4Qgz8JDJCPj7/KYJvzsQ9X4
pGIAnjCXKBE9H94rUYiW1/kKS2mBGUzm
=TF7q
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
