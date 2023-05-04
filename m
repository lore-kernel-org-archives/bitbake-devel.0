Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7A8C77B78
	for <webhook@archiver.kernel.org>; Thu,  4 May 2023 16:55:28 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.172.1683219318396605569
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 May 2023 09:55:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=HbEc+tiW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso7747055e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 May 2023 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683219316; x=1685811316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUfG7X37rkHg3GekpoNey3bhZWrfh/NmwiFrmvlhq8s=;
        b=HbEc+tiW118IYXxU+9NkKGLtcpsRggpoyMMBkiyxcYI/PJIWp5fAmVZtucdcLvHs29
         cHF4VxKIqOY9r5AWufq4ghm854rXZskogmfeQMFBPVa7BBon2tvHX+470rbwwldRaIwq
         k2BDR7qYMJm00y36rK/SFGBYZLq7rqUPzs6lM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683219316; x=1685811316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUfG7X37rkHg3GekpoNey3bhZWrfh/NmwiFrmvlhq8s=;
        b=XD56SdOBPyeGQWsdGn8Mob4m+g4qSCYqpuC0eKGq/VFlvDsPApNPq8rjQoTNbLeOAb
         LC1UdZWbnkM052wsk3ZAB7z9yZIFvNTT7T0/m12xa+t0L8iu/xQCAY9X+wdqeWEYxSK+
         5S98Kyg4ZeulpMu1z2dJJo0Y3N+c4gtRdBwUjBbskc6e1Kd/iL5R8X+g2vYDuapc5D+m
         FG6gERdObdYBsuS4+R2iHGf++04FSTkWbldnuiUiDr+pHOJrBZOvTs53Z2cMJYqZm40P
         NFUKkWSRt33ezTE7PC5DQjScaZ13C88TqmFqZ8GqA2xFn2iF9rloMlyM+4487tdJCadx
         dEfA==
X-Gm-Message-State: AC+VfDzhO4KEtT6TNDVbqdGA81mncT6pCiDIC1YDjwGggKi3tWMglOSQ
	krMtibfSivf5FWeZw3h+sWzHEdoTDr3MVfslsVEhrw==
X-Google-Smtp-Source: ACHHUZ4JmCc/fFzND+BzKmiBaDTsTuD+JdS3+KyR5nF3RWayaO2eJMFSrkW0/kcAXYF0ivjFMhCe8Q==
X-Received: by 2002:a7b:c349:0:b0:3f1:806d:33ad with SMTP id l9-20020a7bc349000000b003f1806d33admr240366wmj.6.1683219316233;
        Thu, 04 May 2023 09:55:16 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6749:5fda:5dc0:e535])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c021000b003f198dfbbfcsm5455622wmi.19.2023.05.04.09.55.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:55:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Default to https git protocol where possible
Date: Thu,  4 May 2023 17:55:15 +0100
Message-Id: <20230504165515.3075424-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 May 2023 16:55:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14767

