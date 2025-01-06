Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC3E77199
	for <webhook@archiver.kernel.org>; Mon,  6 Jan 2025 11:04:31 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.57201.1736161462177784699
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Jan 2025 03:04:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OfQsTBek;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38634c35129so10943262f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 03:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736161460; x=1736766260; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rPVoCn7ttvVWS3e2GU8zwIu+ZQ8uAtDVhrqnUL0ouoI=;
        b=OfQsTBekHRtj+BYpYu3IGJ60X20NzLZYBKgL5EeH3tz/jPjfmTr9gQHWdVZLkf3a9K
         oVmzxEw8VG6l72e44d8tVLsLsZXayo2+c2q6WddzapzcdYkNj9wAVh6pwYgI5bVqS1ST
         VXIVrQ2tJAAdAU2kGK04djmmws4W84Mogof64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736161460; x=1736766260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rPVoCn7ttvVWS3e2GU8zwIu+ZQ8uAtDVhrqnUL0ouoI=;
        b=Ijs3xbB+KuxHitBNCYaqFJRYf5fgyQTA8DHZhjsC8qtasy3GTTImRgfAYHZhT3NB5q
         GZdjjHqAFSn4SOZwjbcB+phEEY4tncC26WiVmD1++vn27AyLH7w4nn3Ywqa3Eyyn1h4o
         UPF54hX4NRlz+5bhhAwfyJErOlaxm7KgN2ePaRfrT1iYBKBS2lMjqyIeLine5EyYaWS7
         BP+UG48GDExA/37vXdcuh4CdgfXsO3+Kgu5Pm27IHikLtzfT3YZCajIncljqDjTE+wxQ
         /GF0ioxU41RQwg5N/Vg8CA4s4vvlWuv4+wxciOVTe84L6mlMK2qAWIYzzzhz7tbwQjbO
         9TwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM2Ph5iwWl/HVUmYb5Y4wpWB7gor28ld9EJb/X9PbMHZFxYeVRnwZFGJAqgzDVC8o2MjhGFT2Mxcocqq/y@lists.openembedded.org
X-Gm-Message-State: AOJu0YxmNCcAcKGjlq8PuUH3zDH2csR6gd2QAo+GSNZvVLKmqU5BAtxc
	pm4tmjVi79YoLNvB8fwMPB2epSeTkTzynTjvs32b6Pksp5Mfsj/kDmrWxoBxoWI=
X-Gm-Gg: ASbGncsCQ+abtG7JWjOVQD9FP3JtC/DGkHwLafn08Am2OHPLuR/4Ij3LlUQmOYVpQed
	/XFw7ZhTN0fIFKfF1mikZ4VhTM299GHNlfQ5ZsvXKNz9PcxXFWYjldZn+JvAAWBcxR4d8sxma87
	SlPAQk9m4oEqOJvSF2vkG2Y353yexrrWyRMzpeJqIgtsqNTelTV4pLXh9xJoNL3JzewZFHMFFIe
	VJyxPPtVznSrmdZGTAcXGbVe3JPDBNCwDBkPzGvTGxVOh5Uak9wkukvLkkTjDkzdOpBxsaaBkgz
	4gwvSW2mOU+O+axX59k4oG56SBB128xm8gyG6QD8UdIOxA==
