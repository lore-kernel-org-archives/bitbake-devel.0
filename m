Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1669BC3DA78
	for <webhook@archiver.kernel.org>; Sun, 15 Jan 2023 15:12:00 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.141819.1673795518383104266
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 15 Jan 2023 07:11:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P7pQUzL3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id t5so20856221wrq.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 15 Jan 2023 07:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=66ppNuEnLmOis7JpxLUePoa/01lPn2sweNMeSpckOSA=;
        b=P7pQUzL3KjQY4m/EXECtdnwfM7haMcn4nUoD+cgEVdxKDA7kQSDUi7VKfi0OSJ/t1i
         gSO2QqHD3ABPf1oA2TmW0Sw/wf+8J1fVZnUKys2A3ju83yfYcAslEaqdPj1c9BxBKqMt
         qRRPyjx/5Vh7cYHJDZJ0CnuzG5zMdnJXWiVWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66ppNuEnLmOis7JpxLUePoa/01lPn2sweNMeSpckOSA=;
        b=HG0//sY13u4V1pAbiONhyPZEovn4IG4cXrqxFJHR27pvtSVT+uBpoam67za4SF1BYH
         eamChN91T85tOvjBP7hXUGG33ZJdivp7m12jpu+z2YPbttemLgaa8e7I1yJccxc65Btt
         S9ZVc44YwrnjfGHfdYxoALzQDVLK9hL4LWlJ3E03GjS3zrVoE8J4NoGt6JviYbf1xpiO
         ULPtgYOESIFs8S6ge2iBWH8/29CbRPAOcYoOHA/ODyxnV30TlqEMVRgPEtDVi2JAh1hL
         KCMWkS+EFxAfN89jwht2HCKOclzTgnsacQ4VAGKVzpHyPvaAbwEHmzfYsR4qjDSopxaj
         BuVA==
X-Gm-Message-State: AFqh2koEhISncK0NkoI6j/5stYKTXqTeV4DSeLZFDOKBRTB2Wrp9CaUk
	eOE865llRLo+eJKh2M8LmG7A6ftKSqJ6mCOl
X-Google-Smtp-Source: AMrXdXsZQmu2xhjUMKUcF1Bemfz30oMua3R1O2Ns4ujzM5VseTX862zEc6pt9ZNyAkljp9VITziDwQ==
X-Received: by 2002:adf:e103:0:b0:26a:6e7d:5782 with SMTP id t3-20020adfe103000000b0026a6e7d5782mr54565746wrz.35.1673795516839;
        Sun, 15 Jan 2023 07:11:56 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c753:75fb:9583:e5c6? ([2001:8b0:aba:5f3c:c753:75fb:9583:e5c6])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b002bbe7efd88csm19296453wrb.41.2023.01.15.07.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 07:11:56 -0800 (PST)
Message-ID: <8b462325bfa33ffd6f62c558c0a521f5a5e6761a.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: handle username/password
 in uri
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kasper <kasper@krinvent.dk>, bitbake-devel@lists.openembedded.org
Cc: Kasper Revsbech <kasper.revsbech.ext@siemensgamesa.com>
Date: Sun, 15 Jan 2023 15:11:55 +0000
In-Reply-To: <20221129132246.436271-1-kasper@krinvent.dk>
References: <20221129132246.436271-1-kasper@krinvent.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 15 Jan 2023 15:12:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14317

On Tue, 2022-11-29 at 14:22 +0100, Kasper wrote:
> From: Kasper Revsbech <kasper.revsbech.ext@siemensgamesa.com>
>=20
> In checkstatus() opener.open() is used to check if an artifact is availab=
le.
> The check fails if the uri contains username password in the format:
> "username:password@hostname..". Moreover, the checkstatus function alread=
y uses
> the username from the "ud" object to craft a header, is username and pass=
word is
> provided.
>=20
> This fix ensure the uri in the Requests object used does not contain user=
name as
> password.
>=20
> Signed-off-by: Kasper Revsbech <kasper.revsbech.ext@siemensgamesa.com>
> ---
>  lib/bb/fetch2/wget.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index 821afa5b..d9aaad6b 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -341,7 +341,8 @@ class Wget(FetchMethod):
>              opener =3D urllib.request.build_opener(*handlers)
> =20
>              try:
> -                uri =3D ud.url.split(";")[0]
> +                uri_base =3D ud.url.split(";")[0]
> +                uri =3D "{}://{}{}".format(urllib.parse.urlparse(uri_bas=
e).scheme, ud.host, ud.path)
>                  r =3D urllib.request.Request(uri)
>                  r.get_method =3D lambda: "HEAD"
>                  # Some servers (FusionForge, as used on Alioth) require =
that the

Didn't this merge back in December?

https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/fetch2?id=3D89ccf60=
3d8119c34f5398dbd737e6a0b805234d3

Cheers,

Richard

