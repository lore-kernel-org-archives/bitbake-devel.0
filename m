Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D00CD4F25
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 10:19:05 +0000 (UTC)
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7472.1778753939373430869
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 03:18:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=fKUAnuGa;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=vYFMsIJv;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.144, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 712CE1D000B6;
	Thu, 14 May 2026 06:18:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 14 May 2026 06:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1778753938; x=1778840338; bh=FwIxa4pi2j
	MecDzBjX4x3rccTIMb3ODs5eO3ijkmCbE=; b=fKUAnuGaALp4rEsDijP+bNdhnZ
	XBs9NNIxdqdhkU8uI+ASSFNGpHfr65DoENdpE49Cw9TJG9vSrds3qkUxAHz+faLr
	bvIZqRZcZHVb+C+g51fYbKB7CxPLkGFRiHRD26TLaKBs5eHKf2TZqGC2H87HcROo
	0q4WL7Lm/6HrvJjyC96T6V3Oq5d+Hu7gNtvf6xwp1Ka/e+/ijDr9Id4/wjI7LxIo
	9TkjhcbGTaZoUtRJ9SWQAz1JPL5ZqyEu1/KIr5PzHUa7iHrj9Q9gTLk7Az8YqcJq
	0Xy2trKwPVKIkpZTfvfw2PkeRTcIyM3bWs0qjavqGocRqcjH+eIAaCGifq+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778753938; x=1778840338; bh=FwIxa4pi2jMecDzBjX4x3rccTIMb3ODs5eO
	3ijkmCbE=; b=vYFMsIJvlc4GSvnyJhsebp4ZL4ZEg+oRNxGJjcgHqP6FofypqWK
	ItptfKjopxInkq8KaPbmEwGZxPx0DCFJ34ULpDzTMrn4r2gk0AmksMTlvwNaRQAt
	e94wymbiUravXqJVFpTs8ncJBC/MrxiB4TK9AnjNPWCqT2P98LdmaEHP1A0rvQRX
	hqDoC3DDLPAhnxVMgDmp89I6neUTT0idD4OS7ZsUoa0DLBHQve3slvGRVNN7gTQN
	i+CFf46ElQY2PgUat9DASi+eV2eLveKyK/NLnwosjIWXZ/kNEQ+aXjbRuXAFzCSs
	pIyVeReUwiC0K0CBIQAVgQ+4/mitMuVilFw==
X-ME-Sender: <xms:kaEFapn_mjwy2kZQgV-Nu-K1tmiQzxRu5USedfHN9bkjWvjFYrk9Sg>
    <xme:kaEFasRBgBDKJ9smB1U9DwsXNX4UJ6zOcARbGAbM-ZwmQeH8YRCij2EP_u-mBiEq1
    hgtczYzLrbl-yh9vPyzko61f2phIbr9gT3aVWWRb_JX8zqt3a5Wky4>
X-ME-Received: <xmr:kaEFatAg4A74FJSBtykS_auYsR7xJvouyq79LzC5gDIBzLwQNczkyL2RAZuAQiBLuZxtdUNxX0prL08ye_08fPkgRwWs_xpbf9-sJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epkeegvdegffetgeehheejleefgefgfeetvdetjefhveetkefgleeufedutdektddtnecu
    ffhomhgrihhnpegvnhguohhflhhifhgvrdgurghtvgenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhrih
    gvuggvrhesfhhrihhsrdguvgdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehl
    ihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprhgtphhtthhopehfrhhivgguvg
    hrrdhstghhrhgvmhhpfheskhhonhhtrhhonhdruggv
X-ME-Proxy: <xmx:kaEFajRccztLLyzSq3JjmkA-M-sZ7uQB3EP5agUYWSf6S5qTNm5x8Q>
    <xmx:kaEFarp1Rnc72XUtOay0qnPBY65K06NrqcCp-t2HwCB6tk8emsJwow>
    <xmx:kaEFaly9zvQi7OVS_EO-VhZU2sW33P4bQXzO4iejDlIjOAnP5umtdw>
    <xmx:kaEFagJSysB3yn475gtJBEQs9cxFiR-a7HR4BtjhTW9YLRrIkjI8bA>
    <xmx:kqEFapBoeM7ZqG4SoP_yvc9RgzznOYtj3dY06kyC-7GzM7XIcXPdIoTm>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 06:18:56 -0400 (EDT)
Message-ID: <3ef9bff03e994480804e680034b0cc4e721e7a88.camel@pbarker.dev>
Subject: Re: [PATCH 2/2] contrib: hashserv: Dockerfile: Update base image
From: Paul Barker <paul@pbarker.dev>
To: Frieder Schrempf <frieder@fris.de>, bitbake-devel@lists.openembedded.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Date: Thu, 14 May 2026 11:18:50 +0100
In-Reply-To: <20260511153632.299677-2-frieder@fris.de>
References: <20260511153632.299677-1-frieder@fris.de>
	 <20260511153632.299677-2-frieder@fris.de>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-68ZRyFpSIQs2g27CS3nY"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 10:19:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19518


--=-68ZRyFpSIQs2g27CS3nY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-11 at 17:36 +0200, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>=20
> Alpine 3.13 is out-of-date and doesn't provide a Python version that
> is comaptible with the current version of bitbake master. Fix this
> by upgrading the alpine base image and installing the missing
> websockets module.
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  contrib/hashserv/Dockerfile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/contrib/hashserv/Dockerfile b/contrib/hashserv/Dockerfile
> index fe7e091ec..5c8b8dd11 100644
> --- a/contrib/hashserv/Dockerfile
> +++ b/contrib/hashserv/Dockerfile
> @@ -9,9 +9,9 @@
>  #   docker build -f contrib/hashserv/Dockerfile .
>  #
> =20
> -FROM alpine:3.13.1
> +FROM alpine:3.23
> =20
> -RUN apk add --no-cache python3 libgcc
> +RUN apk add --no-cache python3 py3-websockets libgcc
> =20
>  COPY bin/bitbake-hashserv /opt/bbhashserv/bin/
>  COPY lib/hashserv /opt/bbhashserv/lib/hashserv/

Thanks for sending this! Alpine 3.13 was end-of-life 3.5 years
ago [1]...

We also need to update the Dockerfile for prserv. I wonder if we should
just use alpine:latest in both of them.

[1]: https://endoflife.date/alpine-linux

Best regards,

--=20
Paul Barker


--=-68ZRyFpSIQs2g27CS3nY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagWhihEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0buN1AQC/TfZh6lIZZESp/B0TEo461coS5VV/yfgB
wGW/Zp0IkQEAwuKXTlaxFetEjQ4Sw6xbpaw+ga1beBkRLpAvw1ELtwE=
=tIx1
-----END PGP SIGNATURE-----

--=-68ZRyFpSIQs2g27CS3nY--

