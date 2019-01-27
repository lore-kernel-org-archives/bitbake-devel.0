Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5FF947C3A1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 27 Jan 2019 16:57:22 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0RGvF3d015835
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 27 Jan 2019 08:57:15 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.435.0;
	Sun, 27 Jan 2019 08:57:14 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 27 Jan 2019 11:57:12 -0500
Message-ID: <20190127165712.118078-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190127165712.118078-1-mark.hatle@windriver.com>
References: <20190127165712.118078-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Cc: liu.ming50@gmail.com
Subject: [PATCH] gitsm: The fetcher did not process some recursive submodules properly.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 27 Jan 2019 16:57:22 -0000
Content-Type: text/plain

Move the submodule processing outside of the if statement to avoid any
optimizations that may happen.

Update the test cases to include the additional case, and split the other
test cases into individual tests to make it easier to figure out what
the failure may be.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py |  4 +++-
 lib/bb/tests/fetch.py  | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index f45546b..b21fed2 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -198,6 +198,8 @@ class GitSM(Git):
 
         Git.unpack(self, ud, destdir, d)
 
-        if not ud.bareclone and self.process_submodules(ud, ud.destdir, unpack_submodules, d):
+        ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
+
+        if not ud.bareclone and ret:
             # Run submodule update, this sets up the directories -- without touching the config
             runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e9ad807..522d202 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -912,6 +912,7 @@ class FetcherNetworkTest(FetcherTest):
         if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
             self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule missing')
 
+    def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
         url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2"
@@ -928,16 +929,35 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-sundry/config')), msg='Missing submodule config "subprojects/c-sundry"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-utf8/config')), msg='Missing submodule config "subprojects/c-utf8"')
 
+    def test_git_submodule_CLI11(self):
         url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
         fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
 
+    def test_git_submodule_aktualizr(self):
+        url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/partial/extern/isotp-c/config')), msg='Missing submodule config "partial/extern/isotp-c/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/partial/extern/isotp-c/modules/deps/bitfield-c/config')), msg='Missing submodule config "partial/extern/isotp-c/modules/deps/bitfield-c/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'partial/extern/isotp-c/deps/bitfield-c/.git')), msg="Submodule of submodule isotp-c did not unpack properly")
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/tests/tuf-test-vectors/config')), msg='Missing submodule config "tests/tuf-test-vectors/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/googletest/config')), msg='Missing submodule config "third_party/googletest/config"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/HdrHistogram_c/config')), msg='Missing submodule config "third_party/HdrHistogram_c/config"')
+
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
         # Ensure trusted_network returns False when the host IS in the list.
-- 
1.8.3.1


