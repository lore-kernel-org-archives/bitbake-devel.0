Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9A5C636D4
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 22:20:21 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.221.1675290015517454279
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 14:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=LD/LLuh4;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.43, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f43.google.com with SMTP id mi9so132266pjb.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 14:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzpOvwN/Xr3QfKSm1sMBTT7InXeDloPqPqWGW1oUiWc=;
        b=LD/LLuh4o9G/5FG0U1LptYZ8YQHLku4ycIO6phh/EirncMb9jwB49sjxnXl80lezMk
         d32Gh0ovrd4AvhSotevML7RZ+4qEWB3ibn9bMAwA4AFXOFVbArviCvGnDujJut/DYgyD
         vk5mbm3awp3lcEt0VxDaBZcPRTwSkHn7TxdophGVKivTjexA+/kkR5oYWbq+y0TgWRqo
         xZG9ppJpxH4BNJGV186qCAAIYnrV3t2gBN46ZkqlLNQZ6TPP6K6kGhJEmLG4NIcUbUt1
         2+AxiYbBeUckCKAJg4PSd4j4a5iZj2uRkjUSHGu683aCWde51j4rhRkvvj1D7UgCfr+B
         TXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzpOvwN/Xr3QfKSm1sMBTT7InXeDloPqPqWGW1oUiWc=;
        b=DvKlPfbXl+bx+MFbc1Yn89f0W+lwHHqRzH8CMdULdzG3cWKpIRB4Wj3e5Ss2ZO5Ex9
         L3UCELDk/4KjkpeKVHOwFp4BN6DgEmmlj2BDRleSAEqZn+5MeLxb1LJHnZO5b+2XNzvt
         6uX35poN82Sb+IDm3GJj5HxHlwN1+PDSc59p6iVCPFA784khj0E8mRtzvRAfmeLsIvUb
         JVQQ8YDUE9o30wlVf/2i0vPre8UrCSbkjpLYI7cknZrq7G0pOduJ7O5xav23u/iGU7mF
         dRDh68Zy9enTsN8Jpe2Xfyj+Vp9v0sHIepU8K/mORul4VsCsXG8sw7YKgVYAKlBaThuc
         941g==
X-Gm-Message-State: AO0yUKVnso1Mp3oRQkSqFkb3wcdYE+QL+BD5hWUNvsCjFhUWklqHTmAd
	197JQhUGr3oSeJJHtXUDGONstZqFfJGYwYTmhm4=
X-Google-Smtp-Source: AK7set81fN9pwjP9YXKnjMzXtL3jJ1yxZLTgtmEyB5UYobBXargJLna+AXgwWAGofendQNMHECNy1g==
X-Received: by 2002:a17:902:e1cd:b0:193:3bf7:40e6 with SMTP id t13-20020a170902e1cd00b001933bf740e6mr2853579pla.53.1675290014502;
        Wed, 01 Feb 2023 14:20:14 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b00186acb14c4asm12294049plb.67.2023.02.01.14.20.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:20:14 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/2] fetch2/git: Prevent git fetcher from fetching gitlab repository metadata
Date: Wed,  1 Feb 2023 12:19:50 -1000
Message-Id: <c17fc1468ab84663b919e2809606b1b8ea2bebd9.1675289845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675289845.git.steve@sakoman.com>
References: <cover.1675289845.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 22:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14370

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
index 9c269ca8..e86a4d86 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -424,8 +424,8 @@ This fetcher supports the following parameters:
 
 -  *"nobranch":* Tells the fetcher to not check the SHA validation for
    the branch when set to "1". The default is "0". Set this option for
-   the recipe that refers to the commit that is valid for a tag instead
-   of the branch.
+   the recipe that refers to the commit that is valid for a any namespace
+   instead of the branch.
 
 -  *"bareclone":* Tells the fetcher to clone a bare clone into the
    destination directory without checking out a working tree. Only the
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f0df6fb6..37b2a07d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -44,7 +44,7 @@ Supported SRC_URI options are:
 
 - nobranch
    Don't check the SHA validation for branch. set this option for the recipe
-   referring to commit which is valid in tag instead of branch.
+   referring to commit which is valid in any namespace instead of branch.
    The default is "0", set nobranch=1 if needed.
 
 - usehead
@@ -374,7 +374,11 @@ class Git(FetchMethod):
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


