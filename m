Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C2DC021A1
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 23:15:02 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.web10.2437.1739315701557528618
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Feb 2025 15:15:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y6yhR6Pl;
 spf=pass (domain: gmail.com, ip: 209.85.160.173, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4717bb7e7deso2550411cf.1;
        Tue, 11 Feb 2025 15:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739315700; x=1739920500; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx0BEsz5eImsdUehP+dAvkCV8RpdpohQCbWeLuM1pm8=;
        b=Y6yhR6PliBtyxqIqDiAct7VMz7odnbQmgJ4rwM2KgTewvyG3qVfxRktNcVaAG0VHRJ
         Rwe+7K+67cbZPfJVoyMKkXv+FmWwsuhGiBOIW+XrRga8dvVYpYPJxZxoVrFOhR3eKXTm
         grsjxnT9OvEsAX6y1KrNRa0ihvKc+ZLG862EQBbL6P4ko7j7p9oYs8+0sG38ahBx6I4D
         mZM0XplTr564ZUKW3gVqgPtJmaBpIJJyv/HKAeW1G3Mag06G6OIQa5w9B6ZIrEp63zC8
         yx1O0bV5MLg6tdzU36+xQKyPnIgH9TZN4AA/GVwQlLWeSn9oMTBYihhFoc1gj7OGm/Ku
         8TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739315700; x=1739920500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx0BEsz5eImsdUehP+dAvkCV8RpdpohQCbWeLuM1pm8=;
        b=FG/Puxf5wEOoqrcRZXuIQu7RrOZpgpo69Xnzyu1N5xcY+2fGhgHrJ8a5w6ZcMflBFP
         tAFDih9R1MSLneXoX+Aob1+MMhH9xQPUeuswMN0k1uGuzxgauE9hJ7fNS4hyZqTSZ5da
         ue9/3kZdXsj4jIo1EwSAHL3vu+PQZrX32R3lIPCvPCa7CmSGdthFGl1QGrIt2TAb5BC8
         8wYM/DDt3ODO6MYHhxLu3Lqxp33UmvIcRN3atY82MbOZAKxiOqZStwyR5r/sAd5+zTS7
         Z/sBSNEJmob/v/1W0CjF8HbWP3iL5GbdLOH0LU8K2an8wVqtRhK8cDKPuuMpf3Z9PrLV
         HDwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpPJk/ywe1Ma9P7W+XBgpw865gD9xsgjIBg2d5Z1dTT+G6HTa7cjxmAZ7KymCFrwywveZzgCpxzPJaWa/2@lists.openembedded.org
X-Gm-Message-State: AOJu0YzMp6AniLqdtAdOvaxIe76OyiDQxy30cxEyuILWAjeju4oeVXYM
	L3kqOpwAef71yJCOes1++iREzDM5hMePYuTMnab8NgXunI/bwXjSH9YQWldItCs=
X-Gm-Gg: ASbGnctalAelgY4dUh2iuDFBaqB7bPRlZUesfKJQEHpBhTujzQi0/vUAgV78i8+9tI/
	aP5eOxb/QLzOx3mZHBPvwfPJuY309+BVWcRl2Hs/tS4S6SqlDUsYNp5PzD2wDtIR2dgPqlLEVmG
	MxyV+zW3jQFuFofN9eKiuXSH7S2M6o8VEMizAGIPmwucSRdsVnL02zA+CXzryD7Zwv4k+0KrlU7
	ZeYE589JXV+53RJ7bizb7h/ArB8qEbuX5m8MTcEkhGWes9jwToiCFOUb4Np14Rf8MoGzyBbYEpL
	9rmMXyEd0YGoQMBBWr7nRStboOGENRAGbswyXAbPinrgeQMeSmD4PssXrcrwznre2t/jMg==
X-Google-Smtp-Source: AGHT+IH66TFGqUExvWALFI3i4vpftCcrzZ9oC/roLQenPgCzWswyrjEfG1afTCtCk7xz7iiBsJhqTA==
X-Received: by 2002:a05:622a:19a6:b0:471:89c1:618a with SMTP id d75a77b69052e-471aff2df66mr15537801cf.15.1739315700473;
        Tue, 11 Feb 2025 15:15:00 -0800 (PST)
Received: from gmail.com (pool-174-112-62-108.cpe.net.cable.rogers.com. [174.112.62.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4719e591a62sm21066071cf.73.2025.02.11.15.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:14:59 -0800 (PST)
Date: Tue, 11 Feb 2025 18:14:58 -0500
From: Bruce Ashfield <bruce.ashfield@gmail.com>
To: stefan.herbrechtsmeier-oss@weidmueller.com
Cc: openembedded-core@lists.openembedded.org,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm
 and rust
Message-ID: <Z6vZ8m8zZLgQKyVg@gmail.com>
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Feb 2025 23:15:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17196



In message: [bitbake-devel] [RFC PATCH 00/30] Add vendor support for go, npm and rust
on 11/02/2025 Stefan Herbrechtsmeier via lists.openembedded.org wrote:

> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
> 
> The series adds on-the-fly support for package manager specific
> dependencies and vendor directories. It contains the following changes:
> 1. Adds an early fetch, unpack and patch task to unpack and patch source
>    code with an embedded lock file for dependencies.
> 2. Parse the go.sum, Cargo.lock and package-lock.json lock files and
>    resolve the dependencies to SRC_URIs.
> 3. Save the SRC_URIs in a file and adapt all SRC_URIs users to handle
>    the SRC_URI files beside the SRC_URIs in the recipe.

I made a few comments, and will have another / better look at the
series tomorrow. There's a lot here, and it is hard to wrap my head
around everything that is changing.

I have one specific question below (from the point of view of go).

I've been looking through the series, and can't pick out where #3 is
done. I see patch 14 using SRC_URI_FILES, but where are those files
written ? Is that in patch 18 (vendor_go_do_vendor_resolve ?)  What is
written to those files ?

The concept that I'm not understanding (and that's just me not being
familiar with things, I'll continue reading the series) is that when
we suggested we'd like to have a mode where the dependencies could
clearly be listed in the SRC_URI, at least I was just thinking about a
way run the fetch/module elements that you were adding, write them to
a file and then have the recipe include it.

I can't tell if in the series those files are written each time, and
that there would be no way to edit those SRC_URI_FILES .. but I'll
look again tomorrow.

That file would manipulate the standard SRC_URI. In other words still
support a mode that is like the .inc files with crate://. So someone
could either have the lockfile parsed and fetched, or have a way to
run the parsing and fetching via a task, write a file and include the
file in their recipe to short circuit the processing of the lockfile.
(meaning the expanded and end fetches that are done once you've
processed the file are simply listed as a series of fetches that are
carried out without extra processing .. and "unrolled" dependency
file pointing at the "sources" git, crate, mod, whatever)

If that just doesn't make sense, then if there was a way to copy
the lockfile out of the recipe and have it overlayed onto the fetched
one .. maybe breaking out the individual fetch lines isn't required,
since they could be individually manipulated in that lockfile.

Bruce

> 4. Create a package manager specific vendor directory during unpack to
>    support additional patching of the dependencies.
> 5. Add the dependency name and version to the SBOM.
> 6. Simplify the npm support
> 
> 
> Stefan Herbrechtsmeier (30):
>   classes: create-spdx-2.2: use expanded FetchData for downloaded
>     packages
>   lib: spdx30_tasks: use expanded FetchData for download files
>   classes: create-spdx-2.2: use name and version for download
>     dependencies
>   lib: bb: fetch2: add support to unpack .crate files
>   lib: oe: add vendor module
>   lib: oe: vendor: add cargo support
>   lib: oe: vendor: add go support
>   lib: oe: vendor: add npm support
>   oeqa: oelib: add vendor tests
>   conf: bitbake: add SRC_URI_FILES variable
>   classes: go: make source directory configurable
>   classes: go-mod: make class customizable
>   classes: add nodejs-arch class
>   classes: base: add get_src_uris and unpack_src_uris functions
>   classes: add early fetch, unpack and patch support
>   classes: add vendor class
>   classes: add vendor class for cargo
>   classes: add vendor class for go
>   classes: add vendor class for npm
>   classes: add vendor_npm_build class
>   python3-bcrypt: mirgrate to vendor cargo class
>   python3-cryptography: mirgrate to vendor cargo class
>   python3-maturin: mirgrate to vendor cargo class
>   python3-rpds-py: mirgrate to vendor cargo class
>   librsvg: mirgrate to vendor cargo class
>   librsvg: update dependecies to fix RUSTSEC-2024-0421
>   [DO NOT MERGE] recipes: add crucible go demo
>   [DO NOT MERGE] recipes: add node-red npm demo
>   [DO NOT MERGE] recipes: add nucleoidai npm demo
>   [DO NOT MERGE] classes: spdx: use version 2.2
> 
>  bitbake/lib/bb/fetch2/__init__.py             |    2 +-
>  .../crucible/crucible2_2023.11.02.bb          |   18 +
>  .../node-red/node-red/package-lock.json       | 6096 +++++++++++++++++
>  .../node-red/node-red_4.0.8.bb                |   14 +
>  .../nucleoidai/nucleoidai_0.7.10.bb           |   11 +
>  meta/classes-global/base.bbclass              |   47 +-
>  meta/classes-global/patch.bbclass             |   17 +-
>  meta/classes-recipe/early.bbclass             |   61 +
>  meta/classes-recipe/go-mod.bbclass            |   10 +-
>  meta/classes-recipe/go.bbclass                |   22 +-
>  meta/classes-recipe/nodejs-arch.bbclass       |   15 +
>  meta/classes-recipe/vendor.bbclass            |   28 +
>  meta/classes-recipe/vendor_cargo.bbclass      |   46 +
>  meta/classes-recipe/vendor_go.bbclass         |   59 +
>  meta/classes-recipe/vendor_npm.bbclass        |  115 +
>  meta/classes-recipe/vendor_npm_build.bbclass  |   50 +
>  meta/classes/archiver.bbclass                 |    4 +-
>  meta/classes/buildhistory.bbclass             |    4 +-
>  meta/classes/copyleft_compliance.bbclass      |    2 +-
>  meta/classes/create-spdx-2.2.bbclass          |   14 +-
>  meta/classes/create-spdx.bbclass              |    2 +-
>  meta/classes/externalsrc.bbclass              |    2 +-
>  meta/conf/bitbake.conf                        |    1 +
>  meta/lib/oe/patch.py                          |   10 +-
>  meta/lib/oe/spdx30_tasks.py                   |    5 +-
>  meta/lib/oe/vendor/__init__.py                |   28 +
>  meta/lib/oe/vendor/cargo.py                   |  121 +
>  meta/lib/oe/vendor/go.py                      |   96 +
>  meta/lib/oe/vendor/npm.py                     |  141 +
>  meta/lib/oeqa/selftest/cases/oelib/vendor.py  |  237 +
>  .../python/python3-bcrypt-crates.inc          |   84 -
>  .../python/python3-bcrypt_4.2.1.bb            |    4 +-
>  .../python/python3-cryptography-crates.inc    |   76 -
>  .../python/python3-cryptography.bb            |    4 +-
>  .../python/python3-maturin-crates.inc         |  712 --
>  .../python/python3-maturin_1.8.1.bb           |    4 +-
>  .../python/python3-rpds-py-crates.inc         |   54 -
>  .../python/python3-rpds-py_0.22.3.bb          |    4 +-
>  meta/recipes-gnome/librsvg/librsvg-crates.inc |  590 --
>  ...-to-get-an-updated-idna-rustsec-2024.patch |  398 ++
>  meta/recipes-gnome/librsvg/librsvg_2.59.2.bb  |    7 +-
>  41 files changed, 7633 insertions(+), 1582 deletions(-)
>  create mode 100644 meta-selftest/recipes-support/crucible/crucible2_2023.11.02.bb
>  create mode 100644 meta-selftest/recipes-support/node-red/node-red/package-lock.json
>  create mode 100644 meta-selftest/recipes-support/node-red/node-red_4.0.8.bb
>  create mode 100644 meta-selftest/recipes-support/nucleoidai/nucleoidai_0.7.10.bb
>  create mode 100644 meta/classes-recipe/early.bbclass
>  create mode 100644 meta/classes-recipe/nodejs-arch.bbclass
>  create mode 100644 meta/classes-recipe/vendor.bbclass
>  create mode 100644 meta/classes-recipe/vendor_cargo.bbclass
>  create mode 100644 meta/classes-recipe/vendor_go.bbclass
>  create mode 100644 meta/classes-recipe/vendor_npm.bbclass
>  create mode 100644 meta/classes-recipe/vendor_npm_build.bbclass
>  create mode 100644 meta/lib/oe/vendor/__init__.py
>  create mode 100644 meta/lib/oe/vendor/cargo.py
>  create mode 100644 meta/lib/oe/vendor/go.py
>  create mode 100644 meta/lib/oe/vendor/npm.py
>  create mode 100644 meta/lib/oeqa/selftest/cases/oelib/vendor.py
>  delete mode 100644 meta/recipes-devtools/python/python3-bcrypt-crates.inc
>  delete mode 100644 meta/recipes-devtools/python/python3-cryptography-crates.inc
>  delete mode 100644 meta/recipes-devtools/python/python3-maturin-crates.inc
>  delete mode 100644 meta/recipes-devtools/python/python3-rpds-py-crates.inc
>  delete mode 100644 meta/recipes-gnome/librsvg/librsvg-crates.inc
>  create mode 100644 meta/recipes-gnome/librsvg/librsvg/0001-update-url-crate-to-get-an-updated-idna-rustsec-2024.patch
> 
> -- 
> 2.39.5
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17192): https://lists.openembedded.org/g/bitbake-devel/message/17192
> Mute This Topic: https://lists.openembedded.org/mt/111123517/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [bruce.ashfield@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


