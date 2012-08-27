Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T66Mp-0000sM-Ks
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Aug 2012 22:57:04 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 27 Aug 2012 13:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,322,1344236400"; d="scan'208";a="191985311"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.136])
	by orsmga002.jf.intel.com with ESMTP; 27 Aug 2012 13:44:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Aug 2012 21:44:34 +0100
Message-Id: <f518f5682d11a1fe41525e7debcf40c4afa871f3.1346099795.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1346099795.git.paul.eggleton@linux.intel.com>
References: <cover.1346099795.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/5] lib/bb/siggen.py: make signature dump/compare functions return a list
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

These functions become a little bit more reusable if they return a list
containing the output rather than just printing it.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-diffsigs |    7 +++--
 bitbake/bin/bitbake-dumpsig  |    4 ++-
 bitbake/lib/bb/siggen.py     |   68 +++++++++++++++++++++++-------------------
 3 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
index 5eb77ce..146cab8 100755
--- a/bitbake/bin/bitbake-diffsigs
+++ b/bitbake/bin/bitbake-diffsigs
@@ -7,6 +7,9 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
 import bb.siggen
 
 if len(sys.argv) > 2:
-    bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
+    output = bb.siggen.compare_sigfiles(sys.argv[1], sys.argv[2])
 else:
-    bb.siggen.dump_sigfile(sys.argv[1])
+    output = bb.siggen.dump_sigfile(sys.argv[1])
+
+if output:
+    print '\n'.join(output)
diff --git a/bitbake/bin/bitbake-dumpsig b/bitbake/bin/bitbake-dumpsig
index 59740c8..ccbc412 100755
--- a/bitbake/bin/bitbake-dumpsig
+++ b/bitbake/bin/bitbake-dumpsig
@@ -6,4 +6,6 @@ sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), '
 
 import bb.siggen
 
-bb.siggen.dump_sigfile(sys.argv[1])
+output = bb.siggen.dump_sigfile(sys.argv[1])
+if output:
+    print '\n'.join(output)
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index d0a4d18..8d1501b 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -302,6 +302,8 @@ def clean_basepaths(a):
     return b
 
 def compare_sigfiles(a, b):
+    output = []
+
     p1 = pickle.Unpickler(open(a, "rb"))
     a_data = p1.load()
     p2 = pickle.Unpickler(open(b, "rb"))