The recommendation from server maintainers is that the https protocol
is both faster and more reliable than the dedicated git protocol at this point.
Switch to it where possible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 58 +++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6ef0836f2b..532adb9414 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -535,7 +535,7 @@ class MirrorUriTest(FetcherTest):
 class GitDownloadDirectoryNamingTest(FetcherTest):
     def setUp(self):
         super(GitDownloadDirectoryNamingTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_dir = "git.openembedded.org.bitbake"
         self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
         self.mirror_dir = "github.com.openembedded.bitbake.git"
@@ -583,7 +583,7 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
 class TarballNamingTest(FetcherTest):
     def setUp(self):
         super(TarballNamingTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
         self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
         self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
@@ -617,7 +617,7 @@ class TarballNamingTest(FetcherTest):
 class GitShallowTarballNamingTest(FetcherTest):
     def setUp(self):
         super(GitShallowTarballNamingTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
         self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
         self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
@@ -652,7 +652,7 @@ class GitShallowTarballNamingTest(FetcherTest):
 class CleanTarballTest(FetcherTest):
     def setUp(self):
         super(CleanTarballTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake"
+        self.recipe_url = "git://git.openembedded.org/bitbake;protocol=https"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
@@ -1011,25 +1011,25 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_gitfetch(self):
-        url1 = url2 = "git://git.openembedded.org/bitbake;branch=master"
+        url1 = url2 = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.gitfetcher(url1, url2)
 
     @skipIfNoNetwork()
     def test_gitfetch_goodsrcrev(self):
         # SRCREV is set but matches rev= parameter
-        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;branch=master"
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;branch=master;protocol=https"
         self.gitfetcher(url1, url2)
 
     @skipIfNoNetwork()
     def test_gitfetch_badsrcrev(self):
         # SRCREV is set but does not match rev= parameter
-        url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5;branch=master"
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5;branch=master;protocol=https"
         self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
 
     @skipIfNoNetwork()
     def test_gitfetch_tagandrev(self):
         # SRCREV is set but does not match rev= parameter
-        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;tag=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;tag=270a05b0b4ba0959fe0624d2a4885d7b70426da5;protocol=https"
         self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
 
     @skipIfNoNetwork()
@@ -1038,7 +1038,7 @@ class FetcherNetworkTest(FetcherTest):
         # `usehead=1' and instead fetch the specified SRCREV. See
         # test_local_gitfetch_usehead() for a positive use of the usehead
         # feature.
-        url = "git://git.openembedded.org/bitbake;usehead=1;branch=master"
+        url = "git://git.openembedded.org/bitbake;usehead=1;branch=master;protocol=https"
         self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, url)
 
     @skipIfNoNetwork()
@@ -1047,26 +1047,26 @@ class FetcherNetworkTest(FetcherTest):
         # `usehead=1' and instead fetch the specified SRCREV. See
         # test_local_gitfetch_usehead() for a positive use of the usehead
         # feature.
-        url = "git://git.openembedded.org/bitbake;usehead=1;name=newName;branch=master"
+        url = "git://git.openembedded.org/bitbake;usehead=1;name=newName;branch=master;protocol=https"
         self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, url)
 
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_tarball_for_mirrored_url_when_previous_downloaded_by_the_recipe_url(self):
-        recipeurl = "git://git.openembedded.org/bitbake;branch=master"
-        mirrorurl = "git://someserver.org/bitbake;branch=master"
+        recipeurl = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
+        mirrorurl = "git://someserver.org/bitbake;branch=master;protocol=https"
         self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake")
         self.gitfetcher(recipeurl, mirrorurl)
 
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_tarball_when_previous_downloaded_from_a_premirror(self):
-        recipeurl = "git://someserver.org/bitbake;branch=master"
+        recipeurl = "git://someserver.org/bitbake;branch=master;protocol=https"
         self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake")
         self.gitfetcher(recipeurl, recipeurl)
 
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_repository_when_premirror_rewrites_the_recipe_url(self):
-        realurl = "git://git.openembedded.org/bitbake"
-        recipeurl = "git://someserver.org/bitbake"
+        realurl = "https://git.openembedded.org/bitbake"
+        recipeurl = "git://someserver.org/bitbake;protocol=https"
         self.sourcedir = self.unpackdir.replace("unpacked", "sourcemirror.git")
         os.chdir(self.tempdir)
         self.git(['clone', realurl, self.sourcedir], cwd=self.tempdir)
@@ -1076,9 +1076,9 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule(self):
         # URL with ssh submodules
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=master"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=master;protocol=https"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee;branch=master"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee;branch=master;protocol=https"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1329,9 +1329,9 @@ class URLHandle(unittest.TestCase):
        "http://www.google.com/index.html" : ('http', 'www.google.com', '/index.html', '', '', {}),
        "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar/dist/ipkg'}),
        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'familiar/dist/ipkg')])),
-       "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
+       "git://git.openembedded.org/bitbake;branch=@foo;protocol=https" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo', 'protocol' : 'https'}),
        "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
-       r'git://s.o-me_ONE:!#$%^&*()-_={}[]\|:?,.<>~`@git.openembedded.org/bitbake;branch=main': ('git', 'git.openembedded.org', '/bitbake', 's.o-me_ONE', r'!#$%^&*()-_={}[]\|:?,.<>~`', {'branch': 'main'}),
+       r'git://s.o-me_ONE:!#$%^&*()-_={}[]\|:?,.<>~`@git.openembedded.org/bitbake;branch=main;protocol=https': ('git', 'git.openembedded.org', '/bitbake', 's.o-me_ONE', r'!#$%^&*()-_={}[]\|:?,.<>~`', {'branch': 'main', 'protocol' : 'https'}),
     }
     # we require a pathname to encodeurl but users can still pass such urls to 
     # decodeurl and we need to handle them
