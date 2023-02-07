Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404AFC6379F
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 15:10:12 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.85635.1675782607168909668
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 07:10:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=GtSxuik3;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id bg10-20020a17090b0d8a00b00230c7f312d4so5883995pjb.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 07:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HZpO9gaG4yrEhhZrm+V1bjeiMxuikEQm91drZeZI8U=;
        b=GtSxuik3/akXz0v/Q8UgDwU4yhWsJP7rx1Qzh/jk+tFWHyTBrT9AYQKDYWkzgt2T94
         rXkCzBnEMfg2kDUZAFPWiUx0tlEZcAM0i6DwrXXzPnxx4eyUiSl7jRPNxOFuewUozh73
         7H9joLLOSNiICVVJWBxkEVHQleepnLilWmNk9ttEoepmjOXjHqjgNK1E/eSD0LqJsyVU
         nqCMuQIeD1MiKCwwINUnON4DUz7smJrX6s/1RWH+q+RlIcnPEkLkM3pM/Qz7TshaWYZ7
         LsI9EaxUQ0j6M4nWnJRJNi/8J/nLxZ0DMGbk9uf9aT8WvZeWvSR+IbJAfA5sZg+qFRzV
         4dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HZpO9gaG4yrEhhZrm+V1bjeiMxuikEQm91drZeZI8U=;
        b=yW7RIqr4UPYBcqU04b3OXtfHmWOYxA9lvUbFWOrfd67p5czJO0M1jgFliVzVtBvWhY
         fBaBLbGfcl+6GkAIT3GNPqawBzl4DpNc0+kvLTXuUQK2SXV2fvVg5x92Bn2n62n6q+1p
         NQxo81Kd/ph0GDQoE8E7dK1S9T/1I+J0adkS5PpXDp6Mnq1RYramkfaMI8NXE0/jjkxC
         XXa3G7eFMjcSeWjR9X/SogPaQcToEVLyUW6ugBLPeseMSpi+7B3cr+2/wqn6iwJx+agW
         uq3+QO6FrdnmxH8KNoHzkEY1Pv8tbdjUnv2ARaYR/nZtkaouB8bMpGmKhwDxPsd/226J
         65ew==
X-Gm-Message-State: AO0yUKVkZTuDHbMXZt6bhy51oLfeIRXy3Zx7dnIMJDZxCdZvjKxfI4t2
	MJKKdxL7VuOwZNLnnLQKDoR7NGatqYXDCxT2O6c=
X-Google-Smtp-Source: AK7set9Vvo0pFeXMjEQioNMmC/xnKZ4j96FoPGVQi/abN2yl8thm3n2lp6mRAKYtaFm5ueXLfOOIeA==
X-Received: by 2002:a05:6a20:47c3:b0:bf:d9f0:aa27 with SMTP id ey3-20020a056a2047c300b000bfd9f0aa27mr2808739pzb.55.1675782606048;
        Tue, 07 Feb 2023 07:10:06 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id g28-20020aa796bc000000b005895f9657ebsm9243444pfk.70.2023.02.07.07.10.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:10:05 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/3] fetch2/git: Prevent git fetcher from fetching gitlab repository metadata
Date: Tue,  7 Feb 2023 05:09:54 -1000
Message-Id: <7590cc452b98e94f930c85a5aa9b4bcb068eafa2.1675782497.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675782497.git.steve@sakoman.com>
References: <cover.1675782497.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 15:10:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14382

From: Marek Vasut <marex@denx.de>

The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
single object in the remote repository. This works poorly with gitlab
and github, which use the remote git repository to track its metadata
like merge requests, CI pipelines and such.

Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
and refs/keep-around/* and they all contain massive amount of data that
are useless for the bitbake build purposes. The amount of useless data
can in fact be so massive (e.g. with FDO mesa.git repository) that some
proxies may outright terminate the 'git fetch' connection, and make it
appear as if bitbake got stuck on 'git fetch' with no output.

To avoid fetching all these useless metadata, tweak the git fetcher such
that it only fetches refs/heads/* and refs/tags/* . Avoid using negative
refspecs as those are only available in new git versions.

Per feedback on the ML, Gerrit may push commits outsides of branches or
tags during CI runs, which currently works with the 'nobranch=1' fetcher
parameter. To retain this functionality, keep fetching everything in case
the 'nobranch=1' is present. This still avoids fetching massive amount of
data in the common case, since 'nobranch=1' is rare. Update 'nobranch'
documentation.

Reviewed-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
(cherry picked from commit d32e5b0ec2ab85ffad7e56ac5b3160860b732556)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/git.py                                     | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 93ac18b7..37c7bcc8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -405,8 +405,8 @@ This fetcher supports the following parameters:
 
 -  *"nobranch":* Tells the fetcher to not check the SHA validation for
    the branch when set to "1". The default is "0". Set this option for
-   the recipe that refers to the commit that is valid for a tag instead
-   of the branch.
+   the recipe that refers to the commit that is valid for a any namespace
+   instead of the branch.
 
 -  *"bareclone":* Tells the fetcher to clone a bare clone into the
    destination directory without checking out a working tree. Only the
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 2868aa5d..b8e00ced 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -44,7 +44,7 @@ Supported SRC_URI options are:
 
 - nobranch
    Don't check the SHA validation for branch. set this option for the recipe
-   referring to commit which is valid in tag instead of branch.
+   referring to commit which is valid in any namespace instead of branch.
    The default is "0", set nobranch=1 if needed.
 
 - usehead
@@ -366,7 +366,11 @@ class Git(FetchMethod):
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
 
             runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
-            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
+
+            if ud.nobranch:
+                fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
+            else:
+                fetch_cmd = "LANG=C %s fetch -f --progress %s refs/heads/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repourl))
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
-- 
2.25.1


