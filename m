Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0ECC43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 08:45:15 +0000 (UTC)
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87985.1782722711535807323
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 01:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=B6WWbFt0;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=ZCtwbaUI;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.145, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B1D071D0007F;
	Mon, 29 Jun 2026 04:45:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 04:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782722710; x=1782809110; bh=Yi1y8HFCp1
	celJPUFZSKRy18XvPsxsD+g4cpDqRWFw4=; b=B6WWbFt0SxWx+4PJTNAtz/ma2/
	G0Fex+thGx1CehLRm6tRVYuwSg4L7qccYK5Q9fmtsRRBFW09IRUZ15cTgkKg0f+l
	x12c9jSlplyqTMjTJR/My+ghJuCpxv/22+mkLcVuV+UzTTNDc/qEenuJtLl/Frr8
	BYPAuFYpCqjx1ViwcDqRHT4kApZHh9el9JmVUMC5qQpSzw7FIn90DcZbLAC0CS+4
	Hs0Fb+nLpvmvBP2rKzUm9xhtvZVqPaMR4Mqt/LPGWLP6oMV3zAcTjNiweqko6yNP
	youHvQnrspVaNqYxeLHUEZnBBbyhtL5X62Mu8LjDit+G7ww0B7EY0twutsWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782722710; x=1782809110; bh=Yi1y8HFCp1celJPUFZSKRy18XvPsxsD+g4c
	pDqRWFw4=; b=ZCtwbaUIi4G9Ms4M3UpW1IP1KZbe+smeyY3U85Ozi7B1jtFT3IK
	Gth8S+oqtVQVi4ARexG+yzxjEUuGNskvCEpTWrZ0lpO/SQw7gDCcHMIGIYedyjbp
	Rhf9+6amSD+hKbuLbTgCpPU9un1YS4OdRZ1un6dCMmkHG3aYEyAODe1T9tIHVBlr
	lIiPuAf6va5Bnpi0FPnYCO1NlVHpS1kEbb/Jy2d3wwWsM7N+hGQzwWau6KBN8XUq
	rfJjhhTGkMYGQ1pimqeLgfd77SboJkvyL4O7jvnpaXuFDiDjxwLSWtGprsAQpETs
	qVcXp2lr6OmbVv4s9c2MUp+gKV1+wtBqdKA==
X-ME-Sender: <xms:ljBCall9wWqkmTk_ToyeRqQVtEZ_MSB9E81JcSOHC2Pb-1BMga_n0Q>
    <xme:ljBCam30n98hOudi1-8X6mTFLkxRDuXcbqJ2XWLn_ld_2TFpt8W1lT2_iwuZIEycZ
    iLJqGNX26lHDyBAF5R5AZwF47khdO-IV5aflLL6ZlWE7IbypP6aSYQ>
X-ME-Received: <xmr:ljBCapT2efsF4sbAtIo996tUOVT7l8oGerybn84vzml25jBjwPyMUr4ZUVkN1G80NRXn5Ga2udVV_Se6uF_MtVH1F1gGC2S0win0mzI>
X-ME-Proxy-Cause: dmFkZTFIYtUNKQKZ7CxMXP8e3FQ4IN75FjzZEdObQjCFeZ5IVt2T8mmZy250zjh9k4Ylug
    YpwCX0xjVetHZVOpsokMsqAdxv2+J9ygl514CmGZZ9nJFvG+XfTbYMSy8dLUO28GlOu7sF
    TUILdBtQSS8DtzkALGpcg9/ZKrxKQLMAG2aNpz/w3N2IPrckEo+BhU2KT7+dYjpz0/sQlv
    hqcLIGpf5VcF0/s4nxNUrvNT0ix2mGBYQH3k1l9Qbu93o3XlwCpZrfu1UwqBgiQaSYQDb0
    M1pgee5efZtMLEUuQ/2K/SfLBR1wopbQuPa1gVlirvRk2TlR3zN3Ye6LX/VreUYw/3bue0
    OfqvQ2wBr37xHAPVtUql4TafHcXX18zAgLqY/U3SM5OP/Ym6kD8cLsz0oLQBVAnecIHVHa
    dZkXQEzNVy+WZm0rrrH9EitI0tzYH1eLIUY3U6MONYdbG6s193ly1EM21mu1KYXmseo8Z2
    tUq2EIzu40Ri7k06Yy/iVCDQ8/H9Yy3nUPRI9jCuZ2iccHJJV2lhYIx4UMS0E6Rxe7lfwL
    ETdAGhXLYEHJnuheGjD5L8G0yryN8bBpLnWvX/pcNgElr+6wYExi2/jJ/90dCLbIWM4xMs
    qCx0sVlgMjPu2F0GHO+lPM4qrKrlGNoWMk8wxxvsb5KonovJwz2Hqp4F65Yg
