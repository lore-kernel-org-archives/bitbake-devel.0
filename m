Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1U3Yv0-0006sz-4x
	for bitbake-devel@lists.openembedded.org;
	Thu, 07 Feb 2013 22:22:38 +0100
Received: by mail-pa0-f44.google.com with SMTP id kp1so1674117pab.17
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2013 13:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:date:from:to:subject:message-id:mime-version
	:content-type:content-disposition:user-agent;
	bh=oxT3IWrC8xhm0vG5eURie+ZWyCvEXEjEalJo7iRQGhs=;
	b=Fm3Oy//UGd0uTxj0ReN1jL+rWgoaLmvz0dvglfTAMQmNZHb1SSE5VBu//OPm/+IOWP
	269t4YymY5+GvlZttqPVviQbcU6V6jSVdkWGv+93KgDMXPaXadQk8KQOAzGmwWue0HEj
	8J+fIkzEQw5H19/Q4ySQaZqMaf2yRTVjg54w0TN+yYbMkhPuHuaXrKX8q2EUwjDow6e1
	hd+qHopr7BjhR7ulXhz8y+knEkSmJXHzPlCfQCC6LE3n6FVazohxHwa6yIJmOK3kGPUS
	KlCe2WMkLmLuGghVkk5xYHgKvE3A94xfSZ7FJuFmpxUBiGvejHlNTY4gxG7TcV1qPHuK
	cNmQ==
X-Received: by 10.66.74.197 with SMTP id w5mr79524704pav.60.1360193439444;
	Wed, 06 Feb 2013 15:30:39 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id d1sm41068407pav.6.2013.02.06.15.30.37
	(version=TLSv1.2 cipher=RC4-SHA bits=128/128);
	Wed, 06 Feb 2013 15:30:38 -0800 (PST)
Date: Thu, 7 Feb 2013 00:30:31 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20130206233031.GG3271@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
Subject: bitbake cache broken today
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
X-List-Received-Date: Thu, 07 Feb 2013 21:24:42 -0000
X-Groupsio-MsgNum: 3231
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ITEy4z2kE7rjCDPK"
Content-Disposition: inline

--ITEy4z2kE7rjCDPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Very likely by this patch:
cooker/utils: Drop custom 'interactive' variables list and store environmen=
t in BB_ORIGENV instead
http://git.openembedded.org/bitbake/commit/?id=3D0a99563a4ea270594fd9a61da4=
6f9387fb79dc66

$ bitbake -p > test1.cache
$ bitbake -p > test2.cache

$ grep "^Parsing of" test*
test1.cache:Parsing of 773 .bb files complete (0 cached, 773 parsed). 1079 =
targets, 43 skipped, 0 masked, 0 errors.
test2.cache:Parsing of 773 .bb files complete (0 cached, 773 parsed). 1079 =
targets, 43 skipped, 0 masked, 0 errors.

--- test1.cache 2013-02-07 00:15:50.930868804 +0100
+++ test2.cache 2013-02-07 00:14:32.044865976 +0100
@@ -4804,7 +4804,7 @@
     else:
         oe.path.remove(stfile + ".*")
         oe.path.remove(stfile + "_setscene" + ".*")
-', 'PREFERRED_PROVIDER_virtual/arm-oe-linux-gnueabi-compilerlibs': 'gcc-ru=
ntime', 'BB_ORIGENV': <bb.data_smart.DataSmart object at 0x19d6150>, 'BUILD=
HISTORY_DIR_IMAGE': '${BUILDHISTORY_DIR}/images/${MACHINE_ARCH}/${TCLIBC}/$=
{IMAGE_BASENAME}', 'preferred_ml_updates': 'def preferred_ml_updates(d):
+', 'PREFERRED_PROVIDER_virtual/arm-oe-linux-gnueabi-compilerlibs': 'gcc-ru=
ntime', 'BB_ORIGENV': <bb.data_smart.DataSmart object at 0x35e9590>, 'BUILD=
HISTORY_DIR_IMAGE': '${BUILDHISTORY_DIR}/images/${MACHINE_ARCH}/${TCLIBC}/$=
{IMAGE_BASENAME}', 'preferred_ml_updates': 'def preferred_ml_updates(d):
     # If any PREFERRED_PROVIDER or PREFERRED_VERSIONS are set,
     # we need to mirror these variables in the multilib case;
     # likewise the PNBLACKLIST flags.




--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--ITEy4z2kE7rjCDPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlES55cACgkQN1Ujt2V2gBxK6ACfQwkaxl+vE/h9Fgou/JiibsDa
qd0An2+n+206+k3XpNWIDuS4M85/pfsq
=Qjrx
-----END PGP SIGNATURE-----

--ITEy4z2kE7rjCDPK--
