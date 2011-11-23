Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RTH38-0002GG-EI
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 18:55:58 +0100
Received: by opal (Postfix, from userid 111)
	id 01A9A10331; Wed, 23 Nov 2011 17:51:49 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111123175149.01A9A10331@opal>
Date: Wed, 23 Nov 2011 17:51:49 +0000 (UTC)
From: git@git.openembedded.org
Subject: Matthew McClintock : siggen.py: sort task hash depedencies with basepath
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
X-List-Received-Date: Wed, 23 Nov 2011 17:55:58 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 9a2029899c946ce9aa8adbc85f2cfe7a85b92182
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=9a2029899c946ce9aa8adbc85f2cfe7a85b92182

Author: Matthew McClintock <msm@freescale.com>
Date:   Wed Nov 23 02:04:00 2011 -0600

siggen.py: sort task hash depedencies with basepath

Without this patch the tash hash dependencies can be in a order
that is dependent upon directory/filesystem layout. With this
change the data is sorted the same regardless.

Without this the dependent hashes could be in different orders
on different systems and consequently final md5 hash would differ
as well even though nothing else changed.

Signed-off-by: Matthew McClintock <msm@freescale.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 3eed664..9231291 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -136,7 +136,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         k = fn + "." + task
         data = dataCache.basetaskhash[k]
         self.runtaskdeps[k] = []
-        for dep in sorted(deps):
+        for dep in sorted(deps, key=clean_basepath):
             # We only manipulate the dependencies for packages not in the whitelist
             if self.twl and not self.twl.search(dataCache.pkg_fn[fn]):
                 # then process the actual dependencies
@@ -218,6 +218,19 @@ def dump_this_task(outfile, d):
     task = "do_" + d.getVar("BB_CURRENTTASK", True)
     bb.parse.siggen.dump_sigtask(fn, task, outfile, "customfile")
 
+def clean_basepath(a):
+    if a.startswith("virtual:"):
+        b = a.rsplit(":", 1)[0] + a.rsplit("/", 1)[1]
+    else:
+        b = a.rsplit("/", 1)[1]
+    return b
+
+def clean_basepaths(a):
+    b = {}
+    for x in a:
+        b[clean_basepath(x)] = a[x]
+    return b
+
 def compare_sigfiles(a, b):
     p1 = pickle.Unpickler(file(a, "rb"))
     a_data = p1.load()
@@ -236,16 +249,6 @@ def compare_sigfiles(a, b):
         removed = sb - sa
         return changed, added, removed
 
-    def clean_basepaths(a):
-        b = {}
-        for x in a:
-            if x.startswith("virtual:"):
-                y = x.rsplit(":", 1)[0] + x.rsplit("/", 1)[1]
-            else:
-                y = x.rsplit("/", 1)[1]
-            b[y] = a[x]
-        return b
-
     if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
         print "basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist'])
         print "changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist'])



