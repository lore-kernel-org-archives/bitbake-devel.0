Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2252BC3DA6F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 19:53:42 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web10.1214.1692906816603914636
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Aug 2023 12:53:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=AofZtM7c;
 spf=pass (domain: gmail.com, ip: 209.85.161.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-57128297bd7so195320eaf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 12:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692906815; x=1693511615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fzhq7Olp7fwJTO1sDRhH66sKhSZqeTMRWwqRTnXOLDc=;
        b=AofZtM7c4/7Jl0rs9xrCCnUULsF/yP5krQZxqo99HiwCTZtyzhyFLJrrUu4fSUNXbb
         dZKsC91aXgMjl346baD55RkWGwiyDcmm1gd5NBVByr+RftcebXqcVy/iY/2xC61UKPT6
         CNHXNKFFyR1o548u9kxMVpTUIwGiHngJXo9EO2ZVZWbaTcL+UkT98U5Txm62hOqUoIy6
         v3qsxN2FHRHLEr6Py+iXHV8Z+kf/sJYiTnc4R6MFPEGPcGEAHDmj4XZI4hMKIdmMoTFX
         6yinj0sdoJc81K0cUbREbA+8AZ9O59Hjc8hSLxyIkTXXmm1UfQ9BZSu7Dw6P4DjIKFmf
         9VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692906815; x=1693511615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fzhq7Olp7fwJTO1sDRhH66sKhSZqeTMRWwqRTnXOLDc=;
        b=AOZ6oAFoqaIXWOH7VUSExJy6VbdzyPnemD3xm5keY5YiQl99kWVppHgPuaqGMgYyGn
         bJqKpJlS+crTcjYwQ1pxD+GEsTFBDmrD/q+I+TjJ6NPLezfoygM716V1EIGG0cX528iv
         9a9Y1Q9mOr5IO1/fwcOw6H21ryyci1EUTOlYxJO6pKLR6A2eDOWkDHMmdqxQ7w/VBFN5
         7Ajt8FQSOQGvec8pgdOo6ixL5GQQGkhW6i9uqqdv4BT77ZoOF7L2fsxv92UGX7zO+Hf6
         +cxZDw3ULThRZO0YLB2mZkTZy26LEZ1Qu6JeS27hzwWn3DKbOi9ljDi/nlIeT1g0xeyt
         3i9w==
X-Gm-Message-State: AOJu0YyMNKuY/++N35jHFrvFyQB8/tcW8hgvtId5FPWqjKrA1Qs8CygW
	Zv2Y5KAc1xzs+wWntBUMOTj2ZDkuHXs=
X-Google-Smtp-Source: AGHT+IFLBxYnYRWUL88wzYVVotbZ3bc2VoZG3cTogvwdR2VRzn6GXlItv0IxrUqGsVoKVoUMB0RgzQ==
X-Received: by 2002:a05:6870:3310:b0:1c8:b7ad:1ec with SMTP id x16-20020a056870331000b001c8b7ad01ecmr872613oae.25.1692906815148;
        Thu, 24 Aug 2023 12:53:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::751c])
        by smtp.gmail.com with ESMTPSA id h42-20020a056870172a00b001cb3ae7cddfsm170303oae.41.2023.08.24.12.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 12:53:34 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] fetch2: git: Check if clone directory is a git repo
Date: Thu, 24 Aug 2023 13:53:32 -0600
Message-Id: <20230824195332.851528-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230804155424.1502010-1-JPEWhacker@gmail.com>
References: <20230804155424.1502010-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Aug 2023 19:53:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14979

If the clone target directory exists and is a valid git repo, but the
git directory is not a child, it needs to be erased and re-cloned. One
example of how this can happen is if a clone creates the directory, but
then fails to actual clone and make it a git repository. This left-over
directory can be particularly problematic if the download directory is a
descent of some top layer git repo (e.g. the default with poky), as the
commands that operate on the remote later will then mangle the layers
git repository instead of the download git repo.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 2a3c06fe4e9..33895e09b29 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -65,6 +65,7 @@ import fnmatch
 import os
 import re
 import shlex
+import shutil
 import subprocess
 import tempfile
 import bb
@@ -365,8 +366,35 @@ class Git(FetchMethod):
                 runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
         repourl = self._get_repo_url(ud)
 
+        needs_clone = False
+        if os.path.exists(ud.clonedir):
+            # The directory may exist, but not be the top level of a bare git
+            # repository in which case it needs to be deleted and re-cloned.
+            try:
+                # Since clones can be bare, use --absolute-git-dir instead of --show-toplevel
+                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
+            except bb.fetch2.FetchError as e:
+                logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
+                needs_clone = True
+            else:
+                toplevel = os.path.abspath(output.rstrip())
+                abs_clonedir = os.path.abspath(ud.clonedir).rstrip('/')
+                # The top level Git directory must either be the clone directory
+                # or a child of the clone directory. Any ancestor directory of
+                # the clone directory is not valid as the Git directory (and
+                # probably belongs to some other unrelated repository), so a
+                # clone is required
+                if os.path.commonprefix([abs_clonedir, toplevel]) != abs_clonedir:
+                    logger.warning("Top level directory '%s' doesn't match expected '%s'. Re-cloning", toplevel, ud.clonedir)
+                    needs_clone = True
+
+            if needs_clone:
+                shutil.rmtree(ud.clonedir)
+        else:
+            needs_clone = True
+
         # If the repo still doesn't exist, fallback to cloning it
-        if not os.path.exists(ud.clonedir):
+        if needs_clone:
             # We do this since git will use a "-l" option automatically for local urls where possible,
             # but it doesn't work when git/objects is a symlink, only works when it is a directory.
             if repourl.startswith("file://"):
-- 
2.33.0


