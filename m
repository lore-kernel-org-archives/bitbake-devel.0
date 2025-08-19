Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B0CA0EF5
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 10:44:03 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.11030.1755600237937617079
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 03:43:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dUiZ7a+k;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso28489795e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 03:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755600236; x=1756205036; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIWrsoVpV47qnhONXV2zbGFbo40zQKPFTuhSQ4nuBI0=;
        b=dUiZ7a+kXzFbdeJZ9QWtutznDymoG16v/lvOVCc2WViQ61ramp/RGQUPiazXUINlKw
         c1UhpDSr0znURXI9LZ4WnvyBwZKxdv4vSb0cVkzGPJva9S/zoHSvX+V5gThehVpbJC9H
         Qw7EQB6Kw9Cz1hpPbvpdXDDJ3TF1alR8cmJGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600236; x=1756205036;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kIWrsoVpV47qnhONXV2zbGFbo40zQKPFTuhSQ4nuBI0=;
        b=AsFGTDlstslBsT1m4wQDltYQjUlHxgyRZwJLl+rOmVdDnW51K8iaDIZdeNdlnXTLU5
         n8L+WKdOJuLQPwSBmMQ70O3QecIhbgW34bj3xVEsA/n6ZdJc5K03kV7mSVyR96eBPkNf
         lSObg7d9ZBt892fhUdsGZIZGE+QSGJXwqP/rbQUDpJK8WjlhlCZUvKE2fcPX4ovEDS2q
         bKtn6Twyi+y+zXMSbSx0Bs09+E+MD1DF2RK9lgOI3ejIMiLb4gdLoWq/yYcHtMPtJ6Wp
         dD2A0BvmhTVnD+ITgqU1aOUUt9KOcc4H0sXCtoPazdB9uYZ5k8/tD5ulh/rZW886Xsr+
         pEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3XUgEww7rhUjl+9KrZ1CEPaHPrK+CxTtmLiTOvcJwLLCC/EyeMdtAFzvXzzQnwzODs2BSHYm1N+dEKKUT@lists.openembedded.org
X-Gm-Message-State: AOJu0YzwU1ipCE2ptsX6CgPLyL7h7Tm4wI5nRUYsdWr1PEj9oyMPeOJe
	5G/qROdvSgFhUqTRYPzMvOe8Gwa5zG583+xyMIMvIQU1x/FLrp3TIGF1D4/b6BHGPzReQ21cbFN
	sAorp
X-Gm-Gg: ASbGnct1Kf2iH3Zym8LohpLZLjoxbF54ySLcWa86pZl2UzKlu3aOxpedQJemzFXNgu5
	Z5he0J5ruaYzKl91NAl6AtNbs42uuytB7N7NDunMDpzwVa4M2ZO2NA03pCc4+ROuGmvGbUJZPqR
	T78RrG/Hu0I13lvsXXWhixlEExxiU9+GFsG8P9oaah9q8Hjdd7AIP2aqW0X4ozzDkDA+KJ6sEZO
	+SmvQa83VzNQjiaEMi0794maj1BeEG/4CS81k9nTS3JAbQeoeLftVWN19Qhtfp4v5o6zpWqsRw0
	VihRkBrOtIVBYt5XuuR82ecCrLCLObEPXoBrtRdC/43hSDBar/r+XtERCzRsqzBgR+fYz4BeDJ2
	eao6jyjTPji5OLecGHRtEp8UWfTkHmTFO5fsq4Vrwc8vT4BPvklo+knyOahvNeRjvakDFvuJkt5
	nwJoLECHKXKMnYqYCdFaoGVQ==
X-Google-Smtp-Source: AGHT+IF2WnBiiZfp6S9Mt/gAGOmL3qlGS0gM7vVmXqQMgI7u1dHRgf0A82hZGqpu2YGsAhUk9EjOig==
X-Received: by 2002:a05:600c:3514:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-45b43e178demr15411805e9.32.1755600236239;
        Tue, 19 Aug 2025 03:43:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80? ([2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm208754145e9.14.2025.08.19.03.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:43:55 -0700 (PDT)
Message-ID: <548d93e5583ca1c1808f51a69901e168263e0917.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake and epileptic seizures
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: william.martin@muxen.fr, bitbake-devel@lists.openembedded.org
Date: Tue, 19 Aug 2025 11:43:54 +0100
In-Reply-To: <185D2421C5FD6ED8.4571@lists.openembedded.org>
References: <b937fbb5-f398-414a-a440-7020004d91f8@muxen.fr>
	 <185D2421C5FD6ED8.4571@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 10:44:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17886

On Tue, 2025-08-19 at 11:25 +0100, Richard Purdie via lists.openembedded.or=
g wrote:
> Hi,
>=20
> On Tue, 2025-08-19 at 11:56 +0200, William MARTIN via lists.openembedded.=
org wrote:
> > I send you this message today to talk about technical choices that can=
=20
> > have serious health problems.
> >=20
> > Some days ago, we have an external person at our office who have see a=
=20
> > bitbake terminal building an image.
> > We discover that he is sensible to epileptic seizures (he is ban from
> > traveling by plane for that).
> > The story finish pretty well for him, but we have to ensure no bitbake=
=20
> > terminal is open when he is here.
> >=20
> > I am not sure that refreshing the task list at very high speed have any=
=20
> > interest for anyone.
> > Maybe an update at 1Hz max is enough to ensure the build is working.
>=20
> Firstly, I'm sorry to hear about that person. Nobody likes to think
> something they've worked on causes an issues like that :(.=C2=A0I hope th=
ey
> are ok.
>=20
> The fast refresh rate isn't an intentional design decision but the
> result of a number of changes over the past decade coming together and
> interacting badly. Those include CPUs with higher core counts, addition
> of progress bars to many tasks and time output on the console view, all
> of which were developed semi-independently.
>=20
> There are some patches that were submitted a while back but there were
> issues in the implementation and we've never got to providing feedback
> and sorting them out. Sadly that is a common theme for many different
> things.
>=20
> I am going to try and get this one resolved though given this report.
>=20
> Thanks for bringing it to our attention.

I've merged some patches. They have a 40hz refresh rate right now but
at least add all the code needed to make it configurable and we can
experiment to find a reasonable value.

Cheers,

Richard

