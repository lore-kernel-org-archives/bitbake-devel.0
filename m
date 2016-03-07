Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 437BA6FFE2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 04:28:11 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 06 Mar 2016 20:28:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,549,1449561600"; d="scan'208";a="918275393"
Received: from kgoh8-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.138.205])
	by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2016 20:28:10 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Mar 2016 17:27:35 +1300
Message-Id: <3d0c4e9ec7d1c4ce7dbdab412eb48ecd6a383e4e.1457324829.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1457324829.git.paul.eggleton@linux.intel.com>
References: <cover.1457324829.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1457324829.git.paul.eggleton@linux.intel.com>
References: <cover.1457324829.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] fetch2/npm: fix indentation
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
X-List-Received-Date: Mon, 07 Mar 2016 04:28:11 -0000

No code changes, just fix to use four spaces.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index f99b308..59312f4 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -57,10 +57,10 @@ class Npm(FetchMethod):
         logger.debug(1, "NpmFetch: %s", msg)
 
     def clean(self, ud, d):
-         logger.debug(2, "Calling cleanup %s" % ud.pkgname)
-         bb.utils.remove(ud.localpath, False)
-         bb.utils.remove(ud.pkgdatadir, True)
-         bb.utils.remove(ud.fullmirror, False)
+        logger.debug(2, "Calling cleanup %s" % ud.pkgname)
+        bb.utils.remove(ud.localpath, False)
+        bb.utils.remove(ud.pkgdatadir, True)
+        bb.utils.remove(ud.fullmirror, False)
 
     def urldata_init(self, ud, d):
         """
@@ -105,32 +105,32 @@ class Npm(FetchMethod):
         runfetchcmd(command, d, quiet)
 
     def _unpackdep(self, ud, pkg, data, destdir, dldir, d):
-       file = data[pkg]['tgz']
-       logger.debug(2, "file to extract is %s" % file)
-       if file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
+        file = data[pkg]['tgz']
+        logger.debug(2, "file to extract is %s" % file)
+        if file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
             cmd = 'tar xz --strip 1 --no-same-owner -f %s/%s' % (dldir, file)
-       else:
+        else:
             bb.fatal("NPM package %s downloaded not a tarball!" % file)
 
-       # Change to subdir before executing command
-       save_cwd = os.getcwd()
-       if not os.path.exists(destdir):
-           os.makedirs(destdir)
-       os.chdir(destdir)
-       path = d.getVar('PATH', True)
-       if path:
+        # Change to subdir before executing command
+        save_cwd = os.getcwd()
+        if not os.path.exists(destdir):
+            os.makedirs(destdir)
+        os.chdir(destdir)
+        path = d.getVar('PATH', True)
+        if path:
             cmd = "PATH=\"%s\" %s" % (path, cmd)
-       bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
-       ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
-       os.chdir(save_cwd)
+        bb.note("Unpacking %s to %s/" % (file, os.getcwd()))
+        ret = subprocess.call(cmd, preexec_fn=subprocess_setup, shell=True)
+        os.chdir(save_cwd)
 
-       if ret != 0:
+        if ret != 0:
             raise UnpackError("Unpack command %s failed with return value %s" % (cmd, ret), ud.url)
 
-       if 'deps' not in data[pkg]:
+        if 'deps' not in data[pkg]:
             return
-       for dep in data[pkg]['deps']:
-           self._unpackdep(ud, dep, data[pkg]['deps'], "%s/node_modules/%s" % (destdir, dep), dldir, d)
+        for dep in data[pkg]['deps']:
+            self._unpackdep(ud, dep, data[pkg]['deps'], "%s/node_modules/%s" % (destdir, dep), dldir, d)
 
 
     def unpack(self, ud, destdir, d):
-- 
2.5.0


