Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T66Mp-0000sX-VP
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Aug 2012 22:57:04 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 27 Aug 2012 13:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,322,1344236400"; d="scan'208";a="191985312"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.136])
	by orsmga002.jf.intel.com with ESMTP; 27 Aug 2012 13:44:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Aug 2012 21:44:35 +0100
Message-Id: <1f11cc13ad436af9e66a68ee0a1f87f76b7a94de.1346099795.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/5] bitbake-diffsigs: allow specifying task & follow deps recursively
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 27 Aug 2012 20:57:04 -0000

Add the ability to compare the two most recent runs of a specified task,
and follow dependent hash changes recursively. This enables you to trace
back and find exactly why a task was re-run after the fact.

Note that this relies on the metadata providing a function, hooked in
as bb.siggen.find_siginfo, which allows searching in the appropriate
places to find signature data files.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-diffsigs |   97 +++++++++++++++++++++++++++++++++++++++---
 bitbake/lib/bb/siggen.py     |   17 +++++---
 2 files changed, 102 insertions(+), 12 deletions(-)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 146cab8..62f6827 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -1,15 +1,102 @@
 #!/usr/bin/env python
+
+# bitbake-diffsigs
+# BitBake task signature data comparison utility
+#
+# Copyright (C) 2012 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
 import os
 import sys
 import warnings
+import fnmatch
+import optparse
+import logging
+
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
 
+import bb.tinfoil
 import bb.siggen
 
-if len(sys.argv) > 2:
-    output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
+logger = logging.getLogger('BitBake')
+
+def find_compare_task(bbhandler, pn, taskname):
+    """ Find the most recent signature files for the specified PN/task and compare them """
+
+    if not hasattr(bb.siggen, 'find_siginfo'):
+        logger.error('Metadata does not support finding signature data files')
+        sys.exit(1)
+
+    filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
+    latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-2:]
+    if not latestfiles:
+        logger.error('No sigdata files found matching %s %s' % (pn, taskname))
+        sys.exit(1)
+    elif len(latestfiles) < 2:
+        logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (pn, taskname))
+        sys.exit(1)
+    else:
+        # Define recursion callback
+        def recursecb(key, hash1, hash2):
+            hashes = [hash1, hash2]
+            hashfiles = bb.siggen.find_siginfo(key, None, hashes, bbhandler.config_data)
+
+            recout = []
+            if len(hashfiles) == 2:
+                out2 = bb.siggen.compare_sigfiles(hashfiles[hash1], hashfiles[hash2], recursecb)
+                recout.extend(list('  ' + l for l in out2))
+            else:
+                recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
+
+            return recout
+
+        # Recurse into signature comparison
+        output = bb.siggen.compare_sigfiles(latestfiles[0], latestfiles[1], recursecb)
+        if output:
+            print '\n'.join(output)
+    sys.exit(0)
+
+
+
+parser = optparse.OptionParser(
+    usage = """
+  %prog -t recipename taskname
+  %prog sigdatafile1 sigdatafile2
+  %prog sigdatafile1""")
+
+parser.add_option("-t", "--task",
+        help = "find the signature data files for last two runs of the specified task and compare them",
+        action="store_true", dest="taskmode")
+
+options, args = parser.parse_args(sys.argv)
+
+if len(args) == 1:
+    parser.print_help()
 else:
-    output = bb.siggen.dump_sigfile(sys.argv[1])
+    tinfoil = bb.tinfoil.Tinfoil()
+    if options.taskmode:
+        if len(args) < 3:
+            logger.error("Please specify a recipe and task name")
+            sys.exit(1)
+        tinfoil.prepare(config_only = True)
+        find_compare_task(tinfoil, args[1], args[2])
+    else:
+        if len(args) == 2:
+            output = bb.siggen.dump_sigfile(sys.argv[1])
+        else:
+            output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
 
-if output:
-    print '\n'.join(output)
+        if output:
+            print '\n'.join(output)
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 8d1501b..8fe59b9 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -301,7 +301,7 @@ def clean_basepaths(a):
         b[clean_basepath(x)] = a[x]
     return b
 
-def compare_sigfiles(a, b):
+def compare_sigfiles(a, b, recursecb = None):
     output = []
 
     p1 = pickle.Unpickler(open(a, "rb"))
@@ -369,8 +369,8 @@ def compare_sigfiles(a, b):
 
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        a = clean_basepaths(a_data['runtaskhashes'])
-        b = clean_basepaths(b_data['runtaskhashes'])
+        a = a_data['runtaskhashes']
+        b = b_data['runtaskhashes']
         changed, added, removed = dict_diff(a, b)
         if added:
             for dep in added:
@@ -381,7 +381,7 @@ def compare_sigfiles(a, b):
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (dep, bdep))
                             bdep_found = True
                 if not bdep_found:
-                    output.append("Dependency on task %s was added with hash %s" % (dep, a[dep]))
+                    output.append("Dependency on task %s was added with hash %s" % (clean_basepath(dep), a[dep]))
         if removed:
             for dep in removed:
                 adep_found = False
@@ -391,11 +391,14 @@ def compare_sigfiles(a, b):
                             #output.append("Dependency on task %s was replaced by %s with same hash" % (adep, dep))
                             adep_found = True
                 if not adep_found:
-                    output.append("Dependency on task %s was removed with hash %s" % (dep, b[dep]))
+                    output.append("Dependency on task %s was removed with hash %s" % (clean_basepath(dep), b[dep]))
         if changed:
             for dep in changed:
-                output.append("Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep]))
-
+                output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))
+                if callable(recursecb):
+                    recout = recursecb(dep, a[dep], b[dep])
+                    if recout:
+                        output.extend(recout)
 
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
-- 
1.7.9.5



