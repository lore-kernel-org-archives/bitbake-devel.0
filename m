Return-Path: <mike.looijmans@topic.nl>
Received: from atl4mhfb03.myregisteredsite.com
	(atl4mhfb03.myregisteredsite.com [209.17.115.119])
	by mail.openembedded.org (Postfix) with ESMTP id DD5DA731C9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 06:54:09 +0000 (UTC)
Received: from atl4mhob07.myregisteredsite.com
	(atl4mhob07.myregisteredsite.com [209.17.115.45])
	by atl4mhfb03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
	u7N6lJ5a002368 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 02:47:19 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.205])
	by atl4mhob07.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
	u7N6lBs7028343 for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 02:47:11 -0400
Received: (qmail 18435 invoked by uid 0); 23 Aug 2016 06:40:31 -0000
X-TCPREMOTEIP: 37.74.225.130
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL)
	(mike@milosoftware.com@37.74.225.130)
	by 0 with ESMTPA; 23 Aug 2016 06:40:31 -0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Aug 2016 08:40:27 +0200
Message-Id: <1471934427-16959-1-git-send-email-mike.looijmans@topic.nl>
X-Mailer: git-send-email 1.9.1
X-Mailman-Approved-At: Wed, 31 Aug 2016 14:36:36 +0000
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] lib/bb/siggen.py: Prevent ResourceWarning exceptions
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
X-List-Received-Date: Tue, 23 Aug 2016 06:54:10 -0000

Add a "with" statement to explicitly close files. This prevents hundreds of
"ResourceWarning: unclosed file" outputs.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 lib/bb/siggen.py | 309 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 155 insertions(+), 154 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index db3daef..467e07a 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -363,167 +363,168 @@ def clean_basepaths_list(a):
 def compare_sigfiles(a, b, recursecb = None):
     output = []
 
