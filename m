Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UTgzL-0006iT-Ho
	for bitbake-devel@lists.openembedded.org;
	Sun, 21 Apr 2013 01:14:37 +0200
Received: by mail-pd0-f175.google.com with SMTP id g10so2849203pdj.34
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 20 Apr 2013 15:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:subject:message-id:mime-version
	:content-type:content-disposition:user-agent;
	bh=WJF+hAEzs3whfV/sR8MCdJsjqHe+Wcklpdo/HDGXcd0=;
	b=r1Na88r5cKlwsnu/11BIkOWr6uefEvs2U5Pe/AiVPKqeuf8W8oYvrrh+Qpez6EEX03
	ZBoK2RHujOY1KsmSyvpZJIKElg2DzfDQNa0J5K5VkVNmc7Jo6j4NZwXzqXAfdZzfKPKs
	KVJdSotfZQ7WacoHrqY1MilutN26ni8IPpVYD2RBARHeN+weMm6kNnoPR/RMMv6/KZEr
	RRRsgJsGkflOoiR5xcgX634I2e12/m5HSLRBqWSm4OuznwVTNDdPK34LM2mzm5ZZXIhN
	SX/q7BAgBrSGBobTq0gpz2QvLB7yCoWFhfTYpcRpDYGLJWxo/tndhjlj/mkRN0o1lRF4
	CfZg==
X-Received: by 10.66.156.103 with SMTP id wd7mr10788566pab.8.1366498618036;
	Sat, 20 Apr 2013 15:56:58 -0700 (PDT)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id ya4sm18671386pbb.24.2013.04.20.15.56.55
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Sat, 20 Apr 2013 15:56:56 -0700 (PDT)
Date: Sun, 21 Apr 2013 00:56:59 +0200
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <20130420225659.GM2489@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: bash-completion
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
X-List-Received-Date: Sat, 20 Apr 2013 23:14:39 -0000
X-Groupsio-MsgNum: 3391
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Content-Disposition: inline

--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is old thread on oe-devel about it
http://lists.linuxtogo.org/pipermail/openembedded-devel/2007-December/00376=
4.html

Is there any reason why it wasn't added to contrib yet?

Would it be applied if I send git patch adding it and update commands to
include cleansstate and packagedata + new options like -S and maybe
more?

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFzHTsACgkQN1Ujt2V2gBwK+QCfXmcVtDS3pP7fo4D6pdcjjyhS
wVUAn1w2MF9ct+yIpmMm1z9Zpbb8xrht
=GHNe
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--
