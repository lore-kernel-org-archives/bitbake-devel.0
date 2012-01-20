Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RoHFu-0003D6-Di for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:24:00 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGGGqC019773
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jan 2012 16:16:16 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18273-09 for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jan 2012 16:16:12 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0KGG8VW019767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Jan 2012 16:16:09 GMT
Message-ID: <1327076168.4268.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 20 Jan 2012 16:16:08 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] siggen.py: Abstract the runtime task dependency handling code in the generators
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
X-List-Received-Date: Fri, 20 Jan 2012 16:24:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This means that custom signature handlers can override specific parts
of the code without having to reimplement whole functions allowing them
more flexibility.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index d9d0294..f31d66a 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
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




