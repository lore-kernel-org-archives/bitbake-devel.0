Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8472C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:22:35 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.28915.1740158552353095728
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:22:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WP4EIf/M;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so1238185f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740158551; x=1740763351; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U0flfhNzQIxSXp38V71LHGvhUnpViyFJo7haEFrJv64=;
        b=WP4EIf/MIEL+/+3u39ONBh2sKPLn/rPh22dWBB1RM9+rTZD+hkURK8tvyi0zNlv6sN
         9L8XbT5WJdsD8tWjjJD6Gz32+4cxsFY9COEzcBJh751V2CXVOvKQQIKUbOLp0iWCgA0T
         ukn7qsAjyACxfP4xbrxdiDBGRpnqyRV8Cv11Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740158551; x=1740763351;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0flfhNzQIxSXp38V71LHGvhUnpViyFJo7haEFrJv64=;
        b=UOX2acJhUnwswftDHs/w6/W9zahiqDp30JeH58WyNX1jIRB6fBjJdAdyz3ID+z5cql
         O0zQskWGU+muQ5FAgacvV9H0T3w+lXJME4P+FN6lmf+4VQ/qDqZumU9HFg5cCWSajAVK
         oWc599bPnszzv0KinBLdXfVART7ydC+VUV2NLuJRLDhr4aBnS5NexOLsq1Ta1DIEtBGx
         GtJSGIOEDntKPrbiRQ8INLesbjVY4v1Qe9PzIlBDfF7ptdfTXvf2Z7axa9aGGlYiYBJM
         n3EYSblVjphEmXf/F+/YfA0I/vi/9FqT9AW8mvCth+RnWyWFB5i3+/ETGBEhebao1iVu
         F+HA==
X-Forwarded-Encrypted: i=1; AJvYcCWN8ImpEvUHnKhtFbLP++Vh8cQ4+UzTMLva2lBROdbfcVXk2Zn/V4Lv43I5Yh8xuM7Pys7Vc7tiOCvEhpfE@lists.openembedded.org
X-Gm-Message-State: AOJu0YwJ4SfqUp/3bsHCWSfiU6vbSG0/UWTb2PYscHSLfYdIG5OCgfQM
	IQCjjTXLAIGr74OdcJUrY/2knNePquhJWwaKrmA25PYUs8x7fgVOgS7szR8YOnU=
X-Gm-Gg: ASbGnctVI3BG9y56aDIJVBN13aPREtq/bX3yFrwCR2z7AA4jlmT4CAIMWn9PGRj9kPA
	EsoFJFK9oRUey/lUC9VSRIWfU+ilv5D2+IF7w+Y/5QjMVmO23oLnB3J7XAy+6W90C9l4K1NaFsp
	Js+koGnxEwX9oUn1O2mP9cSK6l5disI67XSLfcgsZFUJZqTnjf1SifO4RdSr20Gx7I9MyBUY3Bp
	XVrgXaszKmo9V/YeSwCNbG4zm8fPc0cDLswb4yDJlcv9U5VXu4JbL7xHFFPmZfWd7rFWI3s700q
	TKk343ez9jI0h+vfVvSvaKGJNWX+zgzAr5dXg0LG58JBFiw6YntUboNpDcAaOSyQOr4gJoc3UPy
	DuhRGm/+0RpTgoU8=
