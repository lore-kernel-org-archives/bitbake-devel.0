Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86472C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 08:55:55 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88082.1782723354955024134
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 01:55:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=kl843yyg;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=DbuWcXpN;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F2F257A0065;
	Mon, 29 Jun 2026 04:55:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782723353; x=1782809753; bh=zhmxGCVa2J
	mt4yZieEOD0IETX9nxpUJjplJrgWa6ss8=; b=kl843yygWM/gDt3AYnworSjlnb
	OU3/DUacJSFjrydkcwSKTZ9Aszp2gSTd/7xQbcIWXk9gvcnHzxAwgZb3LMV6KShL
	58PQWFNNxd26CD19soCc7AVsUdINnucWb+TbkmXNbk+4Mq4eiB7wR7C9KdakriFr
	z9mE71+qkquoKgx+gnEX5WQZVa8EF4KWcxz861tCLQHJBR1xhLjMJoEZWyRxb0IA
	yVr9bLsh6cFTsnTVQdrKglSLx6b0jyBSxb7phKokWmvGQmWQdIsZzgZJBSB1A4TW
	MFLzirIz8kfVKld4DzjxEiwIKZ98t5rwaylbTJ7/aajpJ+/coDp6GZS/rlLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782723353; x=1782809753; bh=zhmxGCVa2Jmt4yZieEOD0IETX9nxpUJjplJ
	rgWa6ss8=; b=DbuWcXpNJk7fu0ZJiAFiw9GU4b7C7WZxOwMAaoe5fDTDedeGSjg
	OEFZmkCsnq0YQZSf4JhcZkpYIlm73Xsbr+Kzbs096uznhLulESHRZH14+r65wAVq
	X/4irjawuLhABifVxcc4AY3+m0rSDKRKTQ55Cr61yihk6BSYbqsu4eW2WxgGDtwS
	mB/gmNzuuv87D196QYYIlqdtjLOpv1JHTCg097M6EgUjvXoqcgCqzS8gz+gSOLUj
	bb7LkG9gIV/lA+/2jMi8YGyQ1wprXeb3cKK9yKxUBLhP+raPsgXi67mKj6YC3WAc
	WW4U5fyXLLqi0EcNp9LuF7jAVSBYRZ1kQHw==
X-ME-Sender: <xms:GDNCaoLIcBVnjqV8cfJou6rpy6faW4w4AcZ-fCufqboCswVTdJ2MfQ>
    <xme:GDNCauLKleHjXbpRB4CVkx52a8XUf3lV9XnD-Vt7udX6nhMxZwY0C-W1NQqjJGJUH
    5qFUl7CY-SRYWShag8OnbBAJomef7MqH7rj8weBITqZhmhdiWZVM3Y>
X-ME-Received: <xmr:GDNCamVkr9nbQegZ1X3iRcxFNf7a4w0177-wqgKRW7JPSDtt-U1MNQnpxUAPAmOzLnnPM1fp7o1yY1KnHwTqzJeHbCrS8UkIEH2iTQ8>
X-ME-Proxy-Cause: dmFkZTFPaDs3aJbp/d2GT7rPNKgqLFaqHB54NdDGSxQX37E9YRiVtcj0TLrb0AMSc0JGQE
    ZtcyGnA0wTGywesIDrTE65IDlrLl930pqvPiU9SDylYdtCqFqIM2EP4PZbLJc3LFmzAV/c
    eKzUpPw8Yra9bF246Ef+xWYyk6ypybMYGGqFzmiCGLyrPyRt8l91SctgeI963wK77guehq
    npYb9gLTkvL0y0809m47aSQ5omAL3S3GvYgTX3vfvzIlfGxC8xNkydJZAL1jOuTmYVUciX
    ZqPCX1cMhw/s6m1ESCkZgf7EkBIm67tluzIrJlGrJXhiAP4GUwdbJsSUJxOZ5XLEqo2IB9
    8RgqzYU1L/YDee6JyayzAWpuLzpad+DP0ZYoF5ieEKrylFlUgDkkEisTXT9+R/ft1M3+1O
    ESyIwcGm1KIa1oEafAdzx+yroKHWrZ/dn7FXf3Vr1LgEbfLjgvl8Y5N1LN2RXYarG43vSO
    Dpo0IaQ5DEDNRokeZT4zz4wHW6Y4GuTFueubDKgO1v9F2GKV0WhXP2eeAqXgqcC3ixktKy
    KGvS/OLEf9GVUDeuZPqhBx5l/2Rat/qjNOjqtiXFuP5O6ywCF6PczVRxqyVIiKdtCdJX0I
    kNtzoiSA/qqnc+tOmgahgJfb0QOTRSCb9LJ9dMYtf5hZi8pI7+TBDPZnRbQA
