Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8163AEF48F3
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 08:54:31 +0000 (UTC)
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.67767.1770972870214879690
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 00:54:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=Shkh0Taw;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=atVzHrmg;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.157, mailfrom: paul@pbarker.dev)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED6D17A00E8;
	Fri, 13 Feb 2026 03:54:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Feb 2026 03:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770972868; x=1771059268; bh=91j/EaRAui
	+EXpH1Wx3D6+f9OT4QbNVN1K82asZCA5o=; b=Shkh0TawsPXxY1hbT5zU8Kps4i
	3u2dOOaEGK4dWis/h6xQdD3cZr7z1SFsO4pKGB+E7NztT1DdPfInmN2pag0O2K8d
	RftfEJdpLjadWJnU4GIEv8KOX8QCRSdI8kIeb666twpaZMBLFsHZ27boWjDVCTQ1
	kN8WkkMSxOroDNvaCqOkijiOtOagBtU1qg0VQ4iTIVbxIg6eRrY6m5aGTCo5SG3r
	XT9imNwLF1ZcLvFf1kklziqplc676DY31Ozn7c+kPIMxgWvqbS3QHEs21gZPTlCY
	RbVUl+EfDd261aGJgYQFPfThzl+uIQgc+dW+k3Tq6skD3tClB0OaTJ1y0GJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770972868; x=1771059268; bh=91j/EaRAui+EXpH1Wx3D6+f9OT4QbNVN1K8
	2asZCA5o=; b=atVzHrmgRaOPDB8VOG0cQJzlf+dfdJicVgPkGpc0T3SPKLkGruc
	ZubNJKNlao+KiHQeroXLgHoVZS2fUNMoKAdNFSeH4C7RUQ+vv91qN9tpyXBTsTr2
	G5aEmJ6KlKfhUBwl/QOPRoh3HYGoGot9vkSMzyh5CAMbmDxr/sc97SMVEtrCfAf1
	PRXDVqQ7lh3blcwXVf+7FP3KjfuTQBrtbYNhRgP5IT0JRNQvLvu1ppyL6HK+vf6k
	r3NPm51MP9/ghRnVl9WZZJYpwiKYTgmJSMxC2seqNhUf42/x8Gc408MfKoh+aWY8
	R8+Vo7Argm751udGLVTXUTBcxafxs3Fyr7w==
X-ME-Sender: <xms:xOaOaUjib-is3RSM_sE9HMUxTcM4XgkwyPxcUs2o9nXOTwzUfGF6Xw>
    <xme:xOaOaUcAIjk9MXFfTOZQAWdhN8JqT4M4OAmPo01F1WsQ-3p5wpyKgDtZHapHHUTTH
    6KzULVS4gDE1QSdmBcnJuCgdDdyVhJFjicamJP-Aceo5eQfTNVQs2qr>
X-ME-Received: <xmr:xOaOaZfwq-dQDButdtpar239pjxev43HIW32dA0M5alynsq6_2rNzXKZKeIowZ7gcNIONVoVIhI-quTEO39HoHhZLd9MFIjnIPkhpiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    ehgfeuuddvudeitdelheevffdvgfegjeekgfevhffghfevjedtheelieevjefhheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgpdihohgtthhophhrohhjvggtthdrohhrghdpoh
    hpvghnvghmsggvugguvggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtph
    htthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihohgrnhhnrdgtohhn
    ghgrlhesshhmihhlvgdrfhhrpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslh
    hishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtoheprhhitghhrghr
    ugdrphhurhguihgvsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:xOaOae-dW8SlnwXc2CFfLEjl0vsp28kGeT4S7uKMeW78gbsNlAzF1Q>
    <xmx:xOaOaVl0nC8hUEr6pU3YhKo_QOibH3KmjOq6pezyQ_5TmPzY6m_Izw>
    <xmx:xOaOaQ8Bw1C1jSNEQZ5C2FweRssq911vxf3iDB1u8hgOq6bC0lj4cw>
    <xmx:xOaOaTn3of9SYrqoLlCt-oy09tY1AvunW-C9DdZa8r2t8BgdFpKhrw>
    <xmx:xOaOaXFNdFfqfgFvBrW6t6Ln40SZrMRxp8G8bJ7oJn_As7aRub4nkMQF>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 03:54:27 -0500 (EST)
Message-ID: <d513e1c63b35ebf3bf38bcbfd91d663be09a7b0c.camel@pbarker.dev>
Subject: Re: [bitbake][scarthgap][2.8][PATCH 0/2] Pull request (cover letter
 only)
From: Paul Barker <paul@pbarker.dev>
To: Yoann Congal <yoann.congal@smile.fr>, 
	bitbake-devel@lists.openembedded.org, Richard Purdie
	 <richard.purdie@linuxfoundation.org>
Date: Fri, 13 Feb 2026 08:54:25 +0000
In-Reply-To: <cover.1770903920.git.yoann.congal@smile.fr>
References: <cover.1770903920.git.yoann.congal@smile.fr>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lHcKgYe4bt8obctrhR64"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 08:54:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19022


--=-lHcKgYe4bt8obctrhR64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-02-12 at 14:52 +0100, Yoann Congal wrote:
> Those are the patches from the last patch review:
> https://lore.kernel.org/bitbake-devel/cover.1770629479.git.yoann.congal@s=
mile.fr/T/#t
>=20
> Passed a-full on autobuilder (with AB-INT):
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3195
> * The build qemuarm-oecore failed:
>   https://autobuilder.yoctoproject.org/valkyrie/#/builders/40/builds/3140
>   This was caused by bug #16143 =E2=80=93 AB-INT: do_image_wic: tar comma=
nd return exit status 2
> * The build qemuarm-oecore was succesfully retried:
>   https://autobuilder.yoctoproject.org/valkyrie/?#/builders/40/builds/314=
3

Hi Richard, Yoann,

As with the other PR, I think this is ok to merge despite those
failures. So,

The following changes since commit 8dcf084522b9c66a6639b5f117f554fde9b6b45a=
:

  fetch2/wget: Keep query parameters in URL during checkstatus (2025-11-12 =
15:53:31 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib pbarker/2.8

for you to fetch changes up to 10118785e4a670bce4980e1044c0888a8b6e84af:

  knotty: Make sure getTerminalColumns() returns two integers (2026-02-13 0=
8:48:40 +0000)

----------------------------------------------------------------
Enrico Scholz (1):
      knotty: fix TIOCGWINSZ call for Python 3.14 and later

Zoltan Boszormenyi (1):
      knotty: Make sure getTerminalColumns() returns two integers

 lib/bb/ui/knotty.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Best regards,

--=20
Paul Barker


--=-lHcKgYe4bt8obctrhR64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaY7mwREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpJwAP4zaeIufnkm7vdgXQfftCE1XCUDHMaoN3hy
Uic7KATdnwEA0b/bXh63HjsJRq+MmIvtFSeYiKtyOMCqTrUDCsK1GQE=
=wCjc
-----END PGP SIGNATURE-----

--=-lHcKgYe4bt8obctrhR64--

