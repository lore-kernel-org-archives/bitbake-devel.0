Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EBC25B75
	for <webhook@archiver.kernel.org>; Sun, 19 May 2024 14:36:19 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.39556.1716129374129812080
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 May 2024 07:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EyH4ouP/;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59e4136010so672010866b.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 19 May 2024 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716129372; x=1716734172; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tXkXy1OOpUqxzqO4ZFxbVWgI8RioUSqBQdiddaoy8k4=;
        b=EyH4ouP/9SFNch5awy4Q3ooWzUVNiVfHL7q1nTUhglqSteq4ydDfJsiMYBr0wzBcKh
         TssF3vVHLKwweHZV3s6EFF15UJGIe/Nmr0ri0y4mQuuNPmcaba4SwK6O3dfqr02p3Av0
         +JboOfJ/qBdlsTLWpvrra1Ey8dubOads2xcx623gC+wWv9tWHL4saPbhWQvfZU06sEmG
         NrdxQjHy6lOQtewH1kXFlkEJ/c5FrxHln8mmzc7JOzr5xliCzRXtiUTI4qw3t+bedSfN
         xmY3lGFMGO9Nvw+P23uG62PYBdrvKt0UWBJxWZxMEMljW4e3AZcUeQ/sYuiAeBXsFJTl
         snIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716129372; x=1716734172;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXkXy1OOpUqxzqO4ZFxbVWgI8RioUSqBQdiddaoy8k4=;
        b=YsFYrOcKStgL/hObcJNcY+L/YXmCdtYh3g5XKyXrPy86WJ32dsJhKxWmXCkmdkgZRP
         gbcFENUFCkjur9VVlw1mDbx4nbdHaDyMQtxYJxdRDeR5d83lg09pPRxV9O+7IfjBloSc
         fmv4sOaqcwQM1eXWV+HeTWlOJeT352Vp/FRkvo9Yb+D9gNMQQ0wCrswwuugKLNtPp9/D
         8Wo9/r+rKOfvk9D2UT7ztZ74ZIrQotGDeiZTkc//6V30wPn9K3vXMDUH+mkG+zSkvRhv
         Gpj8UdqFc+X6QhNB4curFJ4NecoHOp87+O0MedyblL95+EMIpFftm+AtllDXvOLsn5Ym
         NtZQ==
X-Gm-Message-State: AOJu0YwZMUmtWY7A3K4pbynco/3hDojB0QurHGdwY7JXfc3HiURJ58XP
	zliFxynjYreVRXvjij6OdJk0Vfr9ZjAS9+6Sb1ELofOig8rG9IEw
X-Google-Smtp-Source: AGHT+IGrkojTC3BITmVm88qkGCoAiRcXRdtSCrEyg5dR6xZqN9shQbycj6foLD4YCnfr6ipKzvtJPA==
X-Received: by 2002:a17:906:b0ca:b0:a59:9c58:763a with SMTP id a640c23a62f3a-a5a2d5ccb27mr1715508666b.46.1716129372495;
        Sun, 19 May 2024 07:36:12 -0700 (PDT)
Received: from wsadrian16.fritz.box ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b180c7sm1362213366b.221.2024.05.19.07.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 07:36:11 -0700 (PDT)
Message-ID: <2e6fb6d0ff671fbdd2721c6a6f0dfa07ad9a7ff1.camel@gmail.com>
Subject: Re: [bitbake-devel] Possible kirkstone 4.0.17 variable dependency
 bug
From: Adrian Freihofer <adrian.freihofer@gmail.com>
To: eric.sun@meraki.net
Cc: bitbake-devel@lists.openembedded.org, frederic.martinsons@gmail.com
Date: Sun, 19 May 2024 16:36:11 +0200
In-Reply-To: <CA+cAkepZ=ho2QzO6sCsSPKP_uOhoFPU0TgEd1+izE5y_HX6ONw@mail.gmail.com>
References: 
	<CAFSkHJ9opKaxq01b62+TztjqXWipHrayAwU=vCN3ZRAbO+G1-A@mail.gmail.com>
	 <CA+cAkepZ=ho2QzO6sCsSPKP_uOhoFPU0TgEd1+izE5y_HX6ONw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40app1) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 19 May 2024 14:36:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16231

Hi Eric

If I remember correctly, I suggested cherry-picking the problematic
patches to make Bitbake compatible with Python versions newer than
3.12.

Here is a patch to fix the backward compatibility with 3.6 and 3.7
again:
https://lists.openembedded.org/g/bitbake-devel/message/16230

@Frederic: The commit message explains how this can be reproduced.

Regards,
Adrian









On Sat, 2024-05-18 at 18:00 +0200, Frederic Martinsons via
lists.openembedded.org wrote:
> Hello,
>=20
> Do you mind elaborate a little about the issue? How it broke bitbake
> variable dependencies? Do you have a minimal example that show the
> problem?=C2=A0
>=20
> Thanks.=C2=A0
>=20
>=20
> Le ven. 17 mai 2024, 18:33, Eric Sun via lists.openembedded.org
> <eric.sun=3Dmeraki.net@lists.openembedded.org> a =C3=A9crit=C2=A0:
> > Hello,
> >=20
> > I believe commit 8ec4f29e432feec9d8deedc06bfb90d57e7436cf to the
> > kirkstone branch broke some variable dependency calculations in
> > python
> > 3.6 (and likely 3.7).
> >=20
> > Specifically, those python versions still parse string arguments to
> > functions in python expressions into ast.Str, rather than
> > ast.Constant. And so the code in question is no longer able to
> > determine dependencies involving e.g. bb.utils.contains.
> >=20
> > As an illustrative example, consider the results of the following:
> > import ast; print(ast.dump(ast.parse('f("a", "b", "c")')))
> >=20
> > Python 3.6:
> > Module(body=3D[Expr(value=3DCall(func=3DName(id=3D'f', ctx=3DLoad()),
> > args=3D[Str(s=3D'a'), Str(s=3D'b'), Str(s=3D'c')], keywords=3D[]))])
> >=20
> > Python 3.8:
> > Module(body=3D[Expr(value=3DCall(func=3DName(id=3D'f', ctx=3DLoad()),
> > args=3D[Constant(value=3D'a', kind=3DNone), Constant(value=3D'b',
> > kind=3DNone),
> > Constant(value=3D'c', kind=3DNone)], keywords=3D[]))], type_ignores=3D[=
])
> >=20
> > Happy to try to submit a patch if that'd be helpful. This is only
> > an
> > issue on kirkstone where the minimum required python version is
> > 3.6.
> >=20
> > Thanks,
> > Eric Sun
> >=20
> >=20
> >=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16229):
> https://lists.openembedded.org/g/bitbake-devel/message/16229
> Mute This Topic: https://lists.openembedded.org/mt/106157110/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


