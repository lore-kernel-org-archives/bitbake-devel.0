Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B43BC021AD
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 17:17:27 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.1330.1739899044187750671
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Feb 2025 09:17:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=koeuqgeJ;
 spf=pass (domain: gmail.com, ip: 209.85.216.41, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fc292b3570so7170538a91.1;
        Tue, 18 Feb 2025 09:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739899043; x=1740503843; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RmnIcUrKP4Lz1mLadRRR+wVpLhG+/ZxjojEKWxUlF2c=;
        b=koeuqgeJA6ijfO2VFUr6qqQvcCex4qBtS+ehuV1WXkoZTioeIk8cClannrJgC0POEJ
         OWjYjj/gbFPYeB2g5SdlVBVjcibpu5LlMdYvHyHu4V9GzSICDcyaFL/Pzz0mvm6bnt+K
         czoen6J4zlbliEgehEIeY1hmO4gVFQFlXvwgyoKvBHGrPOF1J/8Y6bQiU7jDAWmr+/Nq
         vNK20j3AXMFUZP9e8Z1/WIizQszYIXCM+thvfhLZCXUHQyKfjK6CKszOJRtLGymruDez
         AnBS8gfQi3tDAtxD+SIvDE8Ht7/Z3bO6hCsm1fIZNq4Mm9mbh2YhIuzXCv0e4gVP16eN
         OvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739899043; x=1740503843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmnIcUrKP4Lz1mLadRRR+wVpLhG+/ZxjojEKWxUlF2c=;
        b=bWKEGcrQyGGkYsIevfmNy3B4lN7Wf+9HJFvmKPKbLeVQUooxGPGydD92ytNsuAh5fP
         q8R9yae3pEM/UUec/6xlsSRWH9yFlO5MefAcD5hdGIoffTKg8Qk0d5brME9cV7LooPO/
         hGj9/nwuMRZ8gdb++lkTTq26kvjI5K3rl91d0OqMA4VJyUFs59Ax+QpzxCk6TdxPnLsa
         ukbc2fI95Vwu4yzoW2OB/2hUJOWIV7pPNMWeiv/mG4I5CvQztOUy7nZkuCotuMttyB1d
         5j8WDb9kcUwGpcV/Z1Ahl6u4bhGmDKYvjUAmP8YOKLhGr0MPXkQqgZJm5TFOO9W+hbj8
         Wu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXKFrWbtP4qQksLAwE0dR0yTC5MDETh7lLUtXtEre5m/ptDnWmHVWq5PKNPB/356gGxicw3FXIWnntWg9OHn+xkaY=@lists.openembedded.org, AJvYcCXuMf17LDWgstwXH/79tp69RMQdHzgv3shl49J3RtqZNzNPxmCw6yx8aeXpNago7e6GR8JVgwTbnGyc4Ghg@lists.openembedded.org
X-Gm-Message-State: AOJu0YyfgW6K9u1CGuiG3yJ32rU6xqS+0t8avoKff7xvLG+snO9yph15
	WsnAuxAm4MXVYDBqtii1XqqhKXzpwMzZYdbFBEba9l4J+oEHVsTLbSxbLyWapCGHH+Xz22vSdYL
	Bde+mcVtMoEab5CixmszSf8jsV+1q+t6JTuQ=
X-Gm-Gg: ASbGncuRRZfiRF9kTzOtGUT/iF3Trzl0J383J00DKTI82tLVC2DxktX2lqrKDJYs4PM
	htnQeGkrpRHBFDcT/e1KFTRcfBdTcT0lwxP+kmevnB9cbQe8H0JZZCXfznnJ4S8psS1EEaBLM
X-Google-Smtp-Source: AGHT+IFIONZj29Ii1oH3qez0I97Va39ooq5cxVtk1FQP2WN8oHmKye7SZYidAEmHYQXj4XvdW51OdVgCSyrCZDt5uuY=
X-Received: by 2002:a17:90b:3809:b0:2ee:94d1:7a9d with SMTP id
 98e67ed59e1d1-2fc411540bfmr19197138a91.32.1739899043417; Tue, 18 Feb 2025
 09:17:23 -0800 (PST)
MIME-Version: 1.0
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
 <55925709-d3e9-49c8-a6fc-f97c611146cc@weidmueller.com> <d30c619392f62f2d40320b01da5ca95369f3e7c2.camel@linuxfoundation.org>
 <9668ba9a-4029-4600-abd1-0f32215aaedd@weidmueller.com> <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
In-Reply-To: <7537c9d9305dd3c7d05cbf36bccfe47c1858f822.camel@linuxfoundation.org>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Tue, 18 Feb 2025 12:17:08 -0500
X-Gm-Features: AWEUYZnGvp6UPw7uOjg3Ac9O1MG6GZEjU4sPwSmxBaz0VHzuI-P492eX3i9zZAU
Message-ID: <CADkTA4OrZW0WZv6f8K-e00ygQpB1p_z=gG=U2aXsGqx+NxoEtg@mail.gmail.com>
Subject: Re: [bitbake-devel] 'vendor' fetching discussion cont.
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	openembedded-core@lists.openembedded.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000006d95d0062e6dd04f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Feb 2025 17:17:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17244

--0000000000006d95d0062e6dd04f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 12:29=E2=80=AFPM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> FWIW I did try and discuss this in the OE TSC meeting today but it is a
> US holiday. There were only two people who showed up.
>

Also a Canadian Holiday! I was one of the missing attendees, so I'll follow
up here.


>
> On Mon, 2025-02-17 at 17:38 +0100, Stefan Herbrechtsmeier wrote:
> >  Am 17.02.2025 um 13:43 schrieb Richard Purdie:
> >  On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:
> > > >  Am 13.02.2025 um 11:43 schrieb Richard Purdie via
> lists.openembedded.org:
> > > > >
> > > > > e) add the ability to add custom hooks in the fetch process to
> > > > > handle
> > > > > the cases of needing to alter the flow for patching the component=
s
> > > > > list
> > > > >
> > > > I fear this isn't easy possible and we have a design problem. Bitba=
ke
> > > > and oe-core assume that a patch doesn't influence the fetch and tha=
t
> > > > the SRC_URI contains all fetched sources. Many code use the Fetch
> > > > class or the SRC_URI direct and doesn't expect recursive implicit
> > > > URIs of gitsm. In reality the SRC_URI describe the given URIs only
> > > > and doesn't contain the additional implicit URIs. The task flow
> > > > applies patches after the unpack and prevent patches to the gitsm. =
In
> > > > reality a patch could influence the implicit URIs and isn't
> > > > independent.
> > > >
> > > > I would recommend to keep the patching outside of bitbake and inste=
ad
> > > > handle the implicit URIs inside oe-core. We could write the implici=
t
> > > > URIs into files in the work directory and migrate the scattered
> > > > direct users of the SRC_URI / Fetch class to a common oe-core
> > > > function. This functions returns the given URIs and optional any
> > > > additional implicit URIs. This allows the usage of the task
> > > > dependencies to ensure that the implicit URIs are resolved before
> > > > use.
> > > >
> > > > The package manager lock file needs a single unpack and patch step
> > > > whereas the gitsm needs a recursive unpack and patch of every
> > > > successive gitsm. This makes it impossible to use additional tasks.
> > > > We could add the resolve of the implicit URIs to the fetch task to
> > > > support recursive resolve (gitsm).
> > > >
> > > > 1. download SRC_URIs
> > > > 2. exit if no URI is marked as unresolved
> > > > 3. unpack unresolved URIs
> > > > 4. apply associated patches
> > > > 5. resolve URIs
> > > > 6. goto 2
> > > >
> > > > This will eliminate the need for the partial implicit URI and gitsm
> > > > support in bitbake and makes the fetcher code simpler. The patching
> > > > could remain in oe-core and patches could be applied to gitsm and
> > > > package manager lock files. Additionally we remove code duplication
> > > > and simplify future changes to the SRC_URI determination.
> > > >
> > > > It will add an indirection for the SRC_URI but the current code
> > > > already shows that this makes problems. Only the archiver class use=
s
> > > > the expanded_urldata function and all other classes including the
> > > > spdx class ignore the implicit SRC_URIs.
> > >
> > > I'm a bit worried we're getting caught up by the terminology. We don'=
t
> > > necessarily have to "patch" the component list so much as allow
> > > something like a function to hook and adjust things. That then remove=
s
> > > the need for it to be a specific task.
> > >
> >
> >  We can use a common patch without a do_patch task. We could even
> > call the patch code from the do_patch without an extra task. I
> > propose to call the code from the do_patch task in the do_fetch task.
> > It doesn't matter if we use a hook or task. We should minimize the
> > work for the user. The common solution to manipulate a package
> > manager lock file is a patch file and we have the code to handle
> > patch files.
>
> One of the challenges is the "patch" code/module lives in OE-Core. That
> means the fetcher can't call into it.
>
> I appreciate this means you'll argue the fetcher code should move to
> OE, or the vendor code should be in OE, however I am pretty decided
> that is a really bad idea. Whether I can convey why, I don't know but I
> have tried.
>
> I also very strongly want to maintain our separation of do_fetch,
> do_unpack and do_patch.
>

