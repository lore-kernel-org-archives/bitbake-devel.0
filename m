Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C082C7618D
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 10:15:14 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.154850.1680776109203993127
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 03:15:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EaMVXtaX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso25252330wms.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680776107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bmApJ2balUlAFZtPTRS9hO3tvqCZa2L5kftampGYhNw=;
        b=EaMVXtaXZ5I031BWIQsLQ2uPXMFsLH1tOEZ9sT/uQRigl5xJzk5VtRT+QUb2LbSzmh
         jz0pcRW90I2pfmtc2wY2WFiv0gGMPx25hhybw6FjwoHDu9+RmB9tIRDNRoYCbghF1yPU
         dhN3cOIcmmTHa2FL83h5TjrZmKFgAoZUKtJpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680776107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmApJ2balUlAFZtPTRS9hO3tvqCZa2L5kftampGYhNw=;
        b=WpVc+MKb8kGW96Xb1K/7Sp4v0rCDRiesgW302KsnDCg//uxm60/mpxICdUpqktqmuB
         yrU0v4nFWtNjzh7WPcM/EdUCJgipn5caPLuP/gscv0dgOVAHnyyekoniat0dKE8OVZlu
         Bro71U9yXU4kcaRkBKqyW5VUhUH/BKS4fRL7xDhEdEm2XAOKtbwYPHdlIqzxxeMr76nN
         U39CKE7+Y11ILKLAtiKJsrOlLAA2jMVYrqYIcjA+VOgjAKS+etmgtkrTTKiWxdaCF0Sv
         4nYhnlx0ZB0JK31fY0cen1feHBwbLnQrbP9TLsqR+1cocHjfTVMY8GXWV0nrysGVMNin
         A9qw==
X-Gm-Message-State: AAQBX9ctxix2DIV6XnTRdarN2p/J4cQ3fl4LOcerZjfEe4Dcq0BKfxxZ
	7cduA2cxPKff3CTA5nZ8GYhvQIwsnhAslatM/fM=
X-Google-Smtp-Source: AKy350aI9znLHg6zZQ4rOb0XWCwusuUg3NzJB2DzKNA+wd6REFMZ+j9JN8expvFWGFW8FLnAiCdeZA==
X-Received: by 2002:a05:600c:3794:b0:3f0:6ada:f445 with SMTP id o20-20020a05600c379400b003f06adaf445mr1118970wmr.33.1680776107488;
        Thu, 06 Apr 2023 03:15:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6a84:552d:cd38:8d5? ([2001:8b0:aba:5f3c:6a84:552d:cd38:8d5])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b003edddae1068sm4881228wmb.9.2023.04.06.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 03:15:07 -0700 (PDT)
Message-ID: <51a95669a4cc3ddecc5382786bc9f009a5fd97d1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name'
 entries
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Martinsons <frederic.martinsons@gmail.com>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 06 Apr 2023 11:15:06 +0100
In-Reply-To: <CA+cAkeq2e=F-LUqkODdQPTgL7VzzAKGssks2z0rEc0AHLH-DAA@mail.gmail.com>
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
	 <CA+cAkeq2e=F-LUqkODdQPTgL7VzzAKGssks2z0rEc0AHLH-DAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 10:15:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14667

On Thu, 2023-04-06 at 12:05 +0200, Fr=C3=A9d=C3=A9ric Martinsons wrote:
>=20
>=20
> Le jeu. 6 avr. 2023, 10:45, Richard Purdie
> <richard.purdie@linuxfoundation.org> a =C3=A9crit=C2=A0:
> > On Wed, 2023-04-05 at 19:05 +0200, Frederic Martinsons wrote:
> > >=20
> > >=20
> > > Le mer. 5 avr. 2023, 18:45, Enrico Scholz
> > > <enrico.scholz@sigma-chemnitz.de> a =C3=A9crit=C2=A0:
> > > > Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> write=
s:
> > > >=20
> > > > > No, I take that back, it should not be an issue since you set
> > > > > the
> > > > > name
> > > > > only if it is not already there. But, to be sure, did you try
> > > > > to
> > > > > build
> > > > > some existing cargo based recipe (zvariant but also python3-
> > > > > bcrypt for
> > > > > example).
> > > >=20
> > > > It will break cargo related recipes which were created between
> > > > 2023-03-16
> > > > and 2023-03-31.=C2=A0 Packages before this date do not contain
> > > > sha256sum
> > > > and
> > > > after this date, they have an explicit 'name' (which matches
> > > > the
> > > > one
> > > > generated by my patch).
> > > >=20
> > > >=20
> > > > Enrico
> > >=20
> > > Ok, I guess these dates match my patches series, if I do things
> > > rights, I handle all the recipes I know of (in meta-openembedded
> > > and
> > > openembedded-core at least)=C2=A0
> >=20
> > This now gives me a problem as rc1 for 4.2 built yesterday. I'm
> > guessing we don't want a stable release series with one form for
> > urls
> > for six months and a different one in master?
> >=20
> > Does this mean I need to scrap rc1, merge this, wait for the recipe
> > updates and then rebuild the release?
> >=20
> > Cheers,
> >=20
> > Richard
>=20
> I'm not sure I understand, is the patch we talk already merged? In
> the 4.2?=C2=A0

4.2 is what is in the mickledore and bitbake 2.4 branches, i.e. the
recent changes but without the patch in this thread.

> This patch seems to me an improvement and without it, all the recipes
> I know of was correctly built (even those in meta-security from what
> I read from Armin in
> https://lists.openembedded.org/g/bitbake-devel/message/14658)=C2=A0

I'm worried that people seem to be saying we need the patch in this
thread but it creates an incompatibility with what was already updated
previously.

Cheers,

Richard





