Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775BC531DC
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 16:00:22 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.22999.1724169615230833390
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Aug 2024 09:00:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=f39yLSVk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3718c176ed7so2706654f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724169613; x=1724774413; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xqq7g8J6jjs9ypwwJ8951OttMrv60tlzVu0dql6fRWw=;
        b=f39yLSVkowVbLdcd1lY1WblRxavf3HyiQGPSQrCKS8nJbYAV7pUY5NTnv2mJjlfWUW
         cHdFu6WsJoecj/RK61YoBdKud5ozjyVHpBrbyiKvj37SxgK2lLmPHoB3ssK1b/mwuVIF
         RneLWomP+ozpyF/o6jg9LXDygJMDtBS3ib9gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169613; x=1724774413;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xqq7g8J6jjs9ypwwJ8951OttMrv60tlzVu0dql6fRWw=;
        b=LAfQGgo3dqvgb5sUZfS/Ydub1m3DYjVdfim/Cmd4aNSgyh/Cs+BW3mDqPSLyZBMaLz
         fezpyUU70U3f/p6g89/KB3b9wbdubX6MlF74nHTBgrV8AoZYbBfU2TSTVNzIeLJBb/RB
         ZZnW91IDN5y3/NcMSSZNl1B0/rnE/yvdq7DnSnGmBYQpOV6KmEpMGBVjPJ2SnzVcCYnL
         Lq3Wh0SMaH6KHu8ukTmHILWx5uJ+K+V00tI78gdb/BFHt0MobszgmI00dYGJr5YDRcPi
         JRw91JZuMPyBPLZDC7r7ZIBb3SLFRD2gRYG734xlzDV3j3Z8Y0ZD+Jr8usET52IvPNLM
         XtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjawtNUg/GlcGUqnMhkvQvvrzqxXH2AfaGIeO1enkSeJM2HqUofmBswhBNHsu41ucNxdNATuJutYwIlf5ARWd7NtZt3/1pA+BE9VJpTjze5EtW8Wo=
X-Gm-Message-State: AOJu0Yz+mVjdAeagHKsGEhLc0xpGVhcfbCYmvDncFdSbjdMPZgqQ/cAs
	7p/WziW0f5qD3gQXe+YArtBYSmzeuQkZOdqsVljF6D3wTqkaxijiZN2BoKzJc2c=
