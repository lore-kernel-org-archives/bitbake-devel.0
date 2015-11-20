Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3108A6012A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Nov 2015 01:54:19 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 19 Nov 2015 17:54:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,320,1444719600"; d="scan'208";a="603692749"
Received: from ywong15-mobl2.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.131.114])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Nov 2015 17:53:00 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Nov 2015 14:52:30 +1300
Message-Id: <43f5af1bb1f482e3e6492002b227fe063b5952f7.1447984320.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1447984320.git.paul.eggleton@linux.intel.com>
References: <cover.1447984320.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1447984320.git.paul.eggleton@linux.intel.com>
References: <cover.1447984320.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] lib/bb/utils: improve edit_bblayers_conf() handling of bblayers.conf formatting
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
X-List-Received-Date: Fri, 20 Nov 2015 01:54:19 -0000

Make the following improvements to edit_bblayers_conf():

* Support ~ in BBLAYERS entries
* Handle where BBLAYERS items are added over multiple lines with +=
  instead of one single long item

Also add some comments documenting the function arguments and return
values as well as a set of bitbake-selftest tests.

(This function is used by the bitbake-layers add, remove and
layerindex-fetch subcommands, as well as devtool when adding the
workspace layer).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tests/utils.py | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       |  73 ++++++++++++++----
 2 files changed, 262 insertions(+), 14 deletions(-)

diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index 9171509..a035ccf 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -376,3 +376,206 @@ do_functionname() {
         (updated, newlines) = bb.utils.edit_metadata(self._origfile.splitlines(True), varlist, handle_var)
         self.assertTrue(updated, 'List should be updated but isn\'t')
         self.assertEqual(newlines, newfile5.splitlines(True))
+
+
+class EditBbLayersConf(unittest.TestCase):
+
+    def _test_bblayers_edit(self, before, after, add, remove, notadded, notremoved):
+        with tempfile.NamedTemporaryFile('w', delete=False) as tf:
+            tf.write(before)
+            tf.close()
+            try:
+                actual_notadded, actual_notremoved = bb.utils.edit_bblayers_conf(tf.name, add, remove)
+                with open(tf.name) as f:
+                    actual_after = f.readlines()
+                self.assertEqual(after.splitlines(True), actual_after)
+                self.assertEqual(notadded, actual_notadded)
+                self.assertEqual(notremoved, actual_notremoved)
+            finally:
+                os.remove(tf.name)
+
+
+    def test_bblayers_remove(self):
+        before = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  /home/user/path/layer1 \
+  /home/user/path/layer2 \
+  /home/user/path/subpath/layer3 \
+  /home/user/path/layer4 \
+  "
+"""
+        after = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  /home/user/path/layer1 \
+  /home/user/path/subpath/layer3 \
+  /home/user/path/layer4 \
+  "
+"""
+        self._test_bblayers_edit(before, after,
+                                 None,
+                                 '/home/user/path/layer2',
+                                 [],
+                                 [])
+
+
+    def test_bblayers_add(self):
+        before = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  /home/user/path/layer1 \
+  /home/user/path/layer2 \
+  /home/user/path/subpath/layer3 \
+  /home/user/path/layer4 \
+  "
+"""
+        after = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  /home/user/path/layer1 \
+  /home/user/path/layer2 \
+  /home/user/path/subpath/layer3 \
+  /home/user/path/layer4 \
+  /other/path/to/layer5 \
+  "
+"""
+        self._test_bblayers_edit(before, after,
+                                 '/other/path/to/layer5/',
+                                 None,
+                                 [],
+                                 [])
+
+
+    def test_bblayers_add_remove(self):
+        before = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  /home/user/path/layer1 \
+  /home/user/path/layer2 \
+  /home/user/path/subpath/layer3 \
+  /home/user/path/layer4 \
+  "
+"""
+        after = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  /home/user/path/layer1 \
+  /home/user/path/layer2 \
+  /home/user/path/layer4 \
+  /other/path/to/layer5 \
+  "
+"""
+        self._test_bblayers_edit(before, after,
+                                 ['/other/path/to/layer5', '/home/user/path/layer2/'], '/home/user/path/subpath/layer3/',
+                                 ['/home/user/path/layer2'],
+                                 [])
+
+
+    def test_bblayers_add_remove_home(self):
+        before = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  ~/path/layer1 \
+  ~/path/layer2 \
+  ~/otherpath/layer3 \
+  ~/path/layer4 \
+  "
+"""
+        after = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS = " \
+  ~/path/layer2 \
+  ~/path/layer4 \
+  ~/path2/layer5 \
+  "
+"""
+        self._test_bblayers_edit(before, after,
+                                 [os.environ['HOME'] + '/path/layer4', '~/path2/layer5'],
+                                 [os.environ['HOME'] + '/otherpath/layer3', '~/path/layer1', '~/path/notinlist'],
+                                 [os.environ['HOME'] + '/path/layer4'],
+                                 ['~/path/notinlist'])
+
+
+    def test_bblayers_add_remove_plusequals(self):
+        before = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS += " \
+  /home/user/path/layer1 \
+  /home/user/path/layer2 \
+  "
+"""
+        after = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS += " \
+  /home/user/path/layer2 \
+  /home/user/path/layer3 \
+  "
+"""
+        self._test_bblayers_edit(before, after,
+                                 '/home/user/path/layer3',
+                                 '/home/user/path/layer1',
+                                 [],
+                                 [])
+
+
+    def test_bblayers_add_remove_plusequals2(self):
+        before = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS += " \
+  /home/user/path/layer1 \
+  /home/user/path/layer2 \
+  /home/user/path/layer3 \
+  "
+BBLAYERS += "/home/user/path/layer4"
+BBLAYERS += "/home/user/path/layer5"
+"""
+        after = r"""
+# A comment
+
+BBPATH = "${TOPDIR}"
+BBFILES ?= ""
+BBLAYERS += " \
+  /home/user/path/layer2 \
+  /home/user/path/layer3 \
+  "
+BBLAYERS += "/home/user/path/layer5"
+BBLAYERS += "/home/user/otherpath/layer6"
+"""
+        self._test_bblayers_edit(before, after,
+                                 ['/home/user/otherpath/layer6', '/home/user/path/layer3'], ['/home/user/path/layer1', '/home/user/path/layer4', '/home/user/path/layer7'],
+                                 ['/home/user/path/layer3'],
+                                 ['/home/user/path/layer7'])
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 9b28952..3e2707c 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1201,7 +1201,19 @@ def edit_metadata_file(meta_file, variables, varfunc):
 
 
 def edit_bblayers_conf(bblayers_conf, add, remove):
-    """Edit bblayers.conf, adding and/or removing layers"""
+    """Edit bblayers.conf, adding and/or removing layers
+    Parameters:
+        bblayers_conf: path to bblayers.conf file to edit
+        add: layer path (or list of layer paths) to add; None or empty
+            list to add nothing
+        remove: layer path (or list of layer paths) to remove; None or
+            empty list to remove nothing
+    Returns a tuple:
+        notadded: list of layers specified to be added but weren't
+            (because they were already in the list)
+        notremoved: list of layers that were specified to be removed
+            but weren't (because they weren't in the list)
+    """
 
     import fnmatch
 
@@ -1210,6 +1222,13 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
             pth = pth[:-1]
         return pth
 
+    approved = bb.utils.approved_variables()
+    def canonicalise_path(pth):
+        pth = remove_trailing_sep(pth)
+        if 'HOME' in approved and '~' in pth:
+            pth = os.path.expanduser(pth)
+        return pth
+
     def layerlist_param(value):
         if not value:
             return []
@@ -1218,49 +1237,75 @@ def edit_bblayers_conf(bblayers_conf, add, remove):
         else:
             return [remove_trailing_sep(value)]
 
-    notadded = []
-    notremoved = []
-
     addlayers = layerlist_param(add)
     removelayers = layerlist_param(remove)
 
     # Need to use a list here because we can't set non-local variables from a callback in python 2.x
     bblayercalls = []
+    removed = []
+    plusequals = False
+    orig_bblayers = []
+
+    def handle_bblayers_firstpass(varname, origvalue, op, newlines):
+        bblayercalls.append(op)
+        if op == '=':
+            del orig_bblayers[:]
+        orig_bblayers.extend([canonicalise_path(x) for x in origvalue.split()])
+        return (origvalue, None, 2, False)
 
     def handle_bblayers(varname, origvalue, op, newlines):
-        bblayercalls.append(varname)
         updated = False
         bblayers = [remove_trailing_sep(x) for x in origvalue.split()]
         if removelayers:
             for removelayer in removelayers:
-                matched = False
                 for layer in bblayers:
-                    if fnmatch.fnmatch(layer, removelayer):
+                    if fnmatch.fnmatch(canonicalise_path(layer), canonicalise_path(removelayer)):
                         updated = True
-                        matched = True
                         bblayers.remove(layer)
+                        removed.append(removelayer)
                         break
-                if not matched:
-                    notremoved.append(removelayer)
-        if addlayers:
+        if addlayers and not plusequals:
             for addlayer in addlayers:
                 if addlayer not in bblayers:
                     updated = True
                     bblayers.append(addlayer)
-                else:
-                    notadded.append(addlayer)
             del addlayers[:]
 
         if updated:
+            if op == '+=' and not bblayers:
+                bblayers = None
             return (bblayers, None, 2, False)
         else:
             return (origvalue, None, 2, False)
 
-    edit_metadata_file(bblayers_conf, ['BBLAYERS'], handle_bblayers)
+    with open(bblayers_conf, 'r') as f:
+        (_, newlines) = edit_metadata(f, ['BBLAYERS'], handle_bblayers_firstpass)
 
     if not bblayercalls:
         raise Exception('Unable to find BBLAYERS in %s' % bblayers_conf)
 
+    # Try to do the "smart" thing depending on how the user has laid out
+    # their bblayers.conf file
+    if bblayercalls.count('+=') > 1:
+        plusequals = True
+
+    notadded = [layer for layer in addlayers if canonicalise_path(layer) in orig_bblayers]
+    notadded_canonicalised = [canonicalise_path(layer) for layer in notadded]
+    addlayers[:] = [layer for layer in addlayers if canonicalise_path(layer) not in notadded_canonicalised]
+
+    (updated, newlines) = edit_metadata(newlines, ['BBLAYERS'], handle_bblayers)
+    if addlayers:
+        # Still need to add these
+        for addlayer in addlayers:
+            newlines.append('BBLAYERS += "%s"\n' % addlayer)
+        updated = True
+
+    if updated:
+        with open(bblayers_conf, 'w') as f:
+            f.writelines(newlines)
+
+    notremoved = list(set(removelayers) - set(removed))
+
     return (notadded, notremoved)
 
 
-- 
2.1.0


