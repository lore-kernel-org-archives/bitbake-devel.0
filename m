Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20A8C38142
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:42:38 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.6842.1674337351306495922
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:42:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=M0MZUQ3g;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: kergoth@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id b10so8675313pjo.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOME4+XVzErrJG4gyb6S1y0RayXeM/DLUtABfcPLKWI=;
        b=M0MZUQ3g1NAZj91GPJeHC9/i1Z1uIeF4k3mnikN1AU4pmpIocGa06xAzq785kRrQrp
         DlT5Tpj8EstHpW/2onRRyvMKQSzcbeJs1fsavs/cyzd/CaHFHCZGd/u6Z6ZiFut34PJX
         qKkm1qhDX+j+jaqjFAiLiKMJQfdFEGFi6jKG+s6tTDtMeBoAwqRh/XQOpMEltGzYkeLj
         rsCslHUFC8cuoxubyf2EKrYX5jqfgudD+N6wI7SIhmQJ6C8/UVVnK5lL1pRTC7MrNOFZ
         GJngOGMZ7CBnLXzMyV++YYWuRVSZCMxzr/+HButqCeRj8nRxVdm9ZrdSmNWO42S3X38F
         UvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOME4+XVzErrJG4gyb6S1y0RayXeM/DLUtABfcPLKWI=;
        b=cKavDEEFwPSmg/f8HgdPi3KxS1FqV2FvXIYJw4JGQC1TXELG6vqap9p9QTfd0JGvbU
         JzjVBCGb3fkQCFSODen3Em3szcwZyFzNdaUclTiO2cXVSX84Hfj8HtNSeZ6MK+BNTnJu
         zfxA5pVyugk5ysKbrbdn8dFFlA7NFaqBYvMK+VMUmM6L5S3IFShO9vv78B/WMooms9Z5
         HQf5XUdvPcEIKLxIiT/FAI9IYBbkOOy7KKFIFXPYC2Iu73EF1Z+07ls1/FC0tXt6g0v1
         xw+ClaZN1cZaGNrlRA3247zqY7Edlvt1PViplA2oHwRpvpA8KVH9zhySLxKOa/wrqjCM
         4lAA==
X-Gm-Message-State: AFqh2kooU0ulwcfjOBRWk3CnCJ38aDH+FGvtDBDg0dVFRKJ/tmnEiBtc
	novQtQdLMVkzF8VeMzukZlVeyDyu7y0lQA==
X-Google-Smtp-Source: AMrXdXvZkufoZXaiNR+VuPieDUx1yMMg6r73osNDbzINuxZ+pGm+5C418/02tc3vNQi0yvUZygJN7Q==
X-Received: by 2002:a17:902:e5c9:b0:194:d0ad:53f0 with SMTP id u9-20020a170902e5c900b00194d0ad53f0mr13615840plf.9.1674337349745;
        Sat, 21 Jan 2023 13:42:29 -0800 (PST)
Received: from smtpclient.apple ([2600:8800:6cc0:300::1002])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b00194706d3f25sm16351731ple.144.2023.01.21.13.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 13:42:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Christopher Larson <kergoth@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [bitbake-devel] [PATCH 3/6] cache: Only write files if we have data
Date: Sat, 21 Jan 2023 14:42:17 -0700
Message-Id: <78456D01-2CB1-4F29-88AD-9C603004DDBA@gmail.com>
References: <20230121212305.2171310-3-richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
In-Reply-To: <20230121212305.2171310-3-richard.purdie@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: iPhone Mail (20B110)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:42:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14335

Hmm have_data =3D any(self.cachedata_extras) perhaps?

Sent from my iPhone

> On Jan 21, 2023, at 2:23 PM, Richard Purdie <richard.purdie@linuxfoundatio=
n.org> wrote:
>=20
> =EF=BB=BFBy writing the cache files only if there is data to write, we can=
 save a
> bit of time.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> lib/bb/cache.py | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index ee924b2d2b..c19fe26f1b 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -873,6 +873,14 @@ class MultiProcessCache(object):
>         if not self.cachefile:
>             return
>=20
> +        have_data =3D False
> +        for c in self.cachedata_extras:
> +            if c:
> +                have_data =3D True
> +                break
> +        if not have_data:
> +            return
> +
>         glf =3D bb.utils.lockfile(self.cachefile + ".lock", shared=3DTrue)=

>=20
>         i =3D os.getpid()
> @@ -907,6 +915,8 @@ class MultiProcessCache(object):
>=20
>         data =3D self.cachedata
>=20
> +        have_data =3D False
> +
>         for f in [y for y in os.listdir(os.path.dirname(self.cachefile)) i=
f y.startswith(os.path.basename(self.cachefile) + '-')]:
>             f =3D os.path.join(os.path.dirname(self.cachefile), f)
>             try:
> @@ -921,12 +931,14 @@ class MultiProcessCache(object):
>                 os.unlink(f)
>                 continue
>=20
> +            have_data =3D True
>             self.merge_data(extradata, data)
>             os.unlink(f)
>=20
> -        with open(self.cachefile, "wb") as f:
> -            p =3D pickle.Pickler(f, -1)
> -            p.dump([data, self.__class__.CACHE_VERSION])
> +        if have_data:
> +            with open(self.cachefile, "wb") as f:
> +                p =3D pickle.Pickler(f, -1)
> +                p.dump([data, self.__class__.CACHE_VERSION])
>=20
>         bb.utils.unlockfile(glf)
>=20
> --=20
> 2.37.2
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14331): https://lists.openembedded.org/g/bitbake-devel=
/message/14331
> Mute This Topic: https://lists.openembedded.org/mt/96443149/3617123
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kergoth=
@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

