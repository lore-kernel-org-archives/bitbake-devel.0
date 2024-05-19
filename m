Return-Path: <eric.sun@meraki.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB78C25B75
	for <webhook@archiver.kernel.org>; Sun, 19 May 2024 16:21:49 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web11.42012.1716135701467166244
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 May 2024 09:21:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@meraki.net header.s=google header.b=mlC4S9+M;
 spf=pass (domain: meraki.net, ip: 209.85.128.177, mailfrom: eric.sun@meraki.net)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-622e32414ffso17746917b3.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 19 May 2024 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meraki.net; s=google; t=1716135700; x=1716740500; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQpcSfoPG2w2tvxeHbPlrztKPBmbuW2W9yCzUXy6jG4=;
        b=mlC4S9+MAa5fr4QZy0Hbv3W0zKYysSiedsxr7QLZjRHqjnScXG2JXgifAzLVt8+eat
         ECJkkPu+VS8druj/eVFs0y8fL344kMF7f+FKsxM4AFIShi3WyphCfLVF0sPyXimRpmyl
         6NuXlH7XyIEAG5TCZHZm22AlyXBlAR9lSURZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716135700; x=1716740500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQpcSfoPG2w2tvxeHbPlrztKPBmbuW2W9yCzUXy6jG4=;
        b=hG1Xk22V/ftHjTTRcIs8oe6dAFfhMENF/vj4EzTt93UqQHjAWjZ325sQA4U+W/luIr
         d2FwUfokuN9Dc7/zagEE0PKuYaXpteNmC+SJ8BN8eNs1O598bqA0WmRR9r8tgJAELUup
         CiFnClguB2n4Lufr4ZdwfE7fYXu41F3Adc3LaFY6niGM3kVT/2korNRHIWD0nsbvIOAo
         9B3AUekl0qCwYTaxiYLzC8kvh0I59dmmA77ldeMpdNE/n45eRmWQWI989Eqaz0fr2Z9L
         Go7yRpOBFWU8OnWnPsPtTeOnZ0gf/pEP3UjSUB2zJSwbQ9dsxw5bgMJlAP5jK/QjdyEk
         R0uA==
X-Gm-Message-State: AOJu0YzIUOl3sDsAwPqcx9ZJ3IqiqnTpuERRbBjTL1NdePjywFWBVtwu
	MqhYrjpCpa8rIH5EuPICZ/lvvUD+iqNv1d9/GIVEshSrUzA8aYP8QlCL5Pbm13WqQA4VTXgW/1s
	8vWnvNS0mdjNNC+ULbAZW+xUzoo//QG2Lhkm7
X-Google-Smtp-Source: AGHT+IFPtyZXRYIB3EK/EIW0EpUUKVyxYgTWslD+T/SWtrPp5WiaYWx4MKyVehMwaNnwN2TfstjIhb/F1MxTF16/bDc=
X-Received: by 2002:a5b:94b:0:b0:df4:9049:e2d9 with SMTP id
 3f1490d57ef6-df49049e4d0mr6780444276.4.1716135700601; Sun, 19 May 2024
 09:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFSkHJ9opKaxq01b62+TztjqXWipHrayAwU=vCN3ZRAbO+G1-A@mail.gmail.com>
 <CA+cAkepZ=ho2QzO6sCsSPKP_uOhoFPU0TgEd1+izE5y_HX6ONw@mail.gmail.com> <2e6fb6d0ff671fbdd2721c6a6f0dfa07ad9a7ff1.camel@gmail.com>
In-Reply-To: <2e6fb6d0ff671fbdd2721c6a6f0dfa07ad9a7ff1.camel@gmail.com>
From: Eric Sun <eric.sun@meraki.net>
Date: Sun, 19 May 2024 09:21:29 -0700
Message-ID: <CAFSkHJ83PW1=DAiPBOr-Rq6vR17nzKA0in42q9nWUD=7ba+8EQ@mail.gmail.com>
Subject: Re: [bitbake-devel] Possible kirkstone 4.0.17 variable dependency bug
To: Adrian Freihofer <adrian.freihofer@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, frederic.martinsons@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 19 May 2024 16:21:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16232

Thanks Adrian and Frederic! Looking forward to picking up this fix.
I'll put together a better repro for any future issues I report.

Eric Sun

On Sun, May 19, 2024 at 7:36=E2=80=AFAM Adrian Freihofer
<adrian.freihofer@gmail.com> wrote:
>
> Hi Eric
>
> If I remember correctly, I suggested cherry-picking the problematic
> patches to make Bitbake compatible with Python versions newer than
> 3.12.
>
> Here is a patch to fix the backward compatibility with 3.6 and 3.7
> again:
> https://lists.openembedded.org/g/bitbake-devel/message/16230
>
> @Frederic: The commit message explains how this can be reproduced.
>
> Regards,
> Adrian
>
>
>
>
>
>
>
>
>
> On Sat, 2024-05-18 at 18:00 +0200, Frederic Martinsons via
> lists.openembedded.org wrote:
> > Hello,
> >
> > Do you mind elaborate a little about the issue? How it broke bitbake
> > variable dependencies? Do you have a minimal example that show the
> > problem?
> >
> > Thanks.
> >
> >
> > Le ven. 17 mai 2024, 18:33, Eric Sun via lists.openembedded.org
> > <eric.sun=3Dmeraki.net@lists.openembedded.org> a =C3=A9crit :
> > > Hello,
> > >
> > > I believe commit 8ec4f29e432feec9d8deedc06bfb90d57e7436cf to the
> > > kirkstone branch broke some variable dependency calculations in
> > > python
> > > 3.6 (and likely 3.7).
> > >
> > > Specifically, those python versions still parse string arguments to
> > > functions in python expressions into ast.Str, rather than
> > > ast.Constant. And so the code in question is no longer able to
> > > determine dependencies involving e.g. bb.utils.contains.
> > >
> > > As an illustrative example, consider the results of the following:
> > > import ast; print(ast.dump(ast.parse('f("a", "b", "c")')))
> > >
> > > Python 3.6:
> > > Module(body=3D[Expr(value=3DCall(func=3DName(id=3D'f', ctx=3DLoad()),
> > > args=3D[Str(s=3D'a'), Str(s=3D'b'), Str(s=3D'c')], keywords=3D[]))])
> > >
> > > Python 3.8:
> > > Module(body=3D[Expr(value=3DCall(func=3DName(id=3D'f', ctx=3DLoad()),
> > > args=3D[Constant(value=3D'a', kind=3DNone), Constant(value=3D'b',
> > > kind=3DNone),
> > > Constant(value=3D'c', kind=3DNone)], keywords=3D[]))], type_ignores=
=3D[])
> > >
> > > Happy to try to submit a patch if that'd be helpful. This is only
> > > an
> > > issue on kirkstone where the minimum required python version is
> > > 3.6.
> > >
> > > Thanks,
> > > Eric Sun
> > >
> > >
> > >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#16229):
> > https://lists.openembedded.org/g/bitbake-devel/message/16229
> > Mute This Topic: https://lists.openembedded.org/mt/106157110/4454582
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe:
> > https://lists.openembedded.org/g/bitbake-devel/unsub [adrian.freihofer@=
gmail.com
> > ]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
>

