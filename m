Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2988C3DA7F
	for <webhook@archiver.kernel.org>; Thu, 15 Aug 2024 14:12:59 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.124095.1723731170508615539
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Aug 2024 07:12:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Yy1AChuu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42808071810so6569285e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Aug 2024 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723731168; x=1724335968; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iXL7pnRRkeU08322PbKczixlscXOD4pSzZYsCVkRLa0=;
        b=Yy1AChuuNU/mrSLYWTUt4DTEI0pugFDweQWMmRGgtmONKO/LdfTE9l+vDlksiPKI7U
         xZfnGpWzZT7biSqAQ+pLz6HfOPiijNtZlxvGRUSp+8DAl1AIDBnWzzGabj1ioCH900uj
         p4rrsf+uyB/arTgPEwA5XKESF4doJwKFYdSJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723731168; x=1724335968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXL7pnRRkeU08322PbKczixlscXOD4pSzZYsCVkRLa0=;
        b=kumcU1dknsLS87C3IdIoNhG8iqPgL5OCZTxzt4DTTP85z27yWZfSMM6kq22aDxfWCT
         IBLIqMrd90NFHRefZPW64Y8diZ5PYAfy0bhJKzaYQ2NH7ucJ2XGlF9E8xInzrxMUdNCh
         wQADCyXKty4kJaqjC+2gRYxY3ekv2hgDF0/GLmglG6gI86Fk8jSCAgdcgqW6Z85QelPB
         hGhxaP1XeCAdGe5XzWwljB7zBHgxIbjLFyxrlkR5mu4Vb37rYgQou1NmcpAVmbVf1H2m
         M9q9Fq7zQR2t98MdYYFlpIqthm1fieLRSQrbDl4w8nsik+yBLjUlMTOZOI9rD3QFWMx8
         5o/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcOzh17kmoHVWCbtdUqnm2Wl7NQOAX0crQc7La+Rc97Kv8OZGKi07mVeuxVgrv0sknvJw20gvlmHMiWmDw@lists.openembedded.org
X-Gm-Message-State: AOJu0Yzi28XZ5/2iTItvDc8orHfV09tWG4CFHfIfAhi3nQUAQnQVjSLl
	omaTbZ/BhD0B9yKXwGVjQBaJ8UldVICsM7/EsQMDNxhhCBT/qngcDcTWCYSUt3lsyLZFjTx0pf8
	9L1M=
X-Google-Smtp-Source: AGHT+IHuIyEVim/YQ6jEcq3JCDVSU+oqcg5ACwiYAbCgND5qBoQrZTMeT0hmoxd5HQ7fxdkOj7AVNg==
X-Received: by 2002:a05:600c:45d0:b0:428:fb7f:c831 with SMTP id 5b1f17b1804b1-429dd2681b9mr51054605e9.32.1723731168326;
        Thu, 15 Aug 2024 07:12:48 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2bbd:6430:deb7:a333? ([2001:8b0:aba:5f3c:2bbd:6430:deb7:a333])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429e7e1c46fsm20671435e9.39.2024.08.15.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 07:12:47 -0700 (PDT)
Message-ID: <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified
 versions in package.json
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enguerrand de Ribaucourt
 <enguerrand.de-ribaucourt@savoirfairelinux.com>, 
 bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com, alexandre.belloni@bootlin.com, 
	stefan.herbrechtsmeier@weidmueller.com
Date: Thu, 15 Aug 2024 15:12:47 +0100
In-Reply-To: <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: 
	<20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Aug 2024 14:12:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16489

On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
> Our current emulation mandates that the package.json contains a version
> field. Some packages may not provide it when they are not published to
> the registry. The actual `npm pack` would allow such packages, so
> should we.
>=20
> A first commit was required in the npm class.
>=20
> For the shrinkwrap part , we can actually use the resolved field which
> contains the exact source, including the revision, to pass integrity
> tests.
>=20
> v3:
> =C2=A0- Split bitbake npmsw.py modification in another commit
>=20
> Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
> Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/npmsw.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
> index d8ed9df327..a5fa598deb 100644
> --- a/bitbake/lib/bb/fetch2/npmsw.py
> +++ b/bitbake/lib/bb/fetch2/npmsw.py
> @@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
integrity =3D params.get("integrity", None)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
resolved =3D params.get("resolved", None)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 versi=
on =3D params.get("version", None)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 versi=
on =3D params.get("version", resolved)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# Handle registry sources
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if is_semver(version) and integrity:

I'm not convinced by this reasoning. The whole point of our SRC_URI is
to precisely define something that is being built. I think this allows
floating versions of dependencies and hence makes this non-
reproducible?

We should probably error if a version cannot be found and force the
user to add one?

I don't really know node well at all so if I'm incorrect about that
feel free to explain. I do know our fetcher requirements which default
to being fully specified and reproducible.

Cheers,

Richard



