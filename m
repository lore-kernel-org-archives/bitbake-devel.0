Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D22C7618D
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 12:14:35 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.156676.1680783264609637406
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 05:14:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gXOx/N05;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id n19-20020a05600c501300b003f064936c3eso2820197wmr.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680783263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9X6qwvUpycKtmn5LTbmHG/gtlQ+fQFuHz94d/WsEjc=;
        b=gXOx/N05ztnwN65vdbwXhztqYMl5j4Xz4EjSbe9j2YXx5W6r75OcSQ5LQ1RktXrjiv
         CXoWNizSq9vUW1LNLT3+mWQTV+Qm2urZ2DqZ5bW3scsIFLshjKxwBYW8BLUd9iS2NfW5
         dpvGjG1XlSIuvabcjVEsVcFnhT2elz5V6xjYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680783263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9X6qwvUpycKtmn5LTbmHG/gtlQ+fQFuHz94d/WsEjc=;
        b=q5CqyAfNg2DH031yZ9ERoLSsWTiJYQmVjxDPMffXGA/xYjYRddwqhPn47kQg3i8Lwu
         LxEwlMQvKQoTbycIP7IVde/r4ppNqBdM5nyMQO2B1q6PKo/xPVinIw1APlqYZsEVr1bJ
         NllVaU1ei/paDLbRrXlM86+dE2Tt+TUGrgUUiKw3xwkmsORXgB6FTYDob1JobxV82BK7
         CL9pmmOSe7eh0hdv56WD180uPEN3FAO0f3PtOlQpfsbRF+HQv6OqDwH4Jy0uSEbNw+r7
         nmycL+ZMxivHYFjSZI/cB1bn8IEZzy6pFFb9bFLdl9LfcTWNf3I7Jswn4chmrwx6hmdZ
         amCw==
X-Gm-Message-State: AAQBX9dGAkSlDgwDPB8eE5PKCBmEpnJ6qpwl8Vie5S7WJp6HMVpIFg/T
	ebFm23qev5RwNE+qkeQI8f6iCA==
X-Google-Smtp-Source: AKy350afZfll1pZKu8LR7dD5CBZtHLRoPvCmbSRAsqMbJI9Ej9vcVhlglTwG0ND2h7EeNkko0MrY/w==
X-Received: by 2002:a05:600c:28f:b0:3ea:bc08:b63e with SMTP id 15-20020a05600c028f00b003eabc08b63emr7398227wmk.2.1680783262886;
        Thu, 06 Apr 2023 05:14:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a84:552d:cd38:8d5? ([2001:8b0:aba:5f3c:6a84:552d:cd38:8d5])
        by smtp.gmail.com with ESMTPSA id j2-20020adfff82000000b002c7107ce17fsm1679807wrr.3.2023.04.06.05.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:14:22 -0700 (PDT)
Message-ID: <ab8238c55687c8db85f9325a13f31b95c228c33c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name'
 entries
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 06 Apr 2023 13:14:21 +0100
In-Reply-To: <ly4jptcnwi.fsf@ensc-pc.intern.sigma-chemnitz.de>
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
	 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
	 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
	 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <17530ADB1695B5D1.3977@lists.openembedded.org>
	 <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
	 <ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
	 <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
	 <ly4jptcnwi.fsf@ensc-pc.intern.sigma-chemnitz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 12:14:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14671

On Thu, 2023-04-06 at 12:20 +0200, Enrico Scholz wrote:
> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>=20
> > > > It will break cargo related recipes which were created between
> > > > 2023-03-16 and 2023-03-31.=C2=A0 Packages before this date do not
> > > > contain sha256sum and after this date, they have an explicit
> > > > 'name' (which matches the one generated by my patch).
> > >=20
> > > Ok, I guess these dates match my patches series, if I do things
> > > rights, I handle all the recipes I know of (in meta-openembedded and
> > > openembedded-core at least)=C2=A0
> >=20
> > This now gives me a problem as rc1 for 4.2 built yesterday. I'm
> > guessing we don't want a stable release series with one form for urls
> > for six months and a different one in master?
> >=20
> > Does this mean I need to scrap rc1, merge this, wait for the recipe
> > updates and then rebuild the release?
>=20
> To avoid breaking builds:
>=20
> 1. OE recipes without explicit ';name=3D' need to be updated; this can be
>    done by 'bitbake -c update_crates'.  Afais, this affects only
>   =20
>    | meta/recipes-devtools/python/python3-bcrypt_4.0.1.bb
>    | meta/recipes-devtools/python/python3-cryptography_39.0.2.bb
>=20
>    and in oe-meta
>=20
>    | meta-oe/recipes-core/uutils-coreutils/uutils-coreutils_0.0.17.bb
>    | meta-python/recipes-devtools/python/python3-pyruvate_1.1.2.bb
>=20
> 2. the patch can be applied to bitbake
>=20
> 3. [optionally] change cargo-update-recipe-crates.bbclass to remove the
>    explicit (and now redundant) ';name=3D' from generated SRC_URI list.
>    This can be done post-mickledore

I've gone ahead and stopped rc1 since I know in the long run this issue
is going to cause problems.

Short term I'll merge this patch and the fixes needed to the oe-core
recipes.=20

Now I've been looking more closely at this, I did start to wonder if we
shouldn't just put ;sha256sum=3DXXX parameters onto the crate urls we
generate though? If we do that, we don't need to name them at all.

That is something we could move to at a later date if it make sense so
it is less important from a release standpoint.

Cheers,

Richard

