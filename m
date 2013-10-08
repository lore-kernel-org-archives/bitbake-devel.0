Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A36F66CE9C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Oct 2013 14:38:31 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 08 Oct 2013 07:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1056,1371106800"; d="scan'208";a="407472798"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.174])
	by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2013 07:38:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Oct 2013 15:34:32 +0100
Message-Id: <1381242872-22015-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] siggen: handle recipe path changes in siginfo files
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
X-List-Received-Date: Tue, 08 Oct 2013 14:38:31 -0000

Avoid storing paths to files in SRC_URI when writing out the the
file checksums to siginfo files. This prevents a move of the source
directory being reported by bitbake-diffsigs as files being removed and
then added (the signature itself is not affected since the file paths
have never been included in the signature).

This has required the format of the file checksums in the siginfo file
to be changed from a dict to a list of tuples (in order to handle
multiple files with the same name under different paths, which is
uncommon but possible); the code remains backwards-compatible with older
siginfo files that use a dict however.

Fixes [YOCTO #5245].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index c15ba28..52e698c 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -224,7 +224,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
         if runtime and k in self.taskhash:
             data['runtaskdeps'] = self.runtaskdeps[k]
-            data['file_checksum_values'] = self.file_checksum_values[k]
+            data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k].items()]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.taskhash[dep]
@@ -322,6 +322,39 @@ def compare_sigfiles(a, b, recursecb = None):
         removed = sb - sa
         return changed, added, removed
 
+    def file_checksums_diff(a, b):
+        from collections import Counter
+        # Handle old siginfo format
+        if isinstance(a, dict):
+            a = [(os.path.basename(f), cs) for f, cs in a.items()]
+        if isinstance(b, dict):
+            b = [(os.path.basename(f), cs) for f, cs in b.items()]
+        # Compare lists, ensuring we can handle duplicate filenames if they exist
+        removedcount = Counter(a)
+        removedcount.subtract(b)
+        addedcount = Counter(b)
+        addedcount.subtract(a)
+        added = []
+        for x in b:
+            if addedcount[x] > 0:
+                addedcount[x] -= 1
+                added.append(x)
+        removed = []
+        changed = []
+        for x in a:
+            if removedcount[x] > 0:
+                removedcount[x] -= 1
+                for y in added:
+                    if y[0] == x[0]:
+                        changed.append((x[0], x[1], y[1]))
+                        added.remove(y)
+                        break
+                else:
+                    removed.append(x)
+        added = [x[0] for x in added]
+        removed = [x[0] for x in removed]
+        return changed, added, removed
+
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
         output.append("basewhitelist changed from '%s' to '%s'" % (a_data['basewhitelist'], b_data['basewhitelist']))
         if a_data['basewhitelist'] and b_data['basewhitelist']:
@@ -357,10 +390,10 @@ def compare_sigfiles(a, b, recursecb = None):
         for dep in changed:
             output.append("Variable %s value changed from '%s' to '%s'" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
 
-    changed, added, removed = dict_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
+    changed, added, removed = file_checksums_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
     if changed:
-        for f in changed:
-            output.append("Checksum for file %s changed from %s to %s" % (f, a_data['file_checksum_values'][f], b_data['file_checksum_values'][f]))
+        for f, old, new in changed:
+            output.append("Checksum for file %s changed from %s to %s" % (f, old, new))
     if added:
         for f in added:
             output.append("Dependency on checksum of file %s was added" % (f))
-- 
1.8.1.2


