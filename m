Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 4D9DF6E908
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Feb 2014 18:50:27 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2014 10:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,536,1389772800"; d="scan'208";a="487258411"
Received: from mmckenna-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.143])
	by fmsmga002.fm.intel.com with ESMTP; 24 Feb 2014 10:50:16 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Feb 2014 18:50:02 +0000
Message-Id: <3dcb6582ecead3b99fbf8b7a45ed7caae9598b2e.1393267755.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1393267755.git.paul.eggleton@linux.intel.com>
References: <cover.1393267755.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] fetch2: fix fetching git submodules with git 1.7.9.x or older
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
X-List-Received-Date: Mon, 24 Feb 2014 18:50:28 -0000

Git versions older than 1.7.10 put absolute paths in configuration files
for the submodule repositories, leading to errors when the repository
checkout is moved. We move the repository as a matter of course in the
gitsm fetcher; the failure occurs in do_unpack). Change the absolute
paths to be relative during processing to fix this.

(At the time of writing, Ubuntu 12.04.4 LTS ships Git version 1.7.9.5,
hence the desire to fix this rather than just mandating a newer Git
version.)

Fixes [YOCTO #5525].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/gitsm.py | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 9fdde46..1a76215 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -42,6 +42,53 @@ class GitSM(Git):
                 pass
         return False
 
+    def _set_relative_paths(self, repopath):
+        """
+        Fix submodule paths to be relative instead of absolute,
+        so that when we move the repo it doesn't break
+        (In Git 1.7.10+ this is done automatically)
+        """
+        submodules = []
+        with open(os.path.join(repopath, '.gitmodules'), 'r') as f:
+            for line in f.readlines():
+                if line.startswith('[submodule'):
+                    submodules.append(line.split('"')[1])
+
+        for module in submodules:
+            repo_conf = os.path.join(repopath, module, '.git')
+            if os.path.exists(repo_conf):
+                with open(repo_conf, 'r') as f:
+                    lines = f.readlines()
+                newpath = ''
+                for i, line in enumerate(lines):
+                    if line.startswith('gitdir:'):
+                        oldpath = line.split(': ')[-1].rstrip()
+                        if oldpath.startswith('/'):
+                            newpath = '../' * (module.count('/') + 1) + '.git/modules/' + module
+                            lines[i] = 'gitdir: %s\n' % newpath
+                            break
+                if newpath:
+                    with open(repo_conf, 'w') as f:
+                        for line in lines:
+                            f.write(line)
+
+            repo_conf2 = os.path.join(repopath, '.git', 'modules', module, 'config')
+            if os.path.exists(repo_conf2):
+                with open(repo_conf2, 'r') as f:
+                    lines = f.readlines()
+                newpath = ''
+                for i, line in enumerate(lines):
+                    if line.lstrip().startswith('worktree = '):
+                        oldpath = line.split(' = ')[-1].rstrip()
+                        if oldpath.startswith('/'):
+                            newpath = '../' * (module.count('/') + 3) + module
+                            lines[i] = '\tworktree = %s\n' % newpath
+                            break
+                if newpath:
+                    with open(repo_conf2, 'w') as f:
+                        for line in lines:
+                            f.write(line)
+
     def update_submodules(self, ud, d):
         # We have to convert bare -> full repo, do the submodule bit, then convert back
         tmpclonedir = ud.clonedir + ".tmp"
@@ -54,6 +101,7 @@ class GitSM(Git):
         runfetchcmd(ud.basecmd + " reset --hard", d)
         runfetchcmd(ud.basecmd + " submodule init", d)
         runfetchcmd(ud.basecmd + " submodule update", d)
+        self._set_relative_paths(tmpclonedir)
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d)
         os.rename(gitdir, ud.clonedir,)
         bb.utils.remove(tmpclonedir, True)
-- 
1.8.5.3