X-Google-Smtp-Source: AGHT+IG1hUuM457fY1Pp2Q/5/u9KQ8pMoR18mj57ibV6UltlCZKQ0vm3VkCBWP8fM/kwcy/YqXB9+Q==
X-Received: by 2002:a5d:59ad:0:b0:386:32ca:aa12 with SMTP id ffacd0b85a97d-38a223feed2mr40741596f8f.49.1736161460364;
        Mon, 06 Jan 2025 03:04:20 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3607:7267:e27a:36e4? ([2001:8b0:aba:5f3c:3607:7267:e27a:36e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8add5asm46961546f8f.107.2025.01.06.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 03:04:19 -0800 (PST)
Message-ID: <00e379e761414e8cf07b83544d5202211bf4623c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Mon, 06 Jan 2025 11:04:18 +0000
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Jan 2025 11:04:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16966

On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> The patch series improves the fetcher support for tightly coupled
> package manager (npm, go and cargo). It adds support for embedded
> dependency fetcher via a common dependency mixin. The patch series
> reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
> fetcher for go.sum and cargo.lock files. The dependency mixin contains
> two stages. The first stage locates a local specification file or
> fetches an archive or git repository with a specification file. The
> second stage resolves the dependency URLs from the specification file
> and fetches the dependencies.
>=20
> SRC_URI =3D "<type>://npm-shrinkwrap.json"
> SRC_URI =3D "<type>+http://example.com/=C2=A0npm-shrinkwrap.json"
> SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;subdir=
=3D${BP}"
> SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"
>=20
> Additionally, the patch series reworks the npm fetcher to work without a
> npm binary and external package repository. It adds support for a common
> dependency name and version schema to integrate the dependencies into
> the SBOM.
>=20
> =3D Background
> Bitbake has diverse concepts and drawbacks for different tightly coupled
> package manager. The Python support uses a recipe per dependency and
> generates common fetcher URLs via a python function. The other languages
> embed the dependencies inside the recipe. The Node.js support offers a
> npmsw fetcher which uses a lock file beside the recipe to generates
> multiple common fetcher URLs on the fly and thereby hides the real
> download sources. This leads to a single source in the SBOM for example.
> The Go support contains two parallel implementations. A vendor-based
> solution with a common fetcher and a go-mod-based solution with a gomod
> fetcher. The vendor-based solution includes the individual dependencies
> into the SRC_URI of the recipe and uses a python function to generate
> common fetcher URLs which additional information for the vendor task.The
> gomod fetcher uses a proprietary gomod URL. It translates the URL into a
> common URL and prepares meta data during unpack. The Rust support
> includes the individual dependencies in the SRC_URI of the recipe and
> uses proprietary crate URLs. The crate fetcher translates a proprietary
> URL into a common fetcher URL and prepares meta data during unpack. The
> recipetool does not support the crate and the gomod fetcher. This leads
> to missing licenses of the dependencies in the recipe for example
> librsvg.
>=20
> The steps needed to fetch dependencies for Node.js, Go and Rust are
> similar:
> 1. Extract the dependencies from a specification file (name, version,
> =C2=A0=C2=A0 checksum and URL)
> 2. Generate proprietary fetcher URIs
> =C2=A0 a. npm://registry.npmjs.org/;package=3Dglob;version=3D 10.3.15
> =C2=A0 b. gomod://golang.org/x/net;version=3Dv0.9.0
> =C2=A0=C2=A0=C2=A0=C2=A0 gomodgit://golang.org/x/net;version=3Dv0.9.0;rep=
o=3Dgo.googlesource.com/net
> =C2=A0 c. crate://crates.io/glob/0.3.1
> 3. Generate wget or git fetcher URIs
> =C2=A0 a. https://registry.npmjs.org/glob/-/glob-10.3.15.tgz;downloadfile=
name=3D=E2=80=A6
> =C2=A0 b. https://proxy.golang.org/golang.org/x/net/@v/v0.9.0.zip;downloa=
dfilename=3D=E2=80=A6
> =C2=A0=C2=A0=C2=A0=C2=A0 git://go.googlesource.com/net;protocol=3Dhttps; =
subdir=3D=E2=80=A6
> =C2=A0 c. https://crates.io/api/v1/crates/glob/0.3.1/download;downloadfil=
ename=3D=E2=80=A6
> 4. Unpack
> 5. Create meta files
> =C2=A0 a. Update lockfile and create tar.gz archives
> =C2=A0 b. Create go.mod file
> =C2=A0=C2=A0=C2=A0=C2=A0 Create info, go.mod file and zip archives
> =C2=A0 c. Create .cargo-checksum.json files
>=20
> It looks like the recipetool is not widely used and therefore this patch
> series integrates the dependency resolving into the fetcher. After an
> agreement on a concept the fetcher could be extended. The fetcher could
> download the license information per package and a new build task could
> run the license cruncher from the recipetool.

I've spent a bit more time thinking about this and looking at the code
and I've mixed feelings on it. I can certainly see why you've
implemented it this way and it does have a lot of potential but there
are also potential risks. My comments (on various elements):

With a npm-shrinkwrap.json/package-lock.json/go.sum file, are
dependencies always recorded as specific entities with checksums? I'm a
little bit worried about how easily you could sneak a "floating"
version into this and make the fetcher non-deterministic. Does (or
could?) the code detect and error on that?

Put another way, could one of these SRC_URIs map to multiple different
combinations of underlying component versions?

Our existing method effectively hardcodes/expands the lock file into
extended SRC_URI entries which makes the specific versions and
components really clear. This change abstracts that away into the
fetcher and makes it opaque to the user, and much harder for code like
the archiver/license/spdx code to fine/handle.

I noticed that any fetcher operation has to first expand the lock file
using a temporary directory. You're using DL_DIR for that which I
suspect isn't a great idea for tmp files. In many cases that will work
fine but it is a bit of a performance overhead.

I did start wondering if we should cache the lock files in a subdir of
DL_DIR to help performance and also give some extra assurance about
changing content.

The url scheme is clever but also has a potential risk in that you
can't really pass parameters to both the top level fetcher and the
underlying one. I'm worried that is going to bite us further down the
line.

> =3D Open questions
>=20
> * Where should we download dependencies?
> ** Should we use a folder per fetcher (ex. git and npm)?
> ** Should we use the main folder (ex. crate)?
> ** Should we translate the name into folder (ex. gomod)?
> ** Should we integrate the name into the filename (ex. git)?

DL_DIR is meant to be a complete cache of the source so it would need
to be downloaded there. Given it maps to the other fetchers, the
existing cache mechanisms likely work for these just fine, the open
question is on whether the lock/spec files should be cached after
extraction.

> * Where should we unpack the dependencies?
> ** Should we use a folder inside the parent folder (ex. node_modules)?
> ** Should we use a fixed folder inside unpackdir
> =C2=A0=C2=A0 (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?

This likely depends on the fetcher as the different mechanisms will
have different expectations about how they should be extracted (as
npm/etc. would).

> * How should we treat archives for package manager caches?
> ** Should we unpack the archives to support patching (ex. npm)?
> ** Should we copy the packed archive to avoid unpacking and packaging
> =C2=A0=C2=A0 (ex. gomod)?

If there are archives left after do_unpack, which task is going to
unpack those? Are we expecting the build process in configure/compile
to decompress them? Would those management tools accept things if they
were extracted earlier? "unpack" would be the correct time to do it but
I can see this getting into conflict with the package manager :/.

> This patch series depends on patch series
> 20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com
> ("[1/4] tests: fetch: adapt npmsw tests to fixed unpack behavior").

Those merged thanks. I did wonder if patches 1-5 of this series could
be merged separately too as they look reasonable regardless of the rest
of the series?

Cheers,

Richard






