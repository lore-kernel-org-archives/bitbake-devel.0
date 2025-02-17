Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC78C021AA
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 17:29:51 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.58143.1739813389719703937
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Feb 2025 09:29:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=L6vyL//9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso27718555e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1739813388; x=1740418188; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os5adCOAdDARYXHszBy4oB93TdzI6x18BJsgDoXDTJQ=;
        b=L6vyL//9G5VqYZ6yBiuAnYHjyED8mWRCh4OvCyp0d7vzPOv/op9yhJ4MGPSTR0EdC5
         WBuTyeX5dm1VLhQ+jbyn3feulnAF18obYpPILM8UK9KqUheZb6pz9fUwn6lc7l7TRxPa
         m8VgbInHKM/p8X6Gs0tqFhx9OcWh6Vba4bLZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739813388; x=1740418188;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=os5adCOAdDARYXHszBy4oB93TdzI6x18BJsgDoXDTJQ=;
        b=YrOCUWM7xvGqD/BqN3VRAWMmp5fcOi4SZ2sfwPNH4TbC0asB8RimkfopDVkj3BA91d
         Ko4/FqJ4JwGX1HcDmhu4rSIQkaKcHj2k9/hK6yjW9Vn0hGLybVdEnCwYy3pep0a+Z9fY
         LZWWN0sEEZL1SZTMp1dIPYvnXNyYjvIrtmdl/fxUvsiUNAe5rV/vSNa2lNkgHXqT8rgL
         7hcPbFw0j1ymyWF2ettyyYeRa9mBTsapQ7sLL57dJG73TMgKAtgAsZS1VHsuXNub9EaV
         N7dNtU2Vq7sPOh/mJBFGECZtlAqkuV1liNznh2s+EQ2inm+YMt+SzeiGwXhbruiU5VTH
         z6aA==
X-Forwarded-Encrypted: i=1; AJvYcCXX+jrUKnXpyjnwqn+MPXBMemFMX4YWhFxLDkdYavl5Mu6Nq4gf0komhUJyLx89U8OGuuOhpkySDZsu/eDh@lists.openembedded.org
X-Gm-Message-State: AOJu0YwapO1M4VazqBY22yMjOd30g382zMQm1F3/jRTqV6GvsA/gMhUF
	bGyWdWagOoFHhHUUTbpLVcnwvmybSPiFjreFNXqhenh3R2DtkOFr9LgY7DYR+io=
X-Gm-Gg: ASbGncuu12WxejtGjfYVRC0uBPaZga/+4kIbOJxht/JL+7+7DXN8rxhBdu+/EzCwRaA
	scF+W0J9riZL+539Tm1MmzoFKYBNp1aFGErJocV5AeFjhQ8Q94wGieEX1LOwD0FQNPubAJ2QX/I
	LVvQF1SZswvo6Z+O4DtzJZ4rQJ4ySLK0x37A2Ow8XROFDzgT2aHOQtWrNfoVrHCzR6tdA4xuDmu
	0MaiKz9lMjUoqaR2L9d3lj8LhotenmB5DJrGdd2bBdqpZxDyqjXE78AMn6jH4TvTMjqTjkDkPLv
	reKh9kzW1VYB7et0Y0FtWQEBKper6SxQGWweUtsVjT7JP7Lk8T13FRswpKXfEAc6bXpbYHFaPq3
	joL6X
