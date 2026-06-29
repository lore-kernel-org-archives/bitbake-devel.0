Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6EC43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 08:58:35 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88105.1782723512701637443
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 01:58:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=gpVlGbvM;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=cBzlp+zb;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED47D7A00DE;
	Mon, 29 Jun 2026 04:58:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 04:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782723511; x=1782809911; bh=AmEm5t+Lw1
	BX45ctvQKzWjviF3HN/aOZS1Gb5WWo9TY=; b=gpVlGbvMs2zwtRaug9JVOJHnmt
	t3IzFAQF39TdED0vU6GZW4U7RzrJNzDgEvkHwbPldWkoV2HIaox6RbuA22VJt4DT
	mPpFnIq8YRsaloxRZP6r5SIip8KHZ98IyOiipT/GDEw8FzZ2MwWk33cYAMh67EqQ
	AzHG+rbtOc1feYmBtpChGM4pSXlbt8aOXoXZrx2hQv0t+dxKc2tabkueR1+IRNak
	eRVzhoAd9s3bdZjaAfXrkz/RU05aKf16TCe8Wpw4Hcf/q1UjRix35Py/1M392jzF
	aku+baRRFua0CHHzzIWprMuVd35vhIdGxjC95KSsQNAKXU0oB40ZALsoljJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782723511; x=1782809911; bh=AmEm5t+Lw1BX45ctvQKzWjviF3HN/aOZS1G
	b5WWo9TY=; b=cBzlp+zbYlYumA/1hn/5KQEHEDmicpH/YZWQfb+jL+cno3RHygG
	55kwc/qTn07v4EFY7D7qgtgmWOVKXBk0i5M2yUODZ6mcbGDAMFd6sdl24PcaIkxg
	Uh9o7ZOl6JDF7yQhcNhbYz7ypeEeD6BTSkOonIwfzIIBRxkos07/LZ/BKfPDQQPE
	3mkcKSk6beS/WlqZPRkHbKYz9b17hT366fsIriNS3gmn+/R7cnCfoVJ5Y1Yjh68O
	he4uHk+gvUgJ4Q3mEMAgxx8GzR+UsMGWk2YxslT9ux0tijQivXxwsqwfaKBAbk/y
	r4YpxPCXLWfxgllpqNMjWOfCHA3Af9T8qAg==
X-ME-Sender: <xms:tzNCaugIVh_1T81lqmTFMIp8Rpkxq0NsPhqXrwK4e09VYSCKgxUkuw>
    <xme:tzNCalDaFeJt4ejnv0EJ_0zvJ3b04jipdsS92iPKAlHB-pSas_srI638VT8eUF3z0
    vR4yLCrM5PjcWlZMcncws7_yTY2zMJD6M7OpI1BvC6o6rtiNwM6SUk>
X-ME-Received: <xmr:tzNCajvKeru_yfTvd3C_gQRNWdFciaKbz8A6wwL2CE5zJde8AdxwLn8Lmia3Vv2D5_WqBWsVF37C3w85XmwLhYq0XACTGgTKPoA6yiE>
X-ME-Proxy-Cause: dmFkZTFJ/G33JyQDLsCrLY9t3weqZnMW23aCN5NU3QMxzo3w04Hph4EgVtE3Wgt4aIr9BW
    JStD7Wrp0Eruds2k05ChBEEfD32THqQydLQT8mue8Vt6PlKfv4+6Xd3Y3yxhsxocuu3xRy
    ftwJLX656zh+PD19uZMx3x7l+KhB1q17hD6U8Pjt/RdwXUda5tkNlBjR7NY9ot0x+nHkbd
    34HzI5foMcM4CDeDBLkqFvhanFZ3ayxPsE0ON2dU1mM+cLEkCy0TAPzKy85rQslCk7ozev
    lzUTzKRPVmzbC42XFiEzFqyUY/J/pZmB1oE0z9UIN2RUdrMgvQLRKzdub1XZdncExCq6oM
    Ofa0N92UIGWK6rBlq471zAqtFRmENUuSpGnbFlvPaLphinTZfBExy362N07HuuJc2SfBhu
    O3DgnQ/2SycMGflwvaDmNN3h12/QO8lENKqJT4kLwBADoXj20gBNcTX0hEw9oSZM4GcN4q
    CyUz0U71CxX2yzWzjf1/TQx+bjrKWdDfM7e4uAB96NKaAha0TEDcShpxt6ELviVPAygYV0
    Dwv0jMDdToMuy5nU9yM97t9MtZyxGCCPC4MbsPK10zDLDL0cTYWgqdjYPmR3idbZ95Z3RB
    gM1TR1z/X1rgcHIXJb+NIO2CDK7/1LXsMfZIP2AC+RTs9mC87helPBkCpo1A
X-ME-Proxy: <xmx:tzNCaiZmN-Xjsm2lAk2r2DcbFkj0H9mULzWq8lsJQd5GHg22Jk9h5A>
    <xmx:tzNCauUfK2cJpO3TJjmiKCQqOVo9MmftYOCJ3ArWchHWxevZNhqhJA>
    <xmx:tzNCau49uEascyxc8WZvIqrAHjFdRyVaMKg8o2BrqJuJ44cYvmE7Jg>
    <xmx:tzNCahjlEvt6pmNJumgXmlVIUhJG9idfgsOk0ox_zqF3gwxl8JDLUw>
    <xmx:tzNCamAC3mSFpjYBbl1lhyKc4cJCC3UHiB42-X96S39lniKcnqtpnB0y>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 04:58:30 -0400 (EDT)
Message-ID: <66a2be8cfe4e8557339541020136bbcdde269fac.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH v4 10/11] Update typing_extensions with
 vendoring
From: Paul Barker <paul@pbarker.dev>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jun 2026 09:58:28 +0100
In-Reply-To: <20260624-add-pypi-v8-v4-10-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
	 <20260624-add-pypi-v8-v4-10-ff499f1fd5a5@windriver.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-emEWW22PIHrF1+kucNgQ"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 08:58:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19803


--=-emEWW22PIHrF1+kucNgQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-24 at 10:20 -0700, Rob Woolley via
lists.openembedded.org wrote:
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  lib/bb/_vendor/bs4/_typing.py            |    2 +-
>  lib/bb/_vendor/bs4/builder/_html5lib.py  |    2 +-
>  lib/bb/_vendor/bs4/builder/_lxml.py      |    2 +-
>  lib/bb/_vendor/bs4/dammit.py             |    2 +-
>  lib/bb/_vendor/bs4/element.py            |    2 +-
>  lib/bb/_vendor/bs4/formatter.py          |    2 +-
>  lib/bb/_vendor/typing_extensions.LICENSE |  279 ++
>  lib/bb/_vendor/typing_extensions.py      | 4317 ++++++++++++++++++++++++=
++++++
>  lib/bb/_vendor/typing_extensions.pyi     |    1 +
>  9 files changed, 4603 insertions(+), 6 deletions(-)

I assume this is the result of running `vendoring sync` after the
previous patch, am I understanding correctly? It'd be good to document
which version of typing_extensions this pulls in.

Best regards,

--=20
Paul Barker


--=-emEWW22PIHrF1+kucNgQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakIztBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bpupAQCKMO7IOQ85tqRzH+CLv0RpUDtO5jb5i4D6
2c92bOX0BAEA7x2E2qOsV5yBU9JuoJ2GxXjs4pIkU++Y346N66pl2w0=
=OKZP
-----END PGP SIGNATURE-----

--=-emEWW22PIHrF1+kucNgQ--

