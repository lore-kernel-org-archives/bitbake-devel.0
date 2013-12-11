Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f53.google.com (mail-ee0-f53.google.com [74.125.83.53])
	by mail.openembedded.org (Postfix) with ESMTP id C408E6B88F;
	Wed, 11 Dec 2013 22:51:29 +0000 (UTC)
Received: by mail-ee0-f53.google.com with SMTP id b57so3208418eek.12
	for <multiple recipients>; Wed, 11 Dec 2013 14:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	bh=RCrI40zvu7VoCtdUMbmBR61cBnLODnSEyxgfjZeCcuU=;
	b=hEWc78Ej3cmxYfCyfuwyuJSUDmDCMgyzv4pijtXiJQXeW5JhqnvVlm5Ri8nRCiuwda
	oZKHygViuHvAAZsugEXIfAcWdoHj3bEUNDtTy4hWxnv6Pz0O2mkTYRyY0h6quBlum1m6
	Pi5nPeyRkYl/iPJO0S3VZ1jt9L0XWdBWd9bOEsL4Al3naYQ18Iaasks2EpHYV2XRh93W
	TrAfFSUDvCG3TLfzIleMPdR35J1gsmzHLcC/xtHr0+/ARziOZSexQf64sOyNMqSbm2Qb
	uk02x0dUP7Ubrfd3GtET1AIbJWazsEVxj6HyPIWsYEAwFlsOU2sjjMYtMi9e0LqD9JOR
	KAdQ==
X-Received: by 10.14.184.66 with SMTP id r42mr4323594eem.86.1386802288962;
	Wed, 11 Dec 2013 14:51:28 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id v1sm58693278eef.9.2013.12.11.14.51.27
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Dec 2013 14:51:27 -0800 (PST)
Date: Wed, 11 Dec 2013 23:51:50 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20131211225150.GB3717@jama>
MIME-Version: 1.0
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: openembedded-core@lists.openembedded.org
Subject: git fetcher sanity check for matching branch and SRCREV
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
X-List-Received-Date: Wed, 11 Dec 2013 22:51:30 -0000
X-Groupsio-MsgNum: 4203
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline

--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I understand and support reasons behind recently added commit
"fetch2/git: Add sanity check to ensure we really did fetch the correct
revisions"

but there is at least one corner case which IMHO isn't supported now, in
meta-webos we have yajl recipe with:

# corresponds to tag 1.0.12
SRCREV =3D "17b1790fb9c8abbb3c0f7e083864a6a014191d56"
SRC_URI =3D "git://github.com/lloyd/${PN}"

the problem is that 17b1790fb9c8abbb3c0f7e083864a6a014191d56 exists only
in 1.0.12 tag and not in any branch

OE @ ~/webos/projects/yajl $ git branch -a --contains
17b1790fb9c8abbb3c0f7e083864a6a014191d56
OE @ ~/webos/projects/yajl $ git tag --contains
17b1790fb9c8abbb3c0f7e083864a6a014191d56
1.0.12

There is "1.x" branch which contains parent of
17b1790fb9c8abbb3c0f7e083864a6a014191d56 but is missing this one commit.

Unfortunately we cannot "disable" this check by explicitly setting empty
branch or setting tag=3D1.0.12

I can ask yajl owner to push that one missing patch to 1.x branch, but
there were no changes in last 11 months so I don't know how responsive
he will be and there could be similar case in different recipes where
the upstream could be completely gone.

As side note, should bitbake do the same check when tag=3Dfoo is
specified?

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKo7IYACgkQN1Ujt2V2gBwRaACgqWiNlxenNgMs4M1VkfwDRXtk
EpoAoIMdiKiDC5Rj8S4qCf2lI/tpyXdI
=Ec2j
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
