Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TDvIT-0006pr-Gc for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 12:44:53 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8IAWDdK026586
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Sep 2012 11:32:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25975-04 for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Sep 2012 11:32:07 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8IAW4bK026580
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Sep 2012 11:32:05 +0100
Message-ID: <1347964324.13596.109.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Sep 2012 11:32:04 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] build/siggen: Add support for stamp 'clean' masks
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
X-List-Received-Date: Tue, 18 Sep 2012 10:44:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently when we execute a task, we don't remove other potentially stale
stamps. This can mean if you switch between two different versions of a
recipe without a clean, the build can get very confused.

This patch adds in functionality to allow a wildcard expression of stamp
files to be removed when creating a new stamp file. This patch adds in
the core of the code to enable this but it also requires metadata support
to enable it.

When writing this improvement I went through several different options but
this was the only way I could find to allow things like noexec tasks to
function correctly (where stamps need to be created without the data store).

[YOCTO #2961]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 82d22f7..85af42c 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -470,11 +470,40 @@ def stamp_internal(taskname, d, file_name):
 
     return stamp
 
+def stamp_cleanmask_internal(taskname, d, file_name):
+    """
+    Internal stamp helper function to generate stamp cleaning mask
+    Returns the stamp path+filename
+
+    In the bitbake core, d can be a CacheData and file_name will be set.
+    When called in task context, d will be a data store, file_name will not be set
+    """
+    taskflagname = taskname
+    if taskname.endswith("_setscene") and taskname != "do_setscene":
+        taskflagname = taskname.replace("_setscene", "")
+
+    if file_name:
+        stamp = d.stamp_base_clean[file_name].get(taskflagname) or d.stampclean[file_name]
+        extrainfo = d.stamp_extrainfo[file_name].get(taskflagname) or ""
+    else:
+        stamp = d.getVarFlag(taskflagname, 'stamp-base-clean', True) or d.getVar('STAMPCLEAN', True)
+        file_name = d.getVar('BB_FILENAME', True)
+        extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info', True) or ""
+
+    if not stamp:
+        return
+
+    return bb.parse.siggen.stampcleanmask(stamp, file_name, taskname, extrainfo)
+
 def make_stamp(task, d, file_name = None):
     """
     Creates/updates a stamp for a given task
     (d can be a data dict or dataCache)
     """
+    cleanmask = stamp_cleanmask_internal(task, d, file_name)
+    if cleanmask:
+        bb.utils.remove(cleanmask)
+
     stamp = stamp_internal(task, d, file_name)
     # Remove the file and recreate to force timestamp
     # change on broken NFS filesystems
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index dea2a80..619b9ee 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "144"
+__cache_version__ = "145"
 
 def getCacheFile(path, filename, data_hash):
     return os.path.join(path, filename + "." + data_hash)
@@ -130,7 +130,9 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.broken = self.getvar('BROKEN', metadata)
         self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata)
         self.stamp = self.getvar('STAMP', metadata)
+        self.stampclean = self.getvar('STAMPCLEAN', metadata)        
         self.stamp_base = self.flaglist('stamp-base', self.tasks, metadata)
+        self.stamp_base_clean = self.flaglist('stamp-base-clean', self.tasks, metadata)
         self.stamp_extrainfo = self.flaglist('stamp-extra-info', self.tasks, metadata)
         self.file_checksums = self.flaglist('file-checksums', self.tasks, metadata, True)
         self.packages_dynamic = self.listvar('PACKAGES_DYNAMIC', metadata)
@@ -157,7 +159,9 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.pkg_dp = {}
 
         cachedata.stamp = {}
+        cachedata.stampclean = {}
         cachedata.stamp_base = {}
+        cachedata.stamp_base_clean = {}
         cachedata.stamp_extrainfo = {}
         cachedata.file_checksums = {}
         cachedata.fn_provides = {}
@@ -189,7 +193,9 @@ class CoreRecipeInfo(RecipeInfoCommon):
         cachedata.pkg_pepvpr[fn] = (self.pe, self.pv, self.pr)
         cachedata.pkg_dp[fn] = self.defaultpref
         cachedata.stamp[fn] = self.stamp
+        cachedata.stampclean[fn] = self.stampclean
         cachedata.stamp_base[fn] = self.stamp_base
+        cachedata.stamp_base_clean[fn] = self.stamp_base_clean
         cachedata.stamp_extrainfo[fn] = self.stamp_extrainfo
         cachedata.file_checksums[fn] = self.file_checksums
 
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 8fe59b9..ff70d4f 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -48,6 +48,9 @@ class SignatureGenerator(object):
     def stampfile(self, stampbase, file_name, taskname, extrainfo):
         return ("%s.%s.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
 
+    def stampcleanmask(self, stampbase, file_name, taskname, extrainfo):
+        return ("%s.%s*.%s" % (stampbase, taskname, extrainfo)).rstrip('.')
+
     def dump_sigtask(self, fn, task, stampbase, runtime):
         return
 
@@ -266,18 +269,24 @@ class SignatureGeneratorBasic(SignatureGenerator):
 class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
     name = "basichash"
 
-    def stampfile(self, stampbase, fn, taskname, extrainfo):
+    def stampfile(self, stampbase, fn, taskname, extrainfo, clean=False):
         if taskname != "do_setscene" and taskname.endswith("_setscene"):
             k = fn + "." + taskname[:-9]
         else:
             k = fn + "." + taskname
-        if k in self.taskhash:
+        if clean:
+            h = "*"
+            taskname = taskname + "*"
+        elif k in self.taskhash:
             h = self.taskhash[k]
         else:
             # If k is not in basehash, then error
             h = self.basehash[k]
         return ("%s.%s.%s.%s" % (stampbase, taskname, h, extrainfo)).rstrip('.')
 
+    def stampcleanmask(self, stampbase, fn, taskname, extrainfo):
+        return self.stampfile(stampbase, fn, taskname, extrainfo, clean=True)
+        
     def invalidate_task(self, task, d, fn):
         bb.note("Tainting hash to force rebuild of task %s, %s" % (fn, task))
         bb.build.write_taint(task, d, fn)