I also agree with this, which is why I've been suggesting the "drop-in"
lock files. That's a fetch and copy and not a patching.  I ended up
doing a custom patch step for some of the kernel meta data and to
this day it is still on my list to change (and I'll be doing that shortly).


> > > I'm also not sure that drawing gitsm into this is a great idea when i=
t
> > > is effectively already working  quite well.
> >
> > To my knowledge it isn't possible to patch a sub module revision. Is
> > it intended that the SBOM doesn't contain the recursive implicit git
> > repositories?
>
> A patch was merged to allow the data about implicit git repos (amongst
> other things) to be available:
>
>
> https://git.yoctoproject.org/poky/commit/bitbake/?id=3Def3e46afd910d4b772=
7d42c4c18b501525c65695
>
> That tracer code was added after a lot of discussion that took up a ton
> of my time, then people moved on and it hasn't seem much
> development/use :(.
>
> So there were mechanisms added to make the data available.
>
> > >  I appreciate the desire to
> > > have neat abstractions applying accross everything equally but I'm no=
t
> > > sure we can achieve that with the level of usability we need and I'd
> > > rather improve usability at the cost of the inclusion of gitsm, which
> > > is the most functional fetcher we currently have in this group.
> >
> > I include gitsm because it is similar to the package manager and have
> > some drawbacks which I solve with my approach. It is the only fetcher
> > that parse a file to determine additional URIs. Its integration into
> > oe-core is sub-optimal.
>
> I believe there was a way added to solve the drawback you mention. The
> same mechanism could be used for other fetchers too yet we're talking
> about much more radical re-designs.
>
> > > I will repeat again that I do strongly feel that a strong API in
> > > bitbake is going to lead to an overall better design that something
> > > bolted onto the fetcher in OE-Core.
>
> The "fetcher" is an API exposed by Bitbake with the intent of
> standardising the fetching of source code. It's aim is to support
> objectives such as allowing resilience through source mirrors and
> support build reproducibility. There is a document in bitbake which
> tries to at least summarise some of that after it was requested it be
> written down.
>

FWIW. This is the mental model that I've always worked with
during my reviews of the series.


> > What is a fetcher? We have fetchers for protocols (wget, git),
>
> These were the original fetchers using the original APIs.
>
> > wrapper around other fetchers (crate, gomod and gomodgit)
>
> These are newer and some work better than others are people have
> attempted to git the newer languages into the older framework.
>
> >  and wrapper around other fetchers which embedded file parser (gitsm,
> > npmsw).
>
> Of these, gitsm is now relatively successfully integrated and
> functional.
>
> >  Thereby the gitsm fetcher fetch a source and parse the embedded
> > file. The npmsw fetcher parse a file from the meta layer. The gitsm
> > fetcher recursive combines the download and unpack function call in
> > mostly every class function.
>
> Sadly there did not seem to be any other way to handle that. I'd
> imagine that some of the other fetchers are going to have to work
> similarly, unfortunately.
>
>
> > The wrappers has the disadvantage that they use uncommon URIs which
> > are useless for the SBOM. We support PyPI without the need for an
> > extra fetcher.
>
> We support pypi in so much as we have a recipe per dependency. That was
> not deemed possible for npm or crates. I would disagree that uncommon
> URIS are useless for SBOMs. They can be problematic but having the data
> there means it is at least listed. There are also ways they can be
> extended (e.g. the intercept code I link to above).
>
> > Is PyPI or crate the desired way to go?
>
> Compared to the complexity in some of the patches proposed, I'd
> actually say yes.
>

I think I'm following this part correctly. When we say "crate the desired
way to go", I read that as "one dependency fetch by the language
specific 'protocol' (crate:// in this example)".  If so, then I also agree.

It became clear very quickly that packaging go dependencies as
separate recipes wasn't going to work, which I assume is the pypi
reference (that works for languages with "stricter" package release
processes).


>
> > Instead of expand the fetcher I would focus the fetcher on the
> > download of provides URIs and keep the file parsing and post unpack
> > processing outside of it.
>
> The challenge is that once you process it, you need to fetch more
> things. Our ecosystem is built on the idea that fetching happens in
> do_fetch. If we change that most mirroring scripts break for example.
> It is like compiling happening during do_configure or do_install - it
> is not what the user expects and that is problematic. I am against
> changing behaviour in ways users do not expect.
>

Which is how we ended up with the create:// lines in the .inc files
and also how I ended up with all my git:// fetches in my bigger
golang recipes. That we could loop, recurse, do whatever we needed
to fully resolve the dependencies, but when the actual fetch and
build of the recipe happened, that has all been detangled and is
a simple iterative processing of the lines.

For me, that separates my debugging into distinct phases. At one
point I'm scratching my head and looking at the language dependency
files, and fixing any issues there. Later on, if there are any issues my
problems are with mirrors, downloading, etc.

I'd also add a last stage of "getting the files in the position that
the language needs for vendoring". I then debug that as a separate
thing.


> > The package manager lock file is a simple file which references to
> > package sources. Thereby a main source could contain multiple package
> > manager lock files. At the moment we have no fetcher which reference
> > an other source as base or combines multiple fetchers.
>
> This is the case for good reason. If the lock file references all the
> sources, perhaps we should just include it alongside the recipe and be
> done with it?
>

I'm definitely ok with this as well, as long as it is complete and is
fully expanded, we don't need the SRC_URIs explicitly expanded in
the recipes. I may still prefer the fully expanded SRC_URIs, but I
also see a route to add that later in my own recipes as needed.


> > Based on my two proposed solutions and the work the last month, I
> > have the following feasible requirements:
> >  * Support patches for the package manager lock file to simply
>      updates, back ports and upsteaming
> >  * Support multiple package manager lock files per main source
> >  * Include the real https or git URI in the SBOM
> >  * Include the dependency name and version in the SBOM
> >  * No manual bitbake command call after a SRC_URI, PV or SRCREV
> > change
>
> I think we may have to relax some of these requirements as we can't do
> everything.
>

Avoiding both some bikeshedding and feature creep! :)

Richard: Which ones would you say don't need to be in something initial ?

To me, I'd say the "multiple package manager files" or the "no manual
bitbake call after"  and "support for patching the lockfile".


> > The following code is mostly used in oe-core and ignore the implicit
> > URIs:
> >
> >     src_uri =3D (d.getVar('SRC_URI') or "").split()
> >     fetcher =3D bb.fetch2.Fetch(src_uri, d)
> >     for url in fetcher.urls:
> >
> > The following code is used in the archiver class only and includes
> > the implicit URIs:
> >
> >     src_uri =3D get_src_uris(d)
> >     fetcher =3D bb.fetch2.Fetch(src_uri, d)
> >     for ud in fetcher.expanded_urldata():
>
> Ironically, I think this an example of the kind of "strong API" I'm
> referring to, where a standard API is exposed by bitbake. In some ways
> this was already attempted with the tracer API above where the
> expand_urldata call would actually be a call into the tracer API to
> obtain the actual urls used.
>
>
> > My last series enable oe-core to generate implicit URIs and therefore
> > replace the usage of the plain SRC_URI with a function:
> >
> >      fetcher =3D bb.fetch.Fetch(get_src_uris(d), d)
> >     for url in fetcher.urls:
> >
> >  The SRC_URI contains the given URIs and the get_src_uri function
> > contains the given and implicit URIs. The concept is taken from other
> > classes like the spdx classes which use files to exchange data
> > between tasks.
>
> I believe the get_src_uris() functionality should happen within the
> fetcher module and not outside of it as a bolt on interface.
>
> I do not know where we go from here. You disagree with me on several
> key things such as whether the code should be in bitbake or OE-Core,
> whether gitsm should be changed, whether we need to have some kind of
> checksum to verify the "lockfile" is correct as originally intended in
> the recipe and probably more.
>

As for where something belongs vs another, let's just say I have
no experience to distrust Richard's experience in these areas. I've
only rarely had to delve deep enough to even know some of the
pitfalls. But I do strongly agree that we need to keep the phases
separate with some sort of clear handoff (via files, but not necessarily
files in recipes) between them.

Cheers,

Bruce


> I'm in the position of trying to mediate things (i.e. see the different
> viewpoints and bring people together, trying to find common ground) and
> yet at the same time, express views as someone who as spent a lot of
> years trying to maintain and improve this code.
>
> I have tried to seek help from the people who effectively oversee me as
> a maintainer (i.e. the TSC) with limited success. I'm not sure what to
> do from here.
>
> Regards,
>
> Richard
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--0000000000006d95d0062e6dd04f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote gmail_quote_con=
tainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 17, 2025 at 12:29=
=E2=80=AFPM Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfounda=
tion.org">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">FWIW I did try and discuss this=
 in the OE TSC meeting today but it is a<br>
US holiday. There were only two people who showed up.<br></blockquote><div>=
<br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Also =
a Canadian Holiday! I was one of the missing attendees, so I&#39;ll follow =
up here.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
On Mon, 2025-02-17 at 17:38 +0100, Stefan Herbrechtsmeier wrote:<br>
&gt; =C2=A0Am 17.02.2025 um 13:43 schrieb Richard Purdie:<br>
&gt; =C2=A0On Mon, 2025-02-17 at 12:00 +0100, Stefan Herbrechtsmeier wrote:=
<br>
&gt; &gt; &gt; =C2=A0Am 13.02.2025 um 11:43 schrieb Richard Purdie via <a h=
ref=3D"http://lists.openembedded.org" rel=3D"noreferrer" target=3D"_blank">=
lists.openembedded.org</a>:<br>
&gt; &gt; &gt; &gt; <br>
&gt; &gt; &gt; &gt; e) add the ability to add custom hooks in the fetch pro=
cess to<br>
&gt; &gt; &gt; &gt; handle<br>
&gt; &gt; &gt; &gt; the cases of needing to alter the flow for patching the=
 components<br>
