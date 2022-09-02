Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B2C001B5
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 15:54:16 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.336.1662134052571174587
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Sep 2022 08:54:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AfrmRiuO;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id
 az24-20020a05600c601800b003a842e4983cso1692027wmb.0
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Sep 2022 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=BP2CEYbc4P3H7UhpcHL1mWPdSiHG8Uwo2PAPj0Idd78=;
        b=AfrmRiuOOgvljqOx7tfJiZKW7gjyFtOHNXcsaJCeFBJmrH4dNUzsLgQkRKgc/Sb0lv
         vy2dOXgwedaW9i98LEnHHUj2qwzlXja93jyjFT50EXoUb0Qz2SDCFmfHosybrN35GLoS
         GRIAhx16NXA9JKZhJdwGjYW1VJ4A16vl2nqEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=BP2CEYbc4P3H7UhpcHL1mWPdSiHG8Uwo2PAPj0Idd78=;
        b=8HRkEYvdtHjvb1Hlub4ff0qt2e1NdS5Lxj2lqoDNIeJ8DeWMw+QsbDBflBQgS/YoOA
         M9rSEMKE/k/X/iHRZ0wHvevPRMJzwDbRdKQsUyTc3ETkLsg6vQGk94MAJ0vnNEZGYQ6M
         PIbLcgmyOK318MpwUeY4/7sSS6WW4c0p4aBijVlt6HU3X86ccga7JLzI0jG2BF6kzwzD
         c91Og4wCHmQvg1SAtPGT+CRlaNlYrvj/1m1UQ571Bd0tn3LVzVHPxvwA0g+ZGwDmD47n
         07L+WtwglUrB1B3ACTSIhouBvalAbiUPye2jUrMLsO5OhMKaG/GGDibxRDv77SwCisF/
         ynQw==
X-Gm-Message-State: ACgBeo0CLE6C+SsvT7S80TjMmk1JdDdarFrNdCAvd/iQ5LoYMdpEDAA1
	bMIv5n35LSA9DiAvx3hJFQXp6A==
X-Google-Smtp-Source: 
 AA6agR4h4J/RU7FeQ3B4qmJ00UF9dnr3UTFsHGK6p0dZN5gOn09JLZwlEtKM+diju4DE1mkgzkTcpg==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id
 u17-20020a7bc051000000b003a636fc8429mr3245400wmc.78.1662134050829;
        Fri, 02 Sep 2022 08:54:10 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:cbec:572b:ff3a:e320?
 ([2001:8b0:aba:5f3c:cbec:572b:ff3a:e320])
        by smtp.gmail.com with ESMTPSA id
 n34-20020a05600c3ba200b003a601707174sm2576316wms.33.2022.09.02.08.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:54:09 -0700 (PDT)
Message-ID: 
 <df0aa57c405aa7a4faf9e2de404d40d7aa48f424.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marek Vasut <marex@denx.de>, Peter Kjellerstedt
	 <peter.kjellerstedt@axis.com>, Quentin Schulz
	 <quentin.schulz@theobroma-systems.com>, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <Mikko.Rapeli@bmw.de>, Martin Jansa
 <Martin.Jansa@gmail.com>,  bitbake-devel
 <bitbake-devel@lists.openembedded.org>
Date: Fri, 02 Sep 2022 16:54:08 +0100
In-Reply-To: <eee248e8-351e-be94-1096-c5483fb8f5e5@denx.de>
References: <20220819165455.270130-1-marex@denx.de>
	 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
	 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
	 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
	 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
	 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
	 <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
	 <0761a8c9-78b4-0794-6bc3-14afd248ac16@theobroma-systems.com>
	 <fbf40e09-ff85-42c0-54d0-0bb8fc833e58@denx.de>
	 <54100db12fc1f75f28ca1592d5debf1cf164f723.camel@linuxfoundation.org>
	 <a96c3947126b49089b0f91e050dd0d3f@axis.com>
	 <3bd32832-e3fa-deaa-bf42-07b2d0534552@denx.de>
	 <eee248e8-351e-be94-1096-c5483fb8f5e5@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Sep 2022 15:54:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13952

On Thu, 2022-09-01 at 19:50 +0200, Marek Vasut wrote:
> On 8/22/22 18:39, Marek Vasut wrote:
>=20
> Hi,
>=20
> [...]
>=20
> > > I made some testing, and for Gerrit to continue to work it would be
> > > enough to use:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s=20
> > > refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*=20
> > > refs/changes/*:refs/changes/*" % (ud.basecmd, shlex.quote(repourl))
> > >=20
> > > This should not affect other Git servers and should avoid using
> > > different fetch commands depending on the URL. The drawback is of
> > > course that for Gerrit, there would be only marginal benefits to
> > > this change since the majority of its metadata is in the
> > > refs/changes space.
> > >=20
> > > However, I wonder if the suggested change actually has any significan=
t
> > > effect, given that the initial clone is done using --mirror, which me=
ans
> > > all refs/ spaces are fetched. If I remove the --mirror option from th=
e
> > > clone command the change works as expected, but I have no idea if tha=
t
> > > has any other significant impact...
> >=20
> > With this change, I am able to actually fetch mesa from=20
> > gitlab.freedesktop.org without local CI proxy terminating the connectio=
n=20
> > in the process. So yes, it does have effect.
>=20
> I keep running into this problem with mesa, how can we proceed to fix it=
=20
> upstream ?

We probably need a version of the patch which restricts by default but
allows it restriction to be turned off on a per url basis with a
parameter.

That restriction needs to be reflected in the mirror tarball name too.

Cheers,

Richard


