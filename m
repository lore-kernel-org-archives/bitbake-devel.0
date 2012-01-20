Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHn5-0004Eb-1L
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:58:16 +0100
Received: by opal (Postfix, from userid 111)
	id 7DF6510335; Fri, 20 Jan 2012 16:50:58 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120165058.7DF6510335@opal>
Date: Fri, 20 Jan 2012 16:50:58 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : siggen: Ensure correct runtask dependency output is shown for diffsigs
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
X-List-Received-Date: Fri, 20 Jan 2012 16:58:16 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 7da7dff83ed765c9cde1d7f91ee1b65e49520481
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=7da7dff83ed765c9cde1d7f91ee1b65e49520481

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Jan 19 19:37:29 2012 +0000

siggen: Ensure correct runtask dependency output is shown for diffsigs

The actual task names are discounted for comparison of dependent tasks, only
the actual hashes are used. This updates the comparison code to account for
this change, attempting heuristic matching for more user friendly output but
falling back to showing the changed hashes directly. This avoids some confusing
output to users where it looked like tasks had changed when they had not and
actually had the same hash but a different taskname.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 22417b9..d9d0294 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -281,21 +281,27 @@ def compare_sigfiles(a, b):
             print "Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep])
 
     if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        a = clean_basepaths(a_data['runtaskhashes'])
-        b = clean_basepaths(b_data['runtaskhashes'])
-        changed, added, removed = dict_diff(a, b)
-        if added:
-            for dep in added:
-                print "Dependency on task %s was added" % (dep)
-        if removed:
-            for dep in removed:
-                print "Dependency on task %s was removed" % (dep)
-        if changed:
-            for dep in changed:
-                print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
-    elif 'runtaskdeps' in a_data and 'runtaskdeps' in b_data and sorted(a_data['runtaskdeps']) != sorted(b_data['runtaskdeps']):
-        print "Tasks this task depends on changed from %s to %s" % (sorted(a_data['runtaskdeps']), sorted(b_data['runtaskdeps']))
-        print "changed items: %s" % a_data['runtaskdeps'].symmetric_difference(b_data['runtaskdeps'])
+        if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
+            a = clean_basepaths(a_data['runtaskhashes'])
+            b = clean_basepaths(b_data['runtaskhashes'])
+            changed, added, removed = dict_diff(a, b)
+            if added:
+                for dep in added:
+                    print "Dependency on task %s was added" % (dep)
+            if removed:
+                for dep in removed:
+                    print "Dependency on task %s was removed" % (dep)
+            if changed:
+                for dep in changed:
+                    print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
+        else:
+            for i in range(len(a_data['runtaskdeps'])):
+                aent = a_data['runtaskdeps'][i]
+                bent = b_data['runtaskdeps'][i]
+                aname = clean_basepath(aent)
+                bname = clean_basepath(bent)
+                if a_data['runtaskhashes'][aent] != b_data['runtaskhashes'][bent]:
+                    print "Task dependency hash changed from %s to %s (for %s and %s)" % (a_data['runtaskhashes'][aent], b_data['runtaskhashes'][bent], aname, bname)
 
 def dump_sigfile(a):
     p1 = pickle.Unpickler(file(a, "rb"))



