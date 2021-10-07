Return-Path: <jdmason@kudzu.us>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF5C433F5
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 15:06:36 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web09.13171.1633619195218594746
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kudzu-us.20210112.gappssmtp.com header.s=20210112
 header.b=5eloC8L9;
 spf=none, err=permanent DNS error (domain: kudzu.us, ip: 209.85.222.170,
 mailfrom: jdmason@kudzu.us)
Received: by mail-qk1-f170.google.com with SMTP id x12so6238365qkf.9
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rObJvR4ymwgSKei93s4IlH70kTkicv9n8x0AGSTu6lg=;
        b=5eloC8L9x3jNrq9gpk6o2/LdtUdaqUsbV1iqrbHzRfXpXcRRO/qlhLwFCsRq/Ql91K
         4a7ZIg9CeycCsjvC8ae+RindDUMs6I3oVCfk1yEMIZsA72Bac9cIwjNEXHRuqmxKkZcH
         LrkIV/70A4FWxsiK4nmXtAdVCzUAaOVgJyO4cbIV1gCIrHaIrnPH3TdejM0qo090nM+1
         CPVVsjGymIGFl9usV8H7epkFxNiHGcqdgVAgacO7dw191UVdttHQQIbxhNngmJXamKCp
         dGMzHv8ke26zf/8fhShwd+pxEfd4ORcOoj4kZ4fw5EhF6G6roF0/dIgV6A0Xejvml1C9
         BH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rObJvR4ymwgSKei93s4IlH70kTkicv9n8x0AGSTu6lg=;
        b=y39ELSR9ZLxSdDrIvg+VW0hEe9SA9NfCPqIp3jY/PL2HI3sAMdF182SDuBkABHPkCL
         hmdiSPnhdyZ3TUb6gTl4skDpa9BY+YY0FICn9OHga4oftaYt0jewE2MRk3zNkC5y3a+W
         Hlh2H+zyE1dbeAK0ysNdrirt59i0EmzOSCs8Hdw0yegQsPU3UqG1BEHUgCgErzRgWBeX
         kXewhUsTE37tLDUSsmE3Eva03Blf/tik0c+GRjZGml7bn4PdQfnDS6vGSk8deM1i9HrM
         zK/HIWXk4DvowVIHITmTC/SvRnPotEecSBl+EfXik+lshX3QG6zA187qLvxyknlRmQ/V
         1H3w==
X-Gm-Message-State: AOAM532MKxDZZNm0FD4+iyYLacKChGeOShSwAFoBCr8KOfxuL41iDzmD
	hwwbf0bstMY7EU93UoUSr3WLXcyen3vEwA==
X-Google-Smtp-Source: 
 ABdhPJzaOrtEgu7WH3m0oqM/fmrYq8lojHqFx0JMfeMePnWMlf5LLKnPrlJcJAMLUKb9Wwm4jiBmCw==
X-Received: by 2002:a37:2e87:: with SMTP id
 u129mr3883317qkh.208.1633619194316;
        Thu, 07 Oct 2021 08:06:34 -0700 (PDT)
Received: from localhost ([2605:a601:a650:b700:9937:f30b:7d2e:fddf])
        by smtp.gmail.com with ESMTPSA id
 101sm893381qta.17.2021.10.07.08.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:06:34 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: openembedded-core@lists.openembedded.org,
	docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/8] yocto-bsp/poky: replace http with https for URLs
Date: Thu,  7 Oct 2021 11:06:26 -0400
Message-Id: <20211007150630.22138-5-jdmason@kudzu.us>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211007150630.22138-1-jdmason@kudzu.us>
References: <20211007150630.22138-1-jdmason@kudzu.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 15:06:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12745

https has been the preferred way to access websites for many years now.
Change all of the URLs with a _working_ https server/certificate to use
that URL.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 meta-poky/README.poky.md          | 12 ++++++------
 meta-poky/conf/distro/poky.conf   | 16 ++++++++--------
 meta-yocto-bsp/README.hardware.md |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/meta-poky/README.poky.md b/meta-poky/README.poky.md
index 289373f94411..a99c75ed5cb8 100644
--- a/meta-poky/README.poky.md
+++ b/meta-poky/README.poky.md
@@ -3,7 +3,7 @@ Poky
 
 Poky is an integration of various components to form a pre-packaged
 build system and development environment which is used as a development and
