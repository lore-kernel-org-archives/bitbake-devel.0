Return-Path: <kergoth@gmail.com>
Received: from mail-wr0-f195.google.com (mail-wr0-f195.google.com
	[209.85.128.195])
	by mail.openembedded.org (Postfix) with ESMTP id 62A2971AD6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 16:37:48 +0000 (UTC)
Received: by mail-wr0-f195.google.com with SMTP id 30so6348162wrk.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=B2TmA9PDgNx/CJ9CyZJ8PD1b1nZv9SA/E3HnMhba5CA=;
	b=N+2Jv2YrkMJdbco7qv7nOZpCsYLL57cG0qV5Z6byHvXyBmaq3tGdozkcYGDSwCqKrv
	pzzDDF67y2CmQ8yXAy2q8+IJo/+eZX3ILWYtwMwEJ1RWHqmhhsJgDTaLGrcuGto1SDwS
	SHcDILubQt5d1pkc51u4EMLpJQ8FR5V4G3+jvu/L+n+5CPkPi5bte2xCFnv3JG5P36Ly
	JwSLAwuwByzQFzp1lypb9eggB9gQLVQpp3ojun7DhfLGNIcfXe9DeP4mX/u4fN/emVKa
	U9JsVRef+meu6ivXCKYEd/FoZZJXVvWRRr+HUm35YsRKcmS0Wt6BP4ohyAa5TIwCQIdx
	kzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=B2TmA9PDgNx/CJ9CyZJ8PD1b1nZv9SA/E3HnMhba5CA=;
	b=m0cxPpDG3jXbUynzVwLAhIrZPVtYS9nP1XkScyPIeu9hT4iK27xhxSlpBmvcVqy1qZ
	izZTPEu91jTLfsdJv2Lfy2TvM9Z8AnBtRGRFhEVefnJpCuzUYneNKbE4ha/9+918jyoM
	QljEH6j5XtswaVO7AyZAveVofxZ6k+L8VBZ4rP8+PYPmp4CXsfpbL9/CZsAN1tth8EaR
	2ugjuVNy0JKmc1/OKF4Ces26G+kFTBxIuuw6qy7kFgQsrbOoIMr9d5W1qF8Xme0LBHVH
	Xs1CwrN+waAjzw4O1OO4AcHbrpS2lZGymCGPe5S/vhXGLDkPuDxH9wKI67i0Y8ysTVfe
	2Ylw==
X-Gm-Message-State: AHYfb5hMCrMuJs/KuzNEDhXAGSZruI1ZX9yuHaUdDPRxJkxTf7amJLYC
	ELXD7HJCSli9Uua/q+Q=
X-Received: by 10.223.136.104 with SMTP id e37mr6561961wre.152.1503333468937; 
	Mon, 21 Aug 2017 09:37:48 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id 62sm9933965wrb.12.2017.08.21.09.37.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Aug 2017 09:37:47 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Aug 2017 21:37:40 +0500
Message-Id: <20170821163741.28301-1-kergoth@gmail.com>
X-Mailer: git-send-email 2.11.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] tests/fetch: add test_git_submodule_branch_new_module
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
X-List-Received-Date: Mon, 21 Aug 2017 16:37:48 -0000

From: Christopher Larson <chris_larson@mentor.com>

This local test validates that we can switch branches for a gitsm URI and the
submodules are correct for that branch when unpacked.

[YOCTO #11830]

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/tests/fetch.py | 60 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index faa5c74a..f91621c0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -19,11 +19,12 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
-import unittest
-import tempfile
-import subprocess
 import collections
 import os
+import shutil
+import subprocess
+import tempfile
+import unittest
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
 import bb
@@ -517,6 +518,59 @@ class FetcherLocalTest(FetcherTest):
         with self.assertRaises(bb.fetch2.UnpackError):
             self.fetchUnpack(['file://a;subdir=/bin/sh'])
 
+    def test_git_submodule_branch_new_module(self):
+        def git(gitdir, *cmd):
+            if len(cmd) == 1 and isinstance(cmd[0], list, str):
+                cmd = cmd[0]
+
+            if isinstance(cmd, str):
+                cmd = 'git ' + cmd
+            else:
+                cmd = ['git'] + list(cmd)
+            return bb.process.run(cmd, cwd=gitdir)[0]
+
+        def newrepo(name):
+            gitdir = os.path.join(self.tempdir, name)
+            bb.process.run(['git', 'init', gitdir])
+            open(os.path.join(gitdir, 'a'), 'w').close()
+            git(gitdir, 'add', 'a')
+            git(gitdir, 'commit', '-m', 'add a')
+            return gitdir
+
+        sub1 = newrepo('upstream-submodule1')
+        upstream = newrepo('upstream')
+        git(upstream, 'submodule', 'add', sub1, 'sub1')
+        git(upstream, 'add', '.gitmodules')
+        git(upstream, 'commit', '-m', 'add submodule1')
+
+        git(upstream, 'checkout', '-b', 'with-sub2')
+        sub2 = newrepo('upstream-submodule2')
+        git(upstream, 'submodule', 'add', sub2, 'sub2')
+        git(upstream, 'add', '.gitmodules')
+        git(upstream, 'commit', '-m', 'add submodule2')
+
+        git(upstream, 'checkout', 'master')
+
+        self.d.setVar('SRCREV', '${@bb.fetch2.get_autorev(d)}')
+
+        bb.utils.mkdirhier(self.unpackdir)
+        tree = self.fetchUnpack(["gitsm://%s;protocol=file;branch=master" % upstream])
+        tree = filter(lambda f: not f.startswith('git/.git/'), tree)
+        self.assertEqual(list(tree), ['git/.gitmodules', 'git/a', 'git/sub1/.git', 'git/sub1/a'])
+
+        shutil.rmtree(self.unpackdir)
+        bb.utils.mkdirhier(self.unpackdir)
+        tree = self.fetchUnpack(["gitsm://%s;protocol=file;branch=with-sub2" % upstream])
+        tree = filter(lambda f: not f.startswith('git/.git/'), tree)
+        self.assertEqual(list(tree), ['git/.gitmodules', 'git/a', 'git/sub1/.git', 'git/sub1/a', 'git/sub2/.git', 'git/sub2/a'])
+
+        shutil.rmtree(self.unpackdir)
+        bb.utils.mkdirhier(self.unpackdir)
+        tree = self.fetchUnpack(["gitsm://%s;protocol=file;branch=master" % upstream])
+        tree = filter(lambda f: not f.startswith('git/.git/'), tree)
+        self.assertEqual(list(tree), ['git/.gitmodules', 'git/a', 'git/sub1/.git', 'git/sub1/a'])
+
+
 class FetcherNetworkTest(FetcherTest):
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-- 
2.11.1


