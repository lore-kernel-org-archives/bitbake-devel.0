Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>)
	id 1Rsetg-0008S5-DH; Wed, 01 Feb 2012 19:27:08 +0100
Received: by eekd41 with SMTP id d41so361648eek.6
	for <multiple recipients>; Wed, 01 Feb 2012 10:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=CdkEmT18gIS8eC/hQPrQjRyvME0qc9+xZ+woW1sS1DU=;
	b=RzfpumPXI8LTM7v2MXdi6V89CG7xV8cMWWEds8xNqz8sJQweK3ZnPggr5kYux+jn5l
	33vlfJty/1N2bm9ojBSoEodOY4IhtBVrqDLmxNSRxOZqe/LODeP081mOQGxidWxuUuWq
	ged5N/LoLkv1JPPKbwdNnmjNFEqVF+h7WkVIY=
Received: by 10.14.32.84 with SMTP id n60mr2752457eea.88.1328120352948;
	Wed, 01 Feb 2012 10:19:12 -0800 (PST)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id a58sm22039211eeb.8.2012.02.01.10.19.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Wed, 01 Feb 2012 10:19:11 -0800 (PST)
Date: Wed, 1 Feb 2012 19:19:09 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <20120201181909.GC6969@jama.jama.net>
References: <CAMKF1so7zfZSiGq+txWdBkONMtMi8iKRhqV_TOPt3FV3fTTEpQ@mail.gmail.com>
	<CAEsOVNekW4Zo6YRHyNCTMJ_GsgrzaOE8QvWr70tRNAZQNokcig@mail.gmail.com>
	<CAP9ODKo5EQEWr2CU9uQdz6mXKPJfN6zhbSkTcC01k8rU2D4kQg@mail.gmail.com>
	<CAEsOVNeh8GTOcU+jF1jxs1FJTi84vq0_AVX9osvU1R83gzq2nA@mail.gmail.com>
	<CAMKF1sqkdApUR9YPamhtxtUHoanHZ5Sxp8ggUnp8PS0v_qPPgg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMKF1sqkdApUR9YPamhtxtUHoanHZ5Sxp8ggUnp8PS0v_qPPgg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] should we switch off patchwork for oe-core and bitbake projects
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
X-List-Received-Date: Wed, 01 Feb 2012 18:27:08 -0000
X-Groupsio-MsgNum: 940
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline

--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2012 at 10:07:14AM -0800, Khem Raj wrote:
> On Wed, Feb 1, 2012 at 9:51 AM, McClintock Matthew-B29882
> <B29882@freescale.com> wrote:
> > I'm saying leave it there even if its not maintained. I can still go se=
arch
> > for patches sent by me or other specific people.
>=20
> thats what mailing list archives are for.

is there something like
oe/contrib/patchwork/pw-am.sh
for some mailing list archive?

When I see some interesting patch in ML, easiest way for me to get it to
development branch is to open patchwork web (from any computer) and then
call pw-am.sh NUMBER in screen session on my development workstation.

Even when reading mail in mutt on the same machine it's easier for me to
use pw-am.sh to get that patch to my chroot for OE builds.

And that git hook marking them as applied works very well.. so usually I
just have to mark cover letters as applied.

Cheers,

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk8pgh0ACgkQN1Ujt2V2gBwTegCgu4vNaQeFBBtnjUeCZURYOIyQ
c5AAnR3vGqa0bMkfwcB4B5CbBQDhxF1l
=4hmW
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
