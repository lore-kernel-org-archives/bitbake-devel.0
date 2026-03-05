Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF13F47CA9
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 18:09:35 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50938.1772734165338146815
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Mar 2026 10:09:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=MNpUaKaz;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=GSMcA3yS;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6BEEB1400012;
	Thu,  5 Mar 2026 13:09:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Mar 2026 13:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772734164; x=1772820564; bh=EHtui5XvsL
	icqN+WGVRmcWfUqbzhOQOXxlhAS7W9Q9A=; b=MNpUaKazvKFM/0FbApHjKdrjGq
	/5Znz8BWbCcYrQe72HX0Ve+Ch7vBwvpf7CXTC/7vO/PrVpCWzQWt8ZqJ9BkM0Y4e
	11HHMu3hxysO1BeCjo1cGGI0YVoq41xWTGxGxNJ+KnhbYiuWDXH1WxTW2uWgJ2Z7
	nheE/3n1IIzdQ53uK5XPPMWEZwj1bTkqb+lwYFSRY/Y+HYD/krsOEdLXN9rAcBQd
	GWdFLaifPMpXep+dT5nRKKdxlC3mz+sRFmY5ENFQwk799IQ+WRo1tHs+KBe8c/0+
	BbQJgmPpdssSIXpC/BQ9tp/tDG1DsjrHIBNsV6PH08ygd0Hj3/L/gpE4UbsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772734164; x=1772820564; bh=EHtui5XvsLicqN+WGVRmcWfUqbzhOQOXxlh
	AS7W9Q9A=; b=GSMcA3yScVRmejoa7IGWoCFtH8CmUn3CPeKlvHDzucUR+KuAPGU
	XzEwaCKTwuS9atSpMtcL0r7EFFScfLOCMBOZWk/BDegwmKO4wgxGgR+iD1y1PfTs
	I/gI4LsA866d8Ub/RKmo4ax5xTgTAAK8mdurLC/SK3A4lirKuOpGKRqe2ppEh4c5
	1g8AiBD833T+OREgurIV1ZhW6AM1jlN+n6qwC75NZx+nhsWOF4XFz7GXVGZBJXm2
	nZPE02/zRfT71Rp6OsfzS5nrTjtEQJOhCZW0u6gBMUz+y/GshRyR/ilRZaG6HK6B
	fcHZNk5B5gJ3Ftxpqx117rOwZr8UGT9YczA==
X-ME-Sender: <xms:1MapabQNtjBUZFrerznTLzrtIgVoZdq8fr-W0jDQlUe4XEriV2BYrg>
    <xme:1MapaUOFlbng7Q2D7RT75dp_7GddtZ6TkXcpbN6qAPPQ46MLXYsfPlmwrq8zeu2Al
    LXzI4fJRxEEGbR__PhzlohB7Ly117qYUh7v3Ybmrx8vqYJOWDb_W4g>
X-ME-Received: <xmr:1MapaeP3pYIW3dvgBsb_h5DW1lTj_D6oYJhvA_Lo8quaHY_1u4YvLInHElVtoAV7SCVnmjrfmN669nFNM1Mr4Ul2aHiVy_fliemLqoyvE8rC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvveffjghftggfggesghdtreertderjeenucfhrhhomheprfgruhhluceu
    rghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    ephfekhfeugfelfeeludellefhkeetvdffiedttdeuueekhfeiudeivdefueehuddtnecu
    ffhomhgrihhnpehophgvnhgvmhgsvgguuggvugdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggv
    vhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    grshgtrghlrdgvsggvrhhhrghrugesghhmrghilhdrtghomhdprhgtphhtthhopegsihht
    sggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrghdprh
    gtphhtthhopehprghstggrlhdrvggsvghrhhgrrhgusehsvgdrtghomh
X-ME-Proxy: <xmx:1MapaUsBbwV8kujGU8t5Q_bZhJQc0EZ1lsn3XFdsGyY8JQmbUZ_ttA>
    <xmx:1MapaYVq8rBeTQCbZmKcwH53hIgfSGvn2oq4N2I1sqHgwbPdkq0RZA>
    <xmx:1MapactZGLZ6LKl-y2CHRzwUAJ3Le9-SL5fC_ynLdG0HAt6Z9f-pxQ>
    <xmx:1MapaUWnAajREyGxhDpRCYs5FLDtfavR5BujzoP2DFvSpHJwTJsf8g>
    <xmx:1MapaUvgUVtvR5Rp2oZ4GUP6--6cWX39LmFrVPKbSOh9EqPo7P-xc7YY>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 13:09:23 -0500 (EST)
Message-ID: <908075bc2ccd5263264d7e7602bb8af3f129e4a4.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH 0/4] fetch2: add alternative fetch
 method based on curl
From: Paul Barker <paul@pbarker.dev>
To: pascal.eberhard@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Pascal Eberhard <pascal.eberhard@se.com>
Date: Thu, 05 Mar 2026 18:09:20 +0000
In-Reply-To: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
References: <20260305-add_alt_fetch_method_curl-v1-0-0d0220e5fa59@se.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-y1sWGPyRd/lp0lHdGx4I"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Mar 2026 18:09:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19116


--=-y1sWGPyRd/lp0lHdGx4I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-03-05 at 16:32 +0100, Pascal Eberhard via B4 Relay via
lists.openembedded.org wrote:
> wget fetch method is used for web downloads with http, https, ftp, ftps
> protocols. wget cmdline tool is missing some features such as hostname
> resolution by the proxy when using SOCKS5 proxy. SSH tunnel provides
> this feature for example.
>=20
> This curl fetch method is based on curl cmdline tool and provides the
> same protocols as wget and supports SOCKS5 hostname resolution.
> This class inherits wget method in order to avoid code duplication as
> much as possible.
>=20
> wget remains the default download method. curl fetch method can be
> enabled by setting a new bitbake variable:
>   BB_FETCH_METHOD_HTTP =3D "curl"
>=20
> The hostname resolution by SOCKS5 proxy is activated by setting
> environment variable:
>   all_proxy=3D"socks5h://...""
>=20
> a patch on ce-core will be sent if this proposal is accepted to
> conditionnaly add curl to HOSTTOOLS variable in meta/conf/bitbake.conf:
> HOSTTOOLS +=3D "${@bb.utils.contains('BB_FETCH_METHOD_HTTP', 'curl', 'cur=
l','', d)}"
>=20
> Signed-off-by: Pascal Eberhard <pascal.eberhard@se.com>

Hi Pascal,

Adding a second HTTP fetcher to bitbake increases complexity and
maintenance cost. The behaviour of wget and curl is unlikely to match
exactly and so issues will be caused when people switch from one to the
other (for whatever reason).

Is it just socks5h:// support that you need? Do you know if there is a
bug/feature request open with wget upstream regarding socks5h support?

Also, do you know the minimum curl version required to support socks5h?
This may be important as we support multiple distros which may have
different curl versions.

Best regards,

--=20
Paul Barker


--=-y1sWGPyRd/lp0lHdGx4I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaanG0BEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0btZtAQDGkEGM0eCQJJWXtiq0d2uDtHPZNa5kgTnF
+vm9tHFepQD7BJ0A50kOck/UcqfNaTqPtSO1ZKJIWuLqQhOGlHt6VQM=
=Ug4i
-----END PGP SIGNATURE-----

--=-y1sWGPyRd/lp0lHdGx4I--