@@ -320,50 +322,50 @@ def compare_sigfiles(a, b):
         return changed, added, removed
 
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
-        print "basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist'])
+        output.append("basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist']))
         if a_data['basewhitelist'] and b_data['basewhitelist']:
-            print "changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist'])
+            output.append("changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist']))
 
     if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
-        print "taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist'])
+        output.append("taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
         if a_data['taskwhitelist'] and b_data['taskwhitelist']:
-            print "changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist'])
+            output.append("changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist']))
 
     if a_data['taskdeps'] != b_data['taskdeps']:
-        print "Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
+        output.append("Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps'])))
 
     if a_data['basehash'] != b_data['basehash']:
-        print "basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash'])
+        output.append("basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash']))
 
     changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
     if changed:
         for dep in changed:
-            print "List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep])
+            output.append("List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
             if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
-                print "changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep])
+                output.append("changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep]))
     if added:
         for dep in added:
-            print "Dependency on variable %s was added" % (dep)
+            output.append("Dependency on variable %s was added" % (dep))
     if removed:
         for dep in removed:
-            print "Dependency on Variable %s was removed" % (dep)
+            output.append("Dependency on Variable %s was removed" % (dep))
 
 
     changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
     if changed:
         for dep in changed:
-            print "Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep])
+            output.append("Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
 
     changed, added, removed = dict_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
     if changed:
         for f in changed:
-            print "Checksum for file %s changed from %s to %s" % (f, a_data['file_checksum_values'][f], b_data['file_checksum_values'][f])
+            output.append("Checksum for file %s changed from %s to %s" % (f, a_data['file_checksum_values'][f], b_data['file_checksum_values'][f]))
     if added:
         for f in added:
-            print "Dependency on checksum of file %s was added" % (f)
+            output.append("Dependency on checksum of file %s was added" % (f))
     if removed:
         for f in removed:
-            print "Dependency on checksum of file %s was removed" % (f)
+            output.append("Dependency on checksum of file %s was removed" % (f))
 
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
@@ -376,58 +378,64 @@ def compare_sigfiles(a, b):
                 if removed:
                     for bdep in removed:
                         if a[dep] == b[bdep]:
-                            #print "Dependency on task %s was replaced by %s with same hash" % (dep, bdep)
+                            #output.append("Dependency on task %s was replaced by %s with same hash" % (dep, bdep))
                             bdep_found = True
                 if not bdep_found:
-                    print "Dependency on task %s was added with hash %s" % (dep, a[dep])
+                    output.append("Dependency on task %s was added with hash %s" % (dep, a[dep]))
         if removed:
             for dep in removed:
                 adep_found = False
                 if added:
                     for adep in added:
                         if a[adep] == b[dep]:
-                            #print "Dependency on task %s was replaced by %s with same hash" % (adep, dep)
+                            #output.append("Dependency on task %s was replaced by %s with same hash" % (adep, dep))
                             adep_found = True
                 if not adep_found:
-                    print "Dependency on task %s was removed with hash %s" % (dep, b[dep])
+                    output.append("Dependency on task %s was removed with hash %s" % (dep, b[dep]))
         if changed:
             for dep in changed:
-                print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
+                output.append("Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep]))
 
 
     a_taint = a_data.get('taint', None)
     b_taint = b_data.get('taint', None)
     if a_taint != b_taint:
-        print "Taint (by forced/invalidated task) changed from %s to %s" % (a_taint, b_taint)
+        output.append("Taint (by forced/invalidated task) changed from %s to %s" % (a_taint, b_taint))
+
+    return output
 
 
 def dump_sigfile(a):
+    output = []
+
     p1 = pickle.Unpickler(open(a, "rb"))
     a_data = p1.load()
 
-    print "basewhitelist: %s" % (a_data['basewhitelist'])
+    output.append("basewhitelist: %s" % (a_data['basewhitelist']))
 
-    print "taskwhitelist: %s" % (a_data['taskwhitelist'])
+    output.append("taskwhitelist: %s" % (a_data['taskwhitelist']))
 
-    print "Task dependencies: %s" % (sorted(a_data['taskdeps']))
+    output.append("Task dependencies: %s" % (sorted(a_data['taskdeps'])))
 
-    print "basehash: %s" % (a_data['basehash'])
+    output.append("basehash: %s" % (a_data['basehash']))
 
     for dep in a_data['gendeps']:
-        print "List of dependencies for variable %s is %s" % (dep, a_data['gendeps'][dep])
+        output.append("List of dependencies for variable %s is %s" % (dep, a_data['gendeps'][dep]))
 
     for dep in a_data['varvals']:
-        print "Variable %s value is %s" % (dep, a_data['varvals'][dep])
+        output.append("Variable %s value is %s" % (dep, a_data['varvals'][dep]))
 
     if 'runtaskdeps' in a_data:
-        print "Tasks this task depends on: %s" % (a_data['runtaskdeps'])
+        output.append("Tasks this task depends on: %s" % (a_data['runtaskdeps']))
 
     if 'file_checksum_values' in a_data:
-        print "This task depends on the checksums of files: %s" % (a_data['file_checksum_values'])
+        output.append("This task depends on the checksums of files: %s" % (a_data['file_checksum_values']))
 
     if 'runtaskhashes' in a_data:
         for dep in a_data['runtaskhashes']:
-            print "Hash for dependent task %s is %s" % (dep, a_data['runtaskhashes'][dep])
+            output.append("Hash for dependent task %s is %s" % (dep, a_data['runtaskhashes'][dep]))
 
     if 'taint' in a_data:
-        print "Tainted (by forced/invalidated task): %s" % a_data['taint']
+        output.append("Tainted (by forced/invalidated task): %s" % a_data['taint'])
+
+    return output
-- 
1.7.9.5



