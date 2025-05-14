Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A834C3ABCC
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 10:14:09 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.99043.1747217643949121585
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 May 2025 03:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ECGxEjL/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0ac853894so5806487f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 03:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747217642; x=1747822442; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S65dssYdjh+f7W0axk3evrLfWVa6qE6058OvT/YVAU=;
        b=ECGxEjL/YLtsQc+0mx8LPvMgLWHQlxlJxgfykNggDOue+dGnqAFfjTfsz7EWDXvkGc
         4Cb9Vx3Uq2hmHdLn75TvZuCCOYnsAE5sAxdsv0dhKv+HWLI7Qrn4Gw/1ObUBDIEf3y0r
         EUXS9RS89NhFI/LZhZ42WpvjVX5e9IdaWFwhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747217642; x=1747822442;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9S65dssYdjh+f7W0axk3evrLfWVa6qE6058OvT/YVAU=;
        b=ebeEfRJlK0L3PSxRhud3f4/xTduCqouFiTP2QPUmdm7Toc+0jv+ruaRak9Y/LkX9OE
         QozWMpBx9VVLG5kOBspjlLo1TB7GenqlokB14A76xf3CtvoTbwaOvOmFQk8cdvl3ayeF
         CdwyPj3Jcs7UbHD/ioiTl9uEt4mrpOAbIXJy9F2tNvrXzx2oSi6PMF9EQxEtdRfpq58r
         uq6xZBnuoZchgo3F/a6K410dSP+mzk6sFY54w/rxUYKATrqT44ofqz27XYk+56shqaif
         JndS2N+WSKJTcDTQBc313VATjVeIE67ztQSBPL5M57S+55QwD84tZ//AKqU2uxVAj+VM
         ss0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3jJOBYKveuM9FUoPBcutsbwslSIpeVvsWihwyKrDLzqO/bstvKEu0MVX73wH/BJSRDu+UR5hnviR8mGRJ@lists.openembedded.org
X-Gm-Message-State: AOJu0YyDkqv4a2x4ahXNLXLceHrB5zYeO3Y7eqQECCuyAMlySCR5JkOg
	KDJwFNz1E7bwBkhV4P/Rk9/OShkVbE4wERI7Sqy9NXLKr1r7114f6pLTkf1Gn21NzJRGqW+JfXh
	s
X-Gm-Gg: ASbGncu4qLQ7YtPwovXbL9pFf0All7eH/wrND+A5XP0Am2D5yaFfZnlPeoCAir6/xf4
	iDdFfhVQsMlH1oQSmCCNjImNQYutydv3tADLEo5Ryq4F/WNMOGa3p+wcqbIFLoxgd4StUGFD9C7
	dP8BkwXMEsRN9kT4hPfP3yuj6/cOj7HdPQlXIhTNKwYRDIStDRKcufYZ67Ie1xiVj8zzuXe05P6
	clPGAJvy/aXA/MjXNpoDYEQ1T/1RJ9RCmAcbDzBNRV4aL25M6/00BtimeRozHgnFusv9pnh82/4
	wLeAfM1x/enRpuWNVtcS3sQYEITq5LHNKQwd6/OfwIf6QIxwe3NJJLwMhmagjznrZDZGzJURGYy
	FaKC5VomYdrrXlYFrUkLcDavNZbWzHsDw4hgcnjKK
X-Google-Smtp-Source: AGHT+IGSppRYoZ7ELV+pxcILAzwAm588dg7krq/AiII/p0jFT5DnEhrLbPslq+IEZ7eSwkU+NYE58Q==
X-Received: by 2002:a5d:4fc5:0:b0:3a1:f654:ebec with SMTP id ffacd0b85a97d-3a349921e04mr1911083f8f.38.1747217642024;
        Wed, 14 May 2025 03:14:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34? ([2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de100sm18942948f8f.2.2025.05.14.03.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:14:01 -0700 (PDT)
Message-ID: <974c88a8ab3710d87273d860e5d4a2420c3582e0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] lib/bb/tests/fetch: add a test case to
 ensure git shallow fetch works for tag containing slash
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org, 
	liezhi.yang@windriver.com
Date: Wed, 14 May 2025 11:14:00 +0100
In-Reply-To: <20250514074839.2171099-1-Qi.Chen@windriver.com>
References: <20250514074839.2171099-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 10:14:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17609

On Wed, 2025-05-14 at 15:48 +0800, Chen Qi via lists.openembedded.org wrote=
:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> Add a test case to ensure git shallow fetch succeeds for SRC_URI
> with tag containing slash.
>=20
> For example, we want to succeed for SRC_URI like below:
> SRC_URI =3D "git://salsa.debian.org/debian/debianutils.git;protocol=3Dhtt=
ps;branch=3Dmaster;tag=3Ddebian/${PV}"
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
> =C2=A0bitbake/lib/bb/tests/fetch.py | 13 +++++++++++++
> =C2=A01 file changed, 13 insertions(+)

Thanks, this really helps us ensure these kinds of issues don't come back!

Cheers,

Richard

