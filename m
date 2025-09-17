Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26952CAC59A
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 22:34:37 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.64.1758148469841901072
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 15:34:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gklxThOr;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso167523f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758148468; x=1758753268; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=firtlVxBuRJKFTLWzyXuBZNtFZeiO9hAojmeGEw0ISs=;
        b=gklxThOrn+f96ONiWah0QJCI3DJcH4a5K9dFEKU3eDVJjZJc0KuaoDkgWNco7H+HMo
         lkD7wNrEC6ljm11LP4coha50ditHBj2C5Dd6A896HvoyKV9OJPUdLuv7hsIwGwoNRFXT
         YedFipWN4hfLg6RwGY3BlXS32R5ZO7PSFA4n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148468; x=1758753268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=firtlVxBuRJKFTLWzyXuBZNtFZeiO9hAojmeGEw0ISs=;
        b=CDWFcwwy1Krg07bg27nYIC7VZvsBye3yEuuO2J8N94Q92ohugdaVNsoCIuUiN8YSzU
         weEzocWVegAKkIlxSIukMr0mmd0PtcJk8UrPTe8vOvVwO3WuQJMsai/3rV7ZKf9DhrFy
         L85YU+WkyRt4StWB3rzp6b1l7b7IPgXzv4/Ay2YD/X6P3ts5mxfziAVooUZisVnsIs6c
         5cJLudjUdvslNAG++LDKXqR1Eaj0toYoQ7pohqzzaPLB8y2ZprFCsA+dfex05Y1VwyM3
         6J/7pu4OpEWAjbvTefmre6sIhY1LeZ/PYjUa7P4ryjJfzhK+vJTH7j/FbqFRyZIS7Jr1
         IRJA==
X-Gm-Message-State: AOJu0YwBwMWd6Nia0DoJciUSlBIVeTGCd2Ts8CSjK7GRHXZzHiP2YT9r
	xo9WV1nGGcQx3ISNUeVSLiGxIEqfLKp9a3cQWB4Fd/PzehlDAkkaxqKRmY73Vpq6BHM=
X-Gm-Gg: ASbGncty1u56KX8nxJxCA87CvNfCiajBHHJ+U4q3OEBmhIV++zOEirLknsSvEmy+u2e
	fmgZQw98vnFCXAMOJWxbhcz/R1MIm6cjXgrok7LVOvyOLCfsZ7dV9ZukbiKh6tld3NqhcKu1o/I
	Qg2yItgImYht/tdMM0Qu0yBHLkrsk2q/K5qtZe3WRWswGMljBh+IsJUmmWpMYvz8nhkL2vJu0px
	ocWwvrPeZuOffrbtbKucwr2RJ7b/LzyvcC8iJ82A+i4Uu8vqhcYBZOVaXuylosT+x+AmErZWHke
	26rRurZ5eJt6IpMkWl9b/DyYU4LTNBO4cT1sxyRaNrAAfGsgfDrqcrttrl72q6mQXYAADlO+HuC
	xgGudDUtTb4TPGcxaSsFw8rP2On1GgaCSdfAger/J+XN/u2le02ixuUzR8biURbxg2aqzt+qV3z
	ja/fE3jPVfz00BHX2mQobrcVy0SJ0oGA==
X-Google-Smtp-Source: AGHT+IGTI58lBgtr7n0t/oBKS22J9KLP/pdeyHUDTDQu5I56En6JTYd4F/PFbNhZ7VWN9V6qiLsYXQ==
X-Received: by 2002:a05:6000:2407:b0:3ce:9872:fd3 with SMTP id ffacd0b85a97d-3ecdfa0d421mr3548305f8f.34.1758148468168;
        Wed, 17 Sep 2025 15:34:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a42a:bde0:2db0:730d? ([2001:8b0:aba:5f3c:a42a:bde0:2db0:730d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf3bfcsm958150f8f.58.2025.09.17.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 15:34:26 -0700 (PDT)
Message-ID: <5c83e6fb22b0d2b56d5a182e18fe528f68370075.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][walnascar][2.12][PATCH 2/2] bitbake:
 Bump version to 2.12.1
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Steve Sakoman <steve@sakoman.com>, Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 17 Sep 2025 23:34:24 +0100
In-Reply-To: <CAOSpxdaCKONLXZ-8aYWWb-jha7-P04-MGj1vSLKuZHbod=dFEA@mail.gmail.com>
References: <cover.1757519577.git.steve@sakoman.com>
	 <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
	 <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
	 <CAOSpxdbx6NRbf3DJdvDbVQswa839AeMbaD=Uv_5U9BJ-Qg-WRw@mail.gmail.com>
	 <CA+chaQfWY40HZhEiDr9dF5UDCFmQcqjRkxNgCDXFRpTYAPMLRg@mail.gmail.com>
	 <CAOSpxdaCKONLXZ-8aYWWb-jha7-P04-MGj1vSLKuZHbod=dFEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 22:34:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18059

On Wed, 2025-09-17 at 09:25 -0700, Steve Sakoman wrote:
> On Wed, Sep 17, 2025 at 7:05=E2=80=AFAM Martin Jansa <martin.jansa@gmail.=
com> wrote:
> >=20
> > I've sent the v2 of all 4 related changes to use 2.12.4 and 2.8.13.
> >=20
> > I've also noticed that the sanity check for bitbake version is
> > executed too late after the utils.py is already failing with:
> > ERROR: Unable to parse oe-core/meta/lib/oe/utils.py
> > Traceback (most recent call last):
> > =C2=A0 File "oe-core/meta/lib/oe/utils.py", line 11, in <module>
> > =C2=A0=C2=A0=C2=A0 from bb import multiprocessing
> > ImportError: cannot import name 'multiprocessing' from 'bb'
> > (bitbake/lib/bb/__init__.py)
> >=20
> > To avoid this issue I recommend to leave "lib/oe/utils: use
> > multiprocessing from bb" commit in oe-core scarthgap and walnascar for
> > some future batch and now merge just the bitbake version bump in
> > bitbake and the requirement for newer bitbake in oe-core, that way
> > people will hopefully update both before it gets really mandatory.
>=20
> I'll be doing the final walnascar build at the end of next week, so we
> either need to have this sorted by early next week, or just decide to
> leave things as they are with walnascar since it is going end of life.
>=20
> I'll pull the patches from scarthgap till we sort the proper version
> numbering and we can then stage them as you suggest.

I've pushed what I think makes sense, hopefully that gets things unblocked.

Cheers,

Richard

