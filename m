Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DFC433EF
	for <webhook@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:48 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web12.5172.1637033566840862534
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Nov 2021 19:32:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="257369171"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="257369171"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800";
   d="scan'208";a="506232237"
Received: from jli90-mobl.gar.corp.intel.com (HELO anmitta2-mobl3.intel.com)
 ([10.214.145.204])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2021 19:32:46 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 3/8] tests/fetch: Update github urls
Date: Tue, 16 Nov 2021 11:32:32 +0800
Message-Id: 
 <a95f05359e65c3336eeb8366c0c35a23d3821dda.1637033341.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637033341.git.anuj.mittal@intel.com>
References: <cover.1637033341.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Nov 2021 03:32:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13051

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 07fca7e3ab696ba985b3ef86ab9031d688bf2df2)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/tests/fetch.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index f5d557e8..c3e714ae 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -491,7 +491,7 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         super(GitDownloadDirectoryNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake"
         self.recipe_dir = "git.openembedded.org.bitbake"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
         self.mirror_dir = "github.com.openembedded.bitbake.git"
 
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
@@ -539,7 +539,7 @@ class TarballNamingTest(FetcherTest):
         super(TarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
         self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
@@ -573,7 +573,7 @@ class GitShallowTarballNamingTest(FetcherTest):
         super(GitShallowTarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
         self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
@@ -985,7 +985,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
-        url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
+        url = "gitsm://github.com/bus1/dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1001,7 +1001,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1016,12 +1016,12 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule_update_CLI11(self):
         """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=main"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
 
         # CLI11 that pulls in a newer nlohmann-json
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=main"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1035,7 +1035,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_aktualizr(self):
-        url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
+        url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=https;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1055,7 +1055,7 @@ class FetcherNetworkTest(FetcherTest):
         """ Prevent regression on deeply nested submodules not being checked out properly, even though they were fetched. """
 
         # This repository also has submodules where the module (name), path and url do not align
-        url = "gitsm://github.com/azure/iotedge.git;protocol=git;rev=d76e0316c6f324345d77c48a83ce836d09392699"
+        url = "gitsm://github.com/azure/iotedge.git;protocol=https;rev=d76e0316c6f324345d77c48a83ce836d09392699"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1231,7 +1231,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     test_git_uris = {
         # version pattern "X.Y.Z"
-        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4", "9b1db6b8060bd00b121a692f942404a24ae2960f", "")
+        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "")
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with testing
@@ -1258,9 +1258,9 @@ class FetchLatestVersionTest(FetcherTest):
             : "0.4.3",
         ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", "(?P<pver>(([0-9][\.|_]?)+[0-9]))")
             : "11.0.0",
-        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot", "cd437ecbd8986c894442f8fce1e0061e20f04dee", "chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
+        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot;protocol=https", "cd437ecbd8986c894442f8fce1e0061e20f04dee", "chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
             : "1.3.59",
-        ("remake", "git://github.com/rocky/remake.git", "f05508e521987c8494c92d9c2871aec46307d51d", "(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
+        ("remake", "git://github.com/rocky/remake.git;protocol=https", "f05508e521987c8494c92d9c2871aec46307d51d", "(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
             : "3.82+dbg0.9",
     }
 
@@ -2047,7 +2047,7 @@ class GitShallowTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_bitbake(self):
-        self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
+        self.git('remote add --mirror=fetch origin https://github.com/openembedded/bitbake', cwd=self.srcdir)
         self.git('config core.bare true', cwd=self.srcdir)
         self.git('fetch', cwd=self.srcdir)
 
-- 
2.33.1


