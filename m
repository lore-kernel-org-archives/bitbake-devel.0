Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8374DC433F5
	for <webhook@archiver.kernel.org>; Fri, 22 Oct 2021 13:59:56 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.8654.1634911195115412459
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Oct 2021 06:59:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=GL+WukCP;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id
 n36-20020a17090a5aa700b0019fa884ab85so5776932pji.5
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Oct 2021 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YjTRU/VerZ4zjZvo6fdXCJOHeCWkHGCTOjPEhhBvtRQ=;
        b=GL+WukCPw3YMBJy01zTCczyExbaXFXW6LgcRDKfKTIpCbIQpQv2s9e2U9/GGkQHr8F
         DpWVvNL9c4ld6gBY0Cy5SrKhVKmdXhowNHK/ZdfzDGr6qjTUbA6B73oHA0LmCgfbOiI2
         utAH5IwL75T9TXps2TeRvV7ALWJdGZVfAmYYbKwp+VTOecJ219NUT1SE0bAhBO/ohWDX
         0wFMERXClod2WkAjGZQp5eCu3nLk0QwuOOLnmKJqlKq6A586kTeoMjac1b+MM1Wu3AWb
         AKQ6sSAIH/85Odwdskdsh6bhXJSrE3gAICsAsjxRuhgVHqkS2WQ211ZKyTmIgYPso02I
         H7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YjTRU/VerZ4zjZvo6fdXCJOHeCWkHGCTOjPEhhBvtRQ=;
        b=ek5W9KamoyAMDtuyMj7NQYYD608ADXUOROtWgBqJ3647kXeF9rBMzecgnpWKj08zGr
         rh3KYWQBmlU1vCNLLFCruRF/I38mxP3LzP1jlw3n1HXQHRnFMkixcz6wij27WrgGkHUW
         bnMNU5gwq7jZSHjyZU5mpDmnDj+2YYHzNEDOosry//CgYyrgLH5CFdpe6/OAIEbRTALz
         JE3d47a5R2vey4rtBqF8ZL/jhC/BFzLVUDHr4aLHSRKyBFHofUhucCJHC4YhT3V1j1iU
         mnsgH2R1JlarQX8KSY+O1zzERoot4tl4CxVTv5mV71TU5AY5Gk0tIVrgNlZRZ1YeapQz
         0T5A==
X-Gm-Message-State: AOAM531vQd9qSxfz2yxM314qoUA9iRN1yCsFU5B4+g3hq9DmrF2zhuY9
	Fboa0IYomJJdbrLv1aOtiCBZeeHZ8IIzT1x8Lsg=
X-Google-Smtp-Source: 
 ABdhPJwWZb4ky+Pt1O3cXQEx4ZACA4mX/mmUF9HFAeeS6UtPXMyurkSXl6nmBBX4KqjtmgYtnWXZcQ==
X-Received: by 2002:a17:90a:598d:: with SMTP id
 l13mr127433pji.8.1634911193965;
        Fri, 22 Oct 2021 06:59:53 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d20sm10032806pfl.82.2021.10.22.06.59.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:59:53 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/2] fetch2/git: Avoid races over
 mirror tarball creation
Date: Fri, 22 Oct 2021 03:59:14 -1000
Message-Id: 
 <e564c5e2a621f8ee75475674edff9457bd60df4f.1634910994.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634910994.git.steve@sakoman.com>
References: <cover.1634910994.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Oct 2021 13:59:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12815

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There is a potential race over the mirror tarballs where a partial git repo
could be extracted causing fetcher failures if the tarball is being rewritten
whilst another build accesses it.

Create the mirror tarball atomically to avoid this.

[YOCTO #14441]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3250bc950c56bd7dd2114df26e5a8e13b04ceac8)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 112b833f..81335c11 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -67,6 +67,7 @@ import subprocess
 import tempfile
 import bb
 import bb.progress
+from contextlib import contextmanager
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
@@ -408,6 +409,20 @@ class Git(FetchMethod):
                 bb.utils.remove(tmpdir, recurse=True)
 
     def build_mirror_data(self, ud, d):
+
+        # Create as a temp file and move atomically into position to avoid races
+        @contextmanager
+        def create_atomic(filename, d):
+            fd, tfile = tempfile.mkstemp(dir=os.path.dirname(filename))
+            try:
+                yield tfile
+                umask = os.umask(0o666)
+                os.umask(umask)
+                os.chmod(tfile, (0o666 & ~umask))
+                runfetchcmd("mv %s %s" % (tfile, filename), d)
+            finally:
+                os.close(fd)
+
         if ud.shallow and ud.write_shallow_tarballs:
             if not os.path.exists(ud.fullshallow):
                 if os.path.islink(ud.fullshallow):
@@ -418,7 +433,8 @@ class Git(FetchMethod):
                     self.clone_shallow_local(ud, shallowclone, d)
 
                     logger.info("Creating tarball of git repository")
-                    runfetchcmd("tar -czf %s ." % ud.fullshallow, d, workdir=shallowclone)
+                    with create_atomic(ud.fullshallow, d) as tfile:
+                        runfetchcmd("tar -czf %s ." % tfile, d, workdir=shallowclone)
                     runfetchcmd("touch %s.done" % ud.fullshallow, d)
                 finally:
                     bb.utils.remove(tempdir, recurse=True)
@@ -427,7 +443,8 @@ class Git(FetchMethod):
                 os.unlink(ud.fullmirror)
 
             logger.info("Creating tarball of git repository")
-            runfetchcmd("tar -czf %s ." % ud.fullmirror, d, workdir=ud.clonedir)
+            with create_atomic(ud.fullmirror, d) as tfile:
+                runfetchcmd("tar -czf %s ." % tfile, d, workdir=ud.clonedir)
             runfetchcmd("touch %s.done" % ud.fullmirror, d)
 
     def clone_shallow_local(self, ud, dest, d):
-- 
2.25.1


