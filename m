Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A376FCD4F52
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 10:31:47 +0000 (UTC)
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5624.1779100306202551162
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 03:31:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=pqR1mcMa;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=aiYWb9UQ;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.156, mailfrom: paul@pbarker.dev)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BF607A005F;
	Mon, 18 May 2026 06:31:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 18 May 2026 06:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779100305; x=1779186705; bh=MoB5dwXL6Z
	CcFXgS8wIC+TLlw5TIE+T2byx+CGXUGm4=; b=pqR1mcMai6DUoFUdqDw5/Re+Xb
	cYixgcHGXXXy25P7BczQfQN5RpKDN71RrImOp2vg7Qh7i/0paVlxcAV1MvL1v9PW
	pud0xFqRQSzWkuhlDQ4/JEO6c+Tchhx2/r2Mum+Owq3sjtQQFZ+arcCnG7HSgOnK
	uNjtmBxqTvqheTa3xA7oa8tYXQKGGbqK4uKQhLvQerH0gMgRNJR3rgewyz4AecwH
	S65xmEh7feKjMn3UGVslKy2mY7BeEYhJ1FYIUuBXKO2D02W6NT08HC7JzwygmNnS
	WNLnjccLqbxOXr21KCmeWYo+dIco3N1/cxuhwZaXIJP8/aw6jRbFlZnuYu5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779100305; x=1779186705; bh=MoB5dwXL6ZCcFXgS8wIC+TLlw5TIE+T2byx
	+CGXUGm4=; b=aiYWb9UQkVvg21V22HlftQqs7EdFZoDyjq5fHCXn2klSbGZh3Rc
	mnhRfdzsGb1o8VpKIktisACiqnkoJtZWmYSO3GA7UQg8VxS2gWmcmgvh+72WHSR4
	4tShAKSRYDVq/mq+ohDrCb1QJ2qvRayltPnuYFqhUkNunWSnDe/ygbjGOoo1CkO4
	bI8zVMxW/+0hQwh3geTTMJgijg5wvn7Rs5NfpCA1kqFZPAlTAPyo5/UgZvRGr2sS
	zttAv3wMRJgsOhQ/rG0D2mi1RQir+ZxeXt84iRJxAPBsWDvSUo6aub34ruqp2+2s
	rsD9jGEEQL03TjHE/64rqG6+4luhGUxKwCw==
X-ME-Sender: <xms:kOoKanfVyhWAlpK3olZmS7-_YIfyXq0Q2mIe9_uDOi2bLVLiuWLU0g>
    <xme:kOoKajNtbVfouInp73iCz50WB4kK9gwE0ri_tdxbEKtd6tPT07VTVRv4cj5DnACba
    _B6hm_ZfzzVzudgnSIkoEbmCI5hIrM2KS2pAZKesm8vLufIBi-65S8>
X-ME-Received: <xmr:kOoKauJGAKMylAGN3F_AhT4jKjFFCIRn2g7gB9JM6VQGVNS2EUn0NjtWToOFP6bEbfKMOJSVlAEHxa0inJMANL6ecGbGm0FA9t03qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkffuhffvffgjfhgtfgggsehgtderredtreejnecuhfhrohhmpefrrghulhcuuegr
    rhhkvghruceophgruhhlsehpsggrrhhkvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    egfefhudethfffveehveekjefhgeffgeeikedtfeektdethfduvdffueeiieetffenucff
    ohhmrghinhepohhpvghnvghmsggvugguvggurdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghv
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehquh
    gvnhhtihhnrdhstghhuhhliiestghhvghrrhihrdguvgdprhgtphhtthhopegsihhtsggr
    khgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-ME-Proxy: <xmx:kOoKakGD_yKhzSf1SeZDAXpjJl1bJQluNVLDsqUVDNpiCeAXdAToSg>
    <xmx:kOoKamTGab78kaVDLLfbE_UTkrWo4cKohFcJAPLzL7G7jo0g81c5Ig>
    <xmx:kOoKagE8D1U-QuJseBPdSGPMypsNGBtBxhZNAHNX1LI4dC3_PSwqkw>
    <xmx:kOoKai8l5vG6UN9F1BPrcplQSkyXgENqcphwNCVPLlVI1gvaFk1X7g>
    <xmx:keoKapHJDuje8YrAjM3AkZLv_FK_6S9yfh-deAtqLGCQjdxsFtiRFUNY>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 06:31:44 -0400 (EDT)
