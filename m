Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A4FCD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 12:16:40 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41021.1781871391515370097
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 05:16:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=rv599FWz;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=YLzCe9tf;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E0E27A0111;
	Fri, 19 Jun 2026 08:16:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 19 Jun 2026 08:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781871390; x=1781957790; bh=Q7A0twGg5n
	klAiDWuivKS4dzNQCqcoFY8316H4hohcw=; b=rv599FWzA8+Q2SFff+/EXMZQTw
	5+HnPqzw8WOz5uUrB2xa1VC29iHTg38CfJF4vLUMIKGTOnp8mPcverEjUNnJkvCh
	P1NZRIwhWRDWTE81CHGl9eVa3BJkXUWmiekc/mTHMRUl7RxLJp5yFFO6w8+POMu2
	U6NwI4wsLmAlkznPlAA/PE69X5TvGsILW1F6QXcgDR/lOSwxlk9qjPPxTU9QFTsZ
	SGO4dNSQSthp/1aCIXCZpHekVT+fGVs+3wDmtnADNzfO+KdX0FIMmCkWDr5RZ5kw
	0+WYFQKQ0nNbS2jWrmi6QkQKZjrywOcPKFkFUXwJmpt+k/+Kk0TyK3PEdwmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781871390; x=1781957790; bh=Q7A0twGg5nklAiDWuivKS4dzNQCqcoFY831
	6H4hohcw=; b=YLzCe9tfqMYQfrq3DO6Hc85DLJk1cgEMWHYSblxvPuHRKZ6Z4ek
	b0rd315cGYghIwg8JN+6z3UQRx2WEarD9TLltf20Px5QYEFSbgDc1kDK++tNJLdp
	HHZTc+ixBO62clrbdBa5yeOTqxdXv+BIgfBwi5+xWS2stNlPaKgBXEGf1fZDtKaB
	0OMstOCzLXky2PifIKyzswT8KqMIfuD+giCUxOlzQW0r4lyE7m9TlqYIgdGlf37J
	5denX164+fi/DsRDyS2wl5YuNJoZeIjuVYaPaPMtqbhRQFgsVy2Uc86HfaRvripb
	5UFDqPPQCwOk89xDdTo8ZHRJdIplkWHD2cQ==
X-ME-Sender: <xms:HTM1ajF__ZfEZ5rz0Jy_k9sq0StUVqzyW7IuCaEeXuA1cvdLmLC0lQ>
    <xme:HTM1amXN9A5C9ggTYKbnkPJwFETXG3mKK5Obm-KzaHVYu4C3ZYMCrJvP3srNcDMqp
    -KCDkJCSyUjIMSjMANvDtUE5IMGA6huyULORlzf9bdh4qaH8pHrmV0q>
X-ME-Received: <xmr:HTM1aiwoKXKqbVEawd6Y9yTw7Ope5Z7OiuAL57XAtjYiZX0A0QMfT9bqXo_IhkKdRNIOZIxAzb4H01x3mOq6eOgIsg7TneJByMQM4QGJqMTC>
X-ME-Proxy-Cause: dmFkZTELwwrisoTDbAqzqdS8Bho8cRvgl0OX+yo34YC+5EbrPRQCUJIkIm/PpUyifZy54V
    ORIE0PkhlPfd9RcZGNzmo0fbaOyAt7nWwnbFiEXkNfFu3NrMG6dXLLgPf0CibNf1iHpi6R
    35Z2ib8Eo6JMxpOWv/6VuxPI7xVDfErSCtahnPzKOxnU40FYp/epRXe6osduHcDl8ngjWi
    jyvcJ14ZALDsJ82wu3sVb2yKJM44bfdV50y4rBEScSWIztSsOmMREA5rD8HDgsTYQsefIi
    Wl85ESMfBOu3K+8FvYl8rWGTN/o59RKTREaKeJBhLBst4/EqQhin8TkFEECqQGM3bVvOch
    OjzddbCHR/MYYLBPU8ohBAxOCqQtbVT/a5HcwOOSQGI9EnEaNv4RznHnRWm5oZ6MhMigpd
    2c+e2pp6NPBtBDApX5YbmghOyIsjd+BWrMHfaU/PyldAfP9vklPCQA5G0EdSrmTm5bruOy
    ugjZcFUFfUkdHPgJDJPJZCOdnuhCvknD57M7Lf8J6hR1sesnRWoAmkF5HA8hiu+3pjGaca
    KeEb8Fn+QpGy+ERs00owjRH1zXVzPlkvXCKdfIvouRrHkOobPa0Lbvqs/vgol4PBtqsbd0
    g55Tg1WS5zmJ7Snor2Tl3Fel1cfpaEwgsxY3BeOyz5Yv89Jxfhdtpp7Bi8ow
