Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B94EC001DB
	for <webhook@archiver.kernel.org>; Fri,  4 Aug 2023 15:54:37 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.860.1691164471296930052
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Aug 2023 08:54:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=F4rxk2SY;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bcb5df95c5so1861293a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Aug 2023 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691164470; x=1691769270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMYbKi2qDPfzQ2KT0/65xd9wjOaxUal5U+D7Abtqbv0=;
        b=F4rxk2SYRxkovEi/Sq/OXNpCKH4GYSsOF1hrFvve1U5ibiHN8q78AI2o/GFll5O/MQ
         SetBE/Kx3ZahI9XpdJwfO64qGpzGxUoXRXybCfUkF9rdK7OcQk4LpDb5CZQ8q8IUX7bY
         pasMRfmbjR+erqyf1Y/AQXpciII1665XNeJe04Kifap/ZT6CRziKKmUAnwUZxbz1JGTv
         bYNNQmYtqnKYRXUiy67Ixl2A5X0q6derp0aOoKJnKDfrx5xWLJ2NNq1+30NO5nqR2tlf
         cDl0oe4yvHg6Ocfl8F7s/NpSyjzXQ2YpTY+i0t2UaDT1NoXzzL6D5vTe3WtfpDMDgQui
         +a+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164470; x=1691769270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMYbKi2qDPfzQ2KT0/65xd9wjOaxUal5U+D7Abtqbv0=;
        b=i1c3hBXKRE6eWVLWjwQUBZi+9cXfwyLapRDFzh9zae+EVMhneSYvS0Irdn3oNyZLgl
         qHlV2Lnfm/Dw1ZI+1kWc86fW1bBt9Bw22s464hrlDFU+MPzQxkcRkQli3KgHuzZRZSLq
         x+76pAHT/dxgDUiUjf9csD6pH/fXerq3aFnyl13PCKDgAhgt9MR7MMtNcZPO3Tp6SogZ
         aUk5xSjfD+QO2yHnagnEOAVv7AKnpOSvwTG8OVO+aavlgCAi2KzUEIEYYJmUE3ediRoy
         yAiaYh5HjOUKkwQ4gL9SsaNJd8886yEy6SobjTO/XMPou6ZZ+c2uZBKZamLsBOWyKDxr
         EnuQ==
X-Gm-Message-State: AOJu0Yx+8XtOrEW1iCwM1gqOQCGDDDEdPLNv58/OmICbdArdCsyCaa2R
	mRyVs0WdwG+X9DpaBJTtivWFbpkubu8=
X-Google-Smtp-Source: AGHT+IE5F4RR//5U25f5RGdilMjOD5TidDrGJASVqDBpPmsJvzjUCcelvSLM5oxbD8p+mPoa/ceHpg==
X-Received: by 2002:a05:6870:e40b:b0:1b4:4935:653f with SMTP id n11-20020a056870e40b00b001b44935653fmr2398370oag.49.1691164469759;
        Fri, 04 Aug 2023 08:54:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::86b4])
        by smtp.gmail.com with ESMTPSA id ed50-20020a056870b7b200b001b3d93884fdsm1235808oab.57.2023.08.04.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:54:29 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] fetch2: git: Check if directory is a bare git repo
Date: Fri,  4 Aug 2023 09:54:24 -0600
Message-Id: <20230804155424.1502010-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 04 Aug 2023 15:54:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14915

If the clone target directory exists, but isn't the valid top level of a
bare git repo, it needs to be erased and re-cloned. One example of how
this can happen is if a clone creates the directory, but then fails to
actual clone and make it a git repository. This left-over directory can
be particularly problematic if the download directory is a descent of
some top layer git repo (e.g. the default with poky), as the commands
that operate on the remote later will then mangle the layers git
repository instead of the download git repo.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 2a3c06fe4e9..112bed294f0 100644
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
@@ -365,8 +366,29 @@ class Git(FetchMethod):
                 runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
         repourl = self._get_repo_url(ud)
 
+        needs_clone = False
+        if os.path.exists(ud.clonedir):
+            # The directory may exist, but not be the top level of a bare git
+            # repository in which case it needs to be deleted and re-cloned.
+            try:
+                # Since clones are bare, use --absolute-git-dir instead of --show-toplevel
+                output = runfetchcmd("LANG=C %s rev-parse --absolute-git-dir" % ud.basecmd, d, workdir=ud.clonedir)
+            except bb.fetch2.FetchError as e:
+                logger.warning("Unable to get top level for %s (not a git directory?): %s", ud.clonedir, e)
+                needs_clone = True
+            else:
+                toplevel = output.rstrip()
+                if os.path.abspath(toplevel) != os.path.abspath(ud.clonedir):
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