X-Google-Smtp-Source: AGHT+IEVqrB+EF4eIyKlmPrPUn1GR6UOqhgN4hZDJZq0pEe09A8DEcQXm5tB8Pe97YlP5UnBD7KB8g==
X-Received: by 2002:a05:6000:120c:b0:371:93eb:78a4 with SMTP id ffacd0b85a97d-37194314cd6mr9442196f8f.9.1724169613430;
        Tue, 20 Aug 2024 09:00:13 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7b46:4014:5d19:3520? ([2001:8b0:aba:5f3c:7b46:4014:5d19:3520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650759sm145190895e9.14.2024.08.20.09.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:00:12 -0700 (PDT)
Message-ID: <b89f6243322fc0e72ae6a9773c437ee598d773e4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified
 versions in package.json
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enguerrand de Ribaucourt
 <enguerrand.de-ribaucourt@savoirfairelinux.com>, 
 bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com, alexandre.belloni@bootlin.com, 
	stefan.herbrechtsmeier@weidmueller.com
Date: Tue, 20 Aug 2024 17:00:12 +0100
In-Reply-To: <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
References: 
	<20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
	 <0e0d0b28d207d2bcb20180aa4c187e10ddc694c3.camel@linuxfoundation.org>
	 <c2136d36-fac4-401d-9220-0f227260ef2d@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 16:00:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16503

On Mon, 2024-08-19 at 09:58 +0200, Enguerrand de Ribaucourt wrote:
> On 15/08/2024 16:12, Richard Purdie wrote:
> > On Mon, 2024-08-12 at 14:25 +0200, Enguerrand de Ribaucourt wrote:
> > > Our current emulation mandates that the package.json contains a versi=
on
> > > field. Some packages may not provide it when they are not published t=
o
> > > the registry. The actual `npm pack` would allow such packages, so
> > > should we.
> > >=20
> > > A first commit was required in the npm class.
> > >=20
> > > For the shrinkwrap part , we can actually use the resolved field whic=
h
> > > contains the exact source, including the revision, to pass integrity
> > > tests.
> > >=20
> > > v3:
> > > =C2=A0=C2=A0- Split bitbake npmsw.py modification in another commit
> > >=20
> > > Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com=
>
> > > Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
> > > Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@sav=
oirfairelinux.com>
> > > ---
> > > =C2=A0=C2=A0bitbake/lib/bb/fetch2/npmsw.py | 2 +-
> > > =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/n=
pmsw.py
> > > index d8ed9df327..a5fa598deb 100644
> > > --- a/bitbake/lib/bb/fetch2/npmsw.py
> > > +++ b/bitbake/lib/bb/fetch2/npmsw.py
> > > @@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 integrity =3D params.get("integrity", None)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 resolved =3D params.get("resolved", None)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
ersion =3D params.get("version", None)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
ersion =3D params.get("version", resolved)
> > > =C2=A0=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # Handle registry sources
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if is_semver(version) and integrity:
> >=20
> > I'm not convinced by this reasoning. The whole point of our SRC_URI is
> > to precisely define something that is being built. I think this allows
> > floating versions of dependencies and hence makes this non-
> > reproducible?
>=20
> The version declared in package.json is purely declarative for the NPM=
=20
> package registry. The basic Yocto fetchers will still be used for=20
> downloading the SRC_URI (https, git, ...), with the same version=20
> reproducibility mechanisms like git hash or md5sum.
>=20
> In the npm.bbclass, we have a second fetch stage (actually during=20
> do_configure) to fetch all the dependencies. The npm class here behaves=
=20
> wildly differently than regular frameworks where each dependency is a
> separate recipe. But since there are myriads of dependencies in the NPM=
=20
> world and it would be rare to share them, the current recipe class is
> intended to package an application with all its dependencies using the=
=20
> NPM registry.
>=20
> To fetch all those dependencies, we rely on the NPM dependencies=20
> mechanism of package.json which lists packages with their declarative
> version. However this is not reproducible. NPM provides two additional=
=20
> files that NPM developers should include in their repositories to pin
> the whole dependency tree: package-lock.json and npm-shrinkwrap.json.
> The npm recipetool will fetch the dependencies the first time with=20
> package.json information, and produce an npm-shrinkwrap.json file that=
=20
> pins all versions.

Are you saying that the codepath in question is only used to generate
the npm-shrinkwrap.json file and that a normal do_fetch and a normal
build will not fetch any floating version?

I appreciate the npm build itself might not be deterministic but the
point of our SRC_URI is to make it deterministic.

I'm also worried that you implied fetching is happening during
do_configure. That should not be the case and if that is happening, it
needs to be changed so that all fetching happens during do_fetch.

> Back to our commit, we do not change the aforementioned behavior, we=20
> only make it compatible with packages which do not declare a version in=
=20
> their package.json. The npmsw.py code wants to have a version to=20
> validate what's being downloaded, so we pass a dummy version. But the
> npm-shrinkwrap.json file, generated by npm native, still contains the
> reproducible metadata. Example here with a package that doesn't declare=
=20
> a version field: NPM still added integrity and resolved fields which=20
> will ensure reproducibility:
>=20
> ```
> =C2=A0=C2=A0=C2=A0=C2=A0 "node_modules/cockpit-repo": {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name": "CockpitDevelopmentDependenc=
ies",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "resolved":=20
> "git+ssh://git@github.com/cockpit-project/cockpit.git#d34cabacb8e5e1e028c=
7eea3d6e3b606d862b8ac",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "integrity":=20
> "sha512-4nBWhDtVLwF++ZPY/67QtpsXc9y/Jpa/jj1LW/gScSafDKoHmtg1BwAQ7sqpN/fdy=
i1xrkysM9hxLq3Q16ofaw=3D=3D",
> ```
> >=20
> > We should probably error if a version cannot be found and force the
> > user to add one?
> An NPM project can typically pull hundreds of dependencies with some not=
=20
> declaring a version, the user would need to submit patches to all of=20
> their upstreams to fix that which is challenging. Meanwhile, the real
> NPM tool is perfectly fine with accepting that, as illustrated above. I=
=20
> believe we should hence behave like the official NPM tool.

I'm not asking for the upstream NPM projects to be locked down. I'm
asking that our recipes always have versions specified. This is similar
to what we do in other places like crates with carg under rust, which
probably is the best example of how we can lock down situations like
this.

Cheers,

Richard


