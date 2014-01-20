Return-Path: <martin.jansa@gmail.com>
Received: from mail-ee0-f49.google.com (mail-ee0-f49.google.com [74.125.83.49])
	by mail.openembedded.org (Postfix) with ESMTP id A02F96B678
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 16:18:05 +0000 (UTC)
Received: by mail-ee0-f49.google.com with SMTP id d17so3515263eek.22
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=wNmv9Mq+GhW3pYwuEFDg9WevzttyxFJMchUAspt8zAM=;
	b=ndpw64JP4176lcsumRuo2eyFEqUuWcugEaagThUP0iS+++3XCGX9OggG6yaz3ruEX9
	uQoF/PdqBnC9aJe+0GzbqgDxh7g55wQRChJo+sHYuyJH07OBQj43kx/zSJZacWckCbPY
	qyfEvicNKkGJeRgfmAAffOr8J6Lt94wX6BBkD1Nd6v8IFo6MCQjRjLO609x5/G+gwpW5
	+WYMT6wKOD1IUHY7bhdnTi/WBFH76aLre2zknxJJ5Q4oxLJlNkRrpuH4AxR588FzYqLs
	7ad+s008n52YrfA+idOLmIEVRva/yzYxXOaXJw//k1MpDZNm625DYI/GL68kGj1LkHDK
	H/4g==
X-Received: by 10.14.107.3 with SMTP id n3mr5560315eeg.67.1390234686248;
	Mon, 20 Jan 2014 08:18:06 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id 4sm4668731eed.14.2014.01.20.08.18.04
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 Jan 2014 08:18:05 -0800 (PST)
Date: Mon, 20 Jan 2014 17:18:05 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Olof Johansson <olof.johansson@axis.com>
Message-ID: <20140120161805.GG5565@jama>
References: <1390231311.874.37.camel@ted>
 <20140120155734.GI6520@axis.com>
MIME-Version: 1.0
In-Reply-To: <20140120155734.GI6520@axis.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Mon, 20 Jan 2014 16:18:07 -0000
X-Groupsio-MsgNum: 4343
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8sldprk+5E/pDEv"
Content-Disposition: inline

--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 04:57:34PM +0100, Olof Johansson wrote:
> On 14-01-20 16:21 +0100, Richard Purdie wrote:
> > When specifying tags, they're searched for unanchored so foo/bar could
> > match:
> >=20
> > refs/heads/abc/foo/bar
> > refs/heads/xyz/foo/bar
> > refs/heads/foo/bar
> >=20
> > This change anchors the expressions so they are based against heads
> > or tags (or any other base level tree that has been created).
>=20
> Afaict, ls-remote matches the wildcard character against any
> character, including /.
>=20
> $ git ls-remote gittest refs/*/foo/bar
> 69ab4bdbb5f3725ca594a2abdb636ee8fc25e1c4        refs/tags/abc/foo/bar
> c8647b027d88af180e90d842577518b73ef6a167        refs/tags/foo/bar
> 149c3c329515086af1ae4e24b12b17100ae16256        refs/tags/xyz/foo/bar

Yes, I've seen the same behavior:

http://lists.openembedded.org/pipermail/bitbake-devel/2013-August/003724.ht=
ml

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--a8sldprk+5E/pDEv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLdTD0ACgkQN1Ujt2V2gBx+PwCfbS6DL5v/5dH2wwoFcTEBdVhj
3RgAn0eIuMrKzcO+8Lnc83pMJbSBXyCe
=V3D7
-----END PGP SIGNATURE-----

--a8sldprk+5E/pDEv--
