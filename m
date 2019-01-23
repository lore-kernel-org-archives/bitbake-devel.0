Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 321BB6BD57
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jan 2019 15:29:08 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0NFSXWm010190
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 23 Jan 2019 07:28:43 -0800
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 23 Jan 2019 07:28:22 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 Jan 2019 10:28:18 -0500
Message-ID: <20190123152818.63800-3-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190123152818.63800-1-mark.hatle@windriver.com>
References: <20190123152818.63800-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] gitsmy.py: Fix unpack of submodules of submodules
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
X-List-Received-Date: Wed, 23 Jan 2019 15:29:08 -0000
Content-Type: text/plain

If the submodule is in a subdirectory, it needs to have that structure
preserved.  This means the unpack path needs to be in the 'dirname' of the
final path -- since the unpack directory name is specified in the URI.

Additional specific test cases were added to ensure this is working properly
based on two recent error reports.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py |  9 ++++++---
 lib/bb/tests/fetch.py  | 26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index faffb4c..f45546b 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -176,12 +176,11 @@ class GitSM(Git):
 
             try:
                 newfetch = Fetch([url], d, cache=False)
-                newfetch.unpack(root=os.path.join(repo_conf, 'modules'))
+                newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 'modules', modpath)))
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (type(e).__name__, str(e)))
                 raise
 
-            newfetch = Fetch([url], d, cache=False)
             local_path = newfetch.localpath(url)
 
             # Correct the submodule references to the local download version...
@@ -191,7 +190,11 @@ class GitSM(Git):
                 runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
 
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
-            runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', modpath))
+            try:
+                runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', modpath))
+            except:
+                logger.error("Unable to set git config core.bare to false for %s" % os.path.join(repo_conf, 'modules', modpath))
+                raise
 
         Git.unpack(self, ud, destdir, d)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index de3b0ce..e9ad807 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -912,6 +912,32 @@ class FetcherNetworkTest(FetcherTest):
         if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
             self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule missing')
 
+        # The following external repositories have show failures in fetch and unpack operations
+        # We want to avoid regressions!
+        url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-dvar/config')), msg='Missing submodule config "subprojects/c-dvar"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-list/config')), msg='Missing submodule config "subprojects/c-list"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-rbtree/config')), msg='Missing submodule config "subprojects/c-rbtree"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-sundry/config')), msg='Missing submodule config "subprojects/c-sundry"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/subprojects/c-utf8/config')), msg='Missing submodule config "subprojects/c-utf8"')
+
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
+
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
         # Ensure trusted_network returns False when the host IS in the list.
-- 
1.8.3.1