X-Google-Smtp-Source: AGHT+IF7jYkMYcPyrqSvK3xGxkTUXeR1YrYImesZZE1NHrdLGUylHnXFZToVQB8LV/oQh3N+mEEP/g==
X-Received: by 2002:a5d:6e0d:0:b0:38f:28df:13a8 with SMTP id ffacd0b85a97d-38f6e95afadmr2413638f8f.17.1740158550455;
        Fri, 21 Feb 2025 09:22:30 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f9ef:7e20:7d31:1dea? ([2001:8b0:aba:5f3c:f9ef:7e20:7d31:1dea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b431fsm23654251f8f.2.2025.02.21.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:22:29 -0800 (PST)
Message-ID: <9082e1118f69c59eafbdffd0d41fe118799a2edf.camel@linuxfoundation.org>
Subject: Re: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Koch, Stefan" <stefan-koch@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"	
 <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Date: Fri, 21 Feb 2025 17:22:29 +0000
In-Reply-To: <63564006bb0c2045fb19d727e6c6c922f382d9e3.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
		 <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
		 <bad4317dc354af35db542247fd5c75071f20da85.camel@siemens.com>
		 <a7dd432e5603a8623a4d06628cc7c36a8eb0a40c.camel@linuxfoundation.org>
	 <63564006bb0c2045fb19d727e6c6c922f382d9e3.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:22:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17285

On Fri, 2025-02-21 at 17:18 +0000, Koch, Stefan wrote:
> On Fri, 2025-02-21 at 17:11 +0000, Richard Purdie wrote:
> > On Fri, 2025-02-21 at 16:40 +0000, Koch, Stefan wrote:
> > > On Fri, 2025-02-21 at 08:09 +0000, Richard Purdie wrote:
> > > > On Thu, 2025-02-20 at 18:27 +0100, Stefan Koch wrote:
> > > > > When `ud.shallow =3D=3D 1`:
> > > > > - Prefer an initial shallow clone over an initial full bare
> > > > > clone,
> > > > > =C2=A0 while still utilizing any already existing full bare clone=
s.
> > > > >=20
> > > > > This improves:
> > > > > - Resolve timeout issues during initial clones on slow internet
> > > > > connections
> > > > > =C2=A0 by reducing the amount of data transferred.
> > > > > - Eliminate the need to use an HTTPS tarball `SRC_URI`
> > > > > =C2=A0 to reduce data transfer.
> > > > > - Allow SSH-based authentication (e.g. cert and agent-based)
> > > > > when
> > > > > =C2=A0 using non-public repos, so additional HTTPS tokens may not=
 be
> > > > > required.
> > > > >=20
> > > > > Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> > > > > ---
> > > > > =C2=A0lib/bb/fetch2/git.py | 100 ++++++++++++++++++++++++++++++++=
---
> > > > > --
> > > > > --
> > > > > ----
> > > > > =C2=A01 file changed, 74 insertions(+), 26 deletions(-)
> > > >=20
> > > > In testing it looks like this series has some issue on Ubuntu
> > > > 20.04
> > > > systems (both x86_64 and arm):
> > > >=20
> > > > https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/=
1097
> > > > https://autobuilder.yoctoproject.org/valkyrie/#/builders/54/builds/=
1016
> > > >=20
> > > > This is probably due to the version of git there...
> > >=20
> > > This issue could occur in two cases:
> > > a) old Git client version
> > > this could be relevant:
> > > https://lore.kernel.org/git/1630496467881.2030439049.4247253551@vival=
di.com/T/
> >=20
> > I suspect the git version is the cause of the issue.
> >=20
> > > b) Git server version, that has disabled announcements
> > > see:
> > > https://superuser.com/questions/1342547/unable-to-fetch-particular-co=
mmit-hash-from-gerit-error-server-does-not-allow-r
> >=20
> > We're testing against the same server and we see some passes and only
> > failures on Ubuntu 20.04 so it is unlikely to be this.
> >=20
> > > So, I have reintroduced the switch from v2 patch with inverse
> > > logic.
> > > 1. enabled by default
> > > 2. old behaviour can be forced by variable
> >=20
> > So in CI on the autobuilder, we need to force the variable to allow
> > the
> > selftests to pass on 20.04 hosts? We also need to error if anyone
> > enables that form of fetching on 20.04 hosts too?
>=20
> My current v4 implementation does it automatically in failure case.
> Because the disabled server side issue is possible at end users but not
> BB CI/CD (there only 20.04)

Ok, automatic fallback sounds ok as long as it doesn't complicate the
code too much. I'm not sure we want to have a variable for it though, I
don't like users needing to care about setting such things from a
usability standpoint.

> > > 3. old behaviour is triggered automatically in mentioned failure
> > > case
> > > (see above)
> > >=20
> > > I'll send updated v4 patch series.
> This patch should work with 20.04, too.
> > >=20
> >=20
> > I'm afraid this solution won't work for us. We either need to find a
> > work around, fall back to a different way of fetching or I guess we
> > have to drop support for Ubuntu 20.04 without using builtools tarball
> > and bump our minimum git version requirements.
> Drop 20.04 might be possible to. The EOL of 20.04 comes in a few
> months...
>=20
> I would prefer the automatic error handling, to support old git server
> versions at end users, too.

There are other reasons we've wondered about using buildtools on 20.04
but I would prefer not to so this seems reasonable assuming the patch
isn't too bad...

Cheers,

Richard

