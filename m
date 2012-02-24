Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1S12g0-0002jO-NG
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 22:27:40 +0100
Received: by eaal10 with SMTP id l10so1331822eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Feb 2012 13:19:17 -0800 (PST)
Received-SPF: pass (google.com: domain of martin.jansa@gmail.com designates
	10.14.32.205 as permitted sender) client-ip=10.14.32.205; 
Authentication-Results: mr.google.com;
	spf=pass (google.com: domain of martin.jansa@gmail.com
	designates 10.14.32.205 as permitted sender)
	smtp.mail=martin.jansa@gmail.com;
	dkim=pass header.i=martin.jansa@gmail.com
Received: from mr.google.com ([10.14.32.205])
	by 10.14.32.205 with SMTP id o53mr2475331eea.47.1330118357770 (num_hops
	= 1); Fri, 24 Feb 2012 13:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	bh=Ts3Ffm8SLT8lHelmlcQo8w+lRy+3M5s99wnQd+t7Btc=;
	b=bl11TSdTkJfkf1WZXJPeSuly6y38S3NrhTHFPSKRJ0dUvF5dBiTekKZ/4/ds/uGEzR
	tGQX3rslv0hvHau5WiU9PSM0gnhjSFYtoVjxFFDXWg99UcnqnTv6XkpEIXFp1Cmzfyhf
	nl8znFHK7ZKjYswgL2SypYhMnfzrqfpLRXZug=
Received: by 10.14.32.205 with SMTP id o53mr1844198eea.47.1330118357594;
	Fri, 24 Feb 2012 13:19:17 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id n52sm22601782eea.5.2012.02.24.13.19.16
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 24 Feb 2012 13:19:16 -0800 (PST)
Date: Fri, 24 Feb 2012 22:19:14 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20120224211914.GN3769@jama.jama.net>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: KeyError in siggen.py
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
X-List-Received-Date: Fri, 24 Feb 2012 21:27:40 -0000
X-Groupsio-MsgNum: 1033
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9HASspBA3mgrZm7c"
Content-Disposition: inline

--9HASspBA3mgrZm7c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Any idea what could cause this?

OE qemux86-64@ ~/oe-core $ bitbake -c configure -b /OE/oe-core/openembedded=
-core/meta/recipes-devtools/gcc/gcc-cross-initial_4.6.bb -f
WARNING: Buildfile specified, dependencies will not be handled. If this is =
not what you want, do not use -b / --buildfile.
ERROR: Command execution failed: Traceback (most recent call last):
  File "/usr/lib64/python2.7/site-packages/bb/command.py", line 87, in runA=
syncCommand
    commandmethod(self.cmds_async, self, options)
  File "/usr/lib64/python2.7/site-packages/bb/command.py", line 203, in bui=
ldFile
    command.cooker.buildFile(bfile, task)
  File "/usr/lib64/python2.7/site-packages/bb/cooker.py", line 1076, in bui=
ldFile
    bb.build.del_stamp('do_%s' % task, self.status, fn)
  File "/usr/lib64/python2.7/site-packages/bb/build.py", line 441, in del_s=
tamp
    stamp =3D stamp_internal(task, d, file_name)
  File "/usr/lib64/python2.7/site-packages/bb/build.py", line 411, in stamp=
_internal
    stamp =3D bb.parse.siggen.stampfile(stamp, file_name, taskname, extrain=
fo)
  File "/usr/lib64/python2.7/site-packages/bb/siggen.py", line 222, in stam=
pfile
    h =3D self.taskhash[k]
KeyError: '/OE/oe-core/openembedded-core/meta/recipes-devtools/gcc/gcc-cros=
s-initial_4.6.bb.do_configure'

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--9HASspBA3mgrZm7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9H/tIACgkQN1Ujt2V2gBxzDQCfYw98BaGcvDK/SnCkOXMOSoWu
oGYAn3g1j4H7eFAlc36wTkUdaUOIxTPw
=aLkq
-----END PGP SIGNATURE-----

--9HASspBA3mgrZm7c--
