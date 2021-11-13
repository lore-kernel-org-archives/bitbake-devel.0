Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13535C433EF
	for <webhook@archiver.kernel.org>; Sat, 13 Nov 2021 16:25:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web09.474.1636820753188875560
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 08:25:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HDuq9bj5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id
 y84-20020a1c7d57000000b00330cb84834fso12292719wmc.2
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 13 Nov 2021 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Nod75QqsWO77cNsFuYxLiS1JteZrNz7uxFrawiUzJ+4=;
        b=HDuq9bj5dK3BktMFf1BSM7M6s5ErcysYJlhC1F4sKTPrZmje+LJ10gGuPEdfxogpFH
         wOria0LLLhToPLFjlS+9h8NWywHU1dTCe1oOrcybV1FwR5q1v93osIyazouSZRaMNSGQ
         Iqb7zpw7XmspspGRsCXdjwBvUoB80+6+I/pqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nod75QqsWO77cNsFuYxLiS1JteZrNz7uxFrawiUzJ+4=;
        b=5MEb3OlKiM5kNX1GCGuTDZxZmvDx2OrQnVCvPxiuaChPgAYt97mByiK354JqLRTiT9
         nZD0BW6mBhGS/DStJXWOTAHHF4ggWCXwKyCns8rXmULxVcVGBQ03Hcgqq5jp/0OC2UsG
         Ga935SryuKmM6rTBUUYOz4BdlzYHewenwfcCGumQ3YYM6+QekY8mJL/fKpFdGSNNE19A
         3SiXU/yd5wkvLMzHPtMuccg+n9Fz/M89/MpTfdPzLU2MYYza+aCV8WGkQxE+KoiiohOP
         Jy59NE4q5yx/vaiOLGcdnkjrUZ1c9x+fec0z/JryCQaK4BtM34TTBLAv2w0bRR+bqLoL
         Anug==
X-Gm-Message-State: AOAM532WAFn4jg/aPlNtZQkbdMDyKUo7akAnGqu9l8GlOIxHdosRWJ7D
	9/7Cg58SCHxLk+TFrqSK+b/o3y6EWf6N2w==
X-Google-Smtp-Source: 
 ABdhPJyuksugrn8UJP7OcoyEmjDABZUsDeL86n2V8BvC5EemGtst0ehkLaaliyemIPM1JicBQIAPUg==
X-Received: by 2002:a05:600c:3586:: with SMTP id
 p6mr45017754wmq.34.1636820751548;
        Sat, 13 Nov 2021 08:25:51 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4f1d:7b2:7d47:57f5])
        by smtp.gmail.com with ESMTPSA id
 b14sm11331714wrd.24.2021.11.13.08.25.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 08:25:51 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] cache/ConfHandler: Drop TOPDIR/chdir manipulations
Date: Sat, 13 Nov 2021 16:25:49 +0000
Message-Id: <20211113162549.3931833-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211113162549.3931833-1-richard.purdie@linuxfoundation.org>
References: <20211113162549.3931833-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 13 Nov 2021 16:25:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13040

This code has been unchanged since 2006 apart from attempts to optimise
performance by minimising chdir() calls.

There is no reason the modern bitbake parser should be changing directory
all the time. We did have some path assumptions in the mists of time but
those were resovled and the code is deterministic and doesn't depend on
cwd now for parsing. We can therefore drop the changes in directory.

Also, TOPDIR is now being set by cookerdata in all cases so we don't
need the fallbacks in this code (which was used to effectively initialise
a value). We don't need to change TOPDIR when parsing a recipe, that makes
no sense. If we stop all the other messing around, we don't need to expand
TMPDIR either.

These changes have the potential to break some obscure use cases such
as an anonymous function assuming the current working directory, or some
case which depends on TOPDIR changing but I believe any such uses should
be fixed at this point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py                      | 29 ++++------------------------
 lib/bb/parse/parse_py/ConfHandler.py |  5 +----
 2 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 4e08c100ab..fcb15796cc 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -284,36 +284,15 @@ def parse_recipe(bb_data, bbfile, appends, mc=''):
     Parse a recipe
     """
 
-    chdir_back = False
-
     bb_data.setVar("__BBMULTICONFIG", mc)
 
-    # expand tmpdir to include this topdir
-    bb_data.setVar('TMPDIR', bb_data.getVar('TMPDIR') or "")
     bbfile_loc = os.path.abspath(os.path.dirname(bbfile))
-    oldpath = os.path.abspath(os.getcwd())
     bb.parse.cached_mtime_noerror(bbfile_loc)
 
-    # The ConfHandler first looks if there is a TOPDIR and if not
-    # then it would call getcwd().
-    # Previously, we chdir()ed to bbfile_loc, called the handler
-    # and finally chdir()ed back, a couple of thousand times. We now
-    # just fill in TOPDIR to point to bbfile_loc if there is no TOPDIR yet.
-    if not bb_data.getVar('TOPDIR', False):
-        chdir_back = True
-        bb_data.setVar('TOPDIR', bbfile_loc)
-    try:
-        if appends:
-            bb_data.setVar('__BBAPPEND', " ".join(appends))
-        bb_data = bb.parse.handle(bbfile, bb_data)
-        if chdir_back:
-            os.chdir(oldpath)
-        return bb_data
-    except:
-        if chdir_back:
-            os.chdir(oldpath)
-        raise
-
+    if appends:
+        bb_data.setVar('__BBAPPEND', " ".join(appends))
+    bb_data = bb.parse.handle(bbfile, bb_data)
+    return bb_data
 
 
 class NoCache(object):
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 0834fe3f9b..b895d5b5ef 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -48,10 +48,7 @@ __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
 
 def init(data):
-    topdir = data.getVar('TOPDIR', False)
-    if not topdir:
-        data.setVar('TOPDIR', os.getcwd())
-
+    return
 
 def supports(fn, d):
     return fn[-5:] == ".conf"
-- 
2.32.0


