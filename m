Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55DCCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 15:15:48 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18181.1762442139284821590
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 07:15:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cCjX6mNe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42421b1514fso608074f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 07:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762442138; x=1763046938; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRnsTz/8dghldaZySLGk7NsHNME9HtgpwhIDdNdbKqI=;
        b=cCjX6mNeK8zOghRn+Gf6XDDvay615j7rqoFVBCY8k26ixtsVm2NhvCDSlb90R9QbsU
         CHY4v3EX38MR8EjMNK+nSeW/oM1uPq8a/Wpr9UffP6hoSs6NMnC7mVaDfycKYUDyWGB+
         2EZWvwRHsw8EprXzfczoqqsQoQ727HhEXx5bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442138; x=1763046938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRnsTz/8dghldaZySLGk7NsHNME9HtgpwhIDdNdbKqI=;
        b=SdpNiP6+hb1ADE81j8R7jH1fwtMKFPqXHYAZuWgLkYtvg0KXIZiAkUXjSb1io/Uby0
         XBM8L6Wt+iRMJ0D35iYC1iwF4bI5aWZRoslBZku1SrcZFB3amQlVAomUwR1GC7K6D3l4
         K5gmndXJqo0picisMHp8sG4/alMHLnG0X1IcEYZov5CDfM+q9xh5CcsWJ2fdkDYJiXuz
         tp3PV/FfxN8iUR58mWdyjoGWv9LDAfH8hU6kHbT1MvXdZltA/ZLk0AhWoL0V5wyksaYh
         GvCnkh5m20B13RwiHULK7hy+s4VZR5M6CMebuVvl4r50rFwHHgiaX1RbpRMmMD+5rUu2
         7CCQ==
X-Gm-Message-State: AOJu0YyypMflPw5Mz+J6cJ5IIbRiP+6nlb3ginnciwRkoARbGjU99pTr
	UpN5PSwYSpP5CoxwJTKkphEAX6XKyRHtGeOwv035UF5BurHyOuM+iAmUyoorQtRYDEY=
X-Gm-Gg: ASbGnct+dzT1nAIkMdUFfotk5oaxSLJZQgJRifS2VO/DeqZ8gctbkoMCTO5n0i9gj0F
	+ZUMd13jLSuxR/SbpzK8mWqHMURzojSxIMEL0nkJ6b82vN0LMYKnvWUZcd2q8roOBoip3iLf6BA
	LaYApe8jpStiJ0oLvmx8feH45zLTUIec+dXTIoK27HCz3krY+WUr+VAuWK980ssC9CBnmxjkGLs
	JpF0USSkwGQ78bmHHMAuXGXa+dLc54W1lTiTrQu6pPTIR/t6myq4XVYsdoi0pObQUErUlOD7I2b
	UAMg+SqSQj3SvvgfKob72CCrOi8IqkCCHSaoXcyLopJh8d3rQgEhN0kzeUpbm0oa2OPGBwrqofG
	kGm/In5xHvb42AZkiTa+54i2a3yDoAzrFzLAcfR4c9aOL6Vz+NEXWtKv1ybrIaS2XlpRrZhALR3
	GtLalQCrl5LKEd0sUAb97r6g9xn4MlsfZXWeTi/pk6HSJAFWQVx8NtPBLdYKZGPSJn
X-Google-Smtp-Source: AGHT+IEfppOWJdBwGmztf3oFwhJZST/3wTiMilLrbaitM2Dxi5Hw8RMbDXGwZE6NgNhYCz2VhNFZpA==
X-Received: by 2002:a05:6000:4026:b0:429:d40e:fa40 with SMTP id ffacd0b85a97d-429e330b7e9mr6069801f8f.45.1762442137632;
        Thu, 06 Nov 2025 07:15:37 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4ec6:c811:ddd8:770d? ([2001:8b0:aba:5f3c:4ec6:c811:ddd8:770d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb3951c6sm5836010f8f.0.2025.11.06.07.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:15:36 -0800 (PST)
Message-ID: <278bb2544a713588af57889f35197e0c6f424c8b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: replace {THISDIR} token
 with an explicit keyword
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: alex.kanavin@gmail.com, Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, Alexander Kanavin
 <alex@linutronix.de>
Date: Thu, 06 Nov 2025 15:15:35 +0000
In-Reply-To: <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
References: <20251106114714.918370-1-alex.kanavin@gmail.com>
	 <DE1LO4GV39WM.156UBA1PODPOV@bootlin.com>
	 <CANNYZj-pgb6SMxhzB4g-siGY7oWaNjb=jOSk3m-TRKLwHPytFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 15:15:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18291

On Thu, 2025-11-06 at 13:28 +0100, Alexander Kanavin via lists.openembedded=
.org wrote:
> On Thu 6. Nov 2025 at 13.11, Antonin Godard <antonin.godard@bootlin.com> =
wrote:
> > Hi,
> >=20
> > On Thu Nov 6, 2025 at 12:47 PM CET, Alexander Kanavin via lists.openemb=
edded.org wrote:
> > > From: Alexander Kanavin <alex@linutronix.de>
> > >=20
> > > {THISDIR} is a special value token that can be used in the list of en=
abled
> > > layers to specify the layer location relative to the confguration fil=
e:
> > > https://git.openembedded.org/bitbake/commit/?id=3Db3153be29de8b8570b0=
c184369bd41f4c646cf92
> > >=20
> > > This replaces the token with an explicit separate keyword for such la=
yers:
> > > so that special processing to determine the final value can be avoide=
d, and
> > > the feature can be formalized in the json schema:
> > >=20
> > > instead of
> > > =C2=A0 =C2=A0 "bb-layers": [
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"{THISDIR}/meta-my-project"
> > > =C2=A0 =C2=A0 =C2=A0]
> > >=20
> > > this allows
> > > =C2=A0 =C2=A0 "bb-layers-relative-to-this-file": [
> >=20
> > Can I suggest naming it "bb-layers-local"? "bb-layers-relative-to-this-=
file"
> > feels bit overwhelming, I think with associated documentation users wil=
l be
> > able to figure what "local" stands for in this case.
> >=20
>=20
>=20
>=20
> =E2=80=98Local=E2=80=99 implies the path can be absolute, which is not su=
pported, and it doesn=E2=80=99t suggest what the path should be relative to=
. I=E2=80=99d rather make it longer but clearer.

bb-layers-relative maybe?

bb-layers-relative-to-this-file is precise but does feel a bit too
unwieldy. Any other options?

Cheers,

Richard

