Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S8pr0-0005fZ-BY
	for bitbake-devel@lists.openembedded.org;
	Sat, 17 Mar 2012 10:23:14 +0100
Received: by wibhj13 with SMTP id hj13so1631909wib.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Mar 2012 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=VmiO7XDWIkmGLVMyJraFIL7I7LAsh2UYFknF2US2JbQ=;
	b=kLTa40azsn1mILpPS1fhHrYxy7CELmQD1kN5b0dcdsth30i5gA7n9sSkTU+sVry7PE
	qquSAwCO2A4WO1uL3ablqngu9nL0LqX8z0PYkfZx1nklZPzsZnBzfHwrI2psMhODj8B3
	E6aJPj2BA5CSo2LmSw+zqAdgp/00C3kX9de3VjkkY7XJtlwXHt7vGs4q+UiQIzTFybKA
	a62TZRyIn5xGu9ZaGYAhgBmK0ye1DUht0i5MexIQ9wnJu72dxOKzVCVijr8pPHX2fymq
	+FxE9Xs4KaqUQLORRtBF+wrppkSTRyduMGmOQKmHwbgm1tecZnjMdr+ROZBwQKDv5RGO
	Ee1w==
Received: by 10.180.80.70 with SMTP id p6mr4961683wix.21.1331975665578;
	Sat, 17 Mar 2012 02:14:25 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id o2sm9741100wiv.11.2012.03.17.02.14.23
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sat, 17 Mar 2012 02:14:24 -0700 (PDT)
Date: Sat, 17 Mar 2012 10:14:22 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Message-ID: <20120317091422.GE3855@jama.jama.net>
References: <4F6373BE.3040209@mvista.com>
MIME-Version: 1.0
In-Reply-To: <4F6373BE.3040209@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Conflict between BBCLASSEXTEND and named recipes.
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
X-List-Received-Date: Sat, 17 Mar 2012 09:23:14 -0000
X-Groupsio-MsgNum: 1327
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 10:09:18AM -0700, Jeremy Puhlman wrote:
> There seems to be a bug with available providers when a recipe file
> provides the same name as an extended recipe. The extended version of
> the recipe does not seem to be available at all.
>=20
> Example:
>=20
> If zlib_1.2.6.bb exists in a layer, with BBCLASSEXTEND=3D"native
> zlib-nativesdk" defined, and zlib-native_1.2.5.bb exists, the version
> 1.2.6 of zlib-native is not selectable at all.
>=20
>=20
> bitbake -s | grep zlib
> zlib                                                :1.2.6-r0
> zlib-native                                         :1.2.5-r0
> zlib-nativesdk                                      :1.2.6-r0
>=20
> Even with PREFERRED_PROVIDER_zlib-naitve =3D 1.2.6 the results are the
> same. I have been poking around the parser, but really haven't made any
> progress, figured I would poke the list.

I though that setting PREFERRED_VERSION should be enough in this case.

notice that it's not PREFERRED_PROVIDER and you have "naitve"/"native"
typo there. Can you retest with correct form if you haven't already?

Cheers,
>=20
>=20
> --=20
> Jeremy Puhlman
> Montavista Software, LLC.
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9kVe4ACgkQN1Ujt2V2gBw/DgCeKo6/BoRMY79Vv3z6VwHmE22n
0G0AoI9r8iRwCDJAuxendTd4WgofxXbi
=Nw4L
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
