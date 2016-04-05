Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 73847770EF
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Apr 2016 13:21:40 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 05 Apr 2016 06:21:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,444,1455004800"; d="scan'208";a="938668554"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2016 06:21:20 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org,
	paul.eggleton@linux.intel.com
Date: Tue,  5 Apr 2016 16:21:19 +0300
Message-Id: <1459862479-13596-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH] externalsrc: avoid race in temporary git index file
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
X-List-Received-Date: Tue, 05 Apr 2016 13:21:41 -0000

Use a unique tempfile as the temporary git index file when determining
the git hash of the source tree. A fixed filename was obviously causing
races (with the git index.lock file) under oe-selftest where multiple
bitbake instances were run against the same source tree at the same
time.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 meta/classes/externalsrc.bbclass | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/meta/classes/externalsrc.bbclass b/meta/classes/externalsrc.bbclass
index dff6184..da7eb478 100644
--- a/meta/classes/externalsrc.bbclass
+++ b/meta/classes/externalsrc.bbclass
@@ -130,21 +130,22 @@ python externalsrc_compile_prefunc() {
 def srctree_hash_files(d):
     import shutil
     import subprocess
+    import tempfile
 
     s_dir = d.getVar('EXTERNALSRC', True)
     git_dir = os.path.join(s_dir, '.git')
-    oe_index_file = os.path.join(git_dir, 'oe-devtool-index')
     oe_hash_file = os.path.join(git_dir, 'oe-devtool-tree-sha1')
 
     ret = " "
     if os.path.exists(git_dir):
-        # Clone index
-        shutil.copy2(os.path.join(git_dir, 'index'), oe_index_file)
-        # Update our custom index
-        env = os.environ.copy()
-        env['GIT_INDEX_FILE'] = oe_index_file
-        subprocess.check_output(['git', 'add', '.'], cwd=s_dir, env=env)
-        sha1 = subprocess.check_output(['git', 'write-tree'], cwd=s_dir, env=env)
+        with tempfile.NamedTemporaryFile(dir=git_dir, prefix='oe-devtool-index') as tmp_index:
+            # Clone index
+            shutil.copy2(os.path.join(git_dir, 'index'), tmp_index.name)
+            # Update our custom index
+            env = os.environ.copy()
+            env['GIT_INDEX_FILE'] = tmp_index.name
+            subprocess.check_output(['git', 'add', '.'], cwd=s_dir, env=env)
+            sha1 = subprocess.check_output(['git', 'write-tree'], cwd=s_dir, env=env)
         with open(oe_hash_file, 'w') as fobj:
             fobj.write(sha1)
         ret = oe_hash_file + ':True'
-- 
2.6.2


