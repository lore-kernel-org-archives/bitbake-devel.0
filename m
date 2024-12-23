Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF1E7718B
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 10:01:23 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.10931.1734948080870268451
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Dec 2024 02:01:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PseXGHl5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363ae65100so42661665e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734948079; x=1735552879; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y4ilAnUZAzrvxRtFS+gsqKTaXf5gmy/aKLDrh+C0hks=;
        b=PseXGHl5OLxgeqK5rG+pURMaHBPX/egHvH+3gqW0JTmrgfCzOWLaCfeDxmY+U4wut3
         6Zh6GrGCFhncm0viJz3JvPX00GxM97Idbrqal9jvC1qRjDupN0rhXeFV3fHWJlW+wZvM
         66KKc1Hco4Dju2S9xAKT0cTlm1qxrGBnKas8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734948079; x=1735552879;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4ilAnUZAzrvxRtFS+gsqKTaXf5gmy/aKLDrh+C0hks=;
        b=nlDt1Wb7PuzwyfSoTlrWLTC2lkR+r7U9TDyGxkwzkgCJ3hQ2LZ/t9DTijFP/f5ezo8
         nqSxuzup0vl5N7fVaRNKap2I6uFKA1fhbE4GbfdjMtMHQvv7oReZ+BrTKkr4QwZs8gOg
         f1QjJ7YfGMANY06XCTC/j8Zm+P2N1DTUErmUtNGKjBbBiS32YFyo+cKYxPo7bSg02EDa
         d5EXok6pC/8hvp0VT6tl7ypOWpKPFiNGS61yybS2Ds3RXnK3/dMtPSxmBWxRMeoA60zw
         jZTbC2yzkr3oqQEHdpAQutgEMhYn5rgsjtuzVSnp+Ud0Wavy9lAPqgdsUh1shM8FSbyR
         77fg==
X-Forwarded-Encrypted: i=1; AJvYcCVNFjSDOQAczRIEh3y/X7rri5LwWod6aKK4Z3dY+0lx0HJ2xVEzFpKxBmReS2LEcwqfLcJ73BhR0PXqwFsA@lists.openembedded.org
X-Gm-Message-State: AOJu0Yyxex31BsPQcDCVu3YzE9DqpWudWmIxPgnbnHgne1vqbNdWqdyt
	gA+cplTAVk9YceZlr8/L+NlP5UhPxvTEOteiu+erg1ybKq2zQCV2mYSrF7Q7NjI=
X-Gm-Gg: ASbGncu89y8jdLvSU7BhqAuqO/qMCjzwFzqhFVaeSGjqRmsDrg6Rvu9PUOKtOiixaRm
	j3fNsWFHCDqY1TyoiM912mQFJmswySgX0giOA1t34Kfm+1P2Yn6sLhHEyUM6TqaDjvTVQUbn/ay
	iwhc9E3mIHW7QGiJfEARk6kUIDiyfTtniXlJiosKlsIIDMKtK9ltDAt7o6dIXxJbcHBWMjRJ0dI
	Mv522S2JLCJH2A42Zx6mJI+d3FC+dOeRRKM9Ge9pOxQdv/dDW65kK29Y/UUcG7ATpIxXfjEsUKW
	WQ3imhde4TxWw9uWOmG63Oh3C9o6rZT/WipqCmh+lZ4UmA==
X-Google-Smtp-Source: AGHT+IEh4j+XMAosmHhx6pw+mS3GYlGX972i1jT1oSjRCBT5QmHoqPYgg9OZJeAF2RsfBvlZRni2ww==
X-Received: by 2002:a05:600c:1c25:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-43668b5f691mr101463965e9.29.1734948079134;
        Mon, 23 Dec 2024 02:01:19 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6ed5:9162:4947:2803? ([2001:8b0:aba:5f3c:6ed5:9162:4947:2803])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e31sm10861122f8f.33.2024.12.23.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 02:01:18 -0800 (PST)
Message-ID: <6e8dca0b11a0244465ae530cb698f6733cc17f10.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 08/21] utils: add Go mod h1 checksum
 support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Mon, 23 Dec 2024 10:01:16 +0000
In-Reply-To: <20241220112613.22647-9-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <20241220112613.22647-9-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 10:01:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16944

On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> Add support for the Go mod h1 hash. The hash is
> based on the Go dirhash package. The package
> defines hashes over directory trees and is uses
> for Go mod files and zip archives.
>=20
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---
>=20
> =C2=A0lib/bb/fetch2/__init__.py |=C2=A0 2 +-
> =C2=A0lib/bb/utils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 25 +++++++++++++++++++++++++
> =C2=A02 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 7d8f71b20..0c2d6d73e 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -34,7 +34,7 @@ _revisions_cache =3D bb.checksum.RevisionsCache()
> =C2=A0
> =C2=A0logger =3D logging.getLogger("BitBake.Fetcher")
> =C2=A0
> -CHECKSUM_LIST =3D [ "md5", "sha256", "sha1", "sha384", "sha512" ]
> +CHECKSUM_LIST =3D [ "h1", "md5", "sha256", "sha1", "sha384", "sha512" ]
> =C2=A0SHOWN_CHECKSUM_LIST =3D ["sha256"]
> =C2=A0
> =C2=A0class BBFetchException(Exception):
>=20

The others are all generic checksum formats so I'm wondering if we need
to indicate this one is go specific go-h1/goh1/go_h1?

Cheers,

Richard



