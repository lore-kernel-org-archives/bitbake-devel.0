Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f170.google.com (mail-ea0-f170.google.com
	[209.85.215.170])
	by mail.openembedded.org (Postfix) with ESMTP id 750D86DC49;
	Thu, 12 Dec 2013 00:28:14 +0000 (UTC)
Received: by mail-ea0-f170.google.com with SMTP id k10so3270633eaj.29
	for <multiple recipients>; Wed, 11 Dec 2013 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=her5+ap64ZCcJLu5YRAk1a38c0fauMgK5n70jd0RLT0=;
	b=XWyjfvpdY3EiwWpYGMX7wD+yCZkvVSRKJn+7h1Au2AoL+3xQWyAkF4B5sBCDadaZFI
	CEPa8Tu+vvk/XAlp/379P1rPRM/2MfB+q+O3JVfYR4V3Op6TqzkK8aFPVeaEZA6ts5Kk
	Eug+pS4N+cnBLJG0FXnq+LaWm4F06fGro1Dbj0T0dsTSKfwTcu8vnd0bTkbgPbiyysfO
	G+MG2Vvao3gEe7EFw7ox27sSi1cAML5DURcHvIYQnYLplKV2OWRk8rirVaE/qzrCY0ej
	0F5jBndNDsxbhS39Jn/Mj2TWH1bE/5lyWqiHk35OkBd+4YwXtWjnIxmbfV1oYM33odEC
	gcJQ==
X-Received: by 10.14.115.133 with SMTP id e5mr4391520eeh.91.1386808093302;
	Wed, 11 Dec 2013 16:28:13 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id 1sm59325529eeg.4.2013.12.11.16.28.12
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Dec 2013 16:28:12 -0800 (PST)
Date: Thu, 12 Dec 2013 01:28:35 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20131212002835.GC3717@jama>
References: <20131211225150.GB3717@jama>
 <1386802700.504.12.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1386802700.504.12.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Subject: Re: [OE-core] git fetcher sanity check for matching branch and SRCREV
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
X-List-Received-Date: Thu, 12 Dec 2013 00:28:15 -0000
X-Groupsio-MsgNum: 4206
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline

--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2013 at 10:58:20PM +0000, Richard Purdie wrote:
> On Wed, 2013-12-11 at 23:51 +0100, Martin Jansa wrote:
> > I understand and support reasons behind recently added commit
> > "fetch2/git: Add sanity check to ensure we really did fetch the correct
> > revisions"
> >=20
> > but there is at least one corner case which IMHO isn't supported now, in
> > meta-webos we have yajl recipe with:
> >=20
> > # corresponds to tag 1.0.12
> > SRCREV =3D "17b1790fb9c8abbb3c0f7e083864a6a014191d56"
> > SRC_URI =3D "git://github.com/lloyd/${PN}"
> >=20
> > the problem is that 17b1790fb9c8abbb3c0f7e083864a6a014191d56 exists only
> > in 1.0.12 tag and not in any branch
> >=20
> > OE @ ~/webos/projects/yajl $ git branch -a --contains
> > 17b1790fb9c8abbb3c0f7e083864a6a014191d56
> > OE @ ~/webos/projects/yajl $ git tag --contains
> > 17b1790fb9c8abbb3c0f7e083864a6a014191d56
> > 1.0.12
> >=20
> > There is "1.x" branch which contains parent of
> > 17b1790fb9c8abbb3c0f7e083864a6a014191d56 but is missing this one commit.
> >=20
> > Unfortunately we cannot "disable" this check by explicitly setting empty
> > branch or setting tag=3D1.0.12
> >=20
> > I can ask yajl owner to push that one missing patch to 1.x branch, but
> > there were no changes in last 11 months so I don't know how responsive
> > he will be and there could be similar case in different recipes where
> > the upstream could be completely gone.
> >=20
> > As side note, should bitbake do the same check when tag=3Dfoo is
> > specified?
>=20
> This is an interesting corner case. I have this patch lying around which
> fixes the issue where a given tag is only available in specific
> branches:
>=20
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=3Drpurdie/t2&=
id=3Dd211662ca92ee084c0c4a3d343e0b1f28ab853ac
>=20
> however that won't help this case. There is also an issue where the
> ls-remote command can match multiple branches/tags since its unanchored:
>=20
> git ls-remote X foo
>=20
> refs/heads/foo
> refs/heads/broken/foo
> refs/tags/foo
> refs/tags/broken/foo

yes we discussed this one in
http://lists.openembedded.org/pipermail/bitbake-devel/2013-August/003725.ht=
ml
which I haven't finished yet, sorry :/

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlKpAzMACgkQN1Ujt2V2gByBGwCggnkL//DsArhrEv6nextkgK/m
Ct0An1hp377lUDe7Ta8OPbakMF1sc9bu
=zRxb
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--