&gt; &gt; &gt; &gt; list<br>
&gt; &gt; &gt; &gt; =C2=A0<br>
&gt; &gt; &gt; I fear this isn&#39;t easy possible and we have a design pro=
blem. Bitbake<br>
&gt; &gt; &gt; and oe-core assume that a patch doesn&#39;t influence the fe=
tch and that<br>
&gt; &gt; &gt; the SRC_URI contains all fetched sources. Many code use the =
Fetch<br>
&gt; &gt; &gt; class or the SRC_URI direct and doesn&#39;t expect recursive=
 implicit<br>
&gt; &gt; &gt; URIs of gitsm. In reality the SRC_URI describe the given URI=
s only<br>
&gt; &gt; &gt; and doesn&#39;t contain the additional implicit URIs. The ta=
sk flow<br>
&gt; &gt; &gt; applies patches after the unpack and prevent patches to the =
gitsm. In<br>
&gt; &gt; &gt; reality a patch could influence the implicit URIs and isn&#3=
9;t<br>
&gt; &gt; &gt; independent.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; I would recommend to keep the patching outside of bitbake an=
d instead<br>
&gt; &gt; &gt; handle the implicit URIs inside oe-core. We could write the =
implicit<br>
&gt; &gt; &gt; URIs into files in the work directory and migrate the scatte=
red<br>
&gt; &gt; &gt; direct users of the SRC_URI / Fetch class to a common oe-cor=
e<br>
&gt; &gt; &gt; function. This functions returns the given URIs and optional=
 any<br>
