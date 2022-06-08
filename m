Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD9BC433EF
	for <webhook@archiver.kernel.org>; Wed,  8 Jun 2022 09:54:47 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web10.4479.1654682078317887381
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 02:54:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=d2x67+4j;
 spf=pass (domain: gmail.com, ip: 209.85.167.42,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id be31so32415344lfb.10
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jun 2022 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vjhEXOWZzp3m2Oz+XW4MwK5A5+1oZOOktTCBfnoYtc=;
        b=d2x67+4jBDkPbCE7AKDQwKOdnxz2U8bxfha8/LuS2U7VZaWOEmipDaTyyqrlAH90UE
         kskSZpR5DkNTJoRtWFmCxRlcl1m4wXoaOtCalrMeHsY+nerwjrRl0vQBrFEYName4VV2
         a48CDYqWhZRK6n7Doo6ISLf5MYR0WDjsUxV49K8/WxUwDTRHIDWQ+tuQjksd/a9kL2Kk
         6GrmpT4VBfMvXfHkIW4r79dRYsHTe4sFJWfanEp6KU+li1F61Z3ho9HL/DPOSAuJ0J7a
         vZHzx/XfuUAcFAwTUHdjF5pWYMbnBjE9YxAZt8Ovl0ccOIguizKqjab9vtxNfG/gG+tx
         4kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vjhEXOWZzp3m2Oz+XW4MwK5A5+1oZOOktTCBfnoYtc=;
        b=UgSBaJjcjumYp0lhbSJ3P1ptjHYW5ffq/xkr7ZLdD9CJy/Cx6rsnQ6UessxcuimRiC
         +kdqbAQMf/bF3xKpoosxi9y/p5UED+ShYE1BjvHXJwMlbgooEQprERWXARb62u+EJ7+N
         Ajph5DrHxwwfVLIgHFn2d7Jagyy26bNkVmt16pZeFD0D5VwH4ilCW0v0ZP4JEMVnpvvP
         sKMYmZ+XHuuIDHmKHffFoYuZH7ryc8GY3f/42q7YChyDTxatmcb758WnMUACYbHsUZNH
         5copbD7KVqtmrvA//cwx0ypSHaJ6qP/gnJdt98TWjU4FGWtckS7GXuxUN1AP5bCWSvNU
         jTdw==
X-Gm-Message-State: AOAM531gS0Q2ZG21w0gmlbjh4aE707H51VqKKiYKZX77K7jw+GTFDvN2
	lKn9WUEFaO/fVxmbQ/YHfcild8S6kUt1wDavOQE=
X-Google-Smtp-Source: 
 ABdhPJxP1JFwV36g0xoN59ec7bS+Ap1BZlimoscaDlhVYaMlThk8Q7RvHu8+5MRasIUQCJHPv5fXT4Bv7v9O4f4hbGE=
X-Received: by 2002:a05:6512:13a4:b0:479:3b9f:f13c with SMTP id
 p36-20020a05651213a400b004793b9ff13cmr11102403lfa.380.1654682076261; Wed, 08
 Jun 2022 02:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220608085733.73997-1-Martin.Jansa@gmail.com>
In-Reply-To: <20220608085733.73997-1-Martin.Jansa@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 8 Jun 2022 11:54:25 +0200
Message-ID: 
 <CANNYZj8CeBGgh9uYOtmfJGUtxFRBDvqqW3hKvhHWDpZKfVy2AA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] cooker: avoid DeprecationWarning with
 python-3.11
To: Martin Jansa <Martin.Jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Jun 2022 09:54:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13740

Neither the old or the new is a documented item, so I believe it is
better to eliminate the use entirely?

Alex

On Wed, 8 Jun 2022 at 10:57, Martin Jansa <Martin.Jansa@gmail.com> wrote:
>
> * fixes:
>   bitbake/lib/bb/cooker.py:16: DeprecationWarning: module 'sre_constants' is deprecated
>   import sre_constants
>
>   it's deprecated since 3.11 with:
>   https://github.com/python/cpython/issues/91308
>
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/cooker.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 6da9291f..e417d0e1 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -13,7 +13,10 @@ import sys, os, glob, os.path, re, time
>  import itertools
>  import logging
>  import multiprocessing
> -import sre_constants
> +if sys.version_info >= (3, 11):
> +    import re._constants as sre_constants
> +else:
> +    import sre_constants
>  import threading
>  from io import StringIO, UnsupportedOperation
>  from contextlib import closing
> --
> 2.35.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13739): https://lists.openembedded.org/g/bitbake-devel/message/13739
> Mute This Topic: https://lists.openembedded.org/mt/91619426/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

