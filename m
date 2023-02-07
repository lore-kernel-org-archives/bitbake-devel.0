Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F94C636D6
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 15:10:12 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.85632.1675782605141039006
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 07:10:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=XT/9/0rn;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id u9so11651095plf.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpmZVAgqRv448uW9k1NS4Us5TMZI9ZDy2qyiA9T60cw=;
        b=XT/9/0rnrbRO0lfGLLLrYf4DX5i+hfJLy5Fh44iFcfXhPn7jh+L/3knQNYUdZI/XO+
         4hItZvhR8joSLESU/MBzVJJ6dGtyhryEvb24uSU6NcsVHGWZ+gqAwIyQeGLUBRaGnTGD
         nGQn/882/+XtY1W86TRZ2pc0pzQ9KI+mQDWr1nMYQwjcUSjUOhbu0K5CcbagOOkub0m1
         vYsed7L7y7XkKeizwM7A/endhbjjU8LX3VHxlCRxO8QoTDCvvIEQuSYzQmNr5d6LyOwq
         A4rBwo+AhGIwiWM/PfJ3tOHIA6WiqqAzTb6gbt9QI46sywb/y47HE1MbF+qOwrvp7JB+
         SoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpmZVAgqRv448uW9k1NS4Us5TMZI9ZDy2qyiA9T60cw=;
        b=2g2V2PvI89/ViTLBnUsEMm6Oli6QrvN6ruNhdWfAcSWY2xBL6z1c0NJ2Ju0PuCEEpg
         zjLtIxaqClpFT8fm+DHul7PYM+/BlHmknAxfu7YT3PJKo+BCP5SEd3YHQ/DgadmMDlC1
         5PzXL8fpu/8UDxbmv0y8Tq6OtqoiXD0HoQqjFVlny4+AT3YNPIejRTbTeG3HKE6uL4z3
         OVjglERsyzX6YaA6outTEyoPC1eN9qw4IwCI8hYg6XKr/gynGBE5XY3Z2x0KRLQzSuv3
         sCZ1W/V0B8ikPvHYKrmwQL59gTKCZHWzJRzlpsLs9WS7ipAx8z7lRmL+tbNRoQPOnKFq
         yd+Q==
X-Gm-Message-State: AO0yUKXriCsnaGmbkH1LEA7oil5YIp9SFM2QXuhDo+0YK3CGNZBbCXAO
	0/YQXpBr2hIjxSR+BSv1yhmvChjj/NuqS1g+DkM=
X-Google-Smtp-Source: AK7set/egtwgPmSyx9WExt8934fGhf8ItlwrtImdf2gJe8XSEOk5vrFsUEN56L7ht3nfYyhubPXfdA==
X-Received: by 2002:a05:6a20:1453:b0:bf:8628:b465 with SMTP id a19-20020a056a20145300b000bf8628b465mr4651220pzi.12.1675782604098;
        Tue, 07 Feb 2023 07:10:04 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id g28-20020aa796bc000000b005895f9657ebsm9243444pfk.70.2023.02.07.07.10.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:10:03 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/3] bitbake: fetch/git: use shlex.quote() to support spaces in SRC_URI url
Date: Tue,  7 Feb 2023 05:09:53 -1000
Message-Id: <009d858be1b6cc4067800ce1094f480ed84b2e05.1675782497.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675782497.git.steve@sakoman.com>
References: <cover.1675782497.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 15:10:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14381

From: Charlie Davies <charles.davies@whitetree.xyz>

This commit replaces the instances where escaped double quotes
are used to support SRC_URI url containing spaces with the more
pythonic shlex.quote().

Signed-off-by: Charlie Davies <charles.davies@whitetree.xyz>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4f9ba9c794de55bea0343267467bddea99844374)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/fetch2/git.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 63a9f92b..2868aa5d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -63,6 +63,7 @@ import errno
 import fnmatch
 import os
 import re
+import shlex
 import subprocess
 import tempfile
 import bb
@@ -352,7 +353,7 @@ class Git(FetchMethod):
             # We do this since git will use a "-l" option automatically for local urls where possible
             if repourl.startswith("file://"):
                 repourl = repourl[7:]
-            clone_cmd = "LANG=C %s clone --bare --mirror \"%s\" %s --progress" % (ud.basecmd, repourl, ud.clonedir)
+            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -364,8 +365,8 @@ class Git(FetchMethod):
             if "origin" in output:
               runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
 
-            runfetchcmd("%s remote add --mirror=fetch origin \"%s\"" % (ud.basecmd, repourl), d, workdir=ud.clonedir)
-            fetch_cmd = "LANG=C %s fetch -f --progress \"%s\" refs/*:refs/*" % (ud.basecmd, repourl)
+            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
+            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             progresshandler = GitProgressHandler(d)
@@ -559,7 +560,7 @@ class Git(FetchMethod):
             raise bb.fetch2.UnpackError("No up to date source found: " + "; ".join(source_error), ud.url)
 
         repourl = self._get_repo_url(ud)
-        runfetchcmd("%s remote set-url origin \"%s\"" % (ud.basecmd, repourl), d, workdir=destdir)
+        runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=destdir)
 
         if self._contains_lfs(ud, d, destdir):
             if need_lfs and not self._find_git_lfs(d):
@@ -687,8 +688,8 @@ class Git(FetchMethod):
         d.setVar('_BB_GIT_IN_LSREMOTE', '1')
         try:
             repourl = self._get_repo_url(ud)
-            cmd = "%s ls-remote \"%s\" %s" % \
-                (ud.basecmd, repourl, search)
+            cmd = "%s ls-remote %s %s" % \
+                (ud.basecmd, shlex.quote(repourl), search)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, cmd, repourl)
             output = runfetchcmd(cmd, d, True)
-- 
2.25.1


