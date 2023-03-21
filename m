Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9388EC74A5B
	for <webhook@archiver.kernel.org>; Tue, 21 Mar 2023 14:49:27 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.15519.1679410161771382942
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Mar 2023 07:49:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JcY4hQBf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id ip21-20020a05600ca69500b003ed56690948so9156670wmb.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679410160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uW9D8zzQt4VO7Ytx9D1P17GYyZxCFQysyr1LAxp2gGE=;
        b=JcY4hQBf0dapL8QzlmATEtNShKAYKRukFVYZJM8QosaE5Ea5y6yHBnRT86kuoi+PnC
         St29AU5E7VQ0hVs0OaSPybJyf0/VgV1hbS+Q9ANJVUmpGZqKmjE1E+segytiWKG08d/x
         WrdVfYIriCUUFjOjDc/c0JoIgpsgybiBH5AW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679410160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uW9D8zzQt4VO7Ytx9D1P17GYyZxCFQysyr1LAxp2gGE=;
        b=cd3crl+wvY3qUah+Q3/5gjDeLwvYUZQWCDaspCH8GAyxQVCFZiggAx+kOcIQM5nlWb
         XmUxIStGN7aecdamKGE7KTDqrfzjXWb56WWl+D+xrWBnSQtq9TnxFjXbIpcWyb71UaDA
         ZiR62O8qPLuEav9Ec36PUGrjY7MIXQPSqy/qkeQ90eQ7khbjf1BCGgzeqpFQOJDYlPqC
         t6TRdjy3I0mG+D5W6PmF73PT8Hm3voV3etSCf+9T0Kq5r2h81wuTlAV2u5uVtnIK3/xY
         PCSho9XNw3lbOM5RnsPy8lfb19ZbzpvvtSeo2CqCQdHe2VMgxk09BpdWkPzI8KvxpTFm
         p6Ag==
X-Gm-Message-State: AO0yUKW38jvHB88iadJEKCyPCdFgT8CR1T5AQ9zzGyP3SDAf3glnOb4j
	UielgxG2hSCfy/bosADyu8Z1axMoH6zR7QxcRS4=
X-Google-Smtp-Source: AK7set/ALRnSoGhKPi9+glcqek5H8cc3y048rjjLUgl1U7zKzhGcW7Nkze4ASgn+KLXWOBm+Pu3PMQ==
X-Received: by 2002:a05:600c:3649:b0:3ed:2a8f:e6dd with SMTP id y9-20020a05600c364900b003ed2a8fe6ddmr2432522wmq.6.1679410160122;
        Tue, 21 Mar 2023 07:49:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ab55:973b:6541:bdcc])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003edddce5b00sm7904682wmn.12.2023.03.21.07.49.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:49:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] fetch2: Add autorev warning when it is set too late
Date: Tue, 21 Mar 2023 14:49:18 +0000
Message-Id: <20230321144918.1242879-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230321144918.1242879-1-richard.purdie@linuxfoundation.org>
References: <20230321144918.1242879-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 14:49:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14607

Bitbake expects a consistent metadata environment when it parses. There
are plenty of ways you can set a recipe to autorev at a point where parts
of the fetcher have already been triggered leading to obsure bugs which
I struggled to debug, let alone anyone not familar with the code.

If anyone is running into the message from the commit, the issue is
likely one of timing. Keep in mind that the anonymous python code
in base.bbclass will expand variables like FILESPATH, WORKDIR and others
which contain PV. The recipe needs to be set to AUTOREV before that
anonymous python runs.

In particular, that means you can't set SRCREV = "${AUTOREV}" in other
anonymous python, it needs to happen earlier.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 8 ++++++--
 lib/bb/fetch2/git.py      | 2 +-
 lib/bb/parse/ast.py       | 3 +++
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3b96849a25..718b9f2958 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -749,10 +749,13 @@ def subprocess_setup():
     # SIGPIPE errors are known issues with gzip/bash
     signal.signal(signal.SIGPIPE, signal.SIG_DFL)
 
-def get_autorev(d):
-    #  only not cache src rev in autorev case
+def mark_recipe_nocache(d):
     if d.getVar('BB_SRCREV_POLICY') != "cache":
         d.setVar('BB_DONT_CACHE', '1')
+
+def get_autorev(d):
+    mark_recipe_nocache(d)
+    d.setVar("__BBAUTOREV_SEEN", True)
     return "AUTOINC"
 
 def get_srcrev(d, method_name='sortable_revision'):
@@ -1219,6 +1222,7 @@ def srcrev_internal_helper(ud, d, name):
     if srcrev == "INVALID" or not srcrev:
         raise FetchError("Please set a valid SRCREV for url %s (possible key names are %s, or use a ;rev=X URL parameter)" % (str(attempts), ud.url), ud.url)
     if srcrev == "AUTOINC":
+        d.setVar("__BBAUTOREV_ACTED_UPON", True)
         srcrev = ud.method.latest_revision(ud, d, name)
 
     return srcrev
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 66c2a7e540..d0d68538e2 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -737,7 +737,7 @@ class Git(FetchMethod):
             raise bb.fetch2.FetchError("Recipe uses a floating tag/branch '%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE)." % (ud.unresolvedrev[name], ud.host+ud.path))
 
         # Ensure we mark as not cached
-        bb.fetch2.get_autorev(d)
+        bb.fetch2.mark_recipe_nocache(d)
 
         output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 375ba3cb79..6441c5cf7c 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -400,6 +400,9 @@ def finalize(fn, d, variant = None):
 
         d.setVar('BBINCLUDED', bb.parse.get_file_depends(d))
 
+        if d.getVar('__BBAUTOREV_SEEN') and d.getVar('__BBSRCREV_SEEN') and not d.getVar("__BBAUTOREV_ACTED_UPON"):
+            bb.fatal("AUTOREV/SRCPV set too late for the fetcher to work properly, please set the variables earlier in parsing. Erroring instead of later obtuse build failures.")
+
         bb.event.fire(bb.event.RecipeParsed(fn), d)
     finally:
         bb.event.set_handlers(saved_handlers)
-- 
2.38.1


