Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D34C433EF
	for <webhook@archiver.kernel.org>; Wed,  8 Jun 2022 16:51:20 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.8966.1654707071721812503
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 09:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DjgHd0Hi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id a10so8675069wmj.5
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=dHPhbR2LKeduAnqo4IsYM0VF+kf6Y1cV72868hQg180=;
        b=DjgHd0Hi3Ga/ehs0ureERniimkVT4eqMY5/iXG4aCwMm8Kgse+D73e8oclgfBbW9pM
         WiIhTTi2DtfrekaCDjgic4zn0w6gskTISAwngJ8lU9SNVrfVkLxKRcdj0zebSfhk0hF6
         FLOuDkOqsVluQGflI16zVmHNbBDSzaQIpZzWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=dHPhbR2LKeduAnqo4IsYM0VF+kf6Y1cV72868hQg180=;
        b=4orzBW5bISMSE7kZXuOTnc5V495Jt35AurZTlNrZx1tRbU86nZfb9Dg9SC8Xoa12CV
         fZFX5uTVc4GdGR0kifGvh5FjdrnuUzVk1JCtMiXRplWXmBJWZp3rgZKyo4kyhw5vn+v2
         VF6wo2s2hS4+8izY1l098nMw4bhv5JwYr/fJ3IcjLZlfZGwEKereqHVmnHhwXlSC01QD
         d2wRc6SEwhQHNEaTISTUDqIzlOadaSM0Hq6dkBq6eSJ+IQWXxfJLhOKM5FE5hjiIXo7t
         2AKrLFhskXU7kOSF4NCFSlf4MLGOOAh7x0BvfctvKCHh/9zbjnxxegmKxfHJASW+bcpS
         Uedw==
X-Gm-Message-State: AOAM531HSYtVZUuTxTSdlywMUGA+YFmsJC8e0/CMZ5/xVgGY+H8M9YAX
	XPVnKvT+1caKs7MwaijxGxDHYA==
X-Google-Smtp-Source: 
 ABdhPJxeXw52dn1MDNoXlnqcmvA3cUAoG4IPkopPv2h7VLVWl+rAUvZQlYa3YjKoS8gd68GQY88Vxg==
X-Received: by 2002:a05:600c:a01:b0:398:d2f6:b5c6 with SMTP id
 z1-20020a05600c0a0100b00398d2f6b5c6mr133492wmp.140.1654707070234;
        Wed, 08 Jun 2022 09:51:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2793:ec22:da5d:8e52?
 ([2001:8b0:aba:5f3c:2793:ec22:da5d:8e52])
        by smtp.gmail.com with ESMTPSA id
 k3-20020a05600c1c8300b0039c5fb1f592sm4246963wms.14.2022.06.08.09.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:09 -0700 (PDT)
Message-ID: 
 <22474be47782b2149e72b6a8ba0431894a24a5dc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: avoid DeprecationWarning with
 python-3.11
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <Martin.Jansa@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Wed, 08 Jun 2022 17:51:09 +0100
In-Reply-To: <20220608085733.73997-1-Martin.Jansa@gmail.com>
References: <20220608085733.73997-1-Martin.Jansa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jun 2022 16:51:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13741

On Wed, 2022-06-08 at 10:57 +0200, Martin Jansa wrote:
> * fixes:
>   bitbake/lib/bb/cooker.py:16: DeprecationWarning: module 'sre_constants'=
 is deprecated
>   import sre_constants
>=20
>   it's deprecated since 3.11 with:
>   https://github.com/python/cpython/issues/91308
>=20
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/cooker.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 6da9291f..e417d0e1 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -13,7 +13,10 @@ import sys, os, glob, os.path, re, time
>  import itertools
>  import logging
>  import multiprocessing
> -import sre_constants
> +if sys.version_info >=3D (3, 11):
> +    import re._constants as sre_constants
> +else:
> +    import sre_constants
>  import threading
>  from io import StringIO, UnsupportedOperation
>  from contextlib import closing

Looking at the code we only ever use sre_constants.error and this
should really be re.error in modern python as far as I can tell so that
change may be easier ?

Cheers,

Richard



