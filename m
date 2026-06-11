Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62803CD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 07:16:59 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40087.1781162215936945806
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 00:16:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=LM90H8M2;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2EEBE1A38A1
	for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 07:16:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E82435FF03;
	Thu, 11 Jun 2026 07:16:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48F2A106B9E11;
	Thu, 11 Jun 2026 09:16:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781162213; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=yVUKr8sgZWuqCWUh4MHrNYwIOk44P1keYZSmgsxJdcE=;
	b=LM90H8M2KIHA4HNvt8lFb8k0KovuPcWE1XdTBvtWIIjSMIp1RWuV57ZuqPTVfFZPBCGD+j
	ENCKJDKs5DnfDzzXEPiJv8zyDH2SzTL73y+mJ+cPF5Q3uwpCa12iSPYQIQcISFIypUv0lR
	GcfdJ/9EGwtKvZ7qbyDEFixIFshExPd2PkIOrPztGcO3M4wo4kz3CWqQJgymD45eAKtz6b
	q95rmFIWfrGMga1bxPSsWnIvQ7lfV8u7LujGoZmUlOwiC2f9csRSTQu+TQi4mzVfDzE8kw
	73/IMsetWpZ5YJOaucF68KUNC7jrVo7MN0hrtSM9U0lu+2PVdr+2l1RLhco0SQ==
Message-ID: <b792862b45f9fdb57cba31418d8a18c68dd2e70e.camel@bootlin.com>
Subject: Re: [bitbake-devel][PATCH 0/2] fetch/npm: fix security issue and
 re-enable fetcher
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Cc: thomas.perrot@bootlin.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Thu, 11 Jun 2026 09:16:50 +0200
In-Reply-To: <411bfc4142ad6d577df4b9350d6a18ca977b7127.camel@linuxfoundation.org>
References: <20260610-dev-tprrt-fix-npm-v1-0-9bf501d4ee0e@bootlin.com>
	 <411bfc4142ad6d577df4b9350d6a18ca977b7127.camel@linuxfoundation.org>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=mQGNBF+/ZOUBDAC2DghCjZvmgYcve02OG7dGZ7Iy58uEwne3LB7w7nRwdAxKw7ZaiVqwY
 O+yNGVi+GVx7oA6Wn4pv46z+QDRLQiq6OseuXhkSGCg7U/yBCUq12B/GRGO1Qt2Qi1mJJT1s+1qZ5
 Gxv6Nypz9qKVn94GM2bR1hXBga0t87vBpebThOHmX5d/0dqIcVxRCM7onNb0dDyRoVgLS5rBhQzrL
 CMrJaCy39xZUy0J1SOlH4Mgk6EhJIPYY4wlzikGX6urg+Tc9EjGd78ry0e0p5U5qgjFR5QGJDy1Gn
 U3CfwbT9sowdCASDbQDUoltlv2iWJCLa0xl97KVchCa0pr7HKbFA3J5SLKqFYUBCkFL+5WudYlz2n
 XxiUgyviMQxyK+ij66kEi6/2zFDAecd43pHV7790ptqZBC3Jc67Emj7Vo3ShX6RXPPxxbeCTOF2uk
 I45aJ9XcVFH/MFE96NjXj8uahnIsiTPyuCUoJu8tj7TSQyue874qJqVQvqlFyt2aZYJZ8ruq8AEQE
 AAbQpVGhvbWFzIFBlcnJvdCA8dGhvbWFzLnBlcnJvdEBib290bGluLmNvbT6JAc4EEwEIADgCGwMF
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCX79mdwAKCRCfw
 AsFcf4K7fhbC/wP0kSl6id2E/K3+UdXk6CLMVRbCFLCREzQs5WFpQ6l/I0WGOamhrOgegdszheiVF
 orlUP8d37XSpFAqydhKGaN78V5Dps0Wmwm4lIlS4MtQXJtSLUHXDJLIZLW0pw8tiPLKsd1o/yDkXE
 dnpsjJTRG6SdDSHnyOB2/gh4p+yTaLytFdARk/r4/P26+L+FiH0fFl+RnBt19LPklfKgeDc7GwIif
 ja+nIWpp3W23DAUuI6xduEut25Q89yu7Ci8CliLfAiLy9bIGjBQWU2Y+1/j/7KuPj6VbBsZWLTZY0
 hUmpJSTnWAqc9SMsNxo7NSQuddgviz5e2tqucaRqxP02FGzNa8U4NAKdWaXrlHG5Dglj9XH0DK+SH
 +c96qqFewYD8VPQ6XAGxQcXbrtJmiMor1R2DfziispLRvJcfYs8xqabbCtoS3ouXB9XRi8hn7A2kh
 ME1ryS+Oh63JshXHnw6bmjCpVd/p+fGLIGU6A47pJOpviKR4jEO84pl2ejtDZ3Tc=
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-2VVxvBduIEgF5n2Klw5F"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 07:16:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19654


