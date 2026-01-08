Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A290D185F6
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 13:26:22 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6248.1767878774704133458
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jan 2026 05:26:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=LVKzDM8D;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=TEwy719b;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D6921D0009F;
	Thu,  8 Jan 2026 08:26:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 08:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767878774; x=1767965174; bh=UA4qO7cMXi
	EqOR5s+GmMuSSJUHNQxTTOx4NC8LXZVVc=; b=LVKzDM8DGQlcqjqKpNGL1zvGoE
	J5CCCd+vCQDbbdrimClca3S2QcM3/q2Tx6chAO4oB8F87L4ttXz1Aj1M+pjDo0fV
	HpQaiQb/WIYzUxTe6kQAn9KfIgBS16JMJ8IK3g3662QNlbSYBUqhUFSoK4PInemG
	dd38Nc8438dz0KKn8CZXNE/DcDBF0wWWm0hjcQ4+IE9d/dAnPUtNLQsxquB1H2bR
	lfjza7NwapjfA1fDC9xWZKa7IB0f4LRlF1mZN1pIyj0mJ5fpuSJiphHemGa6aEZp
	dJrhZxIM2iRyvFWQGnWuu5/eGcuxRaXgWmdtBvQVCkssdV7erPzucDnjHA3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767878774; x=1767965174; bh=UA4qO7cMXiEqOR5s+GmMuSSJUHNQxTTOx4N
	C8LXZVVc=; b=TEwy719b3KYY+GO2EVQZkDnW/0chL5sn4g+oB0tqciVebwaa/dJ
	9NGSB5Iy64kepz36FjgJrrT8y3/uavW8H2X4kBosKR7gSC/ig/mrjgCXR4hlY9vH
	rNwg7RYWgB4XVEBsduJvV+1FvEG9m5SN3nweOHmLeGUYDkvBQbdWXRq7MF6fyFWr
	WFPDxy/Z8TTcSDfdST5yrt8z+ZGMsFQcGQHXteuAQE/A+ekMihcsHZqN3Q2OwtVv
	jfu1KbWWnzFZbKtlrIKqxcW7gw+09VowC5wwfKr8iOm3jMgUhcKsyjZ/x7pP2KOy
	gYYMxrhB0y49geTFcONMg2wl9ckEvytskgA==
X-ME-Sender: <xms:drBfabzFmxui-ruJfbCMY9F7atZ0Rf6PxSDXCf2O3OwZ--RShQ9_8Q>
    <xme:drBfaZS43d5oCNn1afrnoomBllplQem9feDVqXMBSP94SkM9h3-PUKlNyMv3h21v5
    JQC6yoZhM0E74YvNT5qEJFk4T2tuBDYvSIP9BDiVlRjvsa36Dc75g>
X-ME-Received: <xmr:drBfaS-F9cw4ATOT8MWwq508fgMACTXggRRO3y6ziFTlJgG3xv6hR1T83032OW9K_J6mnanDS6o058K9qBOIA-yTfxzo86kNLj7gsqsUmc-t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfevffgjfhgtfgggsehgtderre
    dtreejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghr
    rdguvghvqeenucggtffrrghtthgvrhhnpeegkedvffdvhefhueduleffiedtieeuiedvge
    ehhfdvkeevtdeihfegteefjedtgeenucffohhmrghinhepohhpvghnvghmsggvugguvggu
    rdhorhhgpdhphihshhhtrggslhgvshdrphihnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggp
    rhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgvgidrkh
    grnhgrvhhinhesghhmrghilhdrtghomhdprhgtphhtthhopegsihhtsggrkhgvqdguvghv
    vghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:drBfaQo4YIusIyAtzoRJQVUHXMOzehl7i4JVeiTZBAMnyxzwnd6WtQ>
    <xmx:drBfaflVTwkH3X9erkIhb0jj5LjZ-Gc3uC6yVb0sorSgrg3al5pReA>
    <xmx:drBfaXI8KQsQpUk8iXTWdwhqLEW9BwyoEqZli_Z4jaH4WhDne4ZT2Q>
    <xmx:drBfaUzbiT2D5Iz9e26thgEVz9y-nR0yPtMZuB4lD2_5TRoj4E6yPA>
    <xmx:drBfabDuGj5T6ORm3MO5qjApiPMvfvSdRrnwm1y7suDjR-2TMvyNg_oD>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 08:26:13 -0500 (EST)
Message-ID: <428c9c8cb2f184be1d3b8fca2a6884e2e9b6a8f5.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH] gitignore: Ignore bitbake-builds
 directory
From: Paul Barker <paul@pbarker.dev>
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 08 Jan 2026 13:26:09 +0000
In-Reply-To: <CANNYZj9Z4NXfhcRRyjqkX=egw+0EQoUptgrFYXk6a6ZxU+0bQw@mail.gmail.com>
References: <20260108-ignore-bitbake-builds-v1-1-f7a993e9059f@pbarker.dev>
	 <CANNYZj9Z4NXfhcRRyjqkX=egw+0EQoUptgrFYXk6a6ZxU+0bQw@mail.gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cQD8UubhCBPPaXH/syRb"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jan 2026 13:26:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18711


--=-cQD8UubhCBPPaXH/syRb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-08 at 13:27 +0100, Alexander Kanavin via
lists.openembedded.org wrote:
> On Thu, 8 Jan 2026 at 13:23, Paul Barker via lists.openembedded.org
> <paul=3Dpbarker.dev@lists.openembedded.org> wrote:
> >=20
> > Running `./bin/bitbake-setup init ...` in the bitbake directory with th=
e
> > default bitbake-setup configuration creates a bitbake-builds directory.
> > Add this to .gitignore so it's not tracked.
> >=20
> > Signed-off-by: Paul Barker <paul@pbarker.dev>
> > ---
> >  .gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/.gitignore b/.gitignore
> > index fbf9eb2031c8..8152f617e72b 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -3,6 +3,7 @@
> >  *~
> >  pyshtables.py
> >  /doc/manual/html/
> > +/bitbake-builds/
>=20
> Perhaps it should be ignored across the whole bitbake tree?
>=20
> **/bitbake-builds/

I've sent a v2.

Best regards,

--=20
Paul Barker


--=-cQD8UubhCBPPaXH/syRb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaV+wchEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0btMwAQDiOg3iQjwbp1a9TMQ8UAM1tnW2Ic2obJ6K
SY3rSnyLSQEAx2Im31J0G2aSqFJp8ar4XD0Ow0bMFpt3+Ut3Mr2gewQ=
=DZA5
-----END PGP SIGNATURE-----

--=-cQD8UubhCBPPaXH/syRb--

