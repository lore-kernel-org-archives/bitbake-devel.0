Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98812C433F5
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 17:20:04 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web12.1263.1636564803890535916
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 09:20:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=i8h5yt9R;
 spf=pass (domain: gmail.com, ip: 209.85.214.178,
 mailfrom: raj.khem@gmail.com)
Received: by mail-pl1-f178.google.com with SMTP id b11so3521896pld.12;
        Wed, 10 Nov 2021 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nHmRlZft6yaNKqC0gWZDBDN5S7QALwAMq9TyyLEbZL8=;
        b=i8h5yt9RzoqY1RO4joqMQ8OSFGa1KCoyNvDd8Uf/UyMwncCgH1eG6W/olFKCLrH+EK
         gBB/dpLXgye5nQS/W6fDALE6HWqWOvidFm/Naq89TWRwI06WDhMi+ehs3aRcpHKXFg3p
         IMyfhWkQiNuWKbP2GtmTl7SwUMpGSJAuxkzcvhzZGNj1N4fAxHpBKpd4Mw3E0XrKuCQd
         td90aaQ0XjMXjfmAZR9/WjDj2c9VckqrSP5aTuJCIce1oEfGU78oNWtgZs5joCN+F0Wj
         HrlkqIDi4q/rfzbn3kFjWt/i8mIgCrfRsZq7Rs1LQ41/6dxewJDf8TnQH91P3QrKu2pR
         UOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=nHmRlZft6yaNKqC0gWZDBDN5S7QALwAMq9TyyLEbZL8=;
        b=FrFH0mbVOQjSPH4oocC9nvMZqWljDE78avb2MjZCh4Yc3aBOMSeKEE8qf5RVabyVt3
         al5qB5enyVRCX6piCWAVtZ9OAqfDJ5a0bptgMy5dqCX7IsT+brlLGGn5TUjR84uAfv4i
         Yu+ToNgeyUA7gojFlKgG4QtQFngnKohs6IRXMOwCiJzzZoZgGEa02uELXKvzXYgJPBij
         OAfDZIfu8Kv9C1DteaPy9ASw4X7HTAmEmpusK0Abutv6b0q4x2U1Lr3pEwQPdd8Vs0p0
         r22BaPUkQFggvIm5gCSgMzbXk10RhEOmEeIZ6DAv49/ppz/OA1TJGfoknuo4m/8PKpLz
         fdjg==
X-Gm-Message-State: AOAM532sb3r7J9qSnepX8wjKhFmcp3ultN666gE0xc4oDUSaYhMFnx+j
	dRI/K3RnRHdaR5OEPJAcxvQ=
X-Google-Smtp-Source: 
 ABdhPJzhlrYifqXuuqTqJEsGKsyeGMPAh6SBYAOGAFwMMsAFAFPGuVBmje7vOuxgJ3PEHoJyn07Pfw==
X-Received: by 2002:a17:903:246:b0:13f:2ff9:8b93 with SMTP id
 j6-20020a170903024600b0013f2ff98b93mr621666plh.54.1636564803247;
        Wed, 10 Nov 2021 09:20:03 -0800 (PST)
Received: from ?IPV6:2601:646:9200:a0f0:7cfe:7a02:cfe2:7296?
 ([2601:646:9200:a0f0:7cfe:7a02:cfe2:7296])
        by smtp.gmail.com with ESMTPSA id
 mn15sm218474pjb.35.2021.11.10.09.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 09:20:02 -0800 (PST)
Message-ID: <b9f45c83-9be2-96bc-4a5a-d163c14d32b4@gmail.com>
Date: Wed, 10 Nov 2021 09:20:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [bitbake-devel] [oe-core][PATCH v4 1/2] repo: Add recipe for
 2.17.3
Content-Language: en-US
To: jasper@fancydomain.eu, openembedded-core@lists.openembedded.org
Cc: martin@mko.dev, Daniel.Baumgart@iris-sensing.com,
 bitbake-devel@lists.openembedded.org,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
References: <20211110155332.578088-1-jasper@fancydomain.eu>
From: Khem Raj <raj.khem@gmail.com>
Organization: HIMVIS LLC
In-Reply-To: <20211110155332.578088-1-jasper@fancydomain.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 17:20:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12994



