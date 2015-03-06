Return-Path: <martin.jansa@gmail.com>
Received: from mail-wg0-f54.google.com (mail-wg0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 54E8A6017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2015 13:29:11 +0000 (UTC)
Received: by wggx13 with SMTP id x13so12813137wgg.12
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Mar 2015 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=0jM2SdyBcSwL5decCToTOVnAvem1nuXrzVS9SIzHotQ=;
	b=RteB6ooTeg8JaqKyLwfF8PAXOkxk/hQBTRNn//CjpPVGDwpOif/rVTDOFIbF193ygV
	ZQv9agfNZRdFaku7q3zzU1MtVj3LkIGjqLYQ9Tq3E7X4uz1iHhg78afE2qKB/xmzjc9+
	Xkc3MXyVrZ8g0bioCVguI7hgfDWpT/d8jd8YTKIbZmMjgAbv7X9PVvzuMHR2MAjh+LP1
	xxKAAeoCXaLtaroOzWrYEwnwq6vMVn1w6j7P8AMjwRorVW4wB2h7th3uRviLCDI+E6+l
	g17XFr0zyBgXfd13ewdrx/3QsGIPa5dB0aQmW05LsjADHzyETf0jL9acvkiFOVVj/UTz
	nq1Q==
X-Received: by 10.180.77.233 with SMTP id v9mr77218163wiw.28.1425648552374;
	Fri, 06 Mar 2015 05:29:12 -0800 (PST)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	l9sm2254539wij.16.2015.03.06.05.29.11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 06 Mar 2015 05:29:11 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Fri, 6 Mar 2015 14:29:17 +0100
To: Clemens Lang <clemens.lang@bmw-carit.de>
Message-ID: <20150306132917.GG2337@jama>
References: <20150227120026.GA13973@ulm-bmuc496424.bmw-carit.de>
	<20150306114328.GN5023@ulm-bmuc496424.bmw-carit.de>
	<20150306122238.GF2337@jama>
	<20150306130320.GO5023@ulm-bmuc496424.bmw-carit.de>
MIME-Version: 1.0
In-Reply-To: <20150306130320.GO5023@ulm-bmuc496424.bmw-carit.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2: Revalidate checksums, YOCTO #5571
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
X-List-Received-Date: Fri, 06 Mar 2015 13:29:12 -0000
X-Groupsio-MsgNum: 5500
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0CboPPdgCg0mBjgS"
Content-Disposition: inline

--0CboPPdgCg0mBjgS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 02:03:20PM +0100, Clemens Lang wrote:
> Hi Martin,
>=20
> On Fri, Mar 06, 2015 at 01:22:38PM +0100, Martin Jansa wrote:
> > Using pickle is much better than counting the checksums on every
> > do_fetch.. we have GBs of sources and we don't want to spend extra
> > minutes on the build to re-check them if they are identical.
>=20
> That's what I thought as well. The pickle method should scale a lot
> better than re-running the hash calculation, especially in terms of I/O
> ops.
>=20
> > Maybe add the file time stamp as well, if the file was modified then
> > .done could be invalidated and checksums re-verified.
>=20
> I could modify the code to avoid reading the precomputed checksums if
> the .done file is older than the downloaded file, which should cover
> this case. Of course, the modification date will not be of much use if
> the download is not a file, but a directory.
>=20
> Does this sound good to you?

yes :)

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--0CboPPdgCg0mBjgS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlT5q60ACgkQN1Ujt2V2gBz0bQCfW866GKmTiPwu8YswvHCAVkva
75AAmwdfQvTHw/Bj4X7Bea+2uY21g4bp
=RI6A
-----END PGP SIGNATURE-----

--0CboPPdgCg0mBjgS--