X-ME-Proxy: <xmx:ljBCags-wXZ2bpn1yx3MarR3wG_Y3V8tsqkYf3_zKfxMwTl2c0ofDg>
    <xmx:ljBCambK79OKRb_a5iwe4GJ36lFZBiX37Aq6G_C1VWTpQhWyZLZCcg>
    <xmx:ljBCatu8kFSfRDzznqNzi82uCzJxqZfK5jJwe6Unt0CPe9lSDldN_A>
    <xmx:ljBCagHexepFwxmG3XQ-DFv9Uf4Aoo7ambmNNOD0yMhsKGqa4EqoTg>
    <xmx:ljBCanFQFASlxc5ZRteW4xMTgZ6nddJXn3l_QT40LJXHb4MHcj3tvEDN>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 04:45:09 -0400 (EDT)
Message-ID: <7aee6564b4eec81ffb64526a3c82820a8d0d0f60.camel@pbarker.dev>
Subject: Re: [bitbake-devel] [PATCH v4 07/11] Add vendor patches
From: Paul Barker <paul@pbarker.dev>
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jun 2026 09:45:05 +0100
In-Reply-To: <20260624-add-pypi-v8-v4-7-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
	 <20260624-add-pypi-v8-v4-7-ff499f1fd5a5@windriver.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-sv8BLRs5jvur+w/4xLHa"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 08:45:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19801


--=-sv8BLRs5jvur+w/4xLHa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-24 at 10:20 -0700, Rob Woolley via
lists.openembedded.org wrote:
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  vendor/licenses/ply/LICENSE                        |  32 ++++++
>  .../bs4-0010-lib-bs4-Avoid-soupsieve-warning.patch |  40 +++++++
>  vendor/patches/bs4-remove-double-imports.patch     |  23 ++++
>  ...lib-implement-basic-task-progress-support.patch | 126 +++++++++++++++=
++++++
>  ...-initial-pass-of-SPDX-license-headers-to-.patch |  80 +++++++++++++
>  ...gressbar-accept-value-over-initial-maxval.patch |  55 +++++++++
>  ...-Add-self._fd_console-to-use-for-self._ha.patch |  54 +++++++++
>  ...ar-Make-bars-show-correctly-with-maxval-0.patch |  32 ++++++
>  ...-knotty-Allow-mixing-log-messages-and-pro.patch |  32 ++++++
>  9 files changed, 474 insertions(+)

Hi Rob,

Thanks for sending this series!

I think this commit needs a bit more explanation of these patch files -
where do they come from and how are they used? How do we need to
maintain them going forward?

Best regards,

--=20
Paul Barker


--=-sv8BLRs5jvur+w/4xLHa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCakIwkREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bqXXAQCsdw+KLMm4p7PFgiyoOgwPM4RSeyz4XMYq
nejC/duScAD/Y2wpgpOYV+JnedgVPUpTsESQm9rygi0YoDYqH/uMLwk=
=aJde
-----END PGP SIGNATURE-----

--=-sv8BLRs5jvur+w/4xLHa--