--=-2VVxvBduIEgF5n2Klw5F
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On Wed, 2026-06-10 at 17:27 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Wed, 2026-06-10 at 17:46 +0200, Thomas Perrot via
> lists.openembedded.org wrote:
> > The npm fetcher was disabled in 355cd226 (Jan 2026) because it
> > retrieved
> > checksums from the remote registry rather than from the recipe.=C2=A0 A
> > compromised registry controls both the tarball and its advertised
> > hash,
> > making checksum verification meaningless.
> >=20
> > Fix the root cause by separating URL resolution from checksum
> > handling:
> > - _resolve_proxy_url now stores only the bare tarball URL in the
> > .resolved
> > =C2=A0 file; the registry-supplied dist.integrity / dist.shasum values
> > are
> > =C2=A0 ignored entirely.
> > - _setup_proxy builds the proxy URL from that bare tarball URL and
> > injects
> > =C2=A0 the checksum from the recipe's own SRC_URI parameters
> > (sha512sum=3D,
> > =C2=A0 sha256sum=3D, etc.).=C2=A0 When no checksum is provided the prox=
y URL
> > carries
> > =C2=A0 none, and BitBake's standard BB_STRICT_CHECKSUM machinery handle=
s
> > the
> > =C2=A0 missing-checksum case the same way the wget fetcher does.=C2=A0 =
A
> > bb.warn()
> > =C2=A0 is emitted so recipe authors get a clear signal instead of a
> > silent
> > =C2=A0 unsigned download.
> > - version=3Dlatest is now a hard ParameterError instead of a warning;
> > it is
> > =C2=A0 inherently non-reproducible.
> > - Narrow the broad 'except Exception' in _npm_view to
> > json.JSONDecodeError
> > =C2=A0 so that FetchError and ParameterError propagate typed to
> > callers.=C2=A0 Also
> > =C2=A0 fall back to str(error) when 'summary' is absent in the registry
> > error
> > =C2=A0 dict so the message is never silently None.
> > - Clear uri.params before rebuilding the proxy URL to prevent a
> > =C2=A0 .resolved file written by the npmsw fetcher (which stores the
> > full URI
> > =C2=A0 with checksum params) from contaminating the npm proxy URL with =
a
> > =C2=A0 registry-sourced checksum, bypassing the security invariant that
> > only
> > =C2=A0 recipe-provided checksums are trusted.
> > - Remove dead 'if ud.version =3D=3D "latest": return True' branch from
> > =C2=A0 need_update(); version=3Dlatest is rejected at urldata_init time=
.
> >=20
> > Migration note: recipes using npm:// must now supply a checksum in
> > SRC_URI, e.g.:
> >=20
> > =C2=A0 SRC_URI =3D
> > "npm://registry.npmjs.org;package=3Dlodash;version=3D4.17.21;sha512sum=
=3D
> > <hex>"
> >=20
> > On the first build without a checksum BitBake will download the
> > tarball,
> > compute the hash, and instruct the author to add it.=C2=A0 Any stale
> > .resolved
> > files under DL_DIR/npm2/ written by the old fetcher (which embedded
> > registry-sourced checksums) must be deleted before rebuilding.
> >=20
> > [YOCTO #16105]
> >=20
> > Fixes: 355cd226e072 ("fetch2/npm: Disable npm/npmsw fetchers due to
> > security issues")
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
> > ---
> > Thomas Perrot (2):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fetch/npmsw: fix security issue and re-e=
nable fetcher
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/fetch: restore and extend npm/npms=
w test coverage
> >=20
> > =C2=A0lib/bb/fetch2/npmsw.py | 12 +++++-----
> > =C2=A0lib/bb/tests/fetch.py=C2=A0 | 64 ++++++++++++++++++++++++++++++++=
+++---
> > ------------
> > =C2=A02 files changed, 51 insertions(+), 25 deletions(-)
>=20
> I suspect there is a patch missing or something here as it doesn't
> touch npm.py and half the changes above appear missing...

Sorry, that=E2=80=99s strange, it seems I made a mistake with b4. I=E2=80=
=99ll resend
them.

Kind regards,
Thomas=20

>=20
> Cheers,
>=20
> Richard
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19646):
> https://lists.openembedded.org/g/bitbake-devel/message/19646
> Mute This Topic: https://lists.openembedded.org/mt/119741992/5443093
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[thomas.perrot@=
bootlin.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-2VVxvBduIEgF5n2Klw5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmoqYOIACgkQn8ALBXH+
Cu2vxwv/WtXK0fladdp7Bb69RXWJo81KyU7uaRA+chQ7d7L23GNRuc6lmp3p/CKV
f2QITVstItb6rTuJONmO3/cJR5JqFF7dE1ASDhMA609WSYxuXl+PuJC/kGB9wmDd
torgtgnXKJfbvO7c5NkNBEbSlkZgWeEv3ncUZYIMLGYQmDKXKSlWzivA8bXd4eHT
GgsPJUGUKPD/UjBFUeQCQqqBrapImoFiFoKk7+yry1TOgbB9m0Bn2rvQyr8eWM2b
5SgLe8a8bSSEQJOnasjxn0U5l7GPhyZIDpAkhQtCvNYUqzIOWkd6DRK7tbl53rcv
MPjF0XhFRZEtU4143hkwhRcO7iBMe/fSWJ/6z/pzt4MAGszL7Nylu0NiVEK3HPY3
2+mdZLa3cl4COB3UfCEyT10j6e7iylR+guAH4y53HptE1XMVRtzEwGfskwPflTAP
IGpbA6sLgE896vuaSb4Ygvt2icFmCQPhwMptXO1O19YSQ9nkDaYoil5X5DuMVXx3
ZO9QWlhg
=5Hsf
-----END PGP SIGNATURE-----

--=-2VVxvBduIEgF5n2Klw5F--

