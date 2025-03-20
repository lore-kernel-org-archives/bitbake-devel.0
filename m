Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC41C36001
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 07:28:26 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.2184.1742455698700674604
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Mar 2025 00:28:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=v53A9ttv;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so3997855e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 00:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1742455697; x=1743060497; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcgvGeQxQzlUZLXcxGxi8cPaYNubMjjKmm5c/3/Kai0=;
        b=v53A9ttvc2b6rfRIJ0o9mMi0f5t/q/N8zEXeoZ3Y0p4B1hJn10EI6tP6+HYE6ls9yw
         HzlrTCEO5ojVercO+G8wvtbUIYul6RpLNPzKkN7iGFdcSaRdJWeUZuBvRSWP6Dc2Oh6y
         RxgONs3JIsjw5x4uqRo8+wjqqfz17F1MV43ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742455697; x=1743060497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcgvGeQxQzlUZLXcxGxi8cPaYNubMjjKmm5c/3/Kai0=;
        b=AZRGG1Dgi//Wy+l/Md40Romv01lMmW+iuBBYmng9h2X2PI1wzC8jvjctKaz+uCEsEj
         LlWeYFdBNWisMqKmPSn02cRQv3B1QxJsY1XLruPoR4tgKQkGHLaLmTRERaBxtvJLPUUn
         DSzmh/euamvYYqXsDhHBsE6Sy3ooV04qQPGlyLKjZe0ZZJXAclpk88pIMFh1g7f85K9b
         ZYqZFVpMUVCUi5cLZ5scYMWrTVbgxiAjoDIFODazo7QyPfaP2IPPOHjYvJM/VWtgGMgK
         tT6DX1OmX3kByLRGaV+HDajDeMLkbtmfy8Eqm82F207XSuRyGrW+Ig4n1GKlvgvECF7p
         Q+vQ==
X-Gm-Message-State: AOJu0Yx/XFMafE1mmPBPdgcy0G246GkezMRdMwKVfxUT/07Mqg6bHhKH
	QbpCq/3dNcbyQSqwxnQ88SwDd+pWkPKBkOacoACdb7HwwfJ/qWpiLQseKMwbSWcGCXBSMJcRQiP
	VpHHsswonnXPdwlhAQ3vO9lNwvfWyVC1mOBnpZg==
X-Gm-Gg: ASbGncv/YSK7w8J+0Y3rGPntzqp3TmYl/xMnDAqnGUb65EWWg5LFoDRsdtJunqm0hBL
	5cmr3FaCZJNBhJvFtISh9bzPiB/eWlVGVWVTBXpnfF3uarJ8L2YOTCVvIWEL3xvc6N9RSdoAEA1
	gtrSZ/o6jWd3Es+8Ygj4a1mAvzn4bZHXA+o9ydJut929WFOvOuxzsjp70PBqxV
X-Google-Smtp-Source: AGHT+IGi2UZm7IwJj/xxcw50V/eO9peuQACwhPEP1vZ+dpCE11kF5NBylNn5DPjiPfn6ZNry+P5mwGw5Hx6g9AGgyF8=
X-Received: by 2002:a05:6000:402a:b0:399:6dd9:9f40 with SMTP id
 ffacd0b85a97d-399739b7ca9mr4766426f8f.9.1742455697047; Thu, 20 Mar 2025
 00:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250319195527.860295-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250319195527.860295-1-richard.purdie@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 20 Mar 2025 08:27:51 +0100
X-Gm-Features: AQ5f1JpITcfIpsWuj5y7DDJISF-uqmgi3Bb0WFp35ySpqWmt3Aw-bECehRJUA6E
Message-ID: <CAMSfU+4w4a_ebY0-Y7X8TT2+ijhLiw6XSn5Bw56YuYKzYv-Cvw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb: Bump minimum version requirement
 to 3.9
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Mar 2025 07:28:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17477

Hello,

Le mer. 19 mars 2025 =C3=A0 20:55, Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> a =C3=A9crit =
:
>
> Since Ubuntu 20.04 is heading to EoL and that we're having other issues
> on that platform needing buildtools anyway, we're about to lose the
> last python 3.8 platform we were supporting.
>
> Bump the minimum version to 3.9 since there are many developers wanting
> access to newer python features.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

FYI, here is the 3.8 -> 3.9 changelog:
https://docs.python.org/3/whatsnew/3.9.html

My selection of the highlights that I feel matters to us:

New syntax features:
* PEP 584, union operators added to dict;
* PEP 585, type hinting generics in standard collections;
* PEP 614, relaxed grammar restrictions on decorators.

New built-in features:
* PEP 616, string methods to remove prefixes and suffixes. (NB: We
talk about this one a few weeks ago)

New features in the standard library:
* PEP 593, flexible function and variable annotations;
* os.pidfd_open() added that allows process management without races
and signals.

[...]

New library modules:
[...]
* an implementation of a topological sort of a graph is now provided
in the new graphlib module.

> ---
>  lib/bb/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index 876f7e3976..d3e90d03be 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -12,8 +12,8 @@
>  __version__ =3D "2.9.1"
>
>  import sys
> -if sys.version_info < (3, 8, 0):
> -    raise RuntimeError("Sorry, python 3.8.0 or later is required for thi=
s version of bitbake")
> +if sys.version_info < (3, 9, 0):
> +    raise RuntimeError("Sorry, python 3.9.0 or later is required for thi=
s version of bitbake")
>
>  if sys.version_info < (3, 10, 0):
>      # With python 3.8 and 3.9, we see errors of "libgcc_s.so.1 must be i=
nstalled for pthread_cancel to work"
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17473): https://lists.openembedded.org/g/bitbake-deve=
l/message/17473
> Mute This Topic: https://lists.openembedded.org/mt/111796719/4316185
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [yoann.=
congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Yoann Congal
Smile ECS - Tech expert

