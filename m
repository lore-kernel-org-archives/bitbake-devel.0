Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCECC4167B
	for <webhook@archiver.kernel.org>; Fri,  9 Dec 2022 11:35:48 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.11045.1670585740772604747
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Dec 2022 03:35:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PPJGHaAe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 125-20020a1c0283000000b003d1e906ca23so3067916wmc.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 03:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X5biCGHjMqM5zJfa88Q2z+vos4GxhzHu0JhDHdMzJo=;
        b=PPJGHaAesRev8H8cMzAcUIn5fCLB5lUUD9UCwZIfEq9CJtmbvt6Fnwx+JRdEQ19o1m
         Kzmnhs3zpvXscIuraXhob0PtwBSllhLS8zvT8DGqO0DciH0TsOH8ic2dNOou6lg+HXG7
         MznJcAoDJLAVp54UCkxC9zPK+Aa7Ow1DGZTlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3X5biCGHjMqM5zJfa88Q2z+vos4GxhzHu0JhDHdMzJo=;
        b=y8pSAZj/aXsTDWZ7+Qfc3oEHv3QFK4LN1CxEjwmnZShlRHG4ouVrTBCZ1ErDc2MBgp
         Nm7a7n/3dx8D2FutupaSLQ6YLASsgWmykIkY+L4TXFyDmmCiTNHQwaiZLWWFN4EXNQIf
         t+qenmAGgh/6+BMX5EETvdz5e6htw1RPjZ1ylmvFw3kz6diApJKJl8Wsn5rXhPkZwVGQ
         8v2r2BgOwcSHHlbqxelYHcpO9M08c2F5YS2R7cOAF5yrw5erh6M/JWlOgQpxyq/RkYnH
         DHElDyKuJO7rvryq7J4++qxXbiou06/TxL59K/YTsOEwJ8lXjhBKD9SXXhTCF5W4xQ6M
         7g3w==
X-Gm-Message-State: ANoB5pkKha4vcrfnZlvGOhpcJuGwo4GdBy6cR9CMhdjngyq2YKZJraR4
	3Qcd1Fb/mRNhaYlMKUh0lyqj/w==
X-Google-Smtp-Source: AA0mqf5N2d9ogullCgF1JnPN+hECXjdN3Z5dGfcxRdm3/DP5DYvUgL+R7DyNn7qGX2pqGQ9JTRjg5w==
X-Received: by 2002:a05:600c:783:b0:3d1:bf7c:3923 with SMTP id z3-20020a05600c078300b003d1bf7c3923mr4282400wmo.4.1670585739038;
        Fri, 09 Dec 2022 03:35:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:9b77:8930:5aaa:e9c4? ([2001:8b0:aba:5f3c:9b77:8930:5aaa:e9c4])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b003b4cba4ef71sm9551416wmp.41.2022.12.09.03.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 03:35:38 -0800 (PST)
Message-ID: <36bdfd79eb715671f4e298b3ab5004a986ff8394.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cookerdata: Ensure layers use
 LAYERSERIES_COMPAT fairly
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan =?ISO-8859-1?Q?M=FCller-Klieser?= <S.Mueller-Klieser@phytec.de>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 09 Dec 2022 11:35:37 +0000
In-Reply-To: <34f25e412b1d1f277e3f5e0915106f07ab0387b8.camel@phytec.de>
References: <20221207124913.2108579-1-richard.purdie@linuxfoundation.org>
	 <34f25e412b1d1f277e3f5e0915106f07ab0387b8.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Dec 2022 11:35:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14161

Hi Stefan,

On Fri, 2022-12-09 at 11:07 +0000, Stefan M=C3=BCller-Klieser wrote:
> Am Mittwoch, dem 07.12.2022 um 12:49 +0000 schrieb Richard Purdie:
> > > Some layers think they're going to be 'clever' and copy the values fr=
om
>=20
> as I am one of those "clever" guys...

One of them, yes. You're not the only ones and the widespread adoption
of this was a big part of the concern.

>=20
> > > another layer, e.g. using ${LAYERSERIES_COMPAT_core}. The whole point=
 of
> > > this mechanism is to make it clear which releases a layer supports an=
d
>=20
> FYI we "disabled" the mechanism because its not helping us. Support for u=
s
> means commit level verification for hw+sw, so we had to implement somethi=
ng
> else anyway.

What you did was remove the indications of which releases your
layer/branch was compatible with. I understand you may want to do other
things as well but bypassing the checks really isn't in the spirit of
what we were trying to do.

> > > show when a layer master branch is bitrotting and is unmaintained.
>=20
> I understand the argument especially for master

There are a lot of layers out there which it is unclear what they're
compatible with and I do think having layers clearly indicate
compatibility (or not) with a given release series is a good thing.

> > > Therefore add some code to avoid people doing this. I wish we didn't =
have
> > > to but...
>=20
> I just noticed in the documentation the requirement for layer
> compatible 2.0, enforcing that mechanism. I will fix it asap.
>=20
> As, I guess, there are more cases like that in our layer, for
> the future, instead of enforcing rules on the code level, it would
> help us more to make the yocto compatibility layer program more
> accessible. I tried several times on the management level to
> get into the program, without success. Our company did
> not fit into the existing categories. If you have an idea in that
> direction, a PM would be appreciated.

To use the Yocto Project Compatible branding/badge you need to be a
member however you do not need to be a member to run the yocto-check-
layer script yourself. You can say that the script passes, or to run it
in automated CI and publish the result without any membership
requirement.=C2=A0

Is there something else we should be doing to make this more
accessible? I'd be interested in what options could make membership
more attractive to your management if you have any ideas.

Cheers,

Richard



