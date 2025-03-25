Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9CEC3600B
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 17:49:10 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.2224.1742924947502939930
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 10:49:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EjCcMgzy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913b539aabso3284809f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1742924946; x=1743529746; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fGdQRUEJjttc6jTA3ESli94bm2GxQ09TBcWVbFkHxg=;
        b=EjCcMgzy7N1UmIR8zRzy9ZjVD3RBWnruY2oc+xYtH9dEoAud351zBJDr/XASjssRam
         P+ObUsx8oF4WeC2pU5cCqfx63HiAi405Gnkpz+3lfCt+xGlbymJbukZYwl0WDQRBHPyx
         WewN7X0uBm/76fXzhJ541RoBcbR3AdEdAwuxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742924946; x=1743529746;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fGdQRUEJjttc6jTA3ESli94bm2GxQ09TBcWVbFkHxg=;
        b=PDA4u4LsXkIWCXtYBq517s+9MvZ/sj0XmRqmcBDc11xpXKBRK5RnTVMH1kKseN0c3X
         k2kou9IW41IlLn1PYR9Y2+T73QSHJ3GsdAWcWHnousObiCNwIYnDQlrGF7nTgKNl16MI
         Gds7gh68kBLgu7rmULWHh2o8Xk2t9gGccW1WHaGUznlpqNtsNhmpt/o5M/4L41IstN6t
         QlsXgktdP7TztK5/RPjw2gyA7JpC53RUYe0/DUZRgKoshhiidmR12O8O4B9zSe7JJEdm
         14Y1W4DccL4cMuoLTnpLxa8PAGnd7vCb7txLi2S6t9cIpCvAQ4E8OyvR06Fe1aLF3pQI
         ce7g==
X-Forwarded-Encrypted: i=1; AJvYcCU4RmJK0nGfcXW34AGQJSS6DfeR9ex3j18hsyFzilIHUTVNFK+JZS+LMWYb5nVLQUoKeuAUqzwZgbG2tDJr@lists.openembedded.org
X-Gm-Message-State: AOJu0YypVkAhP26jYnI17bJVjnENfgH0zPgwjeZBlK4klwOyUQF1FSd3
	1dfFnHxImW7vv2+jU2iTuHaNpfQ9wmKFDnbUfF0N5nXfvdFTQ1w/L/PB+A6ZByY=
X-Gm-Gg: ASbGncuYAxGXDVLftHaX5GfbW44bbSrcK43zbEGOKb88V5YbqK4rS2l1mW0JVPmSadD
	ufwVAycnPtZdnpvpwDH8J3SXHKfx71QDI+EYwH/GQqpNHSvqTt38Pj+U1JIp+RgswTsm0KLGf9f
	B4OkzVcFCLZSpJwmTATbalkeg1Pob4jCjdbCdVdMiyeVWs5J5Z0dFU6Q9IJcaimN4wIxtYB/MCr
	KU9GWv6+auUHIFqYgtIHyuYjCnBPoD5//2+NTzB/cX2SXe72m03uzhcnJ3XVAZajpveI8MGN4Xb
	mvWpTROqusrShqL3/RpDRHyqt+UY1nWwpwPz+cdMorQH2PyBa5zP1GCPGOFiBR9vd88HIuCuHPw
	JhXKbJwI1iAhwpeSaBEz3MTZI+b9p+1RUBg7pa1Xlur6i
X-Google-Smtp-Source: AGHT+IEQx0H9sn55V5pVjNcWsDo0qIQwBx1Vs0eZB7q7dH8RwvdJpw6Fp+TBpgdGCRJi/dnvUmFMTA==
X-Received: by 2002:a5d:6d81:0:b0:391:29c0:83f5 with SMTP id ffacd0b85a97d-3997f94da3bmr16175842f8f.44.1742924945687;
        Tue, 25 Mar 2025 10:49:05 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:bd49:ef6e:5ada:f0b5? ([2001:8b0:aba:5f3c:bd49:ef6e:5ada:f0b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eef37sm14063962f8f.85.2025.03.25.10.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:49:05 -0700 (PDT)
Message-ID: <605de159f6b70b6750fa94cb5268511ff2ce84fd.camel@linuxfoundation.org>
Subject: Re: [docs] [bitbake-devel] [PATCH] doc: Mention `if [[
 somecondition ]]` is not supported
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@cherry.de>, javier.tia@linaro.org, 
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Mikko Rapeli <mikko.rapeli@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 25 Mar 2025 17:49:04 +0000
In-Reply-To: <92482b25-bd0e-4a9d-82f5-1fd4fdf473cb@cherry.de>
References: <20250320003358.977774-1-javier.tia@linaro.org>
	 <0531cca3-683c-4ec3-853c-59da9492c8b6@cherry.de>
	 <7275d5d500666f6278ec7937ab15ceb10cdf4f58.camel@linuxfoundation.org>
	 <92482b25-bd0e-4a9d-82f5-1fd4fdf473cb@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 17:49:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17493

On Tue, 2025-03-25 at 18:30 +0100, Quentin Schulz wrote:
> Hi Richard,
>=20
> On 3/25/25 11:14 AM, Richard Purdie wrote:
> > On Tue, 2025-03-25 at 11:04 +0100, Quentin Schulz via lists.yoctoprojec=
t.org wrote:
> > >=20
> > >=20
> > > On 3/20/25 1:33 AM, Javier Tia via lists.openembedded.org wrote:
> > > > I keep forgetting using `if [[ somecondition ]]` is not supported.
> > > >=20
> > > > Signed-off-by: Javier Tia <javier.tia@linaro.org>
> > > > ---
> > > > =C2=A0=C2=A0 doc/bitbake-user-manual/bitbake-user-manual-metadata.r=
st | 4 ++++
> > > > =C2=A0=C2=A0 1 file changed, 4 insertions(+)
> > > >=20
> > > > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.r=
st b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > > index 415fbf6d6..5474e154f 100644
> > > > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > > > @@ -1381,6 +1381,10 @@ To make use of this technique, you need the =
following things in place:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 To call your modified version of the=
 function as defined in your recipe,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call it as ``do_foo``.
> > > > =C2=A0=C2=A0=20
> > > > +=C2=A0=C2=A0 .. note::
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Conditional expression using ``[[ s=
omecondition ]]`` is not supported.
> > > > +
> > >=20
> > > Do you know what the reason is for that limitation?
> > >=20
> > > The example above this git context is not really implying `[[
> > > somecondition ]]` would be valid though.
> > >=20
> > > If I remember correctly, the shell functions are run by /bin/sh
> > > interpreter, so it depends on which shell you have configured by defa=
ult
> > > in your system. Is it possible this is due to you being used to devel=
op
> > > with bash where this is possible and having your Yocto build run with=
 a
> > > different shell (e.g. dash, which doesn't seem to support that? c.f.
> > > https://manned.org/dash.1)?
> > >=20
> > > I think we should recommend people write POSIX-compliant shell functi=
ons
> > > and tasks rather no?
> >=20
> > Bitbake parses the shell functions and our shell parser can't cope with
> > certain syntax unfortunately.
> >=20
>=20
> Ah, I see. This happens before the shell even runs the code. Do we=20
> happen to have a list of things/syntax we cannot parse?

There are open bugs. I did recently run into backgrounding not working
in the pseudo reproducer so I just used a separate script. Not sure we
want to support background processes though.

> I think it therefore deserves a bigger place than a small note, maybe
> e.g. a sub(sub...)section of limitations?

Patches welcome!

Cheers,

Richard

