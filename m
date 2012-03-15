Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S7yHV-0000wM-Nm
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 01:11:01 +0100
Received: by wibhj13 with SMTP id hj13so3029504wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Mar 2012 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=cV/jjEFOo56aK3nrA6mmQUUtuwHBX8wXYrlM8N5PolI=;
	b=oumxgBj/1wwmgUL6Fjccs8dGXCEtuIGy3/tqMRUV0zvpsiclMBO5WO/NsD4Hz8fpA3
	kSBmdOiKu5hY5z+2giQ/GKZ1tRYW4Fc7u5i6D3/fhoPP4S58Ag/iYlErbGD/Tw/r1q22
	ZoqBC6wQ2IReKNQZvnFX0FoAyzFcWL6/ZJh0pgi/6OC5JZMYTxgE4xNx6Wd4OZP0Vke3
	2ghd1wgLzjLF7CBSCdrgwgzyM9V86BfeSukyU1G2X3DfbaWASjxVEhHEKlQaqWBKesoM
	teZiKlFIJivZojC8/Z7sX9O48XEAkRAdyesvCFlPh5rl1SG/47JpQTVQ4o9pKA42oFx/
	z5Dw==
Received: by 10.180.104.137 with SMTP id ge9mr10544616wib.20.1331769736020;
	Wed, 14 Mar 2012 17:02:16 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id w10sm795080wiy.3.2012.03.14.17.02.14
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 14 Mar 2012 17:02:15 -0700 (PDT)
Date: Thu, 15 Mar 2012 01:02:13 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Andreas Oberritter <obi@opendreambox.org>
Message-ID: <20120315000213.GA4973@jama.jama.net>
References: <4F610F03.1070201@opendreambox.org>
	<20120314225418.GB3823@jama.jama.net>
	<4F612F77.5040303@opendreambox.org>
MIME-Version: 1.0
In-Reply-To: <4F612F77.5040303@opendreambox.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: PREFERRED_VERSION and wildcards
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
X-List-Received-Date: Thu, 15 Mar 2012 00:11:01 -0000
X-Groupsio-MsgNum: 1273
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2012 at 12:53:27AM +0100, Andreas Oberritter wrote:
> On 14.03.2012 23:54, Martin Jansa wrote:
> > On Wed, Mar 14, 2012 at 10:34:59PM +0100, Andreas Oberritter wrote:
> >> Hi,
> >>
> >> I just tried using wildcards, like it's done for gcc, e.g.:
> >>
> >> PREFERRED_VERSION_foo =3D "1.2%"
> >>
> >> Now, if I have two foo recipes, foo_1.2.1.bb and foo_1.2.3.bb, in the
> >> same directory, then Bitbake always chooses 1.2.1 instead of the one
> >> with the higher version number. Does bitbake always choose the first
> >> matching version it can find? Is this a general limitation of wildcard=
s,
> >> or is this a problem that can get corrected? I'd expect it to choose t=
he
> >> highest matching version.
> >=20
> > If you want highest then why do you specify P_V at all? or are those
> > 1.2% foo with e.g. negative D_P? or is there 1.3 you don't want?
>=20
> Yes, I'd like to prefer 1.2.x over higher versions, say 1.3.x, which
> coexist in the same directory, i.e. prefer stable over development versio=
ns.

Ah, OK.
=20
> > It will use first provider which matches (in highest usable prio/D_P gr=
oup).
> >=20
> >     sortpkg_pn =3D sortPriorities(pn, dataCache, pkg_pn)
> >     # Find the highest priority provider with a PREFERRED_VERSION set
> >     (preferred_ver, preferred_file) =3D findPreferredProvider(pn, cfgDa=
ta, dataCache, sortpkg_pn, item)
> >     # Find the latest version of the highest priority provider
> >     (latest, latest_f) =3D findLatestProvider(pn, cfgData, dataCache, s=
ortpkg_pn[0])
> >=20
> >     if preferred_file is None:
> >         preferred_file =3D latest_f
> >         preferred_ver =3D latest
> >=20
> > It was added mostly to cover use case with e.g. 1.2+svnr1337 or 1.2+git=
rCAFEBABE where=20
> > you don't care about exact revision, but you know that you want 1.2 fro=
m scm (and there
> > is just one which matches).
>=20
> I see. I must admit that I don't really understand how the code quoted
> above works.
>=20
> > See this thread for details:
> > http://lists.linuxtogo.org/pipermail/bitbake-devel/2009-September/00045=
8.html
>=20
> OK, Now I understand the original intention, but its behaviour doesn't
> seem to be what you'd intuitively expect. Well, at least not what I'd
> expect. Would it be hard to extend the code to find the highest matching
> version instead of the first one? This wouldn't have negative effects on
> your use case.

Agreed, but if someone starts working on it, then we should discuss
first how to properly fix D_P across multiple layers, because I belive
that it's also in those 5 quoted lines.

Cheers,

>=20
> Regards,
> Andreas

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9hMYUACgkQN1Ujt2V2gByRcwCfV3pPCeC+N6mpfaug/+LP83QX
+NAAn2+3m3/QDCBxx589k72txgfqnxkE
=K2+y
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
