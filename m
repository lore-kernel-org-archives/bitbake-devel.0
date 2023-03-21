Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C5C7619A
	for <webhook@archiver.kernel.org>; Tue, 21 Mar 2023 14:49:27 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.15518.1679410161582848584
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Mar 2023 07:49:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JlmuRufh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so9636782wmq.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679410160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFuUhp+2XvYSHiRVgeKfAkIq4+e8ktlcrCG6BqeQfVo=;
        b=JlmuRufh5A+B/GShROUMV9B4huSbzZGHsODfcWLpzM2H+5+VJq4GTDVve8jYIpC5jN
         CMbtnTAH66EzBKA9lSlrY2MeIu14XtRURPqfXrOCRyaDBgZJ6pRthAYj2Gp1AWZdepEg
         y0T2iPw1/0MgoRNm0BQkpvtL+JjUEkvA+s5ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679410160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFuUhp+2XvYSHiRVgeKfAkIq4+e8ktlcrCG6BqeQfVo=;
        b=JjTS+YbQxAekGXlSvT0q2Gvm6zjk/QVH7s3Yr+zKHWfDw9EpCD0320c5ypTnqQD0Xh
         9wrIHUi0SvSYtvazOKWuLoKqMXvUd9viwfVJAj4i8Ev35N+pLAfrtzcUhj04L0RBh+Wm
         C8HW+K611BH+BNMQetMysTLmT4kk6USO55bN20Cvt+3npLUwfGuSSgAYBOOVTYoBwb7V
         96F0Dtbohd24YuISK1d69zgfCm4+rfkrci7JuCLBiA1itU4XuyF443BKSZUqNhX6L4AV
         r0yeIWQUrw02ZaRPOzCHLHIM655yD1M17NFjEE4W1Vd10cnY80p9SF4aGhMXphpAHGvI
         lt6g==
X-Gm-Message-State: AO0yUKWtU5Q98cA0y6Qz1UDhlAI1BngKi5/8ol11ByiAwV4uq1i5zP4Z
	lGr8iqSg8Qk+jeioEQOYX08h+qiR2nMOpatPz5U=
X-Google-Smtp-Source: AK7set94KtT0EtYSIro2E/TWS+Jy3j6jvyST5pKDkTau6/EGK6gtAiMZG3LkgJa9hUR1rrYn9c9ggg==
X-Received: by 2002:a05:600c:d0:b0:3ed:2b49:1571 with SMTP id u16-20020a05600c00d000b003ed2b491571mr2771316wmm.20.1679410159622;
        Tue, 21 Mar 2023 07:49:19 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ab55:973b:6541:bdcc])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003edddce5b00sm7904682wmn.12.2023.03.21.07.49.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:49:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch2: Rename __BBSEENSRCREV -> __BBSRCREV_SEEN
Date: Tue, 21 Mar 2023 14:49:17 +0000
Message-Id: <20230321144918.1242879-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Mar 2023 14:49:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14606

For readability of following patches, rename this internal variable to
allow for others in a similar format.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/fetch2/git.py      | 2 +-
 lib/bb/tests/fetch.py     | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cf65727a20..3b96849a25 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -769,7 +769,7 @@ def get_srcrev(d, method_name='sortable_revision'):
     that fetcher provides a method with the given name and the same signature as sortable_revision.
     """
 
-    d.setVar("__BBSEENSRCREV", "1")
+    d.setVar("__BBSRCREV_SEEN", "1")
     recursion = d.getVar("__BBINSRCREV")
     if recursion:
         raise FetchError("There are recursive references in fetcher variables, likely through SRC_URI")
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5bb8393133..66c2a7e540 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -733,7 +733,7 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
-        if not d.getVar("__BBSEENSRCREV"):
+        if not d.getVar("__BBSRCREV_SEEN"):
             raise bb.fetch2.FetchError("Recipe uses a floating tag/branch '%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE)." % (ud.unresolvedrev[name], ud.host+ud.path))
 
         # Ensure we mark as not cached
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 1533d52b1e..2e5b404d95 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -785,7 +785,7 @@ class FetcherLocalTest(FetcherTest):
 
         # Fetch and check revision
         self.d.setVar("SRCREV", "AUTOINC")
-        self.d.setVar("__BBSEENSRCREV", "1")
+        self.d.setVar("__BBSRCREV_SEEN", "1")
         url = "git://" + self.gitdir + ";branch=master;protocol=file;" + suffix
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
@@ -1654,7 +1654,7 @@ class GitShallowTest(FetcherTest):
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '0')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
-        self.d.setVar("__BBSEENSRCREV", "1")
+        self.d.setVar("__BBSRCREV_SEEN", "1")
 
     def assertRefs(self, expected_refs, cwd=None):
         if cwd is None:
@@ -2218,7 +2218,7 @@ class GitLfsTest(FetcherTest):
 
         self.d.setVar('SRCREV', '${AUTOREV}')
         self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
-        self.d.setVar("__BBSEENSRCREV", "1")
+        self.d.setVar("__BBSRCREV_SEEN", "1")
 
         bb.utils.mkdirhier(self.srcdir)
         self.git_init(cwd=self.srcdir)
@@ -2936,7 +2936,7 @@ class GitSharedTest(FetcherTest):
         super(GitSharedTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
-        self.d.setVar("__BBSEENSRCREV", "1")
+        self.d.setVar("__BBSRCREV_SEEN", "1")
 
     @skipIfNoNetwork()
     def test_shared_unpack(self):
-- 
2.38.1


