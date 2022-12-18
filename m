Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A1BC4332F
	for <webhook@archiver.kernel.org>; Sun, 18 Dec 2022 10:52:28 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.27333.1671360747222654189
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Dec 2022 02:52:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Y8kLL6Wi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so4295198wml.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Dec 2022 02:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUjS8k58gN7uEckWQPof8Epm2TIR4siY6pGqoUjBWxM=;
        b=Y8kLL6WiTBF9ebYkHnj8lk+DXjnId9iyWFozCIG1BGe86jTetu7NUNhwLUUbod9/cj
         57yOu8Lbl1FEEPsIfaBAu2m1QP2H5eXAMBF9BuUa/2Ir9B2KvUiE/WFSIE0YhRNczAgi
         YMFoKtze3bjIIQm0m748myyPjaHq0kCvXeYZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUjS8k58gN7uEckWQPof8Epm2TIR4siY6pGqoUjBWxM=;
        b=8B6Wcf7oRyhmWVQOe97xHzsO4983OuftrbyySQ1Ajgz5n+2OMBIISuPVhJFvUsrajy
         znDGF/kvRqWnGGVClAUBZ6iZgLWQqUxJ7lKVlnyvLzonzba/VIlhWgkPAQ0Za130Od6V
         jnqelBAQ8PHiGGSkwlUTNqAqh8Q438Een2fbO5NNEAV9GXe8fHUJcWVKw6WgI4ACqJuG
         qb5Y+ElorEAYERhByfmf76Rcu/fMCyw7bA34wXiaXOiXMGNIIZMRByewur4EsnczqiHX
         ADMJWxCQZfkpFpdEc+8qrzxQJ0W1gdo4PjWYUm/DHKmF+41uo6GLi48uplESHDaDAAQo
         l4fg==
X-Gm-Message-State: ANoB5pkitUQqyG9bmRQr4BwhVvj3HxGJ4FJvxhwak63HFSan7i6A3IJH
	n9UUmLexS+bjruFwCTEG1hy1eA==
X-Google-Smtp-Source: AA0mqf5nlFS+2zBfhHF8zzLNpO8wo+j4P1oJVhpd8aBvHVHEmeEJn0xjIOCjs2fDpTeBzVnvIdvTXQ==
X-Received: by 2002:a05:600c:4e50:b0:3c6:e63e:23f6 with SMTP id e16-20020a05600c4e5000b003c6e63e23f6mr30327012wmq.37.1671360745516;
        Sun, 18 Dec 2022 02:52:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:2302:f56e:c776:f5ed? ([2001:8b0:aba:5f3c:2302:f56e:c776:f5ed])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c290300b003b4fdbb6319sm15426410wmd.21.2022.12.18.02.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 02:52:25 -0800 (PST)
Message-ID: <7f41a5303bd062f1ccf828299b776532596360a5.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] README: add required python version for
 bitbake
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Frank de Brabander <debrabander@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 18 Dec 2022 10:52:24 +0000
In-Reply-To: <20221212162616.16189-1-debrabander@gmail.com>
References: <20221212162616.16189-1-debrabander@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Dec 2022 10:52:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14195

On Mon, 2022-12-12 at 17:26 +0100, Frank de Brabander wrote:
> Signed-off-by: Frank de Brabander <debrabander@gmail.com>
> ---
>  README | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/README b/README
> index af23c9af..377d0032 100644
> --- a/README
> +++ b/README
> @@ -13,6 +13,8 @@ Bitbake plain documentation can be found under the doc =
directory or its integrat
>  html version at the Yocto Project website:
>      https://docs.yoctoproject.org
> =20
> +Bitbake requires Python version 3.8 or newer.
> +
>  Contributing
>  ------------
> =20

I'm torn on this since it means we have to remember to patch the
minimum version in another place when we do change it...

Cheers,

Richard


