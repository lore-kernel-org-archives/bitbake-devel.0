Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8ADC433EF
	for <webhook@archiver.kernel.org>; Fri, 11 Feb 2022 16:40:41 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.9621.1644597640057948122
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Feb 2022 08:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bTbnxY6q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id u1so2446953wrg.11
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Feb 2022 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upfZT9n4V9qs7ngZ66y5R4Yc0N4NsZGQbPebZAPjAcY=;
        b=bTbnxY6q9C2/VHpMBYEa9W2JO87Ok51Lrh094hS0dxlMsrmZuvXQM+s0UZOK6l11Bm
         zQlyXWlR0moPHvSmIYt0T6mxmq2YCd2Y+wGfSFGWH3hywFxxaXPiorTy6RsTo2q+v4vj
         1OlCa6marUf6D6aaMGJsw1RjtXyxAPf/mY1oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upfZT9n4V9qs7ngZ66y5R4Yc0N4NsZGQbPebZAPjAcY=;
        b=LN97SPk2+4nstCwns2cTNqosM22YZPiv42xgkSpNBUspzyMvus2hEqq2sWZH0x3TJu
         NT18KLwggsf4j+XpgbDJJxAhhqXkykTlxuAhJSNy7bFlG4f8Vb2RmKzCSLv6DysGbY/J
         FIPC70YmxVDUqrA8PkcOm0CAle+is4T1ZjWOmtQULUasVSI6HxQYVlYT304RcWCTr//3
         cbPX0ECIj3CyQTm5yI+pkHb3QTj/F6BjtjCQ3o9Q0UFkq9bXLSCXmBcdkkFD1FL4aB3O
         YOiLdUXx2HWZXjKeUXU5RlPfjwWX/sjcS006fglqPbOdlGh9E77dXnTHrVEU5nHOBgWZ
         IDVA==
X-Gm-Message-State: AOAM532sSG4dlQeJjDEKp2YHO2lfRPTHx5dpBay9DBxmEaIE11igfbwL
	lDQel3Amnut1UvUNgoArAnNQ/NAsbbT51adt
X-Google-Smtp-Source: 
 ABdhPJzU232CaMkoX+t0L2KubOE8NcfWRe6tAVDbxE/8nYntVGL0yPunBbywf6IF62Tq+9jEAbWTfg==
X-Received: by 2002:a5d:6dc5:: with SMTP id d5mr2044342wrz.23.1644597637742;
        Fri, 11 Feb 2022 08:40:37 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e5fe:2e7c:731b:5924])
        by smtp.gmail.com with ESMTPSA id
 p7sm1626605wrr.56.2022.02.11.08.40.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:40:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Add missing branch param for git urls
Date: Fri, 11 Feb 2022 16:40:36 +0000
Message-Id: <20220211164036.2728063-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Feb 2022 16:40:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13339

