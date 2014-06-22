Return-Path: <martin.jansa@gmail.com>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
	[74.125.82.176])
	by mail.openembedded.org (Postfix) with ESMTP id 6295C6FC0F
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Jun 2014 13:25:25 +0000 (UTC)
Received: by mail-we0-f176.google.com with SMTP id u56so5561557wes.21
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Jun 2014 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=7xjzwgHHa8SZyx+PaSyVV+KnwA6YUjDMUtgGWQXxg78=;
	b=YXqMs9zGHN+ACluDPs216jN3PX7I8bMdr95DwKdmoPnzyP9uYR+DdsemkuK80T2xP0
	5PEtoktLVhFqtQ7tt0wxBWJvPUWjyLcGik9SuXoScY/Ycx6JUJ0JNb0iQmMXlW/cV2eC
	KnbGnltOl++Zv1JVpZIIpbyW97MwIcCbLr7k/a2WFoUQMTnm1KBa2LBImHNosJgitB1q
	SPeC5Ti+Y0WcSTmMuMtCopLQdA+5+UsWH6g/84WpYPLK7Vp10SMM+4S9ZBCVAcJy09H0
	3WEqW8Dt2oF8tJh85e7GLdbVuD2CAC+8Xy9uilsY2v9Zfd+kdCQLGHNmifgGtaezG1Zm
	pCWQ==
X-Received: by 10.194.78.141 with SMTP id b13mr10254680wjx.111.1403443525597; 
	Sun, 22 Jun 2014 06:25:25 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	ww4sm1582724wjc.4.2014.06.22.06.25.24 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 22 Jun 2014 06:25:24 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Sun, 22 Jun 2014 15:25:28 +0200
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-ID: <20140622132528.GH2117@jama>
References: <alpine.LFD.2.11.1406220832520.1583@localhost>
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.11.1406220832520.1583@localhost>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: can someone explain "git" versus "gitr" wrt PREFERRED_VERSION?
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
X-List-Received-Date: Sun, 22 Jun 2014 13:25:29 -0000
X-Groupsio-MsgNum: 4823
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1IYcr18XUmgwOrO2"
Content-Disposition: inline

--1IYcr18XUmgwOrO2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 22, 2014 at 08:52:08AM -0400, Robert P. J. Day wrote:
>=20
>   possibly a stupid question but i've never let that stop me before.
> still rummaging around in the bitbake user manual and looking through
> the oe and poky codebase, and i notice examples like this (from poky).
>=20
>   first, there's the recipe and PREFERRED_VERSION for drm:
>=20
> meta/recipes-graphics/drm/libdrm_git.bb:
>   SRCREV =3D "e01d68f9f3acfc35fe164283904b5d058c2ab378"
>   PV =3D "2.4.40+git${SRCPV}"
>=20
> meta-yocto/conf/distro/include/poky-floating-revisions.inc:
>   #PREFERRED_VERSION_libdrm ?=3D "2.4.0+git${SRCREV}"
>=20
>   also, the recipe and PFEFERRED_VERSION for libxcb:
>=20
> meta/recipes-graphics/xorg-lib/libxcb_git.bb:
>   SRCREV =3D "625ed596cae6dd8175aeb6cb6f26784928042f22"
>   PV =3D "1.1.90.1+gitr${SRCPV}"
>=20
> meta-yocto/conf/distro/include/poky-floating-revisions.inc:
>   #PREFERRED_VERSION_libxcb ?=3D "1.1.90.1+gitr${SRCREV}"
>=20
>=20
>   admittedly, the PREFERRED_VERSION settings for both of those are
> commented out, but why does the first use:
>=20
>   git${SRCREV}
>=20
> while the second uses:
>=20
>   gitr${SRCREV}
>=20
> so what's with "git" versus "gitr"? i see no mention of this in the
> bitbake user manual (would that be the right place to explain that?).
> or is that covered in one of the higher-level yocto manuals?

Read this thread:
http://lists.openembedded.org/pipermail/openembedded-core/2012-February/056=
558.html

>   also (and i realize this is outside the scope of the bitbake
> manual), i noticed the meta-oe layer adds another git-based version
> selector in the gitpkgv.bbclass. is *that* documented anywhere? i
> don't see a single mention of the phrase "gitpkgv" in any of the
> current yocto docs.

I think it's only documented in that .bbclass.

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--1IYcr18XUmgwOrO2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlOm2UgACgkQN1Ujt2V2gBw0lQCfVJF00sxVQv9yUlPcw0pfWZGv
gvIAoKlyc1cHQFS1RGYSberRgtmb5pA2
=UseD
-----END PGP SIGNATURE-----

--1IYcr18XUmgwOrO2--
