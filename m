Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C65E77188
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 15:30:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.62229.1736177417114353566
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Jan 2025 07:30:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VaYtCGQ4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43618283d48so105040335e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 07:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736177415; x=1736782215; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Kz2GgrcjCI3fg7XfYJ5RhJAwgCKBxKWk/L9NeJRQ8k=;
        b=VaYtCGQ4WMEaKZYt7su6CT/EqbwdBdRw1OAj7HRqHKmpzLaQ/C4HwKfvZ4g9/Cd5/1
         StnKnuZYDau2PKN8qAYJ2pZ8YyR86WjfOKtv3XEXP/nYBZETVU8dXeJgn0+GWh4Npf6N
         tdsi8n1NQoY4fYOJr+FlDUoRXEp3zIXCRs8fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177415; x=1736782215;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Kz2GgrcjCI3fg7XfYJ5RhJAwgCKBxKWk/L9NeJRQ8k=;
        b=nvRT0qHKGik0tEF3eMqXVITJjQ6ysnAaPBfCUWud5GTnqFdiU59O8zcn/X9+sfbUCF
         zkU6ym7mJKH9TX9SEnvzhxnAyT8lajdXLba92NXuGfW64Vvg9TRsdyjqoJyHOoXjCOyR
         8rsRwKsI80NeykVASS/CljCPsd9gODj8lvGvTX7smcMwg7ubvkY3BGR3ax7ldxtcqeHD
         WM+i5UiaDyV0mY0pbydPs8eYJi9EDhjm9j0tggQRif+/gjFUKVKYN3qf/6h4btsvmyt7
         qlzEdsYOflXR0BSYYra8R4Orkk5qTZ107ak2TUxyNiugQjqmfB2BD5JfWF9D/uQPhvsI
         gSSA==
X-Forwarded-Encrypted: i=1; AJvYcCUoJaEWrCGt9QMNzdt1iOibXL2P69JYAFkabhYiac7g6U4PeikvPKdUhjlgvKI4RWsKYhWLVsTwZJ3brLMZ@lists.openembedded.org
X-Gm-Message-State: AOJu0YwE6zH85dreKv6k0IQfJOVL4Y5cWSCYr/26Rg6PDkD0oalrOml6
	gbR4i6dooGPB4fl9vxwOFz36uJ7AQsuLsINOSoxh33h44YV1oWUbkP2u62+gG9E=
X-Gm-Gg: ASbGnctMdQO1r2xWLHqgHdW+QIvAnZes9VU4dMYCqHRilRO9g8GvcSEQmTcwbLHDCps
	uSZM/BEtUjsfN6aqvyu25liucywT67tgwVBJlCWjBTwkDkoL8PaqhC40Af3ONEj8clPZ2CEog/I
	TM0CAKM4H9tsUdc5wEG3UEuDsctKrrCMEMyqNvncxD0SNFuDCck2ymMZGVsahO/wGkTc3oZXfx0
	9cGFZmnTqWAu0k3rCdBjQdKAF9Zk5Pwxqd3tGbwfYvgtHtLb8nuNu76WZqJQalvgnyihmI1MnyH
	aB8D/f0ykijGlQd2H0g0kM8wB3O9w29Rmpxbjz0k5Q4m0w==
