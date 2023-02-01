Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0DDC636D3
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 14:24:32 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.24416.1675261462946187553
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 06:24:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=IbkIkygr;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so2343374pjb.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3dvZe9UtheAUDUyAViAX5qyx1EcoCkP2T4g58ZwS5E=;
        b=IbkIkygrnIIxnV/7RxvIVGg9WLKZ2JQtbaUKgQrNACxcZmKY7tZ27+3Dq77fOQwRQu
         3hI72qXFXbKEpYz8TJqD7Uo/ayUJSpubvS/NmT3vgxlmmirKI4jdQmajUhTsv9e5MueC
         mOpfE5s+4AyKHAUhT7iym6lE4TKnA20t78b7qtmsIYHvgbDuM5652/fYE8gMwz4Z5AzP
         qDTvi82orR3kgvxj98rRY51D3W2voUUW7JgmHilg2TcUG7zW1pV25lEXYeZNu1Yy7dKn
         EfF5aNr9oSSMpSXOEWpqQ3vXRZ15ouS4AwqxtJh4LCuZuz8ly/b+YmH8mifMsU66nljM
         g62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3dvZe9UtheAUDUyAViAX5qyx1EcoCkP2T4g58ZwS5E=;
        b=gxjdm2i/6O7QWMJopZ4tHlVlxQOrp8SQ8AiunSaE0ZDU9KOZ4YVRgQnO76WhiknrRn
         h+lc6nza/nkZ+qA1NPgy+5M5lrwBU3hw2w/5Ix0zF5OhkVaMLTrGKXU7blYUpju1gT74
         g9OJse26IuSGm9HNhP/+ae3qaW58WVb4JdlyFDHiqhAaudI9tAdGlQSd9WZDHxan+i2S
         OAIHh6iu99f1xNCnhoEt0DaVl944zw0QJpG0NlEU8alJJUiOLefDIW4pfGoJfT8Ims9E
         1IjqJ5pjq60SleyWFBCTo73sTn0qjiN1L2PKsM/eAOjvWobobkywleaUkaxsYPABDgKW
         ftmA==
X-Gm-Message-State: AO0yUKXV2k9XDGED0hptN1ocDbOUGw5BCEOThewub+oAqwufDgLvZE83
	t30aCg/lzZuI37+GfS3wNoW7Wav7VJwsxZ4ofp8=
X-Google-Smtp-Source: AK7set/BOC5/sNqMzCdL0myEVf8xr1Yk2fL6eT6oQLGKC2TcotMiuGhX0gJ1ACdPfCDgBxwC3nFaAQ==
X-Received: by 2002:a17:903:246:b0:198:a715:d26d with SMTP id j6-20020a170903024600b00198a715d26dmr3802838plh.8.1675261461782;
        Wed, 01 Feb 2023 06:24:21 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902744200b00186b7443082sm11788834plt.195.2023.02.01.06.24.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:24:21 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 1/2] fetch2/git: Prevent git fetcher from fetching gitlab repository metadata
Date: Wed,  1 Feb 2023 04:24:12 -1000
Message-Id: <2b4583922de184a2d96324cd4e3f85993341cd14.1675261340.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675261340.git.steve@sakoman.com>
References: <cover.1675261340.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 14:24:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14366

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
index 578edc59..c80e8e5c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -44,7 +44,7 @@ Supported SRC_URI options are:
 
 - nobranch
    Don't check the SHA validation for branch. set this option for the recipe
-   referring to commit which is valid in tag instead of branch.
+   referring to commit which is valid in any namespace instead of branch.
    The default is "0", set nobranch=1 if needed.
 
 - usehead
@@ -382,7 +382,11 @@ class Git(FetchMethod):
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