On 11/10/21 7:53 AM, Jasper Orschulko via lists.openembedded.org wrote:
> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> 
> Add a recipe for repo 2.17.3, prerequisite for the repo fetcher.
> 
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>   meta/conf/distro/include/maintainers.inc      |  1 +
>   .../0001-Set-REPO_REV-to-v2.17.3.patch        | 34 +++++++++++++++++++
>   .../repo/repo/0001-python3-shebang.patch      | 26 ++++++++++++++
>   meta/recipes-devtools/repo/repo_2.17.3.bb     | 29 ++++++++++++++++
>   4 files changed, 90 insertions(+)
>   create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>   create mode 100644 meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
>   create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb
> 
> diff --git a/meta/conf/distro/include/maintainers.inc b/meta/conf/distro/include/maintainers.inc
> index f3e0a75d56..58a0a9615f 100644
> --- a/meta/conf/distro/include/maintainers.inc
> +++ b/meta/conf/distro/include/maintainers.inc
> @@ -652,6 +652,7 @@ RECIPE_MAINTAINER:pn-quilt-native = "Robert Yang <liezhi.yang@windriver.com>"
>   RECIPE_MAINTAINER:pn-quota = "Anuj Mittal <anuj.mittal@intel.com>"
>   RECIPE_MAINTAINER:pn-re2c = "Khem Raj <raj.khem@gmail.com>"
>   RECIPE_MAINTAINER:pn-readline = "Hongxu Jia <hongxu.jia@windriver.com>"
> +RECIPE_MAINTAINER:pn-repo = "Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>"
>   RECIPE_MAINTAINER:pn-resolvconf = "Chen Qi <Qi.Chen@windriver.com>"
>   RECIPE_MAINTAINER:pn-rgb = "Unassigned <unassigned@yoctoproject.org>"
>   RECIPE_MAINTAINER:pn-rpcbind = "Hongxu Jia <hongxu.jia@windriver.com>"
> diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
> new file mode 100644
> index 0000000000..3086f8eb42
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
> @@ -0,0 +1,34 @@
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
> +folders, we hardcode the REPO_REV variable to a SHA1 that corresponds to
> +the version of the recipe.
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
> ++REPO_REV = '11b30b91df1f0e03b53da970ec2588e85817bacc'
> + if not REPO_REV:
> +   REPO_REV = 'stable'
> + # URL to file bug reports for repo tool issues.
> +--
> +2.33.1
> diff --git a/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch b/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
> new file mode 100644
> index 0000000000..d3888c8bb2
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
> @@ -0,0 +1,26 @@
> +From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Tue, 14 Sep 2021 16:46:51 +0200
> +Subject: [PATCH] python3 shebang
> +
> +Yocto does not symlink from python to python3, thus change the shebang from
> +python to python3.
> +
> +Upstream-Status: Inappropriate [configuration]
> +Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +---
> + repo | 2 +-
> + 1 file changed, 1 insertion(+), 1 deletion(-)
> +
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
> diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb b/meta/recipes-devtools/repo/repo_2.17.3.bb
> new file mode 100644
> index 0000000000..20f5d465d3
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: MIT
> +# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
> +
> +SUMMARY = "Tool for managing many Git repositories"
> +DESCRIPTION = "Repo is a tool built on top of Git. Repo helps manage many Git repositories, does the uploads to revision control systems, and automates parts of the development workflow."
> +HOMEPAGE = "https://android.googlesource.com/tools/repo"
> +SECTION = "console/utils"
> +
> +LICENSE = "Apache-2.0"
> +LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
> +
> +SRC_URI = "git://gerrit.googlesource.com/git-repo.git;protocol=https;branch=main"
> +SRCREV = "11b30b91df1f0e03b53da970ec2588e85817bacc"
> +
> +SRC_URI += "file://0001-python3-shebang.patch \
> +            file://0001-Set-REPO_REV-to-v2.17.3.patch"
> +
> +MIRRORS += "git://gerrit.googlesource.com/git-repo.git git://github.com/GerritCodeReview/git-repo.git \n"
> +
> +S = "${WORKDIR}/git"
> +
> +do_install() {
> +	install -d ${D}${bindir}
> +	install ${WORKDIR}/git/repo ${D}${bindir}

to be on safer side perhaps use below single line instead of above two.

install -Dm 0755 ${WORKDIR}/git/repo ${D}${bindir}/repo

> +}
> +
> +RDEPENDS:${PN} = "python3"
> +
> +BBCLASSEXTEND = "native nativesdk"
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12990): https://lists.openembedded.org/g/bitbake-devel/message/12990
> Mute This Topic: https://lists.openembedded.org/mt/86960071/1997914
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [raj.khem@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

