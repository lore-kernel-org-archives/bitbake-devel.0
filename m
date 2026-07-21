Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC605C4452F
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 12:48:00 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21848.1784638075476648942
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jul 2026 05:47:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DD3DHWA2;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3E1DB4E40E9B
	for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jul 2026 12:47:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F086C60368;
	Tue, 21 Jul 2026 12:47:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1858011BD03C7;
	Tue, 21 Jul 2026 14:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784638072; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references:autocrypt;
	bh=gSMrCebOAsrAo2FRDLpG/hIc/GaFYT1GA+G4cnMfH6Q=;
	b=DD3DHWA281r1vzL778nREXNCHx2Uw4uhyvLL6pQbaFuwXOvVtteDZnNxnYipNPUAfinBMV
	ZIcPhRmHfKWFXIlR5POsZeezAUrzCa6R8S//VKEKNMLdxhe045/AgvkiWVnW9Y6nIDvrY8
	n5lVo8tziW5ui6iD68jiAKHRE2mGS0k2dDuXmv58AGAH/i7LoNSf8B1uXfETFHC0yu2fpK
	hWwXABZNRwsjwstmr3C528OxPq79zqTBHfKVGxm/AZKR0cLHzXgyn6Lqua9KZXa6SGSwCE
	hZHsdZVMXGHXluDnh1UmVG4SLA8nFAt46a5Fhd58XwERfHomSzxUjoqKm3YDmw==
Message-ID: <c08f34f8ab5c854a902952a930404b14e1899fe6.camel@bootlin.com>
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch/{npm,npmsw}: fix security
 issue and re-enable fetchers
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org
Cc: "thomas.perrot@bootlin.com" <thomas.perrot@bootlin.com>, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>
Date: Tue, 21 Jul 2026 14:47:50 +0200
In-Reply-To: <420910a84c6d51c2c3742223e2507229d5a93716.camel@linuxfoundation.org>
References: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
		 <420910a84c6d51c2c3742223e2507229d5a93716.camel@linuxfoundation.org>
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
	protocol="application/pgp-signature"; boundary="=-Xgw9st6c6FCxC7HFeIgY"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jul 2026 12:48:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19846


--=-Xgw9st6c6FCxC7HFeIgY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Richard,

On Tue, 2026-07-14 at 13:15 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Tue, 2026-06-16 at 15:37 +0200, Thomas Perrot via
> lists.openembedded.org wrote:
> > The npm and npmsw fetchers were disabled in 355cd226 (Jan 2026)
> > because
> > the npm fetcher retrieved checksums from the remote registry rather
> > than
> > from the recipe. This series fixes the root cause and re-enables
> > both
> > fetchers.
>=20
> Thanks for the patches, I'm not 100% convinced the issues are all
> resolved though.
>=20
> For example, even after the patches are applued, test_npm has a
> version
> in it but no checksum, yet the test passes, test_npm_premirrors also
> has no checksum and so on.
>=20
> How are we verifying the fetched sources in those cases?
>=20

Thanks for the review, you're right, and it's a real gap, not a
misreading of the tests. In v1, a missing checksum only produced a
bb.warn() and the download proceeded anyway, verified against nothing.
That's the same behaviour wget uses (opt-in via BB_STRICT_CHECKSUM),
but it doesn't make sense for npm here.
Unlike wget, npm has no independent anchor for the content it fetches,
so a missing checksum meant we were back to trusting the registry
unconditionally, which is the exact thing this series exists to stop
doing.

v2 will make the checksum mandatory and unconditional, will raise an
error regardless of BB_STRICT_CHECKSUM, when the SRC_URI haven't a
checksum parameter.

Will send v2 shortly.

Kind regards,
Thomas

> Cheers,
>=20
> Richard
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19837):
> https://lists.openembedded.org/g/bitbake-devel/message/19837
> Mute This Topic: https://lists.openembedded.org/mt/119833197/5443093
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

--=-Xgw9st6c6FCxC7HFeIgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmpfanYACgkQn8ALBXH+
Cu3yxgv8CD33wBwuR7W0vwtCL9O8UrPlu6V02BCV+xh0t0PlkqYblIhMt4e9lq8l
Vj0o0D3JJ4z07LH8lrdBu8E0R97Z2/J63q7kSyj0+45cmF9s/LQ7eLOJHvu3FH4E
JRRl0vY+NcPIiV3h80HkVw+DcGoC1FYKCTvf0zCIDOrI2BiMBNsY6d9JYjvjp50k
teHNoyKPQ6YKdXBTj2M/LK1KKfjzNnJeHsN8emSQdv0FzGn+iT82nPvA3wXQCzBh
PZrpFItIlXUxue2wNRuhqIjH7W8dZmh1ZPl5ZqyZK+LE1+6VKWlHsV4y76CndHBs
4RHA7CJm9AxroStIxWErDYQdDOwtfsaBEbXnP67a1Nkh3hCP29rLXg1+lJAR46bj
ahTx73Almn7ZtJfX3eX6yxsEZqVXwK0WeaywM+jiWc4D5d5FeegSpEe70rxiGxvu
GP8VoFrJ7xC840hvWqrLZ3GH+S1EtyrV+O7ww+lF/30KR8P5vtEdkgaqLikbYvcK
l85RagS6
=ol2Z
-----END PGP SIGNATURE-----

--=-Xgw9st6c6FCxC7HFeIgY--

