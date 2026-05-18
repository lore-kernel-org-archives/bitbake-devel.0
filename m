Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D093CCD4F52
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 09:08:32 +0000 (UTC)
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4511.1779095311245473916
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 02:08:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=0mmh8VOF;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=GzRq/VnJ;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.155, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2C7FD7A0019;
	Mon, 18 May 2026 05:08:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 18 May 2026 05:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779095309; x=1779181709; bh=I1ypzjt0OV
	Ru2Z8VH+oAX7fzEIwjooWH2Rvh8w4LcUU=; b=0mmh8VOFpCPALF7FHXYJZVOLLV
	aDqGHJNsWCol1YOZp2TTtRVE/CpM0zaYb92EGR7PcVjY0MHJvNWPgzw/NBFaOEX9
	aBrkVM0TCHr47FLA1ECNY5cc8sug/MkrIUMukfM/B46sUpGuXe/2dQi0WxCB6heF
	vV0knF9u2E7EDwyO2LktFDrExN11FjEnlxfrK6qO0tbNUlPXIhw6sO5NPa+naOoi
	JjMQTSXDGuImQjmBYc3TZNSLouT8uAsu84cuG2bU6uszyKFbtTSPjzMVNJtjKKGs
	yTM4oA14VpaF4tSlxqNb1/dIZuM5PheG6bLgIGEUJ12cjeXX0jMMayXbuRpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779095309; x=1779181709; bh=I1ypzjt0OVRu2Z8VH+oAX7fzEIwjooWH2Rv
	h8w4LcUU=; b=GzRq/VnJVW7DonHYAFuV/wXMLCn4q/HOUDLUZsBPRvUYfMApDWs
	NyRSM1FZUDPJpmzSQzEa2dque1ylyKd9szUxbmvVVuTQTQZHhYHugMQc1C+aYexq
	omm5ieF9kmiHOlrhiefXB/+k9+qfm00E4QdVssbT9pxXI1WP6nmId3kxN2wSPra6
	AuO7MlcJ7FgGcmv39dKdXxeoQYTuuMJcNKD0G/1ohj0Mi7UUbZyXkPvrowP057Lz
	rgLB9MYXBNzDb2llk46PHja/xmt/ENe6Hi7k7vYmNvPeqHfr5gVqT1iYIjeSP/v6
	Bb5BuOlwSWzDdS/YJQjSCuI267OgTwbFNWQ==
X-ME-Sender: <xms:DdcKamYdeCUCn13_dwxu-XYrNMSvhOKm_A79xayuzSU0ErK2_PtfYA>
    <xme:DdcKag0gaB7oz7Xf33d38k1fF4mYpvREntRFXL2GEGelW_My5v4YQPcg0W-iVCwx-
    Z6X9PdqD67Nlyd-vKQDdRydYO5QuHenzii28ZOr6rEN-C_Xe760HbI>
X-ME-Received: <xmr:DdcKauVbm4UWhqVYEnttAxFVjc1TbD77F10XL1Npvqktt21pCWLZtC610Wf_VV7-iPEfjd-lflRF3McmCicZksHKHjE8TQrz8YaC7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    ejledvheegfeeifeegjedufedvtefhhffhtdevgefhfeejvddtkefhgfdthfdvheenucff
    ohhmrghinhepvghnughofhhlihhfvgdruggrthgvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfrhhivg
    guvghrrdhstghhrhgvmhhpfheskhhonhhtrhhonhdruggvpdhrtghpthhtohepfhhrihgv
    uggvrhesfhhrihhsrdguvgdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlih
    hsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:DdcKaiVinK1HRhSBwX4nqd1NNcdkpC9u-R5JuBighB_6FmJpYRL2bA>
    <xmx:DdcKaleDQGZDA6YYBQQaHdtrDCVtScYPLy7-AVzUcWpyiuU8pb12Wg>
    <xmx:DdcKajWXPRAVXjHsMFPWjEEm8fHDiyUvaXJ_uQzP0IGr_itpEB61_g>
    <xmx:DdcKamcJwgjgC-OeA_GUYLextxrdTm48yfYa2rSb7rVLM1BMIdpRAQ>
    <xmx:DdcKannPDDUhsWCuioSRDXGF4ikGpR2N3ilRSOlOS-AZ6ncjhePCRFK3>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:08:28 -0400 (EDT)