&gt; &gt; &gt; additional implicit URIs. This allows the usage of the task<=
br>
&gt; &gt; &gt; dependencies to ensure that the implicit URIs are resolved b=
efore<br>
&gt; &gt; &gt; use.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The package manager lock file needs a single unpack and patc=
h step<br>
&gt; &gt; &gt; whereas the gitsm needs a recursive unpack and patch of ever=
y<br>
&gt; &gt; &gt; successive gitsm. This makes it impossible to use additional=
 tasks.<br>
&gt; &gt; &gt; We could add the resolve of the implicit URIs to the fetch t=
ask to<br>
&gt; &gt; &gt; support recursive resolve (gitsm).<br>
&gt; &gt; &gt; =C2=A0<br>
&gt; &gt; &gt; 1. download SRC_URIs<br>
&gt; &gt; &gt; 2. exit if no URI is marked as unresolved<br>
&gt; &gt; &gt; 3. unpack unresolved URIs<br>
&gt; &gt; &gt; 4. apply associated patches<br>
&gt; &gt; &gt; 5. resolve URIs<br>
&gt; &gt; &gt; 6. goto 2 <br>
&gt; &gt; &gt; =C2=A0<br>
&gt; &gt; &gt; This will eliminate the need for the partial implicit URI an=
d gitsm<br>
&gt; &gt; &gt; support in bitbake and makes the fetcher code simpler. The p=
atching<br>
&gt; &gt; &gt; could remain in oe-core and patches could be applied to gits=
m and<br>
&gt; &gt; &gt; package manager lock files. Additionally we remove code dupl=
ication<br>
&gt; &gt; &gt; and simplify future changes to the SRC_URI determination.<br=
>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; It will add an indirection for the SRC_URI but the current c=
ode<br>
&gt; &gt; &gt; already shows that this makes problems. Only the archiver cl=
ass uses<br>
&gt; &gt; &gt; the expanded_urldata function and all other classes includin=
g the<br>
&gt; &gt; &gt; spdx class ignore the implicit SRC_URIs.<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m a bit worried we&#39;re getting caught up by the terminol=
ogy. We don&#39;t<br>
&gt; &gt; necessarily have to &quot;patch&quot; the component list so much =
as allow<br>
&gt; &gt; something like a function to hook and adjust things. That then re=
moves<br>
&gt; &gt; the need for it to be a specific task.<br>
&gt; &gt; <br>
&gt;<br>
&gt; =C2=A0We can use a common patch without a do_patch task. We could even=
<br>
&gt; call the patch code from the do_patch without an extra task. I<br>
&gt; propose to call the code from the do_patch task in the do_fetch task.<=
br>
&gt; It doesn&#39;t matter if we use a hook or task. We should minimize the=
<br>
&gt; work for the user. The common solution to manipulate a package<br>
&gt; manager lock file is a patch file and we have the code to handle<br>
&gt; patch files.<br>
<br>
One of the challenges is the &quot;patch&quot; code/module lives in OE-Core=
. That<br>
means the fetcher can&#39;t call into it.<br>
<br>
I appreciate this means you&#39;ll argue the fetcher code should move to<br=
>
OE, or the vendor code should be in OE, however I am pretty decided<br>
that is a really bad idea. Whether I can convey why, I don&#39;t know but I=
<br>
have tried.<br>
<br>
I also very strongly want to maintain our separation of do_fetch,<br>
do_unpack and do_patch.<br></blockquote><div><br></div><div><div class=3D"g=
mail_default" style=3D"font-size:small">I also agree with this, which is wh=
y I&#39;ve been suggesting the &quot;drop-in&quot;</div><div class=3D"gmail=
_default" style=3D"font-size:small">lock files. That&#39;s a fetch and copy=
 and not a patching.=C2=A0 I ended up</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">doing a custom patch step for some of the kernel met=
