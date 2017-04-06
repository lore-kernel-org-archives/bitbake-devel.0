Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 7A2A677CFA
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 21:53:08 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga104.jf.intel.com with ESMTP; 06 Apr 2017 14:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,161,1488873600"; d="scan'208";a="1116565915"
Received: from anatara2-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.141.179])
	by orsmga001.jf.intel.com with ESMTP; 06 Apr 2017 14:53:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Apr 2017 09:52:09 +1200
Message-Id: <9a743ad396af642fc20961e38fb7f6c5752f2446.1491514854.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491514854.git.paul.eggleton@linux.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 09/11] lib/bb/siggen: add collapsed mode to compare_sigfiles()
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
X-List-Received-Date: Thu, 06 Apr 2017 21:53:08 -0000

If we just want to drill down to the actual differences then we don't
need to see certain things in the output, e.g. basehash changing or the
signature of dependent tasks. This will be used for comparing signatures
within buildhistory-diff in OE-Core; the default mode as used by
bitbake-diffsigs and bitbake -S printdiff remains unchanged for the
moment.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 51 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index c6b14c2..3c5d862 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -375,7 +375,7 @@ def clean_basepaths_list(a):
         b.append(clean_basepath(x))
     return b
 
-def compare_sigfiles(a, b, recursecb = None):
+def compare_sigfiles(a, b, recursecb=None, collapsed=False):
     output = []
 
     with open(a, 'rb') as f:
@@ -443,7 +443,7 @@ def compare_sigfiles(a, b, recursecb = None):
     if a_data['taskdeps'] != b_data['taskdeps']:
         output.append("Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps'])))
 
-    if a_data['basehash'] != b_data['basehash']:
+    if a_data['basehash'] != b_data['basehash'] and not collapsed:
         output.append("basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash']))
 
     changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
@@ -495,24 +495,25 @@ def compare_sigfiles(a, b, recursecb = None):
     if not 'runtaskdeps' in b_data:
          b_data['runtaskdeps'] = {}
 
-    if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
-        changed = ["Number of task dependencies changed"]
-    else:
-        changed = []
-        for idx, task in enumerate(a_data['runtaskdeps']):
-            a = a_data['runtaskdeps'][idx]
-            b = b_data['runtaskdeps'][idx]
-            if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b]:
-                changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
-
-    if changed:
-        clean_a = clean_basepaths_list(a_data['runtaskdeps'])
-        clean_b = clean_basepaths_list(b_data['runtaskdeps'])
-        if clean_a != clean_b:
-            output.append("runtaskdeps changed from %s to %s" % (clean_a, clean_b))
+    if not collapsed:
+        if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
+            changed = ["Number of task dependencies changed"]
         else:
-            output.append("runtaskdeps changed:")
-        output.append("\n".join(changed))
+            changed = []
+            for idx, task in enumerate(a_data['runtaskdeps']):
+                a = a_data['runtaskdeps'][idx]
+                b = b_data['runtaskdeps'][idx]
+                if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b]:
+                    changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
+
+        if changed:
+            clean_a = clean_basepaths_list(a_data['runtaskdeps'])
+            clean_b = clean_basepaths_list(b_data['runtaskdeps'])
+            if clean_a != clean_b:
+                output.append("runtaskdeps changed from %s to %s" % (clean_a, clean_b))
+            else:
+                output.append("runtaskdeps changed:")
+            output.append("\n".join(changed))
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
         a = a_data['runtaskhashes']
@@ -540,13 +541,17 @@ def compare_sigfiles(a, b, recursecb = None):
                     output.append("Dependency on task %s was removed with hash %s" % (clean_basepath(dep), a[dep]))
         if changed:
             for dep in changed:
-                output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))
+                if not collapsed:
+                    output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))
                 if callable(recursecb):
-                    # If a dependent hash changed, might as well print the line above and then defer to the changes in 
-                    # that hash since in all likelyhood, they're the same changes this task also saw.
                     recout = recursecb(dep, a[dep], b[dep])
                     if recout:
-                        output = [output[-1]] + recout
+                        if collapsed:
+                            output.extend(recout)
+                        else:
+                            # If a dependent hash changed, might as well print the line above and then defer to the changes in 
+                            # that hash since in all likelyhood, they're the same changes this task also saw.
+                            output = [output[-1]] + recout
 
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
-- 
2.9.3


