Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1E0946BE39
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 May 2019 11:53:27 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x4FBrLdV022907
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 15 May 2019 04:53:25 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 15 May 2019 04:53:21 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 May 2019 07:53:20 -0400
Message-ID: <20190515115320.176356-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Cc: koalo@koalo.de, tapani.mattila@bitfactor.fi
Subject: [PATCH] gitsm: Fix a bug where the wrong path was used for the submodule init
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
X-List-Received-Date: Wed, 15 May 2019 11:53:28 -0000
Content-Type: text/plain

Because we are trying to avoid network activity and use our own fetcher,
the system emulates the behavior of 'git submodule init'.

git submodule init uses the .gitmodules file, where typically the module
name and path are the same.  However, in this case the module name and
path (in the tree) were different. i.e.:

[submodule "edgelet/hsm-sys/azure-iot-hsm-c/deps/azure-c-shared-utility"]
        path = edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared
        url = https://github.com/Azure/azure-c-shared-utility.git

Previously the code assumed the 'path' was both the checkout location
under .git/modules, as well as the path to extract the components.  This
proved to be incorrect as the .git/modules path needs to match the submodule
'name'.  This causes the components that were fetched to be initialized in
the wrong location, which later caused the 'git submodule update' process to
skip not properly initialized modules.

A test case was added for this specific case to ensure a regression does
not appear in the future.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 It is believed this is the same issue as YP Bug 13133 even though the
 report was slightly different.

 lib/bb/fetch2/gitsm.py | 12 +++++++-----
 lib/bb/tests/fetch.py  | 27 +++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 1f03ba7..c622771 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -117,7 +117,7 @@ class GitSM(Git):
 
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
-            url += ";subpath=%s" % paths[module]
+            url += ";subpath=%s" % module
 
             ld = d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to
@@ -184,7 +184,7 @@ class GitSM(Git):
 
             try:
                 newfetch = Fetch([url], d, cache=False)
-                newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 'modules', modpath)))
+                newfetch.unpack(root=os.path.dirname(os.path.join(repo_conf, 'modules', module)))
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (type(e).__name__, str(e)))
                 raise
@@ -199,9 +199,9 @@ class GitSM(Git):
 
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
             try:
-                runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', modpath))
+                runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', module))
             except:
-                logger.error("Unable to set git config core.bare to false for %s" % os.path.join(repo_conf, 'modules', modpath))
+                logger.error("Unable to set git config core.bare to false for %s" % os.path.join(repo_conf, 'modules', module))
                 raise
 
         Git.unpack(self, ud, destdir, d)
@@ -209,5 +209,7 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
-            # Run submodule update, this sets up the directories -- without touching the config
+            # All submodules should already be downloaded and configured in the tree.  This simply sets
+            # up the configuration and checks out the files.  The main project config should remain
+            # unmodified, and no download from the internet should occur.
             runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 97656df..6bdf041 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -964,6 +964,33 @@ class FetcherNetworkTest(FetcherTest):
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/googletest/config')), msg='Missing submodule config "third_party/googletest/config"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/third_party/HdrHistogram_c/config')), msg='Missing submodule config "third_party/HdrHistogram_c/config"')
 
+    def test_git_submodule_iotedge(self):
+        """ Prevent regression on deeply nested submodules not being checked out properly, even though they were fetched. """
+
+        # This repository also has submodules where the module (name), path and url do not align
+        url = "gitsm://github.com/azure/iotedge.git;protocol=git;rev=d76e0316c6f324345d77c48a83ce836d09392699"
+        fetcher = bb.fetch.Fetch([url], self.d)
+        fetcher.download()
+        # Previous cwd has been deleted
+        os.chdir(os.path.dirname(self.unpackdir))
+        fetcher.unpack(self.unpackdir)
+
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/README.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/ctest/README.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/testrunner/readme.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/umock-c/readme.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/umock-c/deps/ctest/README.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/c-shared/testtools/umock-c/deps/testrunner/readme.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/README.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/README.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/ctest/README.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/testrunner/readme.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/readme.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/ctest/README.md')), msg='Missing submodule checkout')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'edgelet/hsm-sys/azure-iot-hsm-c/deps/utpm/deps/c-utility/testtools/umock-c/deps/testrunner/readme.md')), msg='Missing submodule checkout')
+
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
         # Ensure trusted_network returns False when the host IS in the list.
-- 
1.8.3.1