Message-ID: <1396d06122a97c5e712b1d15f36c6b841d07187c.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH] prserv/Dockerfile: Update to Alpine 3.23
From: Paul Barker <paul@pbarker.dev>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2026 11:31:41 +0100
In-Reply-To: <b3f4a0e2-7ea1-49c4-9825-377b94e3b788@cherry.de>
References: <20260518-prserv-v1-1-9625c3239954@pbarker.dev>
	 <b3f4a0e2-7ea1-49c4-9825-377b94e3b788@cherry.de>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=mQINBGC756sBEADXL6cawsZRrDvICz9Y1SG0/lW1me4xpq36obh7a0IGAzp3ywNRb/4MO
 DTqP4+DD0cIFuDY41/N17g0sNlp8z+/k/IIDmNPtYQOTVmAkrkdDU4BP8dD3Cp1PUw6nrbInfujAJ
 NrVM0IVDkwKTbL2Nu1P+xns4MIpF9Kj4XN5celYJ9vEJ2n0Bo0nO5T5vg46dihIaDl+24iNIHSsHq
 YyEdMBfY8kY2RulpaAyFOuaaHdIeDkejVvO5xLSiYLjB5qrRhgH134lJXsuLOsFQ64ybGECuOasnb
 auevsPBAaroQW0pqVb9FneGrWHxMCLlQHJRqQJRdVa6bsUdp6NWra8/0msPawSrFwGQdfJBTA3aXJ
 C2CG1JxEgj6QQjEQA49DSjgzdhInbiIK8Vbp/zedM4aVue7qJnwPMTFQM9lYx63b7wLN4Tu8B9YZ0
 UFdSwMCJuqmYGsYRUYdwM3ArjS0VO6WpU+HBKvzLK5GQfUTSM8KaZ5eA2Uo2ain8SSZb+WptUYKpx
 F9jbtCPbjpZKzGuX4iHFl9eT75TM9iXJNGAjB5xigkADLwVfPoJ5E53S+KdNVuOWHugyLMPNAQHOw
 pw5Rey+0zxyzPd4wphutc93UIU5g/029ngAc7DuKCq12jl7fhkjqFlFtYPIc1k7nd+RSezmH/qRes
 bMErHSX1MBSZQARAQABtB5QYXVsIEJhcmtlciA8cGF1bEBwYmFya2VyLmRldj6JAlcEEwEIAEECGw
 EFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQEWIQSYsqrBAKw/grtdVGd0l1yBt+ZrrAUCaWoNAgU
 JCxiQFgAKCRB0l1yBt+ZrrLhdD/sH+qTaxCDUg47eW329yJWCDZmO+iuYzNSyHMs1x0DHKNIQQ8zN
 pA2S/de4jElQuPHjw/IS8B3VmM62Wuq5vHuxNlFv9IMwrwqi6zhCDui8+nCN/AQGGXousJI/SeZjm
 Y5gS9cqh4vNY+huqEEfdTFXIfTBRkmnvYozSO2uDB3EMuiWgBlw2uLrtmkvPLn/m/GvEouLNox6wv
 tcJcIbL59a0+3jv/m7pnWoZXOkWmKQnfFWikqjuKCISNU0gzBSL4UOj8gtQ2z+vu7ffi29b6SV5IL
 m1yzdbkigEn4HL44lz3N+oHZ3wWsRqqeyGSX5fCfx3tGWg6scZQrpsjT5yq+LiffiXVNpjeJ9KzQw
 0cbAZ/9uhk1sWBroP+/gMhsWjlbFYXVlRvkNKGPI22eZtOEz4jF6OrOONyOoY3i26niJUyIgdBpca
 H0hKUSVQ8VnG7qVTNrQk9BbeoSszqRwViN7lfyVtK9b1TCFuGewOETGn0TPvSzruYCtD3CLm7mjuX
 AMBpIGoRUiCFVmF1hlOgqDyH4F6zRTHhKLpfmNzfQcg+Uo147Q2IHpoh0mJsL4FEZEI8hFyecX1Pq
 7HqnvxGD2OhCof1Z6LDxptX0wbgocnYFNxN5S1owcXZUQOFnzYLlLugrcEjlGCm4Gn7k4SiFERSBj
 UFsQgIhw/7lVVn4o4rQjUGF1bCBCYXJrZXIgPHBhdWxAcGF1bGJhcmtlci5tZS51az6JAlQEEwEIA
 D4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSYsqrBAKw/grtdVGd0l1yBt+ZrrAUCaWoNAw
 UJCxiQFgAKCRB0l1yBt+ZrrHy+EADNMt+ewz8H7BUKpEMMhpaA1VxyXO5IqlKXS0gElMgHYXl7L7C
 0/qLfRH96vwVD33zM+f0Vl9aWWkom/k8s42tLyPvX7D5zTrj3r5muJ+d9dXWGwBFXxXlE9YjSP26K
 bYfRusmRHbbEPlLPSnrr9KYS2FGVD6ViRNhhVguflgPv2i18+fNBE3YyByfNCiQgO/SgaSdh172Ql
 tuYE1Chk6FD45tCUv3dI9lO2PlVwrciiVYvIv/jiTDEwZOISOClTE/Ha18pxDJfLhS8QQnLWuBNX6
 HUkLi78fVmVYbcWIkTuSHjfNoGTMaFijMg9Wl6poFrY++Pl0S40681zEIrwZhW5pKoqXoaElt29Yf
 OwVo6BIsSOLEqKiWsdP7PJTaJYU1ovnshBcOmuXMgc13AjQ4AhEGqI1TaEJ/E1jEDDyTQFeWgrfew
 YaWdqpgiDmRMTj/tIGVj9iy7qZQICUUtlfm0QK6w6M7qq0GdO2o+S3uVF6y2AxQo8l9LSHiW9O35I
 juR37zeqv72puYyOteVYJsJaw999HUmhXc/X/J9FQFw8twxPKDLLu+w8MqDo9bhllzR93Zy/OShuG
 yGybcX3DKO2R+AQ90tXLbxKmHLtrnG/zyDPhLv/LGD480v5hEoT+IS0u9wPD2vP5q36a5DtzqXA/7
 t9PCamLoCvZLleg7GY7QbUGF1bCBCYXJrZXIgPHBhdWxAcGJya3IudWs+iQJeBDABCgBIFiEEmLKq
 wQCsP4K7XVRndJdcgbfma6wFAmlqDRwqHSBwYnJrci51ayBkb21haW4gd2lsbCBiZSBhbGxvd2VkI
 HRvIGxhcHNlAAoJEHSXXIG35muspk0P/1G08N6zGSdw2p8+8f/1HhaYEb9KdQHT1JmQfZUrIHIpD2
 ELNb91Z6Pz197d/igGpox1dzYOwE0WolWo44ZHX2yw+p9V+HJAUKRe0SPc1iNLkTzaAZ7oYJ1DnFh
 aaqZi4VtKKabKeorJjcDvl2apMwT0agRuDklU97n++ZUuXIEo1Z9uRqEvXz0iTSY7wPxwfoVOQsgf
 dN1cBLd9OpoOtJRdDJzQUYqjNoQi+5M6KRfBxPLZkmYb4uCGlp1H4AV50eC61j84LBg1ItvU2u+Fx
 X2JB7lHTswubprD2ZsSwp1VziU6pUj3vtslMWKpBGslpLtnaO561dihGyElayMd4VFg7VR/TsglJv
 A10EDs2DMhoYPfRQWvwlr5+jPP6s9H8KSTCGFvQt438rP/gk0lcEZUJK0iE2/yq5gQfaCNI5FLN7C
 q8LVr00oS4doXfmFFxMq6z1rs5SXZorWssjG7v5DILnPxLqYloQK/ebM5Ixbzm0Lq/8vWL7sw7yOH
 JVYCHCApGzKNii6rYyHdi0K8UwvpD++GCWLyvbgP/H3l5FqL63gAN0Rw1CO5r22+SmG7aOmekJH3N
 ChZPI3NMLnKZPJC8ZQZ4S8yb5oA3rqTA2DMODvsrEVlaB2cQ6IWHSa/mvBwA8Ias3771cp4fZS7W7
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-dcnav5iT/lOaeXXld7TY"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 10:31:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19536


