Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TaT4M-0004YD-3L for bitbake-devel@lists.openembedded.org;
	Mon, 19 Nov 2012 16:15:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAJF1RDs027867
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Nov 2012 15:01:27 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26882-06 for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Nov 2012 15:01:23 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAJF1ItR027861
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Nov 2012 15:01:19 GMT
Message-ID: <1353337280.3709.167.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 19 Nov 2012 15:01:20 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] parse/cache/cooker: Preserve order in the file inclusion list
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
X-List-Received-Date: Mon, 19 Nov 2012 15:15:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The data returned by get_file_depends() may me used in contexts like
checksums where order is important. The current usage of sets means
that some of the checksums can change in circumstances they should not.

This patch changes to use lists, thereby removing the problem.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 619b9ee..a3c073a 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -405,12 +405,12 @@ class Cache(object):
         """Parse the specified filename, returning the recipe information"""
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
-        depends = set()
+        depends = []
         for variant, data in sorted(datastores.iteritems(),
                                     key=lambda i: i[0],
                                     reverse=True):
             virtualfn = cls.realfn2virtual(filename, variant)
-            depends |= (data.getVar("__depends", False) or set())
+            depends = depends + (data.getVar("__depends", False) or [])
             if depends and not variant:
                 data.setVar("__depends", depends)
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e299059..98d6957 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -692,8 +692,8 @@ class BBCooker:
         # Generate a list of parsed configuration files by searching the files
         # listed in the __depends and __base_depends variables with a .conf suffix.
         conffiles = []
-        dep_files = self.configuration.data.getVar('__depends') or set()
-        dep_files.union(self.configuration.data.getVar('__base_depends') or set())
+        dep_files = self.configuration.data.getVar('__base_depends') or []
+        dep_files = dep_files + (self.configuration.data.getVar('__depends') or [])
 
         for f in dep_files:
             if f[0].endswith(".conf"):
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 7b9c47e..4293d09c 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -73,8 +73,7 @@ def update_mtime(f):
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-    deps = d.getVar('__depends') or set()
-    deps.update([(f, cached_mtime(f))])
+    deps = (d.getVar('__depends') or []) + [(f, cached_mtime(f))]
     d.setVar('__depends', deps)
 
 def supports(fn, data):
@@ -134,8 +133,8 @@ def vars_from_file(mypkg, d):
 def get_file_depends(d):
     '''Return the dependent files'''
     dep_files = []
-    depends = d.getVar('__depends', True) or set()
-    depends = depends.union(d.getVar('__base_depends', True) or set())
+    depends = d.getVar('__base_depends', True) or []
+    depends = depends + (d.getVar('__depends', True) or [])
     for (fn, _) in depends:
         dep_files.append(os.path.abspath(fn))
     return " ".join(dep_files)




