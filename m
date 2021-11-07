Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4464FC433F5
	for <webhook@archiver.kernel.org>; Sun,  7 Nov 2021 09:05:10 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.29272.1636275909179826706
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Nov 2021 01:05:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SmfRyDFj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id r8so21211765wra.7
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Nov 2021 01:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=rG7e45k7GPNBpObYiBaaLMwwIs2Y5+NtOjHhqSMb2bE=;
        b=SmfRyDFjGow1Ktv1Eaj9ZtiUpMFcz7aqdIkOdXTv1e2SV9U3rttwGsndSV6yv4aZ9V
         vtPIbuOcqw0zFDcb5sUrKQjikD+c3lMblMy5ApWjcku0LNQfkn6DPhPFnBcLuGWRR/sQ
         L9EPiXHbRdabNdRVpM8yWYyyCBE176dsD5DYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rG7e45k7GPNBpObYiBaaLMwwIs2Y5+NtOjHhqSMb2bE=;
        b=OggrhDPkqkaAFTJfhOp4fJoKpKlNXMf0IYztsJDDELELH2X3Z9/tGTcBphh3z4hYGN
         Y3C0yyUCl8BF4UPUxpiWEF1mFXmbORFZ4dYjBjt7K0WfpYm6gkmSFhiOCBqAPvLal6bJ
         ac9jHmjg1Yczi4BwnOk0fxOa2NcNPscVkiJcluIosH8NXTUouXU+wYDfj0xRwxzgn/bF
         0ckUlG1kjJCkMxx7kMbg5mlkwJdJ5G+/awmM1kW0GYhD9eFMJ0SNnmJJafx7ztCpWin/
         hdsJMkrPoNGAoftyLjPB+HyGzlxVA+4BBWZyi4KWRqlhtpuz7eIek5AfGbzNaOmLbGF1
         e2Vw==
X-Gm-Message-State: AOAM530+xeIsDVOWheYYnZZyytj9RS2LfvSH+2taC/cB4EAaEJwbaofn
	mL0N2azGTZMKn9T3zp6A6V3g1Q==
X-Google-Smtp-Source: 
 ABdhPJzfuSkeNubcJexZrtE1hVgiAytn5XXI0xBKbt+cHzZ4YBNGBrCdGbczhaKKyhydiTrpetrAQQ==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr62817745wrt.31.1636275907496;
        Sun, 07 Nov 2021 01:05:07 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:fdfa:2bc:4272:d318?
 ([2001:8b0:aba:5f3c:fdfa:2bc:4272:d318])
        by smtp.gmail.com with ESMTPSA id
 n15sm16994013wmq.38.2021.11.07.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 01:05:07 -0800 (PST)
Message-ID: 
 <4d9824a6a12bbdb28cd3d898b82118356712959b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe
 for repo 2.17.3
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jasper@fancydomain.eu, openembedded-core@lists.openembedded.org
Cc: martin@mko.dev, Daniel.Baumgart@iris-sensing.net,
	bitbake-devel@lists.openembedded.org, Jasper Orschulko
	 <Jasper.Orschulko@iris-sensing.com>
Date: Sun, 07 Nov 2021 09:05:06 +0000
In-Reply-To: <20211105133104.19895-1-jasper@fancydomain.eu>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Nov 2021 09:05:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12927

On Fri, 2021-11-05 at 14:31 +0100, Jasper Orschulko via lists.openembedded.org
wrote:
> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> 
> Add a recipe for repo, prerequisite for the repo fetcher.
> 
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>  .../repo/files/0001-python3-shebang.patch     | 21 ++++++++++++
>  .../0001-Set-REPO_REV-to-v2.17.3.patch        | 33 +++++++++++++++++++
>  meta/recipes-devtools/repo/repo.inc           | 25 ++++++++++++++
>  meta/recipes-devtools/repo/repo_2.17.3.bb     |  7 ++++
>  4 files changed, 86 insertions(+)
>  create mode 100644 meta/recipes-devtools/repo/files/0001-python3-shebang.patch
>  create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>  create mode 100644 meta/recipes-devtools/repo/repo.inc
>  create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb

This basically looks ok to me, I've some minor comments below.