-    p1 = pickle.Unpickler(open(a, "rb"))
-    a_data = p1.load()
-    p2 = pickle.Unpickler(open(b, "rb"))
-    b_data = p2.load()
-
-    def dict_diff(a, b, whitelist=set()):
-        sa = set(a.keys())
-        sb = set(b.keys())
-        common = sa & sb
-        changed = set()
-        for i in common:
-            if a[i] != b[i] and i not in whitelist:
-                changed.add(i)
-        added = sb - sa
-        removed = sa - sb
-        return changed, added, removed
-
-    def file_checksums_diff(a, b):
-        from collections import Counter
-        # Handle old siginfo format
-        if isinstance(a, dict):
-            a = [(os.path.basename(f), cs) for f, cs in a.items()]
-        if isinstance(b, dict):
-            b = [(os.path.basename(f), cs) for f, cs in b.items()]
-        # Compare lists, ensuring we can handle duplicate filenames if they exist
-        removedcount = Counter(a)
-        removedcount.subtract(b)
-        addedcount = Counter(b)
-        addedcount.subtract(a)
-        added = []
-        for x in b:
-            if addedcount[x] > 0:
-                addedcount[x] -= 1
-                added.append(x)
-        removed = []
-        changed = []
-        for x in a:
-            if removedcount[x] > 0:
-                removedcount[x] -= 1
-                for y in added:
-                    if y[0] == x[0]:
-                        changed.append((x[0], x[1], y[1]))
-                        added.remove(y)
-                        break
-                else:
-                    removed.append(x)
-        added = [x[0] for x in added]
-        removed = [x[0] for x in removed]
-        return changed, added, removed
-
-    if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
-        output.append("basewhitelist changed from '%s' to '%s'" % (a_data['basewhitelist'], b_data['basewhitelist']))
-        if a_data['basewhitelist'] and b_data['basewhitelist']:
-            output.append("changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist']))
-
-    if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
-        output.append("taskwhitelist changed from '%s' to '%s'" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
-        if a_data['taskwhitelist'] and b_data['taskwhitelist']:
-            output.append("changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist']))
-
-    if a_data['taskdeps'] != b_data['taskdeps']:
-        output.append("Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps'])))
-
-    if a_data['basehash'] != b_data['basehash']:
-        output.append("basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash']))
-
-    changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
-    if changed:
-        for dep in changed:
-            output.append("List of dependencies for variable %s changed from '%s' to '%s'" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
-            if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
-                output.append("changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep]))
-    if added:
-        for dep in added:
-            output.append("Dependency on variable %s was added" % (dep))
-    if removed:
-        for dep in removed:
-            output.append("Dependency on Variable %s was removed" % (dep))
-
-
-    changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
-    if changed:
-        for dep in changed:
-            output.append("Variable %s value changed from '%s' to '%s'" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
-
-    if not 'file_checksum_values' in a_data:
-         a_data['file_checksum_values'] = {}
-    if not 'file_checksum_values' in b_data:
-         b_data['file_checksum_values'] = {}
-
-    changed, added, removed = file_checksums_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
-    if changed:
-        for f, old, new in changed:
-            output.append("Checksum for file %s changed from %s to %s" % (f, old, new))
-    if added:
-        for f in added:
-            output.append("Dependency on checksum of file %s was added" % (f))
-    if removed:
-        for f in removed:
-            output.append("Dependency on checksum of file %s was removed" % (f))
-
-    if not 'runtaskdeps' in a_data:
-         a_data['runtaskdeps'] = {}
-    if not 'runtaskdeps' in b_data:
-         b_data['runtaskdeps'] = {}
-
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
-        output.append("runtaskdeps changed from %s to %s" % (clean_basepaths_list(a_data['runtaskdeps']), clean_basepaths_list(b_data['runtaskdeps'])))
-        output.append("\n".join(changed))
-
-
-    if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
-        a = a_data['runtaskhashes']
-        b = b_data['runtaskhashes']
-        changed, added, removed = dict_diff(a, b)
+    with open(a, "rb") as file_a, open(b, "rb") as file_b:
+        p1 = pickle.Unpickler(file_a)
+        a_data = p1.load()
+        p2 = pickle.Unpickler(file_b)
+        b_data = p2.load()
+
+        def dict_diff(a, b, whitelist=set()):
+            sa = set(a.keys())
+            sb = set(b.keys())
+            common = sa & sb
+            changed = set()
+            for i in common:
+                if a[i] != b[i] and i not in whitelist:
+                    changed.add(i)
+            added = sb - sa
+            removed = sa - sb
+            return changed, added, removed
+
+        def file_checksums_diff(a, b):
+            from collections import Counter
+            # Handle old siginfo format
+            if isinstance(a, dict):
+                a = [(os.path.basename(f), cs) for f, cs in a.items()]
+            if isinstance(b, dict):
+                b = [(os.path.basename(f), cs) for f, cs in b.items()]
+            # Compare lists, ensuring we can handle duplicate filenames if they exist
+            removedcount = Counter(a)
+            removedcount.subtract(b)
+            addedcount = Counter(b)
+            addedcount.subtract(a)
+            added = []
+            for x in b:
+                if addedcount[x] > 0:
+                    addedcount[x] -= 1
+                    added.append(x)
+            removed = []
+            changed = []
+            for x in a:
+                if removedcount[x] > 0:
+                    removedcount[x] -= 1
+                    for y in added:
+                        if y[0] == x[0]:
+                            changed.append((x[0], x[1], y[1]))
+                            added.remove(y)
+                            break
+                    else:
+                        removed.append(x)
+            added = [x[0] for x in added]
+            removed = [x[0] for x in removed]
+            return changed, added, removed
+
+        if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
+            output.append("basewhitelist changed from '%s' to '%s'" % (a_data['basewhitelist'], b_data['basewhitelist']))
+            if a_data['basewhitelist'] and b_data['basewhitelist']:
+                output.append("changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist']))
+
+        if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
+            output.append("taskwhitelist changed from '%s' to '%s'" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
+            if a_data['taskwhitelist'] and b_data['taskwhitelist']:
+                output.append("changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist']))
+
+        if a_data['taskdeps'] != b_data['taskdeps']:
+            output.append("Task dependencies changed from:\n%s\nto:\n%s" % (sorted(a_data['taskdeps']), sorted(b_data['taskdeps'])))
+
+        if a_data['basehash'] != b_data['basehash']:
+            output.append("basehash changed from %s to %s" % (a_data['basehash'], b_data['basehash']))
+
+        changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
+        if changed:
+            for dep in changed:
+                output.append("List of dependencies for variable %s changed from '%s' to '%s'" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
+                if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
+                    output.append("changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep]))
         if added:
             for dep in added:
-                bdep_found = False
-                if removed:
-                    for bdep in removed:
-                        if b[dep] == a[bdep]:
-                            #output.append("Dependency on task %s was replaced by %s with same hash" % (dep, bdep))
-                            bdep_found = True
-                if not bdep_found:
-                    output.append("Dependency on task %s was added with hash %s" % (clean_basepath(dep), b[dep]))
+                output.append("Dependency on variable %s was added" % (dep))
         if removed:
             for dep in removed:
-                adep_found = False
-                if added:
-                    for adep in added:
-                        if b[adep] == a[dep]:
-                            #output.append("Dependency on task %s was replaced by %s with same hash" % (adep, dep))
-                            adep_found = True
-                if not adep_found:
-                    output.append("Dependency on task %s was removed with hash %s" % (clean_basepath(dep), a[dep]))
+                output.append("Dependency on Variable %s was removed" % (dep))
+
+
+        changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
         if changed:
             for dep in changed:
-                output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))
-                if callable(recursecb):
-                    # If a dependent hash changed, might as well print the line above and then defer to the changes in 
-                    # that hash since in all likelyhood, they're the same changes this task also saw.
-                    recout = recursecb(dep, a[dep], b[dep])
-                    if recout:
-                        output = [output[-1]] + recout
-
-    a_taint = a_data.get('taint', None)
-    b_taint = b_data.get('taint', None)
-    if a_taint != b_taint:
-        output.append("Taint (by forced/invalidated task) changed from %s to %s" % (a_taint, b_taint))
+                output.append("Variable %s value changed from '%s' to '%s'" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
 
-    return output
+        if not 'file_checksum_values' in a_data:
+             a_data['file_checksum_values'] = {}
+        if not 'file_checksum_values' in b_data:
+             b_data['file_checksum_values'] = {}
+
+        changed, added, removed = file_checksums_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
+        if changed:
+            for f, old, new in changed:
+                output.append("Checksum for file %s changed from %s to %s" % (f, old, new))
+        if added:
+            for f in added:
+                output.append("Dependency on checksum of file %s was added" % (f))
+        if removed:
+            for f in removed:
+                output.append("Dependency on checksum of file %s was removed" % (f))
+
+        if not 'runtaskdeps' in a_data:
+             a_data['runtaskdeps'] = {}
+        if not 'runtaskdeps' in b_data:
+             b_data['runtaskdeps'] = {}
+
+        if len(a_data['runtaskdeps']) != len(b_data['runtaskdeps']):
+            changed = ["Number of task dependencies changed"]
+        else:
+            changed = []
+            for idx, task in enumerate(a_data['runtaskdeps']):
+                a = a_data['runtaskdeps'][idx]
+                b = b_data['runtaskdeps'][idx]
+                if a_data['runtaskhashes'][a] != b_data['runtaskhashes'][b]:
+                    changed.append("%s with hash %s\n changed to\n%s with hash %s" % (a, a_data['runtaskhashes'][a], b, b_data['runtaskhashes'][b]))
+
+        if changed:
+            output.append("runtaskdeps changed from %s to %s" % (clean_basepaths_list(a_data['runtaskdeps']), clean_basepaths_list(b_data['runtaskdeps'])))
+            output.append("\n".join(changed))
+
+
+        if 'runtaskhashes' in a_data and 'runtaskhashes' in b_data:
+            a = a_data['runtaskhashes']
+            b = b_data['runtaskhashes']
+            changed, added, removed = dict_diff(a, b)
+            if added:
+                for dep in added:
+                    bdep_found = False
+                    if removed:
+                        for bdep in removed:
+                            if b[dep] == a[bdep]:
+                                #output.append("Dependency on task %s was replaced by %s with same hash" % (dep, bdep))
+                                bdep_found = True
+                    if not bdep_found:
+                        output.append("Dependency on task %s was added with hash %s" % (clean_basepath(dep), b[dep]))
+            if removed:
+                for dep in removed:
+                    adep_found = False
+                    if added:
+                        for adep in added:
+                            if b[adep] == a[dep]:
+                                #output.append("Dependency on task %s was replaced by %s with same hash" % (adep, dep))
+                                adep_found = True
+                    if not adep_found:
+                        output.append("Dependency on task %s was removed with hash %s" % (clean_basepath(dep), a[dep]))
+            if changed:
+                for dep in changed:
+                    output.append("Hash for dependent task %s changed from %s to %s" % (clean_basepath(dep), a[dep], b[dep]))
+                    if callable(recursecb):
+                        # If a dependent hash changed, might as well print the line above and then defer to the changes in 
+                        # that hash since in all likelyhood, they're the same changes this task also saw.
+                        recout = recursecb(dep, a[dep], b[dep])
+                        if recout:
+                            output = [output[-1]] + recout
+
+        a_taint = a_data.get('taint', None)
+        b_taint = b_data.get('taint', None)
+        if a_taint != b_taint:
+            output.append("Taint (by forced/invalidated task) changed from %s to %s" % (a_taint, b_taint))
+
+        return output
 
 
 def calc_basehash(sigdata):
-- 
1.9.1