-validation tool by the [Yocto Project](http://www.yoctoproject.org/). It
+validation tool by the [Yocto Project](https://www.yoctoproject.org/). It
 features support for building customised embedded style device images
 and custom containers. There are reference demo images ranging from X11/GTK+
  to Weston, commandline and more. The system supports cross-architecture
@@ -19,8 +19,8 @@ Many layers are available and can be found through the
 As an integration layer Poky consists of several upstream projects such as 
 [BitBake](https://git.openembedded.org/bitbake/),
 [OpenEmbedded-Core](https://git.openembedded.org/openembedded-core/),
-[Yocto documentation](http://git.yoctoproject.org/cgit.cgi/yocto-docs/),
-the '[meta-yocto](http://git.yoctoproject.org/cgit.cgi/meta-yocto/)' layer
+[Yocto documentation](https://git.yoctoproject.org/cgit.cgi/yocto-docs/),
+the '[meta-yocto](https://git.yoctoproject.org/cgit.cgi/meta-yocto/)' layer
 which has configuration and hardware support components. These components
 are all part of the Yocto Project and OpenEmbedded ecosystems.
 
@@ -29,7 +29,7 @@ reference manual which can be found at <https://docs.yoctoproject.org/>
 
 OpenEmbedded is the build architecture used by Poky and the Yocto project.
 For information about OpenEmbedded, see the 
-[OpenEmbedded website](http://www.openembedded.org/).
+[OpenEmbedded website](https://www.openembedded.org/).
 
 Contribution Guidelines
 -----------------------
@@ -42,7 +42,7 @@ who the maintainers are and where bugs should be reported.
 
 A guide to submitting patches to OpenEmbedded is available at:
 
-<http://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded>
+<https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded>
 
 There is good documentation on how to write/format patches at:
 
@@ -72,7 +72,7 @@ Documentation (files in documentation/):
 
 meta-yocto (files in meta-poky/, meta-yocto-bsp/):
 
-- Git repository: <http://git.yoctoproject.org/cgit/cgit.cgi/meta-yocto>
+- Git repository: <https://git.yoctoproject.org/cgit/cgit.cgi/meta-yocto>
 - Mailing list: poky@lists.yoctoproject.org
 
 If in doubt, check the openembedded-core git repository for the content you
diff --git a/meta-poky/conf/distro/poky.conf b/meta-poky/conf/distro/poky.conf
index e161e4943a38..b0793de21cea 100644
--- a/meta-poky/conf/distro/poky.conf
+++ b/meta-poky/conf/distro/poky.conf
@@ -31,14 +31,14 @@ DISTRO_EXTRA_RRECOMMENDS += "${POKY_DEFAULT_EXTRA_RRECOMMENDS}"
 TCLIBCAPPEND = ""
 
 PREMIRRORS ??= "\
-bzr://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
-cvs://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
-git://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
-gitsm://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
-hg://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
-osc://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
-p4://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
-svn://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n"
+bzr://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \n \
+cvs://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \n \
+git://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \n \
+gitsm://.*/.* https://downloads.yoctoproject.org/mirror/sources/ \n \
+hg://.*/.*    https://downloads.yoctoproject.org/mirror/sources/ \n \
+osc://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \n \
+p4://.*/.*    https://downloads.yoctoproject.org/mirror/sources/ \n \
+svn://.*/.*   https://downloads.yoctoproject.org/mirror/sources/ \n"
 
 SANITY_TESTED_DISTROS ?= " \
             poky-3.2 \n \
diff --git a/meta-yocto-bsp/README.hardware.md b/meta-yocto-bsp/README.hardware.md
index f00f167d3ba2..9151d641d5b7 100644
--- a/meta-yocto-bsp/README.hardware.md
+++ b/meta-yocto-bsp/README.hardware.md
@@ -15,7 +15,7 @@ configuration. For more information please see the Yocto Board Support Package
 (BSP) Developer's Guide - documentation source is in documentation/bspguide or 
 download the PDF from:
 
-   http://yoctoproject.org/documentation
+   https://docs.yoctoproject.org/
 
 Note that these reference BSPs use the linux-yocto kernel and in general don't
 pull in binary module support for the platforms. This means some device functionality
-- 
2.20.1