@@ -1359,14 +1359,14 @@ class FetchLatestVersionTest(FetcherTest):
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with testing
-        ("mtd-utils", "git://git.yoctoproject.org/mtd-utils.git;branch=master", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
+        ("mtd-utils", "git://git.yoctoproject.org/mtd-utils.git;branch=master;protocol=https", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
             : "1.5.0",
         # version pattern "pkg_name-X.Y"
         # mirror of git://anongit.freedesktop.org/git/xorg/proto/presentproto since network issues interfered with testing
-        ("presentproto", "git://git.yoctoproject.org/bbfetchtests-presentproto;branch=master", "24f3a56e541b0a9e6c6ee76081f441221a120ef9", "")
+        ("presentproto", "git://git.yoctoproject.org/bbfetchtests-presentproto;branch=master;protocol=https", "24f3a56e541b0a9e6c6ee76081f441221a120ef9", "")
             : "1.0",
         # version pattern "pkg_name-vX.Y.Z"
-        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
             : "1.4.0",
         # combination version pattern
         ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
@@ -1378,9 +1378,9 @@ class FetchLatestVersionTest(FetcherTest):
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86-video-omap since network issues interfered with testing
-        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap;branch=master", "ae0394e687f1a77e966cf72f895da91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))")
+        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap;branch=master;protocol=https", "ae0394e687f1a77e966cf72f895da91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))")
             : "0.4.3",
-        ("build-appliance-image", "git://git.yoctoproject.org/poky;branch=master", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))")
+        ("build-appliance-image", "git://git.yoctoproject.org/poky;branch=master;protocol=https", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))")
             : "11.0.0",
         ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot;protocol=https", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
             : "1.3.59",
@@ -2189,7 +2189,7 @@ class GitShallowTest(FetcherTest):
         self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0')
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
-        fetcher = bb.fetch.Fetch(["git://git.yoctoproject.org/fstests;branch=master"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.yoctoproject.org/fstests;branch=master;protocol=https"], self.d)
         fetcher.download()
 
         bb.utils.remove(self.dldir + "/*.tar.gz")
@@ -2966,7 +2966,7 @@ class NPMTest(FetcherTest):
 class GitSharedTest(FetcherTest):
     def setUp(self):
         super(GitSharedTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
         self.d.setVar("__BBSRCREV_SEEN", "1")
 
@@ -2999,7 +2999,7 @@ class FetchPremirroronlyLocalTest(FetcherTest):
         os.mkdir(self.mirrordir)
         self.reponame = "bitbake"
         self.gitdir = os.path.join(self.tempdir, "git", self.reponame)
-        self.recipe_url = "git://git.fake.repo/bitbake;branch=master"
+        self.recipe_url = "git://git.fake.repo/bitbake;branch=master;protocol=https"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "1")
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
@@ -3053,7 +3053,7 @@ class FetchPremirroronlyNetworkTest(FetcherTest):
         self.reponame = "fstests"
         self.clonedir = os.path.join(self.tempdir, "git")
         self.gitdir = os.path.join(self.tempdir, "git", "{}.git".format(self.reponame))
-        self.recipe_url = "git://git.yoctoproject.org/fstests"
+        self.recipe_url = "git://git.yoctoproject.org/fstests;protocol=https"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "0")
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
@@ -3135,7 +3135,7 @@ class FetchPremirroronlyBrokenTarball(FetcherTest):
         os.mkdir(self.mirrordir)
         self.reponame = "bitbake"
         self.gitdir = os.path.join(self.tempdir, "git", self.reponame)
-        self.recipe_url = "git://git.fake.repo/bitbake"
+        self.recipe_url = "git://git.fake.repo/bitbake;protocol=https"
         self.d.setVar("BB_FETCH_PREMIRRORONLY", "1")
         self.d.setVar("BB_NO_NETWORK", "1")
         self.d.setVar("PREMIRRORS", self.recipe_url + " " + "file://{}".format(self.mirrordir) + " \n")
-- 
2.39.2