X-Google-Smtp-Source: AGHT+IEUGfVBL/1+jGk9SYMpTZgVXSlnSgmmFvlotjBGqGPhCwvZFrmsYp1PfPUHmeDr9Yyp2IBaxw==
X-Received: by 2002:a05:600c:1989:b0:439:873a:1114 with SMTP id 5b1f17b1804b1-439873a1338mr27110315e9.6.1739813387988;
        Mon, 17 Feb 2025 09:29:47 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:12f2:fcaa:2c32:45fc? ([2001:8b0:aba:5f3c:12f2:fcaa:2c32:45fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5f4fsm12837099f8f.78.2025.02.17.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:29:47 -0800 (PST)
Message-ID: <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	openembedded-core@lists.openembedded.org, Bruce Ashfield	
 <bruce.ashfield@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Feb 2025 17:29:46 +0000
In-Reply-To: <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
References: 
	<4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
	 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com>
	 <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
	 <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Feb 2025 17:29:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17236

FWIW I did try and discuss this in the OE TSC meeting today but it is a
US holiday. There were only two people who showed up.

On Mon, 2025-02-17 at 17:38 +0100, Stefan Herbrechtsmeier wrote:
> =C2=A0Am 17.02.2025 um 13:43 schrieb Richard Purdie:
> =C2=A0On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:
> > > =C2=A0Am 13.02.2025 um 11:43 schrieb Richard Purdie via lists.openemb=
edded.org:
> > > >=20
> > > > e) add the ability to add custom hooks in the fetch process to
> > > > handle
> > > > the cases of needing to alter the flow for patching the components
> > > > list
> > > > =C2=A0
> > > I fear this isn't easy possible and we have a design problem. Bitbake
> > > and oe-core assume that a patch doesn't influence the fetch and that
> > > the SRC_URI contains all fetched sources. Many code use the Fetch
> > > class or the SRC_URI direct and doesn't expect recursive implicit
> > > URIs of gitsm. In reality the SRC_URI describe the given URIs only
> > > and doesn't contain the additional implicit URIs. The task flow
> > > applies patches after the unpack and prevent patches to the gitsm. In
> > > reality a patch could influence the implicit URIs and isn't
> > > independent.
> > >=20
> > > I would recommend to keep the patching outside of bitbake and instead
> > > handle the implicit URIs inside oe-core. We could write the implicit
> > > URIs into files in the work directory and migrate the scattered
> > > direct users of the SRC_URI / Fetch class to a common oe-core
> > > function. This functions returns the given URIs and optional any
> > > additional implicit URIs. This allows the usage of the task
> > > dependencies to ensure that the implicit URIs are resolved before
> > > use.
> > >=20
> > > The package manager lock file needs a single unpack and patch step
> > > whereas the gitsm needs a recursive unpack and patch of every
> > > successive gitsm. This makes it impossible to use additional tasks.
> > > We could add the resolve of the implicit URIs to the fetch task to
> > > support recursive resolve (gitsm).
> > > =C2=A0
> > > 1. download SRC_URIs
> > > 2. exit if no URI is marked as unresolved
> > > 3. unpack unresolved URIs
> > > 4. apply associated patches
> > > 5. resolve URIs
> > > 6. goto 2=20
> > > =C2=A0
> > > This will eliminate the need for the partial implicit URI and gitsm
> > > support in bitbake and makes the fetcher code simpler. The patching
> > > could remain in oe-core and patches could be applied to gitsm and
> > > package manager lock files. Additionally we remove code duplication
> > > and simplify future changes to the SRC_URI determination.
> > >=20
> > > It will add an indirection for the SRC_URI but the current code
> > > already shows that this makes problems. Only the archiver class uses
> > > the expanded_urldata function and all other classes including the
> > > spdx class ignore the implicit SRC_URIs.
> >=20
> > I'm a bit worried we're getting caught up by the terminology. We don't
> > necessarily have to "patch" the component list so much as allow
> > something like a function to hook and adjust things. That then removes
> > the need for it to be a specific task.
> >=20
>
> =C2=A0We can use a common patch without a do_patch task. We could even
> call the patch code from the do_patch without an extra task. I
> propose to call the code from the do_patch task in the do_fetch task.
> It doesn't matter if we use a hook or task. We should minimize the
> work for the user. The common solution to manipulate a package
> manager lock file is a patch file and we have the code to handle
> patch files.

One of the challenges is the "patch" code/module lives in OE-Core. That
means the fetcher can't call into it.

I appreciate this means you'll argue the fetcher code should move to
OE, or the vendor code should be in OE, however I am pretty decided
that is a really bad idea. Whether I can convey why, I don't know but I
have tried.

I also very strongly want to maintain our separation of do_fetch,
do_unpack and do_patch.

> > I'm also not sure that drawing gitsm into this is a great idea when it
> > is effectively already working  quite well.
>=20
> To my knowledge it isn't possible to patch a sub module revision. Is
> it intended that the SBOM doesn't contain the recursive implicit git
> repositories?

A patch was merged to allow the data about implicit git repos (amongst
other things) to be available:

https://git.yoctoproject.org/poky/commit/bitbake/?id=3Def3e46afd910d4b7727d=
42c4c18b501525c65695

That tracer code was added after a lot of discussion that took up a ton
of my time, then people moved on and it hasn't seem much
development/use :(.

So there were mechanisms added to make the data available.

> > =C2=A0I appreciate the desire to
> > have neat abstractions applying accross everything equally but I'm not
> > sure we can achieve that with the level of usability we need and I'd
> > rather improve usability at the cost of the inclusion of gitsm, which
> > is the most functional fetcher we currently have in this group.
>=20
> I include gitsm because it is similar to the package manager and have
> some drawbacks which I solve with my approach. It is the only fetcher
> that parse a file to determine additional URIs. Its integration into
> oe-core is sub-optimal.

I believe there was a way added to solve the drawback you mention. The
same mechanism could be used for other fetchers too yet we're talking
about much more radical re-designs.

> > I will repeat again that I do strongly feel that a strong API in
> > bitbake is going to lead to an overall better design that something
> > bolted onto the fetcher in OE-Core.

The "fetcher" is an API exposed by Bitbake with the intent of
standardising the fetching of source code. It's aim is to support
objectives such as allowing resilience through source mirrors and
support build reproducibility. There is a document in bitbake which
tries to at least summarise some of that after it was requested it be
written down.

> What is a fetcher? We have fetchers for protocols (wget, git),

These were the original fetchers using the original APIs.

> wrapper around other fetchers (crate, gomod and gomodgit)

These are newer and some work better than others are people have
attempted to git the newer languages into the older framework.

>  and wrapper around other fetchers which embedded file parser (gitsm,
> npmsw).

Of these, gitsm is now relatively successfully integrated and
functional.

>  Thereby the gitsm fetcher fetch a source and parse the embedded
> file. The npmsw fetcher parse a file from the meta layer. The gitsm
> fetcher recursive combines the download and unpack function call in
> mostly every class function.

Sadly there did not seem to be any other way to handle that. I'd
imagine that some of the other fetchers are going to have to work
similarly, unfortunately.


> The wrappers has the disadvantage that they use uncommon URIs which
> are useless for the SBOM. We support PyPI without the need for an
> extra fetcher.

We support pypi in so much as we have a recipe per dependency. That was
not deemed possible for npm or crates. I would disagree that uncommon
URIS are useless for SBOMs. They can be problematic but having the data
there means it is at least listed. There are also ways they can be
extended (e.g. the intercept code I link to above).

> Is PyPI or crate the desired way to go?

Compared to the complexity in some of the patches proposed, I'd
actually say yes.

> Instead of expand the fetcher I would focus the fetcher on the
> download of provides URIs and keep the file parsing and post unpack
> processing outside of it.

The challenge is that once you process it, you need to fetch more
things. Our ecosystem is built on the idea that fetching happens in
do_fetch. If we change that most mirroring scripts break for example.
It is like compiling happening during do_configure or do_install - it
is not what the user expects and that is problematic. I am against
changing behaviour in ways users do not expect.

> The package manager lock file is a simple file which references to
> package sources. Thereby a main source could contain multiple package
> manager lock files. At the moment we have no fetcher which reference
> an other source as base or combines multiple fetchers.

This is the case for good reason. If the lock file references all the
sources, perhaps we should just include it alongside the recipe and be
done with it?

> Based on my two proposed solutions and the work the last month, I
> have the following feasible requirements:
>  * Support patches for the package manager lock file to simply
     updates, back ports and upsteaming
>  * Support multiple package manager lock files per main source
>  * Include the real https or git URI in the SBOM
>  * Include the dependency name and version in the SBOM
>  * No manual bitbake command call after a SRC_URI, PV or SRCREV
> change

I think we may have to relax some of these requirements as we can't do
everything.
=20
> The following code is mostly used in oe-core and ignore the implicit
> URIs:
>=20
>     src_uri =3D (d.getVar('SRC_URI') or "").split()
>     fetcher =3D bb.fetch2.Fetch(src_uri, d)
>     for url in fetcher.urls:
>=20
> The following code is used in the archiver class only and includes
> the implicit URIs:
>=20
>     src_uri =3D get_src_uris(d)
>     fetcher =3D bb.fetch2.Fetch(src_uri, d)
>     for ud in fetcher.expanded_urldata():
=20
Ironically, I think this an example of the kind of "strong API" I'm
referring to, where a standard API is exposed by bitbake. In some ways
this was already attempted with the tracer API above where the
expand_urldata call would actually be a call into the tracer API to
obtain the actual urls used.
=20
=20
> My last series enable oe-core to generate implicit URIs and therefore
> replace the usage of the plain SRC_URI with a function:
>=20
>      fetcher =3D bb.fetch.Fetch(get_src_uris(d), d)
>     for url in fetcher.urls:
>
>  The SRC_URI contains the given URIs and the get_src_uri function
> contains the given and implicit URIs. The concept is taken from other
> classes like the spdx classes which use files to exchange data
> between tasks.

I believe the get_src_uris() functionality should happen within the
fetcher module and not outside of it as a bolt on interface.

I do not know where we go from here. You disagree with me on several
key things such as whether the code should be in bitbake or OE-Core,
whether gitsm should be changed, whether we need to have some kind of
checksum to verify the "lockfile" is correct as originally intended in
the recipe and probably more.

I'm in the position of trying to mediate things (i.e. see the different
viewpoints and bring people together, trying to find common ground) and
yet at the same time, express views as someone who as spent a lot of
years trying to maintain and improve this code.

I have tried to seek help from the people who effectively oversee me as
a maintainer (i.e. the TSC) with limited success. I'm not sure what to
do from here.
=20
Regards,

Richard=20


