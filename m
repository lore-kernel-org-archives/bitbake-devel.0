Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51290C43334
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 22:09:11 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web12.849.1657231749928605585
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 15:09:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=d7Fr5EF0;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.173,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f173.google.com with SMTP id a15so21924399pfv.13
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=igEzNik/ZV3D6W933w7nmdInPthNVT3fMCRXQiC6ET8=;
        b=d7Fr5EF0v3AGfPxfcBfgOCnVAlN7isUmXE3YALrxUpfg8i59cHlkI84Leg2mhsE+CG
         E3FDx/imL4D+7LWeF5e9oT3KJF65TvbFFxwqw8jPV5W14nNCW3RPbHuEtmbj8MGR+90u
         ueX8tlPi/V5UxSUzmRuIR3LeEqhRFdd2jH3Eu7gbwDWHbIhH/vYvK6vk0e7cBjn4nFfg
         7j+mfpuCdUFhojhS88AZ57Yu8Ymi3LM0JamChWmysI//OFg0/CRnXR64TUYO+hH/0ys1
         QO2QknUzV3odyMSwzhH7mayFxluGySl7o6i8T+QQcqj8Q9Cfbx3TtqC/+pTLcXbkkJ2P
         vR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igEzNik/ZV3D6W933w7nmdInPthNVT3fMCRXQiC6ET8=;
        b=KIEejutk9VO+SysKViTmlYcbcAJq0uLbInqzvLNF52Zh8o9lrSjIDw89XJsSj5vLd3
         VAbVwF0ns5oIiOTZOVbuAipFyf/FYwPDNMDOp4iAykWZisZwXXpo9r8mrFNxxHQtmkZw
         6IO+5DHDxnmfRcZVpOzgCVr7Sr9cqJT2nwnOX1OOcxgHEKAtuH5fzrE2CSFIeubESEJA
         Lht7wows9xOVxsENl8X3T0bIfcu89n6KULm38W0tARhnEGR5En/Vh9EB1pUA0Wuejx0O
         aBdah9c020Qb4Or/4LFp5AzFPHi2L6zU+wAMHWxmLJ7zwVK7i2hgJyO1XfgNgtVBwlqC
         QCSw==
X-Gm-Message-State: AJIora/iUW4tb9cDDMJoh0UNvQe7vpvRYFz1zmTMs/iOOcBVstynqmmD
	iBu/S/v5LKb/h6pJuTTOf/5HfOoJ5Q/NCmFu
X-Google-Smtp-Source: 
 AGRyM1vHj/bh69tDTx5UYkS6+QVorlqZXEjokCWQcuf4motElBvDl4qQN7PWUp27p00AlHS1l6w5hg==
X-Received: by 2002:a65:694a:0:b0:412:b98:4604 with SMTP id
 w10-20020a65694a000000b004120b984604mr285967pgq.50.1657231748771;
        Thu, 07 Jul 2022 15:09:08 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f126-20020a623884000000b0052891272298sm6320905pfa.120.2022.07.07.15.09.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:09:08 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/1] fetch/git: Fix usehead for
 non-default names
Date: Thu,  7 Jul 2022 12:08:56 -1000
Message-Id: 
 <a247f56df680382d62910bb9a174e0fdd29e4ca8.1657231636.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657231636.git.steve@sakoman.com>
References: <cover.1657231636.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Jul 2022 22:09:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13811

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
Signed-off-by: Steve Sakoman <steve@sakoman.com>
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


