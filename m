Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8079BE77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 11:54:18 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.45854.1736423646389878768
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Jan 2025 03:54:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LFH4mhRw;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30227ccf803so6552661fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 03:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736423644; x=1737028444; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZM8mCGNelIRNZmCWKdC29eemmL99Xv0Fatdaa+MLZE=;
        b=LFH4mhRwVDOKE5RcN0FcRFTc6ahbldPJcIqRm9Y6iCnIo1cL+9Isauv1+r1GthxvPL
         iQPmJxGFlqz2Y7IPyX/6cSFoSDRlTLW+Hr1jy0N0YtY+fyWBmtUQIUqbH9Jr8gpTe24e
         ocOkNH7EKVYpPFS0yuLbaYQE+ZDzy829vWufeB1kim0KvfVm3zXXi0fGRsARofQ066co
         PGuE7J2o6dE3/hgVcS3x8wa6VQwdRFyF8b7H7kW9/d9MfqiiR7Qe22/clel6r+YVyGEs
         8qvhhOHAWUd2P40xTFrxl7qdC+siFw2RnLf/Qk2K4g97P/F0/dCqHiubE6MkJiquvp4w
         RcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736423644; x=1737028444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZM8mCGNelIRNZmCWKdC29eemmL99Xv0Fatdaa+MLZE=;
        b=tolH6OBZ5kcEtGImE49kt3g7gWR/h8SY6uHeEex0UV8g/JsdBlyarEahFLnZ3PK/Ly
         lJ0OuWAPFuYCzA40S+/D2sWrgCX5gtgUhfYpMtQ7H6cpb4ietkEMWc1KTnU9GKURFFMf
         1ljEEqazxCPCWv1ISx6eKCbld7PV0ihebDr/kQ4oDWnmifo+qLReYg9rChw50EMgCtE9
         FcINdBZuCut9pkGVzagRlWTLd86zfltAjWw9J3K9fPLuGs90vXeCMhC/txIvFbo+BkZp
         jUEGwpR3LLrA5gu63noA3QXSWGHiUUuRD4fExmCc4SviIBF/byiug46aKj8QnbPHURZR
         CYZw==
X-Gm-Message-State: AOJu0Yzx7Gp8XF4WxhU7ccvkEEODJTyVM4behPM+UzoQZ+ev4dlrVKsp
	lB/HypD/Exi2018L5Vjrz7KSxXj4L4i+nVn1li9/d9/KT80GezkmYoIQsHF+RxZTXo3sIWparsj
	ze3jhDJStdP7psWWbASSrYaqdDfI=
X-Gm-Gg: ASbGncs6lGuDNE2QMQf9maQIlclG5TEVgOc8Ery9QnQvlfVROcCHrXUBrfR6HgZYRwm
	WJpSHJjgV/9jjyU9p2xzjtn7V/1+gGOme4OXQ9dQJ
X-Google-Smtp-Source: AGHT+IFNNd7p+uYN0JfGwcLUINAnl6XmiX474x8XRXK4iCI5BSQN+eMlycS/4+gDkSauZ/SfvPrzSIDxVPpMgomqvLc=
X-Received: by 2002:a05:651c:a0a:b0:300:360b:bc3f with SMTP id
 38308e7fff4ca-305f4543372mr16041581fa.15.1736423642574; Thu, 09 Jan 2025
 03:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Thu, 9 Jan 2025 12:53:47 +0100
X-Gm-Features: AbW1kvbmo2PD0hjlTEQHkhx9p5slQ4GmQXnZiCKUCG2F6xWl0r4xsi6E9diEqnc
Message-ID: <CA+chaQdqdphd78MWOFgb5hziOLdT+SnT_=bLnFwDPbs=9FYOAw@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: stefan.herbrechtsmeier-oss@weidmueller.com
Cc: bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jan 2025 11:54:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16995

Hi,

thanks for looking into this.

With this series applied I've noticed some recipes now showing warnings lik=
e:
WARNING: enact-dev-native-6.1.3-r0 do_unpack: Please add support for
the url to npm fetcher:
https://registry.npmjs.org/string-width/-/string-width-4.2.3.tgz
WARNING: enact-dev-native-6.1.3-r0 do_unpack: Please add support for
the url to npm fetcher:
https://registry.npmjs.org/strip-ansi/-/strip-ansi-6.0.1.tgz
WARNING: enact-dev-native-6.1.3-r0 do_unpack: Please add support for
the url to npm fetcher:
https://registry.npmjs.org/wrap-ansi/-/wrap-ansi-7.0.0.tgz

and the same is shown before from do_fetch.

Not sure what's special about these, but I believe it used to work
with previous npmsw implementation. Any hint what to check?