Message-ID: <e129f87730bb622b72bc9ed22ff25b2975b3f9c6.camel@pbarker.dev>
Subject: Re: [PATCH 2/2] contrib: hashserv: Dockerfile: Update base image
From: Paul Barker <paul@pbarker.dev>
To: Frieder Schrempf <frieder.schrempf@kontron.de>, Frieder Schrempf
	 <frieder@fris.de>, bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2026 10:08:26 +0100
In-Reply-To: <94eea5ca-e805-4f12-8628-20d8360b72ea@kontron.de>
References: <20260511153632.299677-1-frieder@fris.de>
	 <20260511153632.299677-2-frieder@fris.de>
	 <3ef9bff03e994480804e680034b0cc4e721e7a88.camel@pbarker.dev>
	 <94eea5ca-e805-4f12-8628-20d8360b72ea@kontron.de>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lu9jw54T9vlyNxBH12qE"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 09:08:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19533


--=-lu9jw54T9vlyNxBH12qE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-18 at 09:33 +0200, Frieder Schrempf wrote:
> On 14.05.26 12:18, Paul Barker wrote:
> > On Mon, 2026-05-11 at 17:36 +0200, Frieder Schrempf wrote:
> > > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > >=20
> > > Alpine 3.13 is out-of-date and doesn't provide a Python version that
> > > is comaptible with the current version of bitbake master. Fix this
> > > by upgrading the alpine base image and installing the missing
> > > websockets module.
> > >=20
> > > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > > ---
> > >  contrib/hashserv/Dockerfile | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfil=
e
> > > index fe7e091ec..5c8b8dd11 100644
> > > --- a/contrib/hashserv/Dockerfile
> > > +++ b/contrib/hashserv/Dockerfile
> > > @@ -9,9 +9,9 @@
> > >  #   docker build -f contrib/hashserv/Dockerfile .
> > >  #
> > > =20
> > > -FROM alpine:3.13.1
> > > +FROM alpine:3.23
> > > =20
> > > -RUN apk add --no-cache python3 libgcc
> > > +RUN apk add --no-cache python3 py3-websockets libgcc
> > > =20
> > >  COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
> > >  COPY lib/hashserv /opt/bbhashserv/lib/hashserv/
> >=20
> > Thanks for sending this! Alpine 3.13 was end-of-life 3.5 years
> > ago [1]...
> >=20
> > We also need to update the Dockerfile for prserv. I wonder if we should
> > just use alpine:latest in both of them.
> >=20
> > [1]: https://endoflife.date/alpine-linux
> Yes, alpine:latest would also work for me. The downside would be that
> image builds could break silently if compatibility issues between
> bitbake and the latest alpine release occur.
>=20
> The more stable solution would be to pin the alpine version and have CI
> builds and tests for the image.
>=20
> Anyway, for me this was just a drive-by fix while I was building a
> hashserv image from the official Dockerfile and I don't have any strong
> opinions here.

Ok, it would be better to use a fixed Alpine Linux release and update
this regularly instead of using 'latest'. So we should take this patch.
I'll send a separate patch to update the prserv Dockerfile.

Best regards,

--=20
Paul Barker


--=-lu9jw54T9vlyNxBH12qE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagrXChEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bqnZAQCY9t2FRb74qWtRQHQW9TyQ6Z89ObdNQP+2
5IQtMSjCDwD/bMzqurYrPzSfYSXR7MCTRD0AAbOtL8FlPDnsFCFkUgo=
=+tYk
-----END PGP SIGNATURE-----

--=-lu9jw54T9vlyNxBH12qE--

