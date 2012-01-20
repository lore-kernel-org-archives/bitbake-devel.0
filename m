Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHfE-0003yo-01
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:50:09 +0100
Received: by opal (Postfix, from userid 111)
	id 9741910339; Fri, 20 Jan 2012 16:51:57 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120165157.9741910339@opal>
Date: Fri, 20 Jan 2012 16:51:57 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : siggen.py: Abstract the runtime task dependency handling code in the generators
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
X-List-Received-Date: Fri, 20 Jan 2012 16:50:09 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 164195c068a656733cfe7aa07369c5ed6ea62ca5
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=164195c068a656733cfe7aa07369c5ed6ea62ca5

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Fri Jan 20 16:16:08 2012 +0000

siggen.py: Abstract the runtime task dependency handling code in the generators

This means that custom signature handlers can override specific parts
of the code without having to reimplement whole functions allowing them
more flexibility.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/siggen.py |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index d9d0294..f31d66a 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -62,9 +62,13 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.runtaskdeps = {}
         self.gendeps = {}
         self.lookupcache = {}
+        self.pkgnameextract = re.compile("(?P<fn>.*)\..*")
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST", True) or "").split())
-        self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST", True) or None
+        self.taskwhitelist = None
+        self.init_rundepcheck(data)
 
+    def init_rundepcheck(self, data):
+        self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST", True) or None
         if self.taskwhitelist:
             self.twl = re.compile(self.taskwhitelist)
         else:
@@ -131,17 +135,24 @@ class SignatureGeneratorBasic(SignatureGenerator):
         for task in taskdeps:
             d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task])
 
+    def rundep_check(self, fn, recipename, task, dep, depname):
+        # Return True if we should keep the dependency, False to drop it
+        # We only manipulate the dependencies for packages not in the whitelist
+        if self.twl and not self.twl.search(recipename):
+            # then process the actual dependencies
+            if self.twl.search(depname):
+                return False
+        return True
+
     def get_taskhash(self, fn, task, deps, dataCache):
         k = fn + "." + task
         data = dataCache.basetaskhash[k]
         self.runtaskdeps[k] = []
+        recipename = dataCache.pkg_fn[fn]
         for dep in sorted(deps, key=clean_basepath):
-            # We only manipulate the dependencies for packages not in the whitelist
-            if self.twl and not self.twl.search(dataCache.pkg_fn[fn]):
-                # then process the actual dependencies
-                dep_fn = re.search("(?P<fn>.*)\..*", dep).group('fn')
-                if self.twl.search(dataCache.pkg_fn[dep_fn]):
-                    continue
+            depname = dataCache.pkg_fn[self.pkgnameextract.search(dep).group('fn')]
+            if not self.rundep_check(fn, recipename, task, dep, depname):
+                continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?", dep)
             data = data + self.taskhash[dep]



