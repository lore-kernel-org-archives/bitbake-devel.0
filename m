Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE5DC43334
	for <webhook@archiver.kernel.org>; Sun,  3 Jul 2022 12:17:53 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.59664.1656850668805850486
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Jul 2022 05:17:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=cnRVf+ee;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: ptsneves@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id
 o19-20020a05600c4fd300b003a0489f414cso4103775wmq.4
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Jul 2022 05:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1oo4y60XPfh5lyDPCOFPASUy1Z4UKsboWDSDxdvz1uo=;
        b=cnRVf+eeofA2mrkuKjq/7YATaLub8Wt4YfJ78XBr4SnN82QaQ32k3IIeB+kLwGO17A
         RexKVeYwHYoEOkIq2q9snA6VkApKeFDwQMQVy7mFe1dXmg9xBwfSOMVtnTgpmCuaH0Ao
         vwQ2u25syOEO1dDUygVxotQ+Eu8xju1rC9ruXMJVTRwCH5g5t97cheBukpkrtVBm6hwX
         0WfJ78MXRVb36qB3A5grnAXgrC+FP7ybwK9MjKx0xQdJmhVKnhuResv8tnZCUP0+N2Bn
         hye8JjMM4CjwED6CbNyoWGeuv6UGqaZT9qcBFIgW+v93XSFsevd1M1AoEyBGUlqZX1/m
         Uzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1oo4y60XPfh5lyDPCOFPASUy1Z4UKsboWDSDxdvz1uo=;
        b=3Y2OxPssDfCg9sLaKJfyYWTITvZmo3L+NqGoVJiQeZwJnO9PzaJgCqIcZUy98mHadr
         tPnHma5K9dbYm0UXmnfwVL5j1uPhFxXM45XIAFayliRRm/tWuoFMBGgA1FVIjrgLXmUP
         gMAfWW9lLa63ymcd2J4PxhlPBPcF/YvVIlNqbQibxo6wFCqr41yyEWFsSOPHqv5p2oe/
         qkNQ+8SqVxOuAH4Ynu6bjU9U+Y0Qtw8lrDYYJST0MUYbcKMyMo5KucqkuF6NA/k69/iq
         +SwBOX4yZewuvPTnBJTyuimQd852l2hxwjsmH3NmmbWYo0f0QuiMBIbi68LdFgj6Z+Je
         LSRg==
X-Gm-Message-State: AJIora8Iydw0PB4o+5ZDynh7mHKMLPaQn5BPygqmH5Jq8bF8UlyrikVw
	+uajMDcUS1irzz12gWOyf15GrFCXFA14hE4=
X-Google-Smtp-Source: 
 AGRyM1ubdTAOqznNiMFcsJGD2PkCH/eiDGDnBP3llFxtXtHM3ui6KTrsL11sSq3okXQ+/bKHVxUkmA==
X-Received: by 2002:a05:600c:4fc8:b0:3a1:99cf:7fe with SMTP id
 o8-20020a05600c4fc800b003a199cf07femr4705231wmq.142.1656850667101;
        Sun, 03 Jul 2022 05:17:47 -0700 (PDT)
Received: from localhost.localdomain (83.11.75.211.ipv4.supernova.orange.pl.
 [83.11.75.211])
        by smtp.gmail.com with ESMTPSA id
 z18-20020a05600c0a1200b0039c45fc58c4sm16562045wmp.21.2022.07.03.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 05:17:46 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joey Degges <jdegges@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Paulo Neves <ptsneves@gmail.com>
Subject: [bitbake][dunfell][1.46][PATCH] fetch/git: Fix usehead for
 non-default names
Date: Sun,  3 Jul 2022 14:17:31 +0200
Message-Id: <20220703121731.2326008-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 03 Jul 2022 12:17:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13795

From: Joey Degges <jdegges@gmail.com>

The usehead url parameter for git repositories causes bitbake to use
whatever commit the repository HEAD is pointing to if the repository
happens to have the name 'default'. This is the default name so in many
cases it works just fine, but if a different name is specified with the
url parameter 'name=newName' then it will fail to parse the recipe with
an error along the lines of:

