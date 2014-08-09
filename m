Return-Path: <martin.jansa@gmail.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 6D13060809
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Aug 2014 09:48:59 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id l18so6518139wgh.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 09 Aug 2014 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:date:to:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	bh=GJ0Gu/01HahIFw2PnOVBSKJuYXfyt/rDMzgV3WL9OjI=;
	b=jx+MiqKImgikXkBJYG8Mpi2NO9hkBhkr4ZmAw4I775HVdJX7HwrtEtnsitQvOGY+PK
	uedx75beSomiSMLOAXemYSGnKyvJHjlFgY5isUYNd1o0JxpCcmreU8AQhdfvrves4oL0
	o/Bv9mPhLCG1Cu6F7wbE9uPG2mEuagiALbxlHPyeK4wFWIC17TU9rE8Z2kcafP1A2a66
	QCnDWlNjema8fSwZJ8P9Pm8s7D8eqNw6NhzEYplTfbQj6xogz86GrxqsUsJ8i2HKGYNB
	hvv1kNjx7gbFmtsDy1AGdgZmi+2fFtHuV0U1I/fseqyS04t0t/rEMNZ1WYhNzwJPLRlU
	VPKA==
X-Received: by 10.194.187.4 with SMTP id fo4mr37914023wjc.35.1407577740599;
	Sat, 09 Aug 2014 02:49:00 -0700 (PDT)
Received: from localhost (ip-89-176-104-3.net.upcbroadband.cz. [89.176.104.3])
	by mx.google.com with ESMTPSA id
	q2sm17136937wia.19.2014.08.09.02.48.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 09 Aug 2014 02:48:58 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
Date: Sat, 9 Aug 2014 11:49:32 +0200
To: bitbake-devel@lists.openembedded.org
Message-ID: <20140809094932.GL14848@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: Interesting typo with a bit confusing python exception
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
X-List-Received-Date: Sat, 09 Aug 2014 09:49:05 -0000
X-Groupsio-MsgNum: 4955
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5b5GkgGpaDOibuI"
Content-Disposition: inline

--r5b5GkgGpaDOibuI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Don't take this as bug report, the first ERROR message is right
and I should have noticed what's wrong sooner, but instead I was
checking "ps" for hanging zombie bitbake (which still happends
=66rom time to time).

Is there something we can do for average bitbake user to get clearer
message?

$ bitbake -c cleansstate tracker | bitbake -c build tracker | tee log.track=
er

ERROR: Only one copy of bitbake should be run against a build directory
Traceback (most recent call last):
  File "/OE/build/oe-core/bitbake/bin/bitbake", line 382, in <module>
    ret =3D main()
  File "/OE/build/oe-core/bitbake/bin/bitbake", line 370, in main
    return ui_module.main(server_connection.connection, server_connection.e=
vents, configParams)
  File "/OE/build/oe-core/bitbake/lib/bb/ui/knotty.py", line 396, in main
    parseprogress.update(event.current)
AttributeError: 'NoneType' object has no attribute 'update'

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--r5b5GkgGpaDOibuI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlPl7qwACgkQN1Ujt2V2gBxvkACeLc/LNRsTMHIMsxPeNJkTavrz
1moAniN/TpjPIPjXLriSkridfQlVMcki
=xmLO
-----END PGP SIGNATURE-----

--r5b5GkgGpaDOibuI--
