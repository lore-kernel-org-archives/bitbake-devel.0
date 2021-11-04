Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D15EC433F5
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 14:11:36 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web09.12159.1636035095285362212
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 07:11:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=2nvICjb7;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.177,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f177.google.com with SMTP id s24so7486519plp.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DfNYZAd/qmpWupjHqsY8z8iNLAtGHl0fjELU3IYBI5A=;
        b=2nvICjb7o0O9t/G1SHplPMkz+hRWEZGIM/WdmnE1GboG8MAPVosBP9lV2SAh5tXv25
         0KorfbDDBrQRgqhTpj+cflq/7n2fEGztY+y1k76kiC/Ulx5CoGxjGJAZB8oDLgk0TEIh
         8ngpCLHhdH89gLUEFBDLXM6dgWWmPN4ptScMP7ZYJQI4Vs4g8BhePyzExKBy7WnsjAbx
         9TBKk2zKDcdS9cGe7fa1vqtoySNgtyCbsZXTCL9qChXF/vJZRUARkXTx6t0jr9bKNAnN
         Z9Q1wTvUaZ3uqIbQyU4x2gpInWF0XL5IetblX3dK3CteHDX6oxxcBOgq09l5MPC2DF+D
         Xyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DfNYZAd/qmpWupjHqsY8z8iNLAtGHl0fjELU3IYBI5A=;
        b=KOPUCg8m6evsZJ8+IOZkVK5j0Df0pN+cXWgJbptglrewpSGVdxGHoHVD1yZaDL3k6n
         lih8pWsnup+hdwY2jMO1ehZiCjY/3EN5Ur+Wxl0xwEubBu1oWB91bl7iBRC94XlwSiVt
         Z2pIrdArfvKOEm0FWBYIC5g/3Ux7Or04CD5XKeYxxQtapglqwzbM5A7/U8h2hMOok/Qa
         OX7Qq54/n4ApCvD04l8KdnPIIlJCjwVwuZHZXZVIv328wuq6ZaIn3lel8bUQ+vwUWkM4
         Eazu/N2I3mI6F7/g52ufFzdwNjAqzf3ytvWXiOWyn4EqrVrFLntQL3zTAu6qoWRv6stE
         IZtw==
X-Gm-Message-State: AOAM532PbNDFNfepn/E65lpY2fLfsdmNRrb9X9WHyC7Ob6mCSTbXHp9C
	3HH3Pk3gss4tMCxHRNtMF/HVZpQkLxgxAW7DTeI=
X-Google-Smtp-Source: 
 ABdhPJwsD0rkdPmSK8ZePJXiA59cccssOfAOPsa2XOKddVOcg9JktCcUqedJ30V51KrOXEDBh+ZPJw==
X-Received: by 2002:a17:90a:7845:: with SMTP id
 y5mr22637786pjl.48.1636035094219;
        Thu, 04 Nov 2021 07:11:34 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 lx12sm1850546pjb.5.2021.11.04.07.11.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:11:33 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] tests/fetch2: Fix quoting warning
Date: Thu,  4 Nov 2021 04:11:13 -1000
Message-Id: 
 <a0d8ea1707f8b5bb8d5a7cdfe9ea6dffa2bdcd91.1636034890.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1636034890.git.steve@sakoman.com>
References: <cover.1636034890.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 14:11:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12880

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Fix:

lib/bb/tests/fetch.py:1288: DeprecationWarning: invalid escape sequence

for several lines of the fetch tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9d84fd557a3fcbae2cdd70b24e69325ad737a01e)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 8ad10708..afa071bf 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1190,13 +1190,13 @@ class FetchLatestVersionTest(FetcherTest):
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86-video-omap since network issues interfered with testing
-        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap", "ae0394e687f1a77e966cf72f895da91840dffb8f", "(?P<pver>(\d+\.(\d\.?)*))")
+        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap", "ae0394e687f1a77e966cf72f895da91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))")
             : "0.4.3",
-        ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", "(?P<pver>(([0-9][\.|_]?)+[0-9]))")
+        ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))")
             : "11.0.0",
-        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot", "cd437ecbd8986c894442f8fce1e0061e20f04dee", "chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
+        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
             : "1.3.59",
-        ("remake", "git://github.com/rocky/remake.git", "f05508e521987c8494c92d9c2871aec46307d51d", "(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
+        ("remake", "git://github.com/rocky/remake.git", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
             : "3.82+dbg0.9",
     }
 
@@ -1236,11 +1236,11 @@ class FetchLatestVersionTest(FetcherTest):
         #
         # http://www.cups.org/software/1.7.2/cups-1.7.2-source.tar.bz2
         # https://github.com/apple/cups/releases
-        ("cups", "/software/1.7.2/cups-1.7.2-source.tar.bz2", "/apple/cups/releases", "(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
+        ("cups", "/software/1.7.2/cups-1.7.2-source.tar.bz2", "/apple/cups/releases", r"(?P<name>cups\-)(?P<pver>((\d+[\.\-_]*)+))\-source\.tar\.gz")
             : "2.0.0",
         # http://download.oracle.com/berkeley-db/db-5.3.21.tar.gz
         # http://ftp.debian.org/debian/pool/main/d/db5.3/
-        ("db", "/berkeley-db/db-5.3.21.tar.gz", "/debian/pool/main/d/db5.3/", "(?P<name>db5\.3_)(?P<pver>\d+(\.\d+)+).+\.orig\.tar\.xz")
+        ("db", "/berkeley-db/db-5.3.21.tar.gz", "/debian/pool/main/d/db5.3/", r"(?P<name>db5\.3_)(?P<pver>\d+(\.\d+)+).+\.orig\.tar\.xz")
             : "5.3.10",
     }
 
-- 
2.25.1


