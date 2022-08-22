Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD05C28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 14:17:35 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.18858.1661177850312488263
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 07:17:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mx6OEckL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id d16so8113232wrr.3
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Aug 2022 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=UO1HsTfJrpJ2DtgS06QirndQiJHXZtCEUud/VDY505o=;
        b=Mx6OEckL5AyH60caO1W4JmuvV+2MTfvPwhJUPKu0mnOT6aqvCmjlGqqsw/WDGRSKf6
         Ugm897YLfmq4P1GdT0/ACt4s4au30jK04j19vzg+9cDpAbguSDCSI/RCy1r4pbd2url9
         q24/Kcu/9Coodz3H6f4BV2NOSuOfNR9AF7ZBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=UO1HsTfJrpJ2DtgS06QirndQiJHXZtCEUud/VDY505o=;
        b=ZX1Zyf1pITJkHLWc7bpoJboGR0yPSbTHpvvm4lze0oYNpxOfWLfqHKajs1XLIgdpC8
         vFNUVAVS3042dX9+SUp9uzxOfDAbteHHUj1f/YCNU6ddAs1AXHoTo1ZoRElQPTYHBDcY
         ib0+pFoo/ptQxgXdCW9vsW/WDKlE4kBQWIN/iAnEBrqHKgzDMvxSBNenOm7Mlzer9CJD
         amnByvmvZcL2FPzyeU4ZelmbMzAY6kiK5mE9kwZG0geXbIfczvlQtuRZpLKnTvsfzIy2
         CGZJK1Db8xbHYQha58e+jf40YmSyIUMEzRg5JViTyt5MF9+a5N4tebgO2+LiwLWTZoZV
         k62w==
X-Gm-Message-State: ACgBeo2TlvWree/V7UKq+CoInThcvaX1/2SVunGyhlysQnf7CMAv5D48
	BkpEFgIfauYFqAlBm2rTOuE6Vg==
X-Google-Smtp-Source: 
 AA6agR7e/lJgt860UTH1gwgXq7Zch6YFzGD4ZFVx77wJg7cDQWdRX+OWZjxunlA214i3/2RlG4zhUQ==
X-Received: by 2002:a05:6000:1f01:b0:225:5307:132e with SMTP id
 bv1-20020a0560001f0100b002255307132emr3867779wrb.303.1661177848754;
        Mon, 22 Aug 2022 07:17:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a4a9:e65c:bb6e:14cc?
 ([2001:8b0:aba:5f3c:a4a9:e65c:bb6e:14cc])
        by smtp.gmail.com with ESMTPSA id
 m27-20020a056000181b00b0022549ac786asm6393585wrh.47.2022.08.22.07.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:17:27 -0700 (PDT)
Message-ID: 
 <54100db12fc1f75f28ca1592d5debf1cf164f723.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marek Vasut <marex@denx.de>, Quentin Schulz
	 <quentin.schulz@theobroma-systems.com>, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: Mikko Rapeli <Mikko.Rapeli@bmw.de>, Martin Jansa
 <Martin.Jansa@gmail.com>,  bitbake-devel
 <bitbake-devel@lists.openembedded.org>, Peter Kjellerstedt
 <peter.kjellerstedt@axis.com>
Date: Mon, 22 Aug 2022 15:17:26 +0100
In-Reply-To: <fbf40e09-ff85-42c0-54d0-0bb8fc833e58@denx.de>
References: <20220819165455.270130-1-marex@denx.de>
	 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com> <YwMR+H8KWePvpJtn@korppu>
	 <CANNYZj_Ag2Y8ZTXVgwagGv+26+HKPM31SRq8p3h4EL0PUEPefQ@mail.gmail.com>
	 <YwMyXi/vfRh3S6bx@korppu> <7b3d167e-17c0-c236-d0a7-97c4b0fd8e27@denx.de>
	 <c4c53113-49bd-ec7b-b5dd-f510c281f013@denx.de>
	 <CANNYZj_LPwamXHBTj=g8_+ZGaL2WF+s0EOcGKf5VJYfxUyOq6g@mail.gmail.com>
	 <438756a1-efb1-cd7e-2c80-af60f8b2fcdc@denx.de>
	 <0761a8c9-78b4-0794-6bc3-14afd248ac16@theobroma-systems.com>
	 <fbf40e09-ff85-42c0-54d0-0bb8fc833e58@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 14:17:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13922

On Mon, 2022-08-22 at 13:55 +0200, Marek Vasut wrote:
> On 8/22/22 12:57, Quentin Schulz wrote:
> > Hi Marek,
> >=20
> > On 8/22/22 12:35, Marek Vasut wrote:
> > > On 8/22/22 10:41, Alexander Kanavin wrote:
> > > > On Mon, 22 Aug 2022 at 10:37, Marek Vasut <marex@denx.de> wrote:
> > > >=20
> > > > > > So maybe the easy way out is, if nobranch=3D1 then fetch everyt=
hing,=20
> > > > > > else
> > > > > > just heads and tags ?
> > > > >=20
> > > > > No, this won't do, nobranch expects the commit to be in a tag.
> > > >=20
> > > > I don't think it expects that.
> > >=20
> > > Documentation says it does:
> > >=20
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.openembedd=
ed.org_bitbake_tree_lib_bb_fetch2_git.py-23n45&d=3DDwICaQ&c=3D_sEr5x9kUWhuk=
4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172II=
y1t&m=3DuZNWVMGEowy_ntO8q5fjINXu3LIe9haqbSTYjwWiqO6Q5sEPsUIx5nw28YTBw6oI&s=
=3D_AJ3mkGnnM8peSNP8k6MePZ0RtEkQLo7yS1Cll2yjmc&e=3D "
> > > - nobranch
> > > =C2=A0=C2=A0=C2=A0 Don't check the SHA validation for branch. set thi=
s option for the=20
> > > recipe
> > > =C2=A0=C2=A0=C2=A0 referring to commit which is valid in tag instead =
of branch.
> >=20
> > I assume this was meant to give the example of tags which aren't=20
> > necessarily in a branch (annotated tags or tags of commits not belong t=
o=20
> > any branch anymore (force-push for example, or branch deletion).
> >=20
> > The git fetcher does a git log --pretty=3Doneline -n 1 <hash> when=20
> > nobranch is set, otherwise git branch --contains <hash> --list <branch>=
=20
> > to check whether a commit exists and can be used by bitbake.
> >=20
> > Considering this check, I assume nobranch=3D1 is working for any commit=
=20
> > that was fetched by the git fetcher?
> >=20
> > (We need to update the docs to reflect that in that case).
>=20
> In that case, 'git fetch refs/*' in case nobranch is set and 'refs/head=
=20
> refs/tags' otherwise ?

This does get a bit more complex though since you now need two
different mirror tarballs, one for each option. The code can do that if
setup correctly but we do need to cover that issue.

Cheers,

Richard