ERROR: ExpansionError during parsing /path/to/my/recipe.bb
Traceback (most recent call last):
  File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 235, in Git.urldata_init:
    >        ud.setup_revisions(d)
  File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1302, in FetchData.setup_revisions:
             for name in self.names:
    >            self.revisions[name] = srcrev_internal_helper(self, d, name)
  File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1167, in srcrev_internal_helper(name='newName'):
         if srcrev == "AUTOINC":
    >        srcrev = ud.method.latest_revision(ud, d, name)
  File "/path/to/poky/bitbake/lib/bb/fetch2/__init__.py", line 1562, in Git.latest_revision(name='newName'):
             except KeyError:
    >            revs[key] = rev = self._latest_revision(ud, d, name)
                 return rev
  File "/path/to/poky/bitbake/lib/bb/fetch2/git.py", line 650, in Git._latest_revision(name='newName'):
             raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
    >            (ud.unresolvedrev[name], ud.host+ud.path))
bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetcher failure: Unable to resolve 'master' in upstream git repository in git ls-remote output for /path/to/local/git/repo

Let's fix this by setting the unresolved rev of _all_ repository names
to 'HEAD' when the usehead url parameter is specified. Update the
currently failing test, test_local_gitfetch_usehead_withname, to now
expect success.

This change preserves existing behavior that allows usehead to be
overridden by a valid looking revision if one happens to be specified
instead of AUTOREV.

Signed-off-by: Joey Degges <jdegges@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 01e901c44ab0f496606b1d45c8953dc54970204c)
Signed-off-by: Paulo Neves <ptsneves@gmail.com>
---
 lib/bb/fetch2/git.py  |  7 +++++-
 lib/bb/tests/fetch.py | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index f6f6b63a..63a9f92b 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -224,7 +224,12 @@ class Git(FetchMethod):
             ud.shallow = False
 
         if ud.usehead:
-            ud.unresolvedrev['default'] = 'HEAD'
+            # When usehead is set let's associate 'HEAD' with the unresolved
+            # rev of this repository. This will get resolved into a revision
+            # later. If an actual revision happens to have also been provided
+            # then this setting will be overridden.
+            for name in ud.names:
+                ud.unresolvedrev[name] = 'HEAD'
 
         ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 301c4683..484fa582 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -650,6 +650,58 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.UnpackError):
             self.fetchUnpack(['file://a;subdir=/bin/sh'])
 
+    def test_local_gitfetch_usehead(self):
+        # Create dummy local Git repo
+        src_dir = tempfile.mkdtemp(dir=self.tempdir,
+                                   prefix='gitfetch_localusehead_')
+        src_dir = os.path.abspath(src_dir)
+        bb.process.run("git init", cwd=src_dir)
+        bb.process.run("git commit --allow-empty -m'Dummy commit'",
+                       cwd=src_dir)
+        # Use other branch than master
+        bb.process.run("git checkout -b my-devel", cwd=src_dir)
+        bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
+                       cwd=src_dir)
+        stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
+        orig_rev = stdout[0].strip()
+
+        # Fetch and check revision
+        self.d.setVar("SRCREV", "AUTOINC")
+        url = "git://" + src_dir + ";protocol=file;usehead=1"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        stdout = bb.process.run("git rev-parse HEAD",
+                                cwd=os.path.join(self.unpackdir, 'git'))
+        unpack_rev = stdout[0].strip()
+        self.assertEqual(orig_rev, unpack_rev)
+
+    def test_local_gitfetch_usehead_withname(self):
+        # Create dummy local Git repo
+        src_dir = tempfile.mkdtemp(dir=self.tempdir,
+                                   prefix='gitfetch_localusehead_')
+        src_dir = os.path.abspath(src_dir)
+        bb.process.run("git init", cwd=src_dir)
+        bb.process.run("git commit --allow-empty -m'Dummy commit'",
+                       cwd=src_dir)
+        # Use other branch than master
+        bb.process.run("git checkout -b my-devel", cwd=src_dir)
+        bb.process.run("git commit --allow-empty -m'Dummy commit 2'",
+                       cwd=src_dir)
+        stdout = bb.process.run("git rev-parse HEAD", cwd=src_dir)
+        orig_rev = stdout[0].strip()
+
+        # Fetch and check revision
+        self.d.setVar("SRCREV", "AUTOINC")
+        url = "git://" + src_dir + ";protocol=file;usehead=1;name=newName"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        fetcher.unpack(self.unpackdir)
+        stdout = bb.process.run("git rev-parse HEAD",
+                                cwd=os.path.join(self.unpackdir, 'git'))
+        unpack_rev = stdout[0].strip()
+        self.assertEqual(orig_rev, unpack_rev)
+
 class FetcherNoNetworkTest(FetcherTest):
     def setUp(self):
         super().setUp()
-- 
2.25.1


