Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RRM2U-00044h-Be
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 Nov 2011 11:51:22 +0100
Received: by opal (Postfix, from userid 111)
	id D72041032F; Fri, 18 Nov 2011 10:46:38 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111118104638.D72041032F@opal>
Date: Fri, 18 Nov 2011 10:46:38 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : siggen.py: Fix diffsigs output for filename comparisions
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
X-List-Received-Date: Fri, 18 Nov 2011 10:51:22 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 165a22ddcc647b945707fb5c483146bb336d5f66
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=165a22ddcc647b945707fb5c483146bb336d5f66

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Nov 17 14:02:06 2011 +0000

siggen.py: Fix diffsigs output for filename comparisions

When comparing sig files, if the recipe locations had changed, the
dependent tasks list would show as changed even if the actual hash
had not changed. This updates the code to only compare the base part
of the pathnames.

It also tweaks some of the output to add newlines to aid comparing
two lists of variables as it makes the location of the difference
clearer.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 1225791..611772a 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -235,6 +235,16 @@ def compare_sigfiles(a, b):
         removed = sb - sa
         return changed, added, removed
 
+    def clean_basepaths(a):
+        b = {}
+        for x in a:
+            if x.startswith("virtual:"):
+                y = x.rsplit(":", 1)[0] + x.rsplit("/", 1)[1]
+            else:
+                y = x.rsplit("/", 1)[1]
+            b[y] = a[x]
+        return b
+
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
         print "basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist'])
 
@@ -242,7 +252,7 @@ def compare_sigfiles(a, b):
         print "taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist'])
 
     if a_data['taskdeps'] != b_data['taskdeps']:
-        print "Task dependencies changed from %s to %s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
+        print "Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps']))
 
     if a_data['basehash'] != b_data['basehash']:
         print "basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash'])
@@ -265,7 +275,9 @@ def compare_sigfiles(a, b):
             print "Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep])
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        changed, added, removed = dict_diff(a_data['runtaskhashes'], b_data['runtaskhashes'])
+        a = clean_basepaths(a_data['runtaskhashes'])
+        b = clean_basepaths(b_data['runtaskhashes'])
+        changed, added, removed = dict_diff(a, b)
         if added:
             for dep in added:
                 print "Dependency on task %s was added" % (dep)
@@ -274,7 +286,7 @@ def compare_sigfiles(a, b):
                 print "Dependency on task %s was removed" % (dep)
         if changed:
             for dep in changed:
-                print "Hash for dependent task %s changed from %s to %s" % (dep, a_data['runtaskhashes'][dep], b_data['runtaskhashes'][dep])
+                print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
     elif 'runtaskdeps' in a_data and 'runtaskdeps' in b_data and sorted(a_data['runtaskdeps']) != sorted(b_data['runtaskdeps']):
         print "Tasks this task depends on changed from %s to %s" % (sorted(a_data['runtaskdeps']), sorted(b_data['runtaskdeps']))
 



