Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6BC021B5
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:11:35 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.28679.1740157889825987403
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:11:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DFteQfuc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso24266895e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740157888; x=1740762688; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T1rdGaXBRhDc5RN6G/sCyHJxRk46flBBGDvn38abimY=;
        b=DFteQfucE/cifi/ta8LkVoRWIfutSsPkqhxoFA+CenPdIVRQNzpBOptrrTgSARJbRG
         5JyrHYHNkMFbhtw0caE2qnxptL+WZTJ20KJ3Md+Dc8QsiQiVE7GIERj+jzUBZv41zr9s
         wOmwwwJfBrhP4Pe8uzVNHtw878Z8QCKZnEkfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157888; x=1740762688;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1rdGaXBRhDc5RN6G/sCyHJxRk46flBBGDvn38abimY=;
        b=qTzWfKqr/UelXIKj4OSeke/eL8HUeLL+jY+JMGdBnvaLL7J3h27/TVT6mUFn5dlmXz
         /6OqJrnIv+FLOtzl7+cdDy+/K4J3RQI2qPOhnL7sSk1Lnx8Ha4NrQYaFtEOGECvw68YX
         xc+Kzhap/8p+rGa9PIgEkpnw32/LGOApiTt1lDW0G1i7z89bl3PspbgRS+reLl7HVkIi
         cZt0/ct/GmYEZlhoK/WKlek/xsOqPzluJYfzl1iuds7BPNXPb/MaM/TOEbmL2XA13Ii5
         CQslcmICxQ4AfY1p8ysGBL67RH5xPwbDq+Zk/2SSXS63L5t9g9Xu8cAuz1se5oQTlJ+B
         2osw==
X-Forwarded-Encrypted: i=1; AJvYcCV+lI/f5B2FyVmejfqlRHnH06+2pHbPupIBkpV08gnH7UfMaQnw23c/Mi7ollqJVUq514TfrvCtKVf+0l2m@lists.openembedded.org
X-Gm-Message-State: AOJu0Yx3Bg5nepTBwiQItf6/fQiNigTk+AQ3G2BY6+0g0Ubc4rLBoR5A
	4hCTN0G/P9lDVnamZ20krWSD7rQQEQGE7Iz+OtoqwR90nr0l0q8XnB73KgjAmj0=
X-Gm-Gg: ASbGncu7fezKjyfmM01Q8lo1vnRBA0A+XtzhWrBB4zifk4zw0hBKoK4nsysXI3JKnSG
	ed8M3KX5MmbteqgjVEZ6zQykir+ML8US+inxWvGlb95vSOUWFVEKho9+o/qCwjsj9dxZgRmOpz8
	9/3AlUGxdv0xVEm4JxKvm/rOA2vPwGMZy2yj3gQlVPJ4B6zZ2Q/cir2m50hFxIQybz9Y+H8yvq7
	DKajbQfq0xlfLm7FUmf7weCIdKE/WRAVPB3/1StSwq7cT8KF9zg/35YE56ci4/XGh9ffXpqvafo
	03QZ2TIb+kNGy4VIyRKZ7/1tUPZjbXFoBLh3CqT1sKQeBfNI8m9xSaSKD2bxY1P8kVjCAfkfwpe
	Nga+vod5zgLiTBao=
X-Google-Smtp-Source: AGHT+IHk5HK/OzmOu4Fr4tpAkmb0Xm3Xs4217PPpN2+vujTHUElU1/M0MiFa34R0UCRUufODp+l9aw==
X-Received: by 2002:a05:6000:1a8e:b0:38f:2073:14a7 with SMTP id ffacd0b85a97d-38f6f0bf9d5mr4472408f8f.47.1740157887964;
        Fri, 21 Feb 2025 09:11:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f9ef:7e20:7d31:1dea? ([2001:8b0:aba:5f3c:f9ef:7e20:7d31:1dea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm23558352f8f.82.2025.02.21.09.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:11:27 -0800 (PST)
Message-ID: <a7dd432e5603a8623a4d06628cc7c36a8eb0a40c.camel@linuxfoundation.org>
Subject: Re: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Koch, Stefan" <stefan-koch@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"	
 <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Date: Fri, 21 Feb 2025 17:11:26 +0000
In-Reply-To: <bad4317dc354af35db542247fd5c75071f20da85.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
		 <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
	 <bad4317dc354af35db542247fd5c75071f20da85.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:11:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17283

On Fri, 2025-02-21 at 16:40 +0000, Koch, Stefan wrote:
> On Fri, 2025-02-21 at 08:09 +0000, Richard Purdie wrote:
> > On Thu, 2025-02-20 at 18:27 +0100, Stefan Koch wrote:
> > > When `ud.shallow =3D=3D 1`:
> > > - Prefer an initial shallow clone over an initial full bare
> > > clone,
> > > =C2=A0 while still utilizing any already existing full bare clones.
> > >=20
> > > This improves:
> > > - Resolve timeout issues during initial clones on slow internet
> > > connections
> > > =C2=A0 by reducing the amount of data transferred.
> > > - Eliminate the need to use an HTTPS tarball `SRC_URI`
> > > =C2=A0 to reduce data transfer.
> > > - Allow SSH-based authentication (e.g. cert and agent-based) when
> > > =C2=A0 using non-public repos, so additional HTTPS tokens may not be
> > > required.
> > >=20
> > > Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> > > ---
> > > =C2=A0lib/bb/fetch2/git.py | 100 ++++++++++++++++++++++++++++++++----=
-
> > > --
> > > ----
> > > =C2=A01 file changed, 74 insertions(+), 26 deletions(-)
> >=20
> > In testing it looks like this series has some issue on Ubuntu 20.04
> > systems (both x86_64 and arm):
> >=20
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/1097
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/1016
> >=20
> > This is probably due to the version of git there...
>=20
> This issue could occur in two cases:
> a) old Git client version
> this could be relevant:
> https://lore.kernel.org/git/1630496467881.2030439049.4247253551@vivaldi.c=
om/T/

I suspect the git version is the cause of the issue.

> b) Git server version, that has disabled announcements
> see:
> https://superuser.com/questions/1342547/unable-to-fetch-particular-commit=
-hash-from-gerit-error-server-does-not-allow-r

We're testing against the same server and we see some passes and only
failures on Ubuntu 20.04 so it is unlikely to be this.

> So, I have reintroduced the switch from v2 patch with inverse logic.
> 1. enabled by default
> 2. old behaviour can be forced by variable

So in CI on the autobuilder, we need to force the variable to allow the
selftests to pass on 20.04 hosts? We also need to error if anyone
enables that form of fetching on 20.04 hosts too?

> 3. old behaviour is triggered automatically in mentioned failure case
> (see above)
>=20
> I'll send updated v4 patch series.
>=20

I'm afraid this solution won't work for us. We either need to find a
work around, fall back to a different way of fetching or I guess we
have to drop support for Ubuntu 20.04 without using builtools tarball
and bump our minimum git version requirements.

Cheers,

Richard