We started to require the branch parameter for git urls. This updates
the tests to match and quieten some noise.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 88 +++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3fd8fac229..f368cd02b0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -514,9 +514,9 @@ class MirrorUriTest(FetcherTest):
 class GitDownloadDirectoryNamingTest(FetcherTest):
     def setUp(self):
         super(GitDownloadDirectoryNamingTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
         self.recipe_dir = "git.openembedded.org.bitbake"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
         self.mirror_dir = "github.com.openembedded.bitbake.git"
 
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
@@ -562,9 +562,9 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
 class TarballNamingTest(FetcherTest):
     def setUp(self):
         super(TarballNamingTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
         self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
@@ -596,9 +596,9 @@ class TarballNamingTest(FetcherTest):
 class GitShallowTarballNamingTest(FetcherTest):
     def setUp(self):
         super(GitShallowTarballNamingTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
         self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
@@ -728,7 +728,7 @@ class FetcherLocalTest(FetcherTest):
 
         # Fetch and check revision
         self.d.setVar("SRCREV", "AUTOINC")
-        url = "git://" + self.gitdir + ";protocol=file;" + suffix
+        url = "git://" + self.gitdir + ";branch=master;protocol=file;" + suffix
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         fetcher.unpack(self.unpackdir)
@@ -952,19 +952,19 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_gitfetch(self):
-        url1 = url2 = "git://git.openembedded.org/bitbake"
+        url1 = url2 = "git://git.openembedded.org/bitbake;branch=master"
         self.gitfetcher(url1, url2)
 
     @skipIfNoNetwork()
     def test_gitfetch_goodsrcrev(self):
         # SRCREV is set but matches rev= parameter
-        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5"
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=270a05b0b4ba0959fe0624d2a4885d7b70426da5;branch=master"
         self.gitfetcher(url1, url2)
 
     @skipIfNoNetwork()
     def test_gitfetch_badsrcrev(self):
         # SRCREV is set but does not match rev= parameter
-        url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5"
+        url1 = url2 = "git://git.openembedded.org/bitbake;rev=dead05b0b4ba0959fe0624d2a4885d7b70426da5;branch=master"
         self.assertRaises(bb.fetch.FetchError, self.gitfetcher, url1, url2)
 
     @skipIfNoNetwork()
@@ -979,7 +979,7 @@ class FetcherNetworkTest(FetcherTest):
         # `usehead=1' and instead fetch the specified SRCREV. See
         # test_local_gitfetch_usehead() for a positive use of the usehead
         # feature.
-        url = "git://git.openembedded.org/bitbake;usehead=1"
+        url = "git://git.openembedded.org/bitbake;usehead=1;branch=master"
         self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, url)
 
     @skipIfNoNetwork()
@@ -988,19 +988,19 @@ class FetcherNetworkTest(FetcherTest):
         # `usehead=1' and instead fetch the specified SRCREV. See
         # test_local_gitfetch_usehead() for a positive use of the usehead
         # feature.
-        url = "git://git.openembedded.org/bitbake;usehead=1;name=newName"
+        url = "git://git.openembedded.org/bitbake;usehead=1;name=newName;branch=master"
         self.assertRaises(bb.fetch.ParameterError, self.gitfetcher, url, url)
 
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_tarball_for_mirrored_url_when_previous_downloaded_by_the_recipe_url(self):
-        recipeurl = "git://git.openembedded.org/bitbake"
-        mirrorurl = "git://someserver.org/bitbake"
+        recipeurl = "git://git.openembedded.org/bitbake;branch=master"
+        mirrorurl = "git://someserver.org/bitbake;branch=master"
         self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake")
         self.gitfetcher(recipeurl, mirrorurl)
 
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_tarball_when_previous_downloaded_from_a_premirror(self):
-        recipeurl = "git://someserver.org/bitbake"
+        recipeurl = "git://someserver.org/bitbake;branch=master"
         self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake")
         self.gitfetcher(recipeurl, recipeurl)
 
@@ -1017,9 +1017,9 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule(self):
         # URL with ssh submodules
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=049da4a6cb198d7c0302e9e8b243a1443cb809a7;branch=master"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=a2885dd7d25380d23627e7544b7bbb55014b16ee;branch=master"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1109,7 +1109,7 @@ class FetcherNetworkTest(FetcherTest):
         """ Prevent regression on deeply nested submodules not being checked out properly, even though they were fetched. """
 
         # This repository also has submodules where the module (name), path and url do not align
-        url = "gitsm://github.com/azure/iotedge.git;protocol=https;rev=d76e0316c6f324345d77c48a83ce836d09392699"
+        url = "gitsm://github.com/azure/iotedge.git;protocol=https;rev=d76e0316c6f324345d77c48a83ce836d09392699;branch=master"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1215,43 +1215,43 @@ class SVNTest(FetcherTest):
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
         # Ensure trusted_network returns False when the host IS in the list.
-        url = "git://Someserver.org/foo;rev=1"
+        url = "git://Someserver.org/foo;rev=1;branch=master"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org someserver.org server2.org server3.org")
         self.assertTrue(bb.fetch.trusted_network(self.d, url))
 
     def test_wild_trusted_network(self):
         # Ensure trusted_network returns true when the *.host IS in the list.
-        url = "git://Someserver.org/foo;rev=1"
+        url = "git://Someserver.org/foo;rev=1;branch=master"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
         self.assertTrue(bb.fetch.trusted_network(self.d, url))
 
     def test_prefix_wild_trusted_network(self):
         # Ensure trusted_network returns true when the prefix matches *.host.
-        url = "git://git.Someserver.org/foo;rev=1"
+        url = "git://git.Someserver.org/foo;rev=1;branch=master"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
         self.assertTrue(bb.fetch.trusted_network(self.d, url))
 
     def test_two_prefix_wild_trusted_network(self):
         # Ensure trusted_network returns true when the prefix matches *.host.
-        url = "git://something.git.Someserver.org/foo;rev=1"
+        url = "git://something.git.Someserver.org/foo;rev=1;branch=master"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org *.someserver.org server2.org server3.org")
         self.assertTrue(bb.fetch.trusted_network(self.d, url))
 
     def test_port_trusted_network(self):
         # Ensure trusted_network returns True, even if the url specifies a port.
-        url = "git://someserver.org:8080/foo;rev=1"
+        url = "git://someserver.org:8080/foo;rev=1;branch=master"
         self.d.setVar("BB_ALLOWED_NETWORKS", "someserver.org")
         self.assertTrue(bb.fetch.trusted_network(self.d, url))
 
     def test_untrusted_network(self):
         # Ensure trusted_network returns False when the host is NOT in the list.
-        url = "git://someserver.org/foo;rev=1"
+        url = "git://someserver.org/foo;rev=1;branch=master"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
         self.assertFalse(bb.fetch.trusted_network(self.d, url))
 
     def test_wild_untrusted_network(self):
         # Ensure trusted_network returns False when the host is NOT in the list.
-        url = "git://*.someserver.org/foo;rev=1"
+        url = "git://*.someserver.org/foo;rev=1;branch=master"
         self.d.setVar("BB_ALLOWED_NETWORKS", "server1.org server2.org server3.org")
         self.assertFalse(bb.fetch.trusted_network(self.d, url))
 
@@ -1289,32 +1289,32 @@ class FetchLatestVersionTest(FetcherTest):
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with testing
-        ("mtd-utils", "git://git.yoctoproject.org/mtd-utils.git", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
+        ("mtd-utils", "git://git.yoctoproject.org/mtd-utils.git;branch=master", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
             : "1.5.0",
         # version pattern "pkg_name-X.Y"
         # mirror of git://anongit.freedesktop.org/git/xorg/proto/presentproto since network issues interfered with testing
-        ("presentproto", "git://git.yoctoproject.org/bbfetchtests-presentproto", "24f3a56e541b0a9e6c6ee76081f441221a120ef9", "")
+        ("presentproto", "git://git.yoctoproject.org/bbfetchtests-presentproto;branch=master", "24f3a56e541b0a9e6c6ee76081f441221a120ef9", "")
             : "1.0",
         # version pattern "pkg_name-vX.Y.Z"
-        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
+        ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
             : "1.4.0",
         # combination version pattern
-        ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
+        ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
             : "1.2.0",
         ("u-boot-mkimage", "git://git.denx.de/u-boot.git;branch=master;protocol=git", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
             : "2014.01",
         # version pattern "yyyymmdd"
-        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
+        ("mobile-broadband-provider-info", "git://gitlab.gnome.org/GNOME/mobile-broadband-provider-info.git;protocol=https;branch=master", "4ed19e11c2975105b71b956440acdb25d46a347d", "")
             : "20120614",
         # packages with a valid UPSTREAM_CHECK_GITTAGREGEX
                 # mirror of git://anongit.freedesktop.org/xorg/driver/xf86-video-omap since network issues interfered with testing
-        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap", "ae0394e687f1a77e966cf72f895da91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))")
+        ("xf86-video-omap", "git://git.yoctoproject.org/bbfetchtests-xf86-video-omap;branch=master", "ae0394e687f1a77e966cf72f895da91840dffb8f", r"(?P<pver>(\d+\.(\d\.?)*))")
             : "0.4.3",
-        ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))")
+        ("build-appliance-image", "git://git.yoctoproject.org/poky;branch=master", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))")
             : "11.0.0",
         ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot;protocol=https", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
             : "1.3.59",