X-ME-Proxy: <xmx:GDNCagjG1o7SVZeYHS-RatDNPcIInNblEWCX7kxQpqvHSRn22sRw_w>
    <xmx:GDNCah__gzDwbPWQ7r5Esr55fEqauzSNGyyB-SQ8uTSvjxaAZBrYOA>
    <xmx:GDNCaqBlle_xwnOHG5J4x8Z_QPRYQyrPCeMzAD1Y0Xj8HGexR6TT1A>
    <xmx:GDNCauK3_oYslSCyaCNizYCVaUrVG1LpM2SkTp6hdNMTk9cQYDx_GQ>
    <xmx:GTNCajrQAl7MfWBB5X22gbyVPiM6XpnvMw3uemlHMeNQJ331j-F7ANT1>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 04:55:51 -0400 (EDT)
Message-ID: <50069e374d8feb205f8d34e7ae5b378cda03a544.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH v4 08/11] Update vendorized modules
From: Paul Barker <paul@pbarker.dev>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jun 2026 09:55:49 +0100
In-Reply-To: <20260624-add-pypi-v8-v4-8-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
	 <20260624-add-pypi-v8-v4-8-ff499f1fd5a5@windriver.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-L4iYHn31vxE7QonALZNQ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 08:55:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19802


--=-L4iYHn31vxE7QonALZNQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-24 at 10:20 -0700, Rob Woolley via
lists.openembedded.org wrote:
> This was automated with "vendoring sync .".
>=20
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  lib/bb/_vendor/__init__.py                         |   18 -
>  .../{bs4/LICENSE =3D> beautifulsoup4.LICENSE}        |    0
>  lib/bb/_vendor/bs4/AUTHORS                         |   49 -
>  lib/bb/_vendor/bs4/CHANGELOG                       | 1839 -----------
>  lib/bb/_vendor/bs4/__init__.py                     |  856 +++--
>  lib/bb/_vendor/bs4/_deprecation.py                 |   80 +
>  lib/bb/_vendor/bs4/_typing.py                      |  205 ++
>  lib/bb/_vendor/bs4/_warnings.py                    |   98 +
>  lib/bb/_vendor/bs4/builder/__init__.py             |  828 +++--
>  lib/bb/_vendor/bs4/builder/_html5lib.py            |  592 ++--
>  lib/bb/_vendor/bs4/builder/_htmlparser.py          |  426 ++-
>  lib/bb/_vendor/bs4/builder/_lxml.py                |  387 ++-
>  lib/bb/_vendor/bs4/css.py                          |  268 +-
>  lib/bb/_vendor/bs4/dammit.py                       | 1622 +++++----
>  lib/bb/_vendor/bs4/diagnose.py                     |  169 +-
>  lib/bb/_vendor/bs4/element.py                      | 3494 +++++++++++++-=
------
>  lib/bb/_vendor/bs4/exceptions.py                   |   28 +
>  lib/bb/_vendor/bs4/filter.py                       |  764 +++++
>  lib/bb/_vendor/bs4/formatter.py                    |  211 +-
>  lib/bb/_vendor/bs4/py.typed                        |    0
>  lib/bb/_vendor/ply.pyi                             |    1 +
>  lib/bb/_vendor/ply/__init__.py                     |    1 +
>  lib/bb/_vendor/ply/cpp.py                          |  918 +++++
>  lib/bb/_vendor/ply/ctokens.py                      |  133 +
>  lib/bb/_vendor/ply/lex.py                          |  845 ++---
>  lib/bb/_vendor/ply/yacc.py                         | 2231 +++++++------
>  lib/bb/_vendor/ply/ygen.py                         |   74 +
>  lib/bb/_vendor/progressbar.pyi                     |    1 +
>  lib/bb/_vendor/progressbar/__init__.py             |    4 +-
>  lib/bb/_vendor/progressbar/progressbar.py          |   21 +-
>  lib/bb/_vendor/progressbar/widgets.py              |   14 +-
>  lib/bb/_vendor/simplediff.pyi                      |    1 +
>  lib/bb/_vendor/simplediff/__init__.py              |    2 +-
>  33 files changed, 9570 insertions(+), 6610 deletions(-)

Hi Rob,

Is it possible to capture which versions we have of each upstream
package we have after running `vendoring sync`? It would be good to list
these in the commit message.

Best regards,

--=20
Paul Barker



--=-L4iYHn31vxE7QonALZNQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakIzFREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bh5TAP4sZ5E+4IhNUI/1Q8ASL2hM71yIpOr4pdOO
rQurZbBGagEAv4B5jbdMWF/3QekrC7GSkVT4DDP8K9cLb0k6ht1rBAw=
=Tqq1
-----END PGP SIGNATURE-----

--=-L4iYHn31vxE7QonALZNQ--