On Fri, Dec 20, 2024 at 12:26=E2=80=AFPM Stefan Herbrechtsmeier via
lists.openembedded.org
<stefan.herbrechtsmeier-oss=3Dweidmueller.com@lists.openembedded.org>
wrote:
>
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>
> The patch series improves the fetcher support for tightly coupled
> package manager (npm, go and cargo). It adds support for embedded
> dependency fetcher via a common dependency mixin. The patch series
> reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
> fetcher for go.sum and cargo.lock files. The dependency mixin contains
> two stages. The first stage locates a local specification file or
> fetches an archive or git repository with a specification file. The
> second stage resolves the dependency URLs from the specification file
> and fetches the dependencies.
>
> SRC_URI =3D "<type>://npm-shrinkwrap.json"
> SRC_URI =3D "<type>+http://example.com/ npm-shrinkwrap.json"
> SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;subdir=
=3D${BP}"
> SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"
>
> Additionally, the patch series reworks the npm fetcher to work without a
> npm binary and external package repository. It adds support for a common
> dependency name and version schema to integrate the dependencies into
> the SBOM.
>
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
>
> The steps needed to fetch dependencies for Node.js, Go and Rust are
> similar:
> 1. Extract the dependencies from a specification file (name, version,
>    checksum and URL)
> 2. Generate proprietary fetcher URIs
>   a. npm://registry.npmjs.org/;package=3Dglob;version=3D 10.3.15
>   b. gomod://golang.org/x/net;version=3Dv0.9.0
>      gomodgit://golang.org/x/net;version=3Dv0.9.0;repo=3Dgo.googlesource.=
com/net
>   c. crate://crates.io/glob/0.3.1
> 3. Generate wget or git fetcher URIs
>   a. https://registry.npmjs.org/glob/-/glob-10.3.15.tgz;downloadfilename=
=3D=E2=80=A6
>   b. https://proxy.golang.org/golang.org/x/net/@v/v0.9.0.zip;downloadfile=
name=3D=E2=80=A6
>      git://go.googlesource.com/net;protocol=3Dhttps; subdir=3D=E2=80=A6
>   c. https://crates.io/api/v1/crates/glob/0.3.1/download;downloadfilename=
=3D=E2=80=A6
> 4. Unpack
> 5. Create meta files
>   a. Update lockfile and create tar.gz archives
>   b. Create go.mod file
>      Create info, go.mod file and zip archives
>   c. Create .cargo-checksum.json files
>
> It looks like the recipetool is not widely used and therefore this patch
> series integrates the dependency resolving into the fetcher. After an
> agreement on a concept the fetcher could be extended. The fetcher could
> download the license information per package and a new build task could
> run the license cruncher from the recipetool.
>
> =3D Open questions
>
> * Where should we download dependencies?
> ** Should we use a folder per fetcher (ex. git and npm)?
> ** Should we use the main folder (ex. crate)?
> ** Should we translate the name into folder (ex. gomod)?
> ** Should we integrate the name into the filename (ex. git)?
> * Where should we unpack the dependencies?
> ** Should we use a folder inside the parent folder (ex. node_modules)?
> ** Should we use a fixed folder inside unpackdir
>    (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
> * How should we treat archives for package manager caches?
> ** Should we unpack the archives to support patching (ex. npm)?
> ** Should we copy the packed archive to avoid unpacking and packaging
>    (ex. gomod)?
>
> This patch series depends on patch series
> 20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com
> ("[1/4] tests: fetch: adapt npmsw tests to fixed unpack behavior").
>
>
> Stefan Herbrechtsmeier (21):
>   tests: fetch: update npmsw tests to new lockfile format
>   fetch2: npmsw: remove old lockfile format support
>   tests: fetch: replace [url] with urls for npm
>   fetch2: do not prefix embedded checksums
>   fetch2: read checksum from SRC_URI flag for npm
>   fetch2: introduce common package manager metadata
>   fetch2: add unpack support for npm archives
>   utils: add Go mod h1 checksum support
>   fetch2: add destdir to FetchData
>   fetch: npm: rework
>   tests: fetch: adapt style in npm(sw) class
>   tests: fetch: move npmsw test cases into npmsw test class
>   tests: fetch: adapt npm test cases
>   fetch: add dependency mixin
>   tests: fetch: add test cases for dependency fetcher
>   fetch: npmsw: migrate to dependency mixin
>   tests: fetch: adapt npmsw test cases
>   fetch: add gosum fetcher
>   tests: fetch: add test cases for gosum
>   fetch: add cargolock fetcher
>   tests: fetch: add test cases for cargolock
>
>  lib/bb/fetch2/__init__.py   |  35 +-
>  lib/bb/fetch2/cargolock.py  |  73 +++
>  lib/bb/fetch2/dependency.py | 167 +++++++
>  lib/bb/fetch2/gomod.py      |   5 +-
>  lib/bb/fetch2/gosum.py      |  51 +++
>  lib/bb/fetch2/npm.py        | 244 +++-------
>  lib/bb/fetch2/npmsw.py      | 347 ++++----------
>  lib/bb/tests/fetch.py       | 880 +++++++++++++++++-------------------
>  lib/bb/utils.py             |  25 +
>  9 files changed, 916 insertions(+), 911 deletions(-)
>  create mode 100644 lib/bb/fetch2/cargolock.py
>  create mode 100644 lib/bb/fetch2/dependency.py
>  create mode 100644 lib/bb/fetch2/gosum.py
>
> --
> 2.39.5
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16920): https://lists.openembedded.org/g/bitbake-deve=
l/message/16920
> Mute This Topic: https://lists.openembedded.org/mt/110212697/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [martin=
.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