a data and to</div><div class=3D"gmail_default" style=3D"font-size:small">t=
his day it is still on my list to change (and I&#39;ll be doing that shortl=
y).</div></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; &gt; I&#39;m also not sure that drawing gitsm into this is a great ide=
a when it<br>
&gt; &gt; is effectively already working=C2=A0 quite well.<br>
&gt; <br>
&gt; To my knowledge it isn&#39;t possible to patch a sub module revision. =
Is<br>
&gt; it intended that the SBOM doesn&#39;t contain the recursive implicit g=
it<br>
&gt; repositories?<br>
<br>
A patch was merged to allow the data about implicit git repos (amongst<br>
other things) to be available:<br>
<br>
<a href=3D"https://git.yoctoproject.org/poky/commit/bitbake/?id=3Def3e46afd=
910d4b7727d42c4c18b501525c65695" rel=3D"noreferrer" target=3D"_blank">https=
://git.yoctoproject.org/poky/commit/bitbake/?id=3Def3e46afd910d4b7727d42c4c=
18b501525c65695</a><br>
<br>
That tracer code was added after a lot of discussion that took up a ton<br>
of my time, then people moved on and it hasn&#39;t seem much<br>
development/use :(.<br>
<br>
So there were mechanisms added to make the data available.<br>
<br>
&gt; &gt; =C2=A0I appreciate the desire to<br>
&gt; &gt; have neat abstractions applying accross everything equally but I&=
#39;m not<br>
&gt; &gt; sure we can achieve that with the level of usability we need and =
I&#39;d<br>
&gt; &gt; rather improve usability at the cost of the inclusion of gitsm, w=
hich<br>
&gt; &gt; is the most functional fetcher we currently have in this group.<b=
r>
&gt; <br>
&gt; I include gitsm because it is similar to the package manager and have<=
br>
&gt; some drawbacks which I solve with my approach. It is the only fetcher<=
br>
&gt; that parse a file to determine additional URIs. Its integration into<b=
r>
&gt; oe-core is sub-optimal.<br>
<br>
I believe there was a way added to solve the drawback you mention. The<br>
same mechanism could be used for other fetchers too yet we&#39;re talking<b=
r>
about much more radical re-designs.<br>
<br>
&gt; &gt; I will repeat again that I do strongly feel that a strong API in<=
br>
&gt; &gt; bitbake is going to lead to an overall better design that somethi=
ng<br>
&gt; &gt; bolted onto the fetcher in OE-Core.<br>
<br>
The &quot;fetcher&quot; is an API exposed by Bitbake with the intent of<br>
standardising the fetching of source code. It&#39;s aim is to support<br>
objectives such as allowing resilience through source mirrors and<br>
support build reproducibility. There is a document in bitbake which<br>
tries to at least summarise some of that after it was requested it be<br>
written down.<br></blockquote><div><br></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">FWIW. This is the mental model that I&#39;ve =
always worked with</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">during my reviews of the series.</div></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
&gt; What is a fetcher? We have fetchers for protocols (wget, git),<br>
<br>
These were the original fetchers using the original APIs.<br>
<br>
&gt; wrapper around other fetchers (crate, gomod and gomodgit)<br>
<br>
These are newer and some work better than others are people have<br>
attempted to git the newer languages into the older framework.<br>
<br>
&gt;=C2=A0 and wrapper around other fetchers which embedded file parser (gi=
tsm,<br>
&gt; npmsw).<br>
<br>
Of these, gitsm is now relatively successfully integrated and<br>
functional.<br>
<br>
&gt;=C2=A0 Thereby the gitsm fetcher fetch a source and parse the embedded<=
br>
&gt; file. The npmsw fetcher parse a file from the meta layer. The gitsm<br=
>
&gt; fetcher recursive combines the download and unpack function call in<br=
>
&gt; mostly every class function.<br>
<br>
Sadly there did not seem to be any other way to handle that. I&#39;d<br>
imagine that some of the other fetchers are going to have to work<br>
similarly, unfortunately.<br>
<br>
<br>
&gt; The wrappers has the disadvantage that they use uncommon URIs which<br=
>
&gt; are useless for the SBOM. We support PyPI without the need for an<br>
&gt; extra fetcher.<br>
<br>
We support pypi in so much as we have a recipe per dependency. That was<br>
not deemed possible for npm or crates. I would disagree that uncommon<br>
URIS are useless for SBOMs. They can be problematic but having the data<br>
there means it is at least listed. There are also ways they can be<br>
extended (e.g. the intercept code I link to above).<br>
<br>
&gt; Is PyPI or crate the desired way to go?<br>
<br>
Compared to the complexity in some of the patches proposed, I&#39;d<br>
actually say yes.<br></blockquote><div><br></div><div><div class=3D"gmail_d=
efault" style=3D"font-size:small">I think I&#39;m following this part corre=
ctly. When we say &quot;crate the desired=C2=A0</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">way to go&quot;, I read that as &quot;one =
dependency fetch by the language</div><div class=3D"gmail_default" style=3D=
"font-size:small">specific &#39;protocol&#39; (crate:// in this example)&qu=
ot;.=C2=A0 If so, then I also agree.</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-=
size:small">It became clear very quickly that packaging go dependencies as<=
/div><div class=3D"gmail_default" style=3D"font-size:small">separate recipe=
s wasn&#39;t going to work, which I assume is the pypi</div><div class=3D"g=
mail_default" style=3D"font-size:small">reference (that works for languages=
 with &quot;stricter&quot; package release=C2=A0</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">processes).</div></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Instead of expand the fetcher I would focus the fetcher on the<br>
&gt; download of provides URIs and keep the file parsing and post unpack<br=
>
&gt; processing outside of it.<br>
<br>
The challenge is that once you process it, you need to fetch more<br>
things. Our ecosystem is built on the idea that fetching happens in<br>
do_fetch. If we change that most mirroring scripts break for example.<br>
It is like compiling happening during do_configure or do_install - it<br>
is not what the user expects and that is problematic. I am against<br>
changing behaviour in ways users do not expect.<br></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">Which is ho=
w we ended up with the create:// lines in the .inc files</div></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">and also how I ended up wit=
h all my git:// fetches in my bigger</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">golang recipes. That we could loop, recurse, do whate=
ver we needed</div><div class=3D"gmail_default" style=3D"font-size:small">t=
o fully resolve the dependencies, but when the actual fetch and</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">build of the recipe happen=
ed, that has all been detangled and is</div><div class=3D"gmail_default" st=
yle=3D"font-size:small">a simple iterative processing of the lines.</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">For me, that separates my debu=
gging into distinct phases. At one</div><div class=3D"gmail_default" style=
=3D"font-size:small">point I&#39;m scratching my head and looking at the la=
nguage dependency</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">files, and fixing any issues there. Later on, if there are any issues my=
</div><div class=3D"gmail_default" style=3D"font-size:small">problems are w=
ith mirrors, downloading, etc.=C2=A0</div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-=
size:small">I&#39;d also add a last stage of &quot;getting the files in the=
 position that</div><div class=3D"gmail_default" style=3D"font-size:small">=
the language needs for vendoring&quot;. I then debug that as a separate</di=
v><div class=3D"gmail_default" style=3D"font-size:small">thing.</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; The package manager lock file is a simple file which references to<br>
&gt; package sources. Thereby a main source could contain multiple package<=
br>
&gt; manager lock files. At the moment we have no fetcher which reference<b=
r>
&gt; an other source as base or combines multiple fetchers.<br>
<br>
This is the case for good reason. If the lock file references all the<br>
sources, perhaps we should just include it alongside the recipe and be<br>
done with it?<br></blockquote><div><br></div><div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">I&#39;m definitely ok with this as well, as l=
ong as it is complete and is</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">fully expanded, we don&#39;t need the SRC_URIs explicitly exp=
anded in</div><div class=3D"gmail_default" style=3D"font-size:small">the re=
cipes. I may still prefer the fully expanded SRC_URIs, but I</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">also see a route to add that =
later in my own recipes as needed.</div></div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
&gt; Based on my two proposed solutions and the work the last month, I<br>
&gt; have the following feasible requirements:<br>
&gt;=C2=A0 * Support patches for the package manager lock file to simply<br=
>
=C2=A0 =C2=A0 =C2=A0updates, back ports and upsteaming<br>
&gt;=C2=A0 * Support multiple package manager lock files per main source<br=
>
&gt;=C2=A0 * Include the real https or git URI in the SBOM<br>
&gt;=C2=A0 * Include the dependency name and version in the SBOM<br>
&gt;=C2=A0 * No manual bitbake command call after a SRC_URI, PV or SRCREV<b=
r>
&gt; change<br>
<br>
I think we may have to relax some of these requirements as we can&#39;t do<=
br>
everything.<br></blockquote><div><br></div><div><div class=3D"gmail_default=
" style=3D"font-size:small">Avoiding both some bikeshedding and feature cre=
ep! :)</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small">Richard: Which one=
s would you say don&#39;t need to be in something initial ?</div><br></div>=
<div><div class=3D"gmail_default" style=3D"font-size:small">To me, I&#39;d =
say the &quot;multiple package manager files&quot; or the &quot;no manual</=
div><div class=3D"gmail_default" style=3D"font-size:small">bitbake call aft=
er&quot;=C2=A0 and &quot;support for patching the lockfile&quot;.</div></di=
v><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; The following code is mostly used in oe-core and ignore the implicit<b=
r>
&gt; URIs:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0src_uri =3D (d.getVar(&#39;SRC_URI&#39;) or &quot;&=
quot;).split()<br>
&gt;=C2=A0 =C2=A0 =C2=A0fetcher =3D bb.fetch2.Fetch(src_uri, d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0for url in fetcher.urls:<br>
&gt; <br>
&gt; The following code is used in the archiver class only and includes<br>
&gt; the implicit URIs:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0src_uri =3D get_src_uris(d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0fetcher =3D bb.fetch2.Fetch(src_uri, d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0for ud in fetcher.expanded_urldata():<br>
<br>
Ironically, I think this an example of the kind of &quot;strong API&quot; I=
&#39;m<br>
referring to, where a standard API is exposed by bitbake. In some ways<br>
this was already attempted with the tracer API above where the<br>
expand_urldata call would actually be a call into the tracer API to<br>
obtain the actual urls used.<br>
<br>
<br>
&gt; My last series enable oe-core to generate implicit URIs and therefore<=
br>
&gt; replace the usage of the plain SRC_URI with a function:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch(get_src_uris(d), d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0for url in fetcher.urls:<br>
&gt;<br>
&gt;=C2=A0 The SRC_URI contains the given URIs and the get_src_uri function=
<br>
&gt; contains the given and implicit URIs. The concept is taken from other<=
br>
&gt; classes like the spdx classes which use files to exchange data<br>
&gt; between tasks.<br>
<br>
I believe the get_src_uris() functionality should happen within the<br>
fetcher module and not outside of it as a bolt on interface.<br>
<br>
I do not know where we go from here. You disagree with me on several<br>
key things such as whether the code should be in bitbake or OE-Core,<br>
whether gitsm should be changed, whether we need to have some kind of<br>
checksum to verify the &quot;lockfile&quot; is correct as originally intend=
ed in<br>
the recipe and probably more.<br></blockquote><div><br></div><div><div clas=
s=3D"gmail_default" style=3D"font-size:small">As for where something belong=
s vs another, let&#39;s just say I have</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">no experience to distrust Richard&#39;s experience=
 in these areas. I&#39;ve</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">only rarely had to delve deep enough to even know some of the</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">pitfalls. But I d=
o strongly agree that we need to keep the phases</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">separate with some sort of clear handoff =
(via files, but not necessarily</div><div class=3D"gmail_default" style=3D"=
font-size:small">files in recipes) between them.</div><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-size:small">Cheers,</div><div class=3D=
"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_def=
ault" style=3D"font-size:small">Bruce</div><br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
I&#39;m in the position of trying to mediate things (i.e. see the different=
<br>
viewpoints and bring people together, trying to find common ground) and<br>
yet at the same time, express views as someone who as spent a lot of<br>
years trying to maintain and improve this code.<br>
<br>
I have tried to seek help from the people who effectively oversee me as<br>
a maintainer (i.e. the TSC) with limited success. I&#39;m not sure what to<=
br>
do from here.<br>
<br>
Regards,<br>
<br>
Richard <br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--0000000000006d95d0062e6dd04f--

