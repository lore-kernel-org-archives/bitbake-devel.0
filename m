Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5716B732D8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Feb 2015 18:13:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 10 Feb 2015 10:13:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,551,1418112000"; d="scan'208";a="664422246"
Received: from mjbowe-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.18.120])
	by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2015 10:13:37 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Feb 2015 18:13:25 +0000
Message-Id: <9956ed8a340c00c8bc90f9a1edc79bf132a18440.1423591698.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1423591698.git.paul.eggleton@linux.intel.com>
References: <cover.1423591698.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1423591698.git.paul.eggleton@linux.intel.com>
References: <cover.1423591698.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] cooker: rework LAYERDEPENDS versioning so that it is actually useful
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
X-List-Received-Date: Tue, 10 Feb 2015 18:13:44 -0000

We've had versioned dependency support in LAYERDEPENDS for quite a long
time, but I can say with pretty good certainty that almost nobody has
used it up to now because it was too strict - the specified version had
to exactly match the version in your configuration or you would get an
error; there was no "greater than or equal" option, which is usually
what you will want given that LAYERVERSION does get bumped from time to
time.

However, users mismatching layer branches and then having their builds
fail later on with some incomprehensible error is still a pretty common
problem. We can't simply use the git branch because not everyone is
always on a branch and the branch names don't always match up (and
that's not an issue). To provide a practical means to address branch
mismatching, I have reworked LAYERDEPENDS version specifications to use
the more familiar "dependency (>= version)" syntax as used with package
dependencies, support non-integer versions, and clarified the error
message a little. If we then take care to bump the version on every
breaking change, it is at least possible to have layers depend on these
changes when they update to match; we can now even support a major.minor
scheme to allow retrospectively adding a version limiter to old branches
when a new branch is created and yet still allow the old branch minor
version to be bumped if needed.

Fixes [YOCTO #5991].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py      | 40 ++++++++++++++--------------------------
 lib/bb/tests/utils.py | 33 +++++++++++++++++++++++++++++++++
 lib/bb/utils.py       | 22 ++++++++++++++++++++++
 3 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f77c6c0..0bbbc09 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1096,42 +1096,30 @@ class BBCooker:
                 # Check dependencies and store information for priority calculation
                 deps = self.data.getVar("LAYERDEPENDS_%s" % c, True)
                 if deps:
-                    depnamelist = []
-                    deplist = deps.split()
-                    for dep in deplist:
-                        depsplit = dep.split(':')
-                        if len(depsplit) > 1:
-                            try:
-                                depver = int(depsplit[1])
-                            except ValueError:
-                                parselog.error("invalid version value in LAYERDEPENDS_%s: \"%s\"", c, dep)
-                                errors = True
-                                continue
-                        else:
-                            depver = None
-                        dep = depsplit[0]
-                        depnamelist.append(dep)
-
+                    try:
+                        deplist = bb.utils.explode_dep_versions2(deps)
+                    except bb.utils.VersionStringException as vse:
+                        bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (c, str(vse)))
+                    for dep, oplist in deplist.iteritems():
                         if dep in collection_list:
-                            if depver:
+                            for opstr in oplist:
                                 layerver = self.data.getVar("LAYERVERSION_%s" % dep, True)
+                                (op, depver) = opstr.split()
                                 if layerver:
                                     try:
-                                        lver = int(layerver)
-                                    except ValueError:
-                                        parselog.error("invalid value for LAYERVERSION_%s: \"%s\"", c, layerver)
-                                        errors = True
-                                        continue
-                                    if lver != depver:
-                                        parselog.error("Layer '%s' depends on version %d of layer '%s', but version %d is enabled in your configuration", c, depver, dep, lver)
+                                        res = bb.utils.vercmp_string_op(layerver, depver, op)
+                                    except bb.utils.VersionStringException as vse:
+                                        bb.fatal('Error parsing LAYERDEPENDS_%s: %s' % (c, str(vse)))
+                                    if not res:
+                                        parselog.error("Layer '%s' depends on version %s of layer '%s', but version %s is currently enabled in your configuration. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, dep, layerver)
                                         errors = True
                                 else:
-                                    parselog.error("Layer '%s' depends on version %d of layer '%s', which exists in your configuration but does not specify a version", c, depver, dep)
+                                    parselog.error("Layer '%s' depends on version %s of layer '%s', which exists in your configuration but does not specify a version. Check that you are using the correct matching versions/branches of these two layers.", c, opstr, dep)
                                     errors = True
                         else:
                             parselog.error("Layer '%s' depends on layer '%s', but this layer is not enabled in your configuration", c, dep)
                             errors = True
-                    collection_depends[c] = depnamelist
+                    collection_depends[c] = deplist.keys()
                 else:
                     collection_depends[c] = []
 
diff --git a/lib/bb/tests/utils.py b/lib/bb/tests/utils.py
index cf145f0..507de2d 100644
--- a/lib/bb/tests/utils.py
+++ b/lib/bb/tests/utils.py
@@ -55,3 +55,36 @@ class VerCmpString(unittest.TestCase):
         result = bb.utils.explode_dep_versions2("foo ( =1.10 )")
         self.assertEqual(result, correctresult)
 
+    def test_vercmp_string_op(self):
+        compareops = [('1', '1', '=', True),
+                      ('1', '1', '==', True),
+                      ('1', '1', '!=', False),
+                      ('1', '1', '>', False),
+                      ('1', '1', '<', False),
+                      ('1', '1', '>=', True),
+                      ('1', '1', '<=', True),
+                      ('1', '0', '=', False),
+                      ('1', '0', '==', False),
+                      ('1', '0', '!=', True),
+                      ('1', '0', '>', True),
+                      ('1', '0', '<', False),
+                      ('1', '0', '>>', True),
+                      ('1', '0', '<<', False),
+                      ('1', '0', '>=', True),
+                      ('1', '0', '<=', False),
+                      ('0', '1', '=', False),
+                      ('0', '1', '==', False),
+                      ('0', '1', '!=', True),
+                      ('0', '1', '>', False),
+                      ('0', '1', '<', True),
+                      ('0', '1', '>>', False),
+                      ('0', '1', '<<', True),
+                      ('0', '1', '>=', False),
+                      ('0', '1', '<=', True)]
+
+        for arg1, arg2, op, correctresult in compareops:
+            result = bb.utils.vercmp_string_op(arg1, arg2, op)
+            self.assertEqual(result, correctresult, 'vercmp_string_op("%s", "%s", "%s") != %s' % (arg1, arg2, op, correctresult))
+
+        # Check that clearly invalid operator raises an exception
+        self.assertRaises(bb.utils.VersionStringException, bb.utils.vercmp_string_op, '0', '0', '$')
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 7ba1234..5ac9bcf 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -131,6 +131,28 @@ def vercmp_string(a, b):
     tb = split_version(b)
     return vercmp(ta, tb)
 
+def vercmp_string_op(a, b, op):
+    """
+    Compare two versions and check if the specified comparison operator matches the result of the comparison.
+    This function is fairly liberal about what operators it will accept since there are a variety of styles
+    depending on the context.
+    """
+    res = vercmp_string(a, b)
+    if op in ('=', '=='):
+        return res == 0
+    elif op == '<=':
+        return res <= 0
+    elif op == '>=':
+        return res >= 0
+    elif op in ('>', '>>'):
+        return res > 0
+    elif op in ('<', '<<'):
+        return res < 0
+    elif op == '!=':
+        return res != 0
+    else:
+        raise VersionStringException('Unsupported comparison operator "%s"' % op)
+
 def explode_deps(s):
     """
     Take an RDEPENDS style string of format:
-- 
1.9.3