--=-dcnav5iT/lOaeXXld7TY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-18 at 12:28 +0200, Quentin Schulz wrote:
> Hi Paul,
>=20
> On 5/18/26 11:15 AM, Paul Barker via lists.openembedded.org wrote:
> > Alpine 3.13 is long obsolete, update to use the current version of
> > Alpine as our base image
> >=20
> > Signed-off-by: Paul Barker <paul@pbarker.dev>
> > ---
> >   contrib/prserv/Dockerfile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/contrib/prserv/Dockerfile b/contrib/prserv/Dockerfile
> > index 9585fe3f076c..c630ce99722f 100644
> > --- a/contrib/prserv/Dockerfile
> > +++ b/contrib/prserv/Dockerfile
> > @@ -28,7 +28,7 @@
> >   # prserv
> >   #
> >  =20
> > -FROM alpine:3.14.4
> > +FROM alpine:3.23
> >  =20
>=20
> FYI, these are "tags" but they have the same meaning as in git. They=20
> aren't immutable and they actually are very often changed to point to a=
=20
> different layer.
>=20
> e.g. 3.23 currently points at the same layer as 3.23.4, but a month ago=
=20
> it very likely was pointing at 3.23.3.
>=20
> The only way to work around this limitation (if desired) is to use the=
=20
> digest value of the tag as argument, this guarantees that alpine:3.23 is=
=20
> the same from any machine and does not depend on when it was first=20
> pulled or whether --pull=3Dalways was passed.
>=20
> I'm not sure this is a necessity here but wanted to bring this up :)

Hi Quentin,

We do want to pick up the latest updates in the Alpine 3.23 series when
this container image is built. What we don't want is to automatically
jump to 3.24 or later without some human review as that may need some
other changes to be made in the Dockerfile.

Best regards,

--=20
Paul Barker


--=-dcnav5iT/lOaeXXld7TY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagrqjREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bsoNAQCoZ3+lKED5f3XQG9uzwXMMKWusDuKfaIfN
3+eYh4nSJgEA98Rd9gqkoJibYGKBsbLx8CYX4gdUFc1kbuPgbip9EgA=
=D6QX
-----END PGP SIGNATURE-----

--=-dcnav5iT/lOaeXXld7TY--