X-Google-Smtp-Source: AGHT+IH4jbBwGIH/acQ4HgAzHLofbjOyYDUD5b2PWQNYBvGKX6jV09plArb6ZhPV1XZG5c4c+9pnEA==
X-Received: by 2002:a05:600c:46ce:b0:431:55c1:f440 with SMTP id 5b1f17b1804b1-43668b7a2cfmr516021115e9.30.1736177415325;
        Mon, 06 Jan 2025 07:30:15 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3607:7267:e27a:36e4? ([2001:8b0:aba:5f3c:3607:7267:e27a:36e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea4a7sm568453455e9.3.2025.01.06.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 07:30:14 -0800 (PST)
Message-ID: <84c9eee86cd0a378dcfbcbcac297d3a24f2424ad.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Mon, 06 Jan 2025 15:30:13 +0000
In-Reply-To: <578ed107-1a04-48db-ac2e-1dc9cdab60d0@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
	 <578ed107-1a04-48db-ac2e-1dc9cdab60d0@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 15:30:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16969

On Mon, 2025-01-06 at 15:35 +0100, Stefan Herbrechtsmeier wrote:
> Am 06.01.2025 um 12:04 schrieb Richard Purdie:
>=20
> >=20
> > My comments (on various elements):
> >=20
> > With a npm-shrinkwrap.json/package-lock.json/go.sum file, are
> > dependencies always recorded as specific entities with checksums?
> > =C2=A0=C2=A0
> Yes, every dependency contains a fixed version and a checksum. The
> purpose of the file is integrity and reproducibility.

Thanks for confirming, that hasn't always been the case for some of
these package management systems!

> > =C2=A0I'm a
> > little bit worried about how easily you could sneak a "floating"
> > version into this and make the fetcher non-deterministic. Does (or
> > could?) the code detect and error on that?=C2=A0
>=20
> We could raise an error if a checksum is missing in the dependency
> specification file or make the checksum mandatory for the dependency
> fetcher.=C2=A0 Furthermore we could inspect the dependency URLs to detect
> a misuse of the file like a latest string for the version.


I think adding such an error would be a requirement for merging this.

> > Put another way, could one of these SRC_URIs map to multiple
> > different
> > combinations of underlying component versions?
>=20
> If you mean the extracted SRC_URI for a single dependency from the
> dependency specification file (ex. npm-shrinkwrap.json) it could use
> special URLs to map to the latest version. But this is a missus of
> the dependency specification file and could be detected. The tools
> generate files with fixed versions always because a floating version
> with a fixed checksum make no senses.

Even if it shouldn't happen, we need to detect and error for this case
as it would become very problematic for us.

> > Our existing method effectively hardcodes/expands the lock file
> > into
> > extended SRC_URI entries which makes the specific versions and
> > components really clear. This change abstracts that away into the
> > fetcher and makes it opaque to the user, and much harder for code
> > like
> > the archiver/license/spdx code to fine/handle.
>=20
> Really? Let's use the crate fetcher as an example. At the moment the
> cargo-update-recipe-crates class extract the URI and checksum from
> the Cargo.lock. The class ignores the licenses and they leads to
> missing licenses in the recipe. The spdx files contains bitbake
> specific fetcher URLs only which are unknown outside of bitbake.

I guess what I'm trying to say is that people generally easily
understand the explicit expanded urls. Whilst that class does ignore
license handling, the hope was that it would get added, it is certainly
possible to fix that.

> =C2=A0I also thought it would make sense to generate recipes from the
> dependency specification files and therefore worked on the recipetool
> previous. But it looks like the tool isn't really used and I'm afraid
> nobody will use the recipe to fix dependencies. In most cases it is
> easy to update a dependency in the native tooling and only provide an
> updated dependency specification file.

I think people have wanted a single simple command to translate the
specification file into our recipe format to update the recipe. For
various reasons people didn't seem to find the recipetool approach was
working and created the task workflow based one. There are pros and
cons to both and I don't have a strong preference. I would like to see
something which makes it clear to users what is going on though and is
simple to use.

People do intuitively understand a .inc file with a list of urls in it.
There are challenges in updating it.

This other approach is not as intuitive as everything is abstracted out
of sight.

One thing for example which worries me is how are the license fields in
the recipe going to be updated?

Currently, if we teach the class, it can set LICENSE variables
appropriately. With the new approach, you don't know the licenses until
after unpack has run. Yes it can write it into the SPDX, but it won't
work for something like the layer index or forms of analysis which
don't build things.

This does also extend to vulnerability analysis since we can't know
what is in a given recipe without actually unpacking it. For example we
could know crate XXX at version YYY has a CVE but we can't tell if a
recipe uses that crate until after do_unpack, or at least not without
expandurl.=C2=A0

> =C2=A0I have a WIP to integrate the the dependencies into the spdx . This
> uses the expanded_urldata / implicit_urldata function to add the
> dependencies to the process list of archiver and spdx.
> =C2=A0
> https://github.com/weidmueller/poky/tree/feature/dependency-fetcher
>=20
> Regarding the license we could migrate the functionality from
> recipetool into a class and detect the licenses at build time.
> Theoretically the fetcher could fetch the license from the package
> manager repository but we have to trust the repository because we
> have no checksum to detect changes. Maybe we could integrate tools
> like Syft or ScanCode to detect the licenses at build time. At the
> moment the best solution is to make sure that the SBOM contains the
> name and version of the dependencies and let other tools handle the
> license via SBOM for now. Therefore I propose a common scheme to
> define the dependency name (dn) and version (dv) in the SRC_URI.

We could compare what licenses the package manager is showing us with
what is in the recipe and error if different. There would then need to
be a command to update the licenses in the recipe (in much the way urls
currently get updated).

> > =C2=A0
> > I noticed that any fetcher operation has to first expand the lock
> > file
> > using a temporary directory.
> > =C2=A0
> =C2=A0I follow gitsm and open for suggestions. The expand happens only
> once per fetcher object. The sub fechter object is saved in the proxy
> variable.

That fetcher object has to be recreated in every task or task context
using the fetcher.

> > =C2=A0
> > You're using DL_DIR for that which I
> > suspect isn't a great idea for tmp files.
> > =C2=A0
> =C2=A0Take over from gitsm.

Probably not the best fetcher and I'd say gitsm should be fixed.

> > =C2=A0
> > =C2=A0In many cases that will work
> > fine but it is a bit of a performance overhead.
> >=20
> > I did start wondering if we should cache the lock files in a subdir
> > of
> > DL_DIR to help performance and also give some extra assurance about
> > changing content.
> > =C2=A0
> =C2=A0This would be possible. I assume the best would be another sub
> SRC_URI to avoid code duplication for the locking and change
> detection.

Probably, I did wonder if the mixin could cover that
abstraction/caching.

> > =C2=A0
> > The url scheme is clever but also has a potential risk in that you
> > can't really pass parameters to both the top level fetcher and the
> > underlying one. I'm worried that is going to bite us further down
> > the
> > line.
> > =C2=A0
> =C2=A0
> At the moment I don't see a real problem but maybe you are right. The
> existing language specific fetcher use fixed paths for there
> downloads.
> =C2=A0
> =C2=A0What do you propose? Should the fetcher skip the unpack of the
> source or should we introduce a sub fetcher which uses the download
> from an other SRC_URI entry. The two entries could be linked via the
> name parameter. This approach could be combined with your suggestion
> above. The new fetcher will unpack a lock file from an other
> (default) download.
> =C2=A0
I'm not really sure what is best right now. I'm trying to spell out the
pros/cons of what is going on here in the hope it encourages others to
give feedback as well. I agree there isn't a problem right now but I
worry there soon will be by mixing two things together like this. The
way we handle git protocol does cause us friction with other urls
schemes already.

> > > =3D Open questions
> > >=20
> > > * Where should we download dependencies?
> > > ** Should we use a folder per fetcher (ex. git and npm)?
> > > ** Should we use the main folder (ex. crate)?
> > > ** Should we translate the name into folder (ex. gomod)?
> > > ** Should we integrate the name into the filename (ex. git)?
> > > =C2=A0
> > =C2=A0
> > DL_DIR is meant to be a complete cache of the source so it would
> > need
> > to be downloaded there. Given it maps to the other fetchers, the
> > existing cache mechanisms likely work for these just fine, the open
> > question is on whether the lock/spec files should be cached after
> > extraction.
> > =C2=A0
> =C2=A0
> You misunderstand the question. Its about the downloadfilename
> parameter. At the moment some fetcher use sub folder inside DL_DIR
> and others use the main folder. It looks like every fetcher has its
> own concept to handle file collision between different fetchers. The
> git and npm fetcher use there own folder, the crate fetcher use its
> own .crate file prefix, the gomod fetcher translate the URL into
> multiple folders and the git fetcher translate the URL into a single
> folder name.

That makes more sense. The layout is partially legacy. The wget and
local fetchers were first and hence go directly into DL_DIR. git/svn
were separated out into their own directories with a plan to have a
directory per fetcher. That didn't always work out with each newer
fetcher. Each fetcher does have to handle a unique naming of its urls
as only the specific fetcher can know all the urls parameters and which
ones affect the output vs which ones don't.


> > > * Where should we unpack the dependencies?
> > > ** Should we use a folder inside the parent folder (ex.
> > > node_modules)?
> > > ** Should we use a fixed folder inside unpackdir
> > > =C2=A0=C2=A0 (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
> > > =C2=A0
> > =C2=A0
> > This likely depends on the fetcher as the different mechanisms will
> > have different expectations about how they should be extracted (as
> > npm/etc. would).
> > =C2=A0
> =C2=A0
> It depends on the fetcher but the fetcher could use the same
> approach. At the moment every fetcher use a different approach. The
> crate fetcher use a fixed value. The gomod fetcher uses a variable
> (GO_MOD_CACHE_DIR) and the npm fetcher uses a parameter (destsuffix).
> Furthermore the gomod fetcher override the common subdir parameter.

I think we really need to standardise that if we can. Each new fetcher
has claimed a certain approach is effectively required by the package
manager.

> =C2=A0
> > > * How should we treat archives for package manager caches?
> > > ** Should we unpack the archives to support patching (ex. npm)?
> > > ** Should we copy the packed archive to avoid unpacking and
> > > packaging
> > > =C2=A0=C2=A0 (ex. gomod)?
> > > =C2=A0
> > =C2=A0
> > If there are archives left after do_unpack, which task is going to
> > unpack those? Are we expecting the build process in
> > configure/compile
> > to decompress them? Would those management tools accept things if
> > they
> > were extracted earlier? "unpack" would be the correct time to do it
> > but
> > I can see this getting into conflict with the package manager :/.
> > =C2=A0
> =C2=A0
> Most package manager expect archives. In the npm case the archive is
> unpack by the fetcher and packed by thenpm.bbclass to support
> patching. The gomod fetcher doesn't unpack the downloaded archive and
> the gomodgit fetcher create archives from git folders during unpack.
> It would be possible to always keep the archives or always extract
> the archives and recreate archives during build. It is a decision
> between performance and patchability.
> =C2=A0
> =C2=A0At the moment it is complicated to work with the different fetcher
> because every fetcher use a different concept and it is unclear what
> is the desired approach.

This is a challenge. Can we handle the unpacking with the package
manager as a specific step or does it have to be combined with other
steps like configure/compile?

> > =C2=A0
> > I did wonder if patches 1-5 of this series could
> > be merged separately too as they look reasonable regardless of the
> > rest
> > of the series?
> > =C2=A0
> =C2=A0
> Sure. Should I resend the patches as separate series?

Yes please, that would then let us remove the bits we can easily
review/sort and focus on this other part.

Cheers,

Richard