-        ("remake", "git://github.com/rocky/remake.git;protocol=https", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
+        ("remake", "git://github.com/rocky/remake.git;protocol=https;branch=master", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
             : "3.82+dbg0.9",
     }
 
@@ -1573,7 +1573,7 @@ class GitShallowTest(FetcherTest):
         self.d.delVar('PREMIRRORS')
         self.d.delVar('MIRRORS')
 
-        uri = 'git://%s;protocol=file;subdir=${S}' % self.srcdir
+        uri = 'git://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
         self.d.setVar('SRCREV', '${AUTOREV}')
         self.d.setVar('AUTOREV', '${@bb.fetch2.get_autorev(d)}')
@@ -1804,7 +1804,7 @@ class GitShallowTest(FetcherTest):
         self.git('submodule update', cwd=self.srcdir)
         self.git('commit -m submodule -a', cwd=self.srcdir)
 
-        uri = 'gitsm://%s;protocol=file;subdir=${S}' % self.srcdir
+        uri = 'gitsm://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
         fetcher, ud = self.fetch_shallow(uri)
 
         # Verify the main repository is shallow
@@ -1868,7 +1868,7 @@ class GitShallowTest(FetcherTest):
             self.git('commit --author "Foo Bar <foo@bar>" -m annex-c -a', cwd=self.srcdir)
             bb.process.run('chmod u+w -R %s' % self.srcdir)
 
-            uri = 'gitannex://%s;protocol=file;subdir=${S}' % self.srcdir
+            uri = 'gitannex://%s;protocol=file;subdir=${S};branch=master' % self.srcdir
             fetcher, ud = self.fetch_shallow(uri)
 
             self.assertRevCount(1)
@@ -2115,7 +2115,7 @@ class GitShallowTest(FetcherTest):
         self.d.setVar('SRCREV', 'e5939ff608b95cdd4d0ab0e1935781ab9a276ac0')
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
-        fetcher = bb.fetch.Fetch(["git://git.yoctoproject.org/fstests"], self.d)
+        fetcher = bb.fetch.Fetch(["git://git.yoctoproject.org/fstests;branch=master"], self.d)
         fetcher.download()
 
         bb.utils.remove(self.dldir + "/*.tar.gz")
@@ -2160,7 +2160,7 @@ class GitLfsTest(FetcherTest):
     def test_lfs_enabled(self):
         import shutil
 
-        uri = 'git://%s;protocol=file;lfs=1' % self.srcdir
+        uri = 'git://%s;protocol=file;lfs=1;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
         # Careful: suppress initial attempt at downloading until
@@ -2185,7 +2185,7 @@ class GitLfsTest(FetcherTest):
     def test_lfs_disabled(self):
         import shutil
 
-        uri = 'git://%s;protocol=file;lfs=0' % self.srcdir
+        uri = 'git://%s;protocol=file;lfs=0;branch=master' % self.srcdir
         self.d.setVar('SRC_URI', uri)
 
         # In contrast to test_lfs_enabled(), allow the implicit download
@@ -2209,13 +2209,13 @@ class GitLfsTest(FetcherTest):
 
 class GitURLWithSpacesTest(FetcherTest):
     test_git_urls = {
-        "git://tfs-example.org:22/tfs/example%20path/example.git" : {
-            'url': 'git://tfs-example.org:22/tfs/example%20path/example.git',
+        "git://tfs-example.org:22/tfs/example%20path/example.git;branch=master" : {
+            'url': 'git://tfs-example.org:22/tfs/example%20path/example.git;branch=master',
             'gitsrcname': 'tfs-example.org.22.tfs.example_path.example.git',
             'path': '/tfs/example path/example.git'
         },
-        "git://tfs-example.org:22/tfs/example%20path/example%20repo.git" : {
-            'url': 'git://tfs-example.org:22/tfs/example%20path/example%20repo.git',
+        "git://tfs-example.org:22/tfs/example%20path/example%20repo.git;branch=master" : {
+            'url': 'git://tfs-example.org:22/tfs/example%20path/example%20repo.git;branch=master',
             'gitsrcname': 'tfs-example.org.22.tfs.example_path.example_repo.git',
             'path': '/tfs/example path/example repo.git'
         }
@@ -2744,7 +2744,7 @@ class NPMTest(FetcherTest):
 class GitSharedTest(FetcherTest):
     def setUp(self):
         super(GitSharedTest, self).setUp()
-        self.recipe_url = "git://git.openembedded.org/bitbake"
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master"
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
     @skipIfNoNetwork()
-- 
2.32.0


