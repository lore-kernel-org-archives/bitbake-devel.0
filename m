Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCDCC433FE
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 13:35:42 +0000 (UTC)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (EUR03-DB5-obe.outbound.protection.outlook.com [40.92.71.100])
 by mx.groups.io with SMTP id smtpd.web09.5544.1636119340023198093
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 06:35:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=M2ZazKrO;
 spf=pass (domain: outlook.com, ip: 40.92.71.100,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1+AMaeQkckswbrJdJsy8XGwEzcitbZUH2pnThlpeHholnMYlIRTCVV9CBO8WYV1x4jklZCoIO7JobkkcXfHVKrBAHvLtQmTi8PK0gbulUWYFETb8/XEXXP6qAOXTWwJ0MR47bQOOe221bR9wbQedqghu0c2lOcML8FQlWFegCMA8BnPHYzuMiY/4rfccEorKZoU+ZX5hDuFqA2aq5HEvLQ1ajkzmWqIeBWiiHlmWq80B5LxzEBGdx26axuomTjd7UErLi6e1N4tlL23j1YBPLEDrjlHD9cyR1eAPooTxdUYanusM2Br6n7Q1LjRwEYm7DSVh42YKE8uHhKfKsVa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Lf1OoIRjwMe90JMWOSI6cRMLJZ5aptSqTDaBrl0Bz4=;
 b=eFyPDLw9lq52k/7PILDAWWndVS947waLIQJ+TTULDMOOWNR/s20sEVqfRQBYS4DquZKEzFf5bLXGZHyzCkfi3lxPnl2JS8E0U+Ne1QtN1K/n/ENBGIJzv9suTeVdoZYJObnvS/p2a4RvtjW+16Twguoiy9ydsOGPzWM6412wRGM0/aLAGkQFICoSU/R7t4SIw9K8NvfIq9fhgTp24OjItXWSBmgrC6wnJ9ZAql6NTH/2LUZ/EWiCKTUTAP1liWj/64rzFQChMgaJcpxbaRfPxMdfTPx9pquPGxAxcIyE3rhzxPIpNa40648WFaZ3BaPQLHBIMIKLMen0Sp8Ru6wRaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Lf1OoIRjwMe90JMWOSI6cRMLJZ5aptSqTDaBrl0Bz4=;
 b=M2ZazKrOXOI1Ymdoni8Yx+Kt7sSFDjieCw+1nWZ49qlGP7O90fACIKsqosqrHN4bxpf0hO+37L0/PgqCaODG8d2jvzbYAa4dogh130odlX59HWggnsdInzrI1GbcNsVOwm4iP67Hz4BaptMMfwWAKJcpJywZArYHf58E7vKTkRsFTLNjdVCstMRjATyxIrHbABAeUMNU0dsSM6IYAvf/L7dwPwJNmYHLTVekuOXul1Ztq/LvmANWmKlqyiEx2o/ujEEBJwMapkv38/Rb7+MUWy3yCkLGssnX6BrSeZlu+smrTB/1PxtaJvEKSS8meFBP/LAZC9dn3O6hKwkmAAOGMg==
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com (2603:10a6:20b:284::24)
 by AM0PR09MB4499.eurprd09.prod.outlook.com (2603:10a6:208:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 13:35:38 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::7c6f:9b99:3d00:f710%4]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 13:35:38 +0000
Subject: Re: [bitbake-devel] [oe-core][PATCH 1/2] devtools: Initial recipe for
 repo 2.17.3
To: jasper@fancydomain.eu, openembedded-core@lists.openembedded.org
Cc: martin@mko.dev, Daniel.Baumgart@iris-sensing.net,
 bitbake-devel@lists.openembedded.org,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
References: <20211105133104.19895-1-jasper@fancydomain.eu>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AM9PR09MB4642AA3727D430C698E95EE5A88E9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Fri, 5 Nov 2021 14:35:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211105133104.19895-1-jasper@fancydomain.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN: [NvSTzyB0PdVSXWkNHAdPdaqwlEZjTRRzAuFkkj8zrPHy84g85EiYKWu43d/tiYMf]
X-ClientProxiedBy: AM4PR0902CA0021.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::31) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
X-Microsoft-Original-Message-ID: 
 <dddcad05-941c-08a7-a65b-395058dc9d2e@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 AM4PR0902CA0021.eurprd09.prod.outlook.com (2603:10a6:200:9b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 5 Nov 2021 13:35:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba335ef-6c79-4782-1cd4-08d9a061270e
X-MS-TrafficTypeDiagnostic: AM0PR09MB4499:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eyWTBs/zw913Fy+h2kRx7E7bn63lrnLPT+CekExVK3K5gZ6xDhpUzp0irtFHm+7LbsonacQEBmNzXctvcRNmu7298gaGHqopEP84sitPdnftkZ2AkEneD8ANf166L6xg84oyHlskU0WBDu01jzdv5jnMu5ZfpqZyme6ig0wIN4pu5DnK75Q1NXq0ILv1XgMhCA7ehbcMgi9hHv2CdkmTqMMV8QFlpF9qJBtUtV+yw5f2JlwFyVrG2m5n1ty0qtdU3bWCDDPD+SZT83cefiWS9AwfnnLWMN7O9bPTx0SunEjFSJIoEnRc4gegCLbYBPAoKqLNIjSSPP85tD8elXoixgSqVs5ED6EU1EHs/zXJVhO1rb4PN93nyg0Xj4KMylsYU8pVBLHlZP8h2smcQq2X0OTuriyFlUzloBKMkjecaOf1RRMtPFk0EssaBtOYi27oz7BhXoyjR46p7YS/KJBpTuFznaZuWrPslbiLRNRTk4kpSWM2Z5xX/F1E/hTaCbVWR1TEVKJoaaI/njqILd6mylvL9cSOrIChfJZ7U+iiBBIV++3qq/liGDHplHdxqNEjiIwpACeBSIJGDwkIqdD6ysgpQOtkyt9yaY8He0wJ6OZha0Iw89CrLJuuSpJBEKNr
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	sHAf1zgWO2PhGV8LDsT9W2KuSDsfMCFRqnMCus/8ilSqy3Ezb14R5ivJ7FYVxZMe9TQ5aDaIbjI3NLcBC4emtN5reGWA+dQ7FkZynRLshJ4QfjemajoVTxJ1T/9+mMSPUmBrrOaE1rYBOyCRjqDULFqkMZD0x5yoGEl54awU0+UcNIrbfaxmkx+VlBa2uDIS12su5DDY/hDCvR6X6c+DOYgRLriZvMXyNJ9Rm+wMCirYlixH5jP5zGJxVlpR7n3vA12XLrVh5waSj6+2hi7GlIiR88Mk0Egtmm5rw9zYdk80/GFXcVWm1zEDZwSHWplUIcLk8wtrGcaSSUv0sJcQqP2fSVkRlm5VAnsl2OSOGJ27KED0PdYsQIveJsF2H3+t4zaIBQ2s36nrx9tVoQyN7A64+KTmb2KUSTB2kHFhXnxOK1I8aYHk3yDRr77G1q4rvtSiTI/Msb8TQuA4mSDO3OtrfOd3MSzhlNFzJdpqlMg4rMjfmeTRFDoT/SADUFz0fGBTnoyHi3DHdNVlSmzJSlgXMy9Q2ophFmGeN1Gt3SX4hIWCRXMLWVCjW+glaYFhYtRL76/grx/5TeNtGbrL1oyAg/v6leAe5+Nf2ls1pSmTB1va5HEnSkMUmN+OFsRvZh6dp8Bq4ETsmBeuIP2q1beGyQQl4eWY4Bj50cx15d3HbdUbgD76W1yeG+NM/6wuy4zzNwRCfYcfbkfUxfMzSxnyMqYGGKIjFKgP49Yej85cwwzGyOigwhXg4SoC9SGICxaGD+inN0lG0J3wCRdSLA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2ba335ef-6c79-4782-1cd4-08d9a061270e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4642.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 13:35:38.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4499
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 13:35:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12895

Is this implementation of repo being patched against phoning home to 
google everytime and trying to do that pesky auto-update of the tool?

Otherwise this will become an issue when at one point in time an (then) 
outdated version of the tool is used in a BB_NO_NETWORK build.

On 05.11.21 14:31, Jasper Orschulko via lists.openembedded.org wrote:
> From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> 
> Add a recipe for repo, prerequisite for the repo fetcher.
> 
> Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> ---
>   .../repo/files/0001-python3-shebang.patch     | 21 ++++++++++++
>   .../0001-Set-REPO_REV-to-v2.17.3.patch        | 33 +++++++++++++++++++
>   meta/recipes-devtools/repo/repo.inc           | 25 ++++++++++++++
>   meta/recipes-devtools/repo/repo_2.17.3.bb     |  7 ++++
>   4 files changed, 86 insertions(+)
>   create mode 100644 meta/recipes-devtools/repo/files/0001-python3-shebang.patch
>   create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3.patch
>   create mode 100644 meta/recipes-devtools/repo/repo.inc
>   create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb
> 
> diff --git a/meta/recipes-devtools/repo/files/0001-python3-shebang.patch b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
> new file mode 100644
> index 0000000000..09ccf58264
> --- /dev/null
> +++ b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
> @@ -0,0 +1,21 @@
> +From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
> +From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
> +Date: Tue, 14 Sep 2021 16:46:51 +0200
> +Subject: [PATCH] python3 shebang
> +
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
> +
> +SRC_URI += "file://0001-python3-shebang.patch"
> +
> +S = "${WORKDIR}/git"
> +
> +RDEPENDS_${PN} = "python3"
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
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12893): https://lists.openembedded.org/g/bitbake-devel/message/12893
> Mute This Topic: https://lists.openembedded.org/mt/86840271/3647476
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kweihmann@outlook.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

