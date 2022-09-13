Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B2C6FA8A
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:20 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web09.5464.1663079238452346540
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=ldYoj0Uu;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id l10so11988966plb.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=+8g8k4aGB5h5nH+/V9CltFxlo1WEQD0HNcKu8PVaR18=;
        b=ldYoj0UuZXd0iLy2jrXWPI2cUWh+bmEk2GSGduDECLkW8bxzG2n1OjggQIUi8uCJ5I
         +pPCFO3yu3X+jKtBVnKxZm/9sLrYS09ydRtLqdES6jI2msymtGwRnLGMR/ns6ekQWX3t
         UN7FC+NbdwU0zZ4UdsPX1QGp2zRRRXIysmONBRwRs2Ide2sm7nZGdaySonQu3PQp97ky
         adPiH0zxKkyZMj+FZQiO9vl70H4eq+rMjjHzT2/WfwnddM3ZZaUSi6oNCC5C1fg9pwsE
         8EjikFlIIVCXcKW2sHXfFZkAJSm096DB30aBs3aeTpugaQh1afi/v/vO4ttuIcHaH/p2
         8Gug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+8g8k4aGB5h5nH+/V9CltFxlo1WEQD0HNcKu8PVaR18=;
        b=NOjICMV+k1PF5ynrS7sDA92VXE0uNkgfTyjVn7LAg1OWGEHkakobZQZ2mJlYZUqG7R
         BTJDSz8eE4RfPCuAitl4oywWmwB+RedEC2DhzP2pxsU6U9XE+DR8dEp9LXuC2z0gpI2i
         3XCOja/yMgrhaRYwv7HVp/DJtWRLeU6YZnZqsiXKHoxeJg+LlzkuFO6bUmI1jTHy2VhA
         lRmSHWotfq3nnjx+NC6Pzv2Ska9ucTeDRL/XJU8tPy7pjziqMOJUU7coi9YAqsb4FvtK
         CcKAYkzokBUbdpwrKX59YLdJUhdPXT7AOezSz0NPi5wa0Y1KLla6aYXzSlDQm9EVtRz6
         WpqA==
X-Gm-Message-State: ACgBeo3u2wFAs5SD5Uw7CKycd/1bKiyuuQ9uaFc743zaXGHpDHeLLVbm
	YcKcYjdrb1vkKWZ93QJU4dYJrcEeXnSiV3d6
X-Google-Smtp-Source: 
 AA6agR7/YrDU7eZXooFmch1P++BRHOix/2Wk6jNnfr+4L9Sp7ECnr08WFEg4NPiuXUrtRN3kZfd0bQ==
X-Received: by 2002:a17:903:11c9:b0:172:6ea1:b728 with SMTP id
 q9-20020a17090311c900b001726ea1b728mr32053417plh.95.1663079237214;
        Tue, 13 Sep 2022 07:27:17 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.27.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:27:16 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 07/14] doc: bitbake-user-manual:
 document npm and npmsw fetchers
Date: Tue, 13 Sep 2022 04:26:37 -1000
Message-Id: 
 <79bec5d23116c85724a98e59c4ebfa33a1b57dd3.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663078873.git.steve@sakoman.com>
References: <cover.1663078873.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13968

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This addresses bug [YOCTO #10098]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit cca7999586317435d79bf53df4359cdd8bfadff4)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 .../bitbake-user-manual-fetching.rst          | 76 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index ea8a8aa7..4dfb7889 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -706,6 +706,80 @@ Here is an example URL::
 
    SRC_URI = "crate://crates.io/glob/0.2.11"
 
+.. _npm-fetcher:
+
+NPM Fetcher (``npm://``)
+------------------------
+
+This submodule fetches source code from an
+`NPM <https://en.wikipedia.org/wiki/Npm_(software)>`__
+Javascript package registry.
+
+The format for the :term:`SRC_URI` setting must be::
+
+   SRC_URI = "npm://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+
+This fetcher supports the following parameters:
+
+-  *"package":* The NPM package name. This is a mandatory parameter.
+
+-  *"version":* The NPM package version. This is a mandatory parameter.
+
+-  *"downloadfilename":* Specifies the filename used when storing the downloaded file.
+
+-  *"destsuffix":* Specifies the directory to use to unpack the package (default: ``npm``).
+
+Note that NPM fetcher only fetches the package source itself. The dependencies
+can be fetched through the `npmsw-fetcher`_.
+
+Here is an example URL with both fetchers::
+
+   SRC_URI = " \
+       npm://registry.npmjs.org/;package=cute-files;version=${PV} \
+       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
+       "
+
+See :yocto_docs:`Creating Node Package Manager (NPM) Packages
+</dev-manual/common-tasks.html#creating-node-package-manager-npm-packages>`
+in the Yocto Project manual for details about using
+:yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-reference.html>`
+to automatically create a recipe from an NPM URL.
+
+.. _npmsw-fetcher:
+
+NPM shrinkwrap Fetcher (``npmsw://``)
+-------------------------------------
+
+This submodule fetches source code from an
+`NPM shrinkwrap <https://docs.npmjs.com/cli/v8/commands/npm-shrinkwrap>`__
+description file, which lists the dependencies
+of an NPM package while locking their versions.
+
+The format for the :term:`SRC_URI` setting must be::
+
+   SRC_URI = "npmsw://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+
+This fetcher supports the following parameters:
+
+-  *"dev":* Set this parameter to ``1`` to install "devDependencies".
+
+-  *"destsuffix":* Specifies the directory to use to unpack the dependencies
+   (``${S}`` by default).
+
+Note that the shrinkwrap file can also be provided by the recipe for
+the package which has such dependencies, for example::
+
+   SRC_URI = " \
+       npm://registry.npmjs.org/;package=cute-files;version=${PV} \
+       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
+       "
+
+Such a file can automatically be generated using
+:yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-reference.html>`
+as described in the :yocto_docs:`Creating Node Package Manager (NPM) Packages
+</dev-manual/common-tasks.html#creating-node-package-manager-npm-packages>`
+section of the Yocto Project.
+
 Other Fetchers
 --------------
 
@@ -715,8 +789,6 @@ Fetch submodules also exist for the following:
 
 -  Mercurial (``hg://``)
 
--  npm (``npm://``)
-
 -  OSC (``osc://``)
 
 -  Secure FTP (``sftp://``)
-- 
2.25.1


