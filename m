Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F410CCA0EE8
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 07:27:40 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.17140.1758094055503582633
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 00:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Wrv4qqJG;
 spf=pass (domain: gmail.com, ip: 209.85.167.43, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-571a58b385aso5815708e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 00:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758094053; x=1758698853; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+KyYfJWU/xc2e2QAugcexbSTz1d7gHyy83zjsgTaqs=;
        b=Wrv4qqJGyl9gOVtwXpMplSmumwpeWrwYkezhvvRW+wmvRCed1+NdD3nw8m8XaHD0zX
         JeY+cgShDkqCi4qFN3tBx+cTfBlRgo4gEhTxFpQ5SnnvUgtG1y+C+0aWJGE94aMmXj4e
         dHP49pHf9pRRRReHM9r4xulk1a3FzZPk8bKdUiulpsGhdshVgCqDs7w1JtGOzCQIo+vb
         fLro8lNL87QThpb5AQ9EBzXqkgX/pxMPqH60xMfQQkxxjViXKCw+b0dbaVzo/H39+0OJ
         wKiBmXzgxhu+tlONmZcDCPeLs3ffNdvArVzMJdp5PoujPKpxvLIGUXrlVDxRfWdEzyFG
         Ynew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094053; x=1758698853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+KyYfJWU/xc2e2QAugcexbSTz1d7gHyy83zjsgTaqs=;
        b=p+g8s5XDOZKB7Go53K4SXNeupqdqvczKTiMwZ79bsQxDfsXt718jKlSLbt6VQjrmX+
         BD5uMMaKEOZdX6AOrF28p4kgNl8PVfm8Kobalt7Zh4JV9a9gL24aZ6Q8AMz6oXuM7d9f
         MinJeTgoI0XeJO2zMCpsbaZZVOWiSl+6sv5J8R6vhlXhIcfU2rq+xT/58u1nadc0XNd9
         C+1Vy6Jr3h877iAvB+sUjPQ0L45dD25yQIJohAgZNjyMa/1JQgTgYomyBUX2BBDh5TOc
         e24Gftwel+cpxF1q6+rdUynPqf3U/5s9jI6tO065AS1M8f1TuTh3AxdGZdf/AuOEMT1u
         A94g==
X-Gm-Message-State: AOJu0Yw/BZSzV2nVB0htfyUiIPAQ2+41Q1YVsXdbaGPKy2aP/v+cP2qW
	NASxKePc+qSJfE2ZrqvVlBI+w64OcymfIBXEK1v3aDwln62q3osUYfachThU9ueVaN2Y7aPvByC
	KS88mqmEwgf4g9gMXnrN+WOLmqPylVMjQ3NL+
X-Gm-Gg: ASbGncuZUpNPzYnqt4XHN6NU7RAuInvOmkFPh4SyGNYvfHoGfSoBn9g4ZS6L/CcwgIU
	tdhldVB14Czuy+sNTbxLSoCSOisI7JaLK62mCu7X0gTN44iMf3LaXXNtWfp+58++x0n8erBlFj9
	R+M35/9VNN98N0orYJUDpNcTs2qPQ+MWE6ITORzMLuHh4eRZ88sZ3Tb4nuyW3w7N9wK5TdnGoZo
	KIJ+1ZSSQ==
X-Google-Smtp-Source: AGHT+IF7WXqdG8Y/3HkXCwrsdIikZCTRJZLi9qfnzHqItRqNtlmcXTl3l0NdU4sjd1Sk/IzpT3RmoopZAwfYU3E1pPE=
X-Received: by 2002:a05:6512:4010:b0:55e:2c0:81c4 with SMTP id
 2adb3069b0e04-57798757854mr280447e87.27.1758094053065; Wed, 17 Sep 2025
 00:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757519577.git.steve@sakoman.com> <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
In-Reply-To: <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 17 Sep 2025 09:27:19 +0200
X-Gm-Features: AS18NWAuHbUNTUyycnrjn5XESGs5ImR5_qY3N2rdSfNvUU3HOfhBlf_0PYJACNM
Message-ID: <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][walnascar][2.12][PATCH 2/2] bitbake:
 Bump version to 2.12.1
To: steve@sakoman.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 07:27:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18049

Hello Steve,

I've noticed today that 1.12.3 tag was pushed for current 1.12 branch:

commit 710f98844ae30416bdf6a01b655df398b49574ec (tag: yocto-5.2.3,
tag: 2025-04.3-walnascar, tag: 2.12.3, origin/2.12, oe/2.12,
github/2.12, github.oe/2.12, 2.12)
Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue Jul 29 16:42:25 2025 -0400

    utils: Optimise signal/sigmask performance

Should I redo this as 2.12.4 and adjust the related change for oe-core
to bump the minimal version to 2.12.4 as well?

Similarly for scarthgap and 2.8 bitbake, which has 2.8.12 tag already,
so instead of 2.8.1 I would bump it to 2.8.13.

commit 982645110a19ebb94d519926a4e14c8a2a205cfd (tag: yocto-5.0.12,
tag: 2024-04.12-scarthgap, tag: 2.8.12, origin/2.8, oe/2.8,
github/2.8, github.oe/2.8, 2.8)
Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Tue Jul 29 14:43:09 2025 -0400

    utils: Optimise signal/sigmask performance

Regards,

On Wed, Sep 10, 2025 at 5:55=E2=80=AFPM Steve Sakoman via
lists.openembedded.org <steve=3Dsakoman.com@lists.openembedded.org>
wrote:
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> To indicate compatibility with python 3.14
>
> [YOCTO #15858]
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> ---
>  bin/bitbake        | 2 +-
>  lib/bb/__init__.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bin/bitbake b/bin/bitbake
> index 09cbb54e8..05b6ba742 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParamete=
rs, BBMainException
>
>  bb.utils.check_system_locale()
>
> -__version__ =3D "2.12.0"
> +__version__ =3D "2.12.1"
>
>  if __name__ =3D=3D "__main__":
>      if __version__ !=3D bb.__version__:
> diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> index 605355e1a..eba7b8fdd 100644
> --- a/lib/bb/__init__.py
> +++ b/lib/bb/__init__.py
> @@ -9,7 +9,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  #
>
> -__version__ =3D "2.12.0"
> +__version__ =3D "2.12.1"
>
>  import sys
>  if sys.version_info < (3, 9, 0):
> --
> 2.43.0
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17999): https://lists.openembedded.org/g/bitbake-deve=
l/message/17999
> Mute This Topic: https://lists.openembedded.org/mt/115172226/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [martin=
.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