X-ME-Proxy: <xmx:HTM1asPrB-5VminXB3X1Gt7oKb5RgV9TbbPki6UZvbm1f1001AeaGw>
    <xmx:HTM1ar4Ru9JuhijFEwDh1fw4c7oO9dorU5Hdd0lfCUcNIB9iPYTYcQ>
    <xmx:HTM1alMtV4i9GBNCzpDsXnMzab8RBBcnOnNqg2RVGgvKAH6MT8yz7Q>
    <xmx:HTM1ahmR7_1MSnn3XzDj5T6N1KVvHpajHdcUjltTd3SJsFU6Q4cwZg>
    <xmx:HjM1akkBuV5pnOwhfIdFc3FiOw5pcUcmBCXWP3M6-ZP5t4K2KOJDSWrw>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 08:16:29 -0400 (EDT)
Message-ID: <8754f7cae81e11a3fe2f1c7bee93d07464c5679c.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH] fetch2/crate: support user-defined
 protocols
From: Paul Barker <paul@pbarker.dev>
To: Gabriel.Smith@belden.com, "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 19 Jun 2026 13:16:22 +0100
In-Reply-To: <LV8PR18MB5783EC1D3247161CBB9FFFB482E42@LV8PR18MB5783.namprd18.prod.outlook.com>
References: 
	<LV8PR18MB5783EC1D3247161CBB9FFFB482E42@LV8PR18MB5783.namprd18.prod.outlook.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-AL3ViIImUFmyo0Ik9gYt"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 12:16:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19750


--=-AL3ViIImUFmyo0Ik9gYt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-17 at 18:59 +0000, Gabriel A Smith via
lists.openembedded.org wrote:
> From cd89f0c841d9611d79047c70045a05f6ac41da56 Mon Sep 17 00:00:00 2001
> From: Gabriel Smith <gabriel.smith@belden.com>
> Date: Wed, 17 Jun 2026 17:53:56 +0000
> Subject: [PATCH] fetch2/crate: support user-defined protocols
>=20
> By default HTTPS is used for crate downloads, but both HTTP and FTP are
> also supported by wget. FTP is not supported by crate registries so
> it is not recommended. This adds a protocol parameter similar to the
> git fetcher to allow a user to specify a different protocol.
>=20
> Documentation has been updated to mention the new parameter.
>=20
> Signed-off-by: Gabriel Smith <gabriel.smith@belden.com>

Hi Gabriel,

What's the motivation for this patch? I don't think we should encourage
use of insecure protocols.

If there's a strong reason for supporting this, please also rebase on
top of the patch for configurable registry and index URLs support [1]
and send a v2.

[1]: https://lore.kernel.org/bitbake-devel/20260521163033.40871-1-ms98.cho@=
gmail.com/

Thanks,

--=20
Paul Barker


--=-AL3ViIImUFmyo0Ik9gYt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCajUzFhEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0br+uAP96TkOG4i41UGuH2ia03tkvwCxQTAhMcup/
K7Tymux5jgEAqfZtduaSr4RJAw48YgtH8+1Tp8Tg2AVQoiaS6xyqAg0=
=LUMR
-----END PGP SIGNATURE-----

--=-AL3ViIImUFmyo0Ik9gYt--

