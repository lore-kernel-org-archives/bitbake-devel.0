Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5D932605D0;
	Thu, 29 Jan 2015 13:50:15 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Jan 2015 05:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,486,1418112000"; d="scan'208";a="644478599"
Received: from jamiewei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.23.125])
	by orsmga001.jf.intel.com with ESMTP; 29 Jan 2015 05:50:16 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Jan 2015 13:49:52 +0000
Message-Id: <e1f6bd9ed8e0a1b89277af10e0d9af17ec8efd86.1422539142.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1422539142.git.paul.eggleton@linux.intel.com>
References: <cover.1422539142.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1422539142.git.paul.eggleton@linux.intel.com>
References: <cover.1422539142.git.paul.eggleton@linux.intel.com>
Cc: openembedded-core@lists.openembedded.org
Subject: [RFC bitbake][RFC PATCH 1/1] cooker: rework LAYERDEPENDS versioning so that it is actually useful
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
X-List-Received-Date: Thu, 29 Jan 2015 13:50:23 -0000

We've had versioned dependency support in LAYERDEPENDS for quite a long
time, but I can say with pretty good certainty that almost nobody has
used it because it was too strict - the specified version had to exactly
match the version in your configuration or you would get an error; there
was no "greater than or equal" option, which is usually what you will
want given that LAYERVERSION does get bumped.

However, users mismatching layer branches and then having their builds
fail later on with some incomprehensible error is still a pretty common
problem. To address this, I have reworked LAYERDEPENDS version
specifications to use the more familiar "dependency (>= version)" syntax
as used with package dependencies, support non-integer versions, and
clarified the error message a little. If we then take care to bump the
version on every breaking change, it is at least possible to have layers
depend on these changes when they update to match; we can now even
support a major.minor scheme to allow retrospectively adding a version
limiter to old branches when a new branch is created and yet still allow
the old branch minor version to be bumped if needed.

Fixes [YOCTO #5991].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 36 +++++++++---------------------------
 lib/bb/utils.py  | 22 ++++++++++++++++++++++
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f77c6c0..87c6385 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1094,44 +1094,26 @@ class BBCooker:
                     collection_priorities[c] = None
 
                 # Check dependencies and store information for priority calculation
+                dep_re = re.compile('([<>=]*)([0-9]+)')
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
+                    deplist = bb.utils.explode_dep_versions2(deps)
+                    for dep, oplist in deplist.iteritems():
                         if dep in collection_list:
-                            if depver:
+                            for opstr in oplist:
                                 layerver = self.data.getVar("LAYERVERSION_%s" % dep, True)
+                                (op, depver) = opstr.split()
                                 if layerver:
-                                    try:
-                                        lver = int(layerver)
-                                    except ValueError:
-                                        parselog.error("invalid value for LAYERVERSION_%s: \"%s\"", c, layerver)
-                                        errors = True
-                                        continue
-                                    if lver != depver:
-                                        parselog.error("Layer '%s' depends on version %d of layer '%s', but version %d is enabled in your configuration", c, depver, dep, lver)
+                                    if not bb.utils.vercmp_string_op(layerver, depver, op):
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
 
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 90090b2..4ad23c9 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -128,6 +128,28 @@ def vercmp_string(a, b):
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
+        raise Exception('vercmp_string_op: unsupported operation %s' % op)
+
 def explode_deps(s):
     """
     Take an RDEPENDS style string of format:
-- 
1.9.3