The patch is missing adding an entry to:

meta/conf/distro/include/maintainers.inc

which is required for OE-Core recipes and will trip up automated testing if we
don't.

> 
> diff --git a/meta/recipes-devtools/repo/files/0001-python3-shebang.patch b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
> new file mode 100644
> index 0000000000..09ccf58264
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch


I'd put this in a folder called "repo" rather than files.

> @@ -0,0 +1,21 @@
> +From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Tue, 14 Sep 2021 16:46:51 +0200
> +Subject: [PATCH] python3 shebang
> +
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> 

Missing Upstream-Status: (you got the second one ok though! :)

> +diff --git a/repo b/repo
> +index b13e34c..205e0e5 100755
> +--- a/repo
> ++++ b/repo
> +@@ -1,4 +1,4 @@
> +-#!/usr/bin/env python
> ++#!/usr/bin/env python3
> + # -*- coding:utf-8 -*-
> + #
> + # Copyright (C) 2008 The Android Open Source Project
> +--
> +2.33.0
> diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
> new file mode 100644
> index 0000000000..294a3af53a
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
> @@ -0,0 +1,33 @@
> +From bdd2a528da59c28db8ae2986834926de7cebf3ab Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Thu, 4 Nov 2021 16:55:12 +0100
> +Subject: [PATCH] Set REPO_REV to v2.17.3
> +
> +repo is an unusual tool because it downloads all of its own Python modules
> +using GPG-signed git tags, and stores those files as part of the project
> +that it is working with.
> +
> +So in order to have a reproducible repo installation within the project
> +folders, we hardcode the REPO_REV variable to this recipes PV.
> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
> +diff --git a/repo b/repo
> +index 4cddbf1..cf5f6b1 100755
> +--- a/repo
> ++++ b/repo
> +@@ -142,7 +142,7 @@ if __name__ == '__main__':
> + REPO_URL = os.environ.get('REPO_URL', None)
> + if not REPO_URL:
> +   REPO_URL = 'https://gerrit.googlesource.com/git-repo'
> +-REPO_REV = os.environ.get('REPO_REV')
> ++REPO_REV = 'v2.17.3'
> + if not REPO_REV:
> +   REPO_REV = 'stable'
> + # URL to file bug reports for repo tool issues.
> +--
> +2.33.1
> diff --git a/meta/recipes-devtools/repo/repo.inc b/meta/recipes-devtools/repo/repo.inc
> new file mode 100644
> index 0000000000..60b32e4d74
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo.inc
> @@ -0,0 +1,25 @@
> +# SPDX-License-Identifier: MIT
> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
> +
> +SUMMARY = "Tool for managing many Git repositories"
> +DESCRIPTION = "Repo is a tool built on top of Git. Repo helps manage many Git repositories, does the uploads to revision control systems, and automates parts of the development workflow."
> +HOMEPAGE = "https://android.googlesource.com/tools/repo"
> +SECTION = "console/utils"
> +
> +LICENSE = "Apache-2.0"
> +
> +SRC_URI = "git://git@gerrit.googlesource.com/git-repo.git;protocol=https;branch=main"
> +MIRRORS = "git://git@gerrit.googlesource.com/git-repo.git git://github.com/GerritCodeReview/git-repo.git \n"

You shouldn't be clearing MIRRORS with "=" as the user may have something set in
there the system needs to work, you probably want += here.

> +
> +SRC_URI += "file://0001-python3-shebang.patch"
> +
> +S = "${WORKDIR}/git"
> +
> +RDEPENDS_${PN} = "python3"

This is old overrides syntax, it is RDEPENDS:${PN} now as others have mentioned.

> +
> +do_install() {
> +    install -d ${D}${bindir}
> +    install -m 755 ${WORKDIR}/git/repo ${D}${bindir}
> +}
> +
> +BBCLASSEXTEND = "native nativesdk"
> diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb b/meta/recipes-devtools/repo/repo_2.17.3.bb
> new file mode 100644
> index 0000000000..c26264b9e9
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: MIT
> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
> +
> +require recipes-devtools/repo/repo.inc
> +
> +SRCREV = "11b30b91df1f0e03b53da970ec2588e85817bacc"
> +LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"



