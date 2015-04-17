Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E0BED73D94
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Apr 2015 14:27:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 17 Apr 2015 07:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,595,1422950400"; d="scan'208";a="710873724"
Received: from pbrao1-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.13.156])
	by fmsmga002.fm.intel.com with ESMTP; 17 Apr 2015 07:27:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Apr 2015 15:26:59 +0100
Message-Id: <54b162c649388c63015cdd0d69866d5604303b60.1429280244.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1429280244.git.paul.eggleton@linux.intel.com>
References: <cover.1429280244.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1429280244.git.paul.eggleton@linux.intel.com>
References: <cover.1429280244.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] lib/bb/utils: add safeguard against recursively deleting things we shouldn't
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
X-List-Received-Date: Fri, 17 Apr 2015 14:27:21 -0000

Add some very basic safeguard against recursively deleting paths such
as / and /home in the event of bugs or user mistakes.

Addresses [YOCTO #7620].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/utils.py | 17 +++++++++++++++++
 lib/bb/utils.py       | 21 +++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 507de2d..6e09858 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -21,6 +21,7 @@
 
 import unittest
 import bb
+import os
 
 class VerCmpString(unittest.TestCase):
 
@@ -88,3 +89,19 @@ class VerCmpString(unittest.TestCase):
 
         # Check that clearly invalid operator raises an exception
         self.assertRaises(bb.utils.VersionStringException, bb.utils.vercmp_string_op, '0', '0', '$')
+
+
+class Path(unittest.TestCase):
+    def test_unsafe_delete_path(self):
+        checkitems = [('/', True),
+                      ('//', True),
+                      ('///', True),
+                      (os.getcwd().count(os.sep) * ('..' + os.sep), True),
+                      (os.environ.get('HOME', '/home/test'), True),
+                      ('/home/someone', True),
+                      ('/home/other/', True),
+                      ('/home/other/subdir', False),
+                      ('', False)]
+        for arg1, correctresult in checkitems:
+            result = bb.utils._check_unsafe_delete_path(arg1)
+            self.assertEqual(result, correctresult, '_check_unsafe_delete_path("%s") != %s' % (arg1, correctresult))
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 5ac9bcf..c97f3ef 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -601,11 +601,30 @@ def build_environment(d):
         if export:
             os.environ[var] = d.getVar(var, True) or ""
 
+def _check_unsafe_delete_path(path):
+    """
+    Basic safeguard against recursively deleting something we shouldn't. If it returns True,
+    the caller should raise an exception with an appropriate message.
+    NOTE: This is NOT meant to be a security mechanism - just a guard against silly mistakes
+    with potentially disastrous results.
+    """
+    extra = ''
+    # HOME might not be /home/something, so in case we can get it, check against it
+    homedir = os.environ.get('HOME', '')
+    if homedir:
+        extra = '|%s' % homedir
+    if re.match('(/|//|/home|/home/[^/]*%s)$' % extra, os.path.abspath(path)):
+        return True
+    return False
+
 def remove(path, recurse=False):
     """Equivalent to rm -f or rm -rf"""
     if not path:
         return
     if recurse:
+        for name in glob.glob(path):
+            if _check_unsafe_delete_path(path):
+                raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % path)
         # shutil.rmtree(name) would be ideal but its too slow
         subprocess.call(['rm', '-rf'] + glob.glob(path))
         return
@@ -619,6 +638,8 @@ def remove(path, recurse=False):
 def prunedir(topdir):
     # Delete everything reachable from the directory named in 'topdir'.
     # CAUTION:  This is dangerous!
+    if _check_unsafe_delete_path(topdir):
+        raise Exception('bb.utils.prunedir: called with dangerous path "%s", refusing to delete!' % topdir)
     for root, dirs, files in os.walk(topdir, topdown = False):
         for name in files:
             os.remove(os.path.join(root, name))
-- 
2.1.0


