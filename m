Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5C6C43334
	for <webhook@archiver.kernel.org>; Sat,  4 Jun 2022 11:25:00 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web09.9078.1654341899434935239
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Jun 2022 04:24:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FEtwcWbg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id t13so13400308wrg.9
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Jun 2022 04:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=RInlNxF3f7RzXnvIOJ4e2aYTcGdmXo68Q+LztUVKxRQ=;
        b=FEtwcWbgkjggiChmlYRmEUdjr+z7BN3Cck129ehpPhi/7NF7bMRNnNCj6KoO7yRgKm
         838rGxeMxy2mcYhHsOJt4hNK04aeB3kVQvHUKAaCPbLxA69lD6MbsfFG7b+CjOr8/4Au
         BT22f8xXwyQ58MfwVNCS2gRPLxBWShawrJgG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=RInlNxF3f7RzXnvIOJ4e2aYTcGdmXo68Q+LztUVKxRQ=;
        b=6OADuMBLIw0MfZiKP4So/FjgMNh2LI8yMNHGI7XtYm5rgCmyq7xKe4jqiq/91RQlIn
         Yl0KEfWe/tbeGxfl/1MHXjhHC6MDRL692nr+Q7Fvsg4cK9hUppdbJjAyi+6TyzTRqSlP
         r4oD27Vg4jf38QMzOI1XN/DORWF566r1vQVjYkGwv5kL4ScSIjqeEopy3dCzTER6M2zb
         PELlFbCng6JmC5NgOUGbyu84xHTPxVLoiOnSfdK7czNffuaJLyJWN4O1mIuOe2OsHiUI
         X0r7QvOCWq/oBP573Ce9y3ivYriVEa5f6KCwY3IjwlEuDMKjYZ80Zm7uOL1S89HwfieZ
         vxDA==
X-Gm-Message-State: AOAM530ii2JKrQsKAb4AOROEsuSo/yMoYSUCDOIep/cxYSVUHLixIsWC
	cqymKfr5bMXHWnwUA4EdgArkXg==
X-Google-Smtp-Source: 
 ABdhPJxDse5imPCJ+wn0YwLGaEfbNWidIG6N3VorF/McC8TFowiAxS3kjN5vF5UflENtjqWSJF1dDA==
X-Received: by 2002:adf:e19a:0:b0:210:157c:7b3c with SMTP id
 az26-20020adfe19a000000b00210157c7b3cmr12202488wrb.121.1654341897873;
        Sat, 04 Jun 2022 04:24:57 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9b17:e3e6:3e93:a118?
 ([2001:8b0:aba:5f3c:9b17:e3e6:3e93:a118])
        by smtp.gmail.com with ESMTPSA id
 k7-20020a5d6d47000000b0020e5e906e47sm9843864wri.75.2022.06.04.04.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:24:57 -0700 (PDT)
Message-ID: 
 <27c8408ee81603ef68deffb8a5aa872a23466600.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Ensure gitsrcname is not
 too long
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jan Brzezanski <jan.brzezanski@gmail.com>,
	bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Date: Sat, 04 Jun 2022 12:24:56 +0100
In-Reply-To: <20220531094535.9841-1-jan.brzezanski@gmail.com>
References: <20220531094535.9841-1-jan.brzezanski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 04 Jun 2022 11:25:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13732

On Tue, 2022-05-31 at 11:45 +0200, Jan Brzezanski wrote:
> If SRC_URI is pointing to local repository, it can happen that
> the path will be over 255 characters. When transformed into filename,
> bitbake will fail/hang on e.g. trying to create lockfile based on this
> name.
>=20
> Thus we make sure to truncate this string to last 230 characters
> (arbitrary number) when it exceeds this limit.
>=20
> Signed-off-by: Jan Brzezanski <jan.brzezanski@gmail.com>
> Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
> ---
>  lib/bb/fetch2/git.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 23f8c0da..77bd9be3 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -259,6 +259,8 @@ class Git(FetchMethod):
>                  ud.revisions[name] =3D self.latest_revision(ud, d, name)
> =20
>          gitsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.repl=
ace('/', '.').replace('*', '.').replace(' ','_'))
> +        if len(gitsrcname) > 230:
> +            gitsrcname =3D gitsrcname[-230:]
>          if gitsrcname.startswith('.'):
>              gitsrcname =3D gitsrcname[1:]
> =20

Which release of the project is this with? I ask since there is this
code:

https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/utils.py?id=3D09e82=
6cfb021731c1b139046665d2d9fa24baa88
https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/utils.py?id=3D273b1=
24bf6acd77b074fde2421be331721a68c11

Are you saying that isn't working?

Cheers,

Richard




