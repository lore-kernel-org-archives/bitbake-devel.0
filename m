Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SgeKw-0000gd-9T
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jun 2012 17:57:54 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 18 Jun 2012 08:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="167049113"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.122])
	by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2012 08:45:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jun 2012 16:45:35 +0100
Message-Id: <dcf1fb0acb4bd3424cbb5f48cd62f4f994896c20.1340034255.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1340034255.git.paul.eggleton@linux.intel.com>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1340034255.git.paul.eggleton@linux.intel.com>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake: ensure -f causes dependent tasks to be re-run
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
X-List-Received-Date: Mon, 18 Jun 2012 15:57:54 -0000

If -f is specified, force dependent tasks to be re-run next time. This
works by changing the force behaviour so that instead of deleting the
task's stamp, we write a "taint" file into the stamps directory, which
will alter the taskhash randomly and thus trigger the task to re-run
next time we evaluate whether or not that should be done as well as
influencing the taskhashes of any dependent tasks so that they are
similarly re-triggered. As a bonus because we write this file as
<stamp file name>.taskname.taint, the existing code which deletes the
stamp files in OE's do_clean will already handle removing it.

This means you can now do the following:

bitbake somepackage
[ change the source code in the package's WORKDIR ]
bitbake -c compile -f somepackage
bitbake somepackage

and the result will be that all of the tasks that depend on do_compile
(do_install, do_package, etc.) will be re-run in the last step.

Note that to operate in the manner described above you need full hashing
enabled (i.e. BB_SIGNATURE_HANDLER must be set to a signature handler
that inherits from BasicHash). If this is not the case, -f will just
delete the stamp for the specified task as it did before.

This fix is required for [YOCTO #2615] and [YOCTO #2256].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/build.py    |   18 ++++++++++++++++++
 bitbake/lib/bb/cooker.py   |    6 +++---
 bitbake/lib/bb/runqueue.py |   12 ++++++------
 bitbake/lib/bb/siggen.py   |   35 +++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index a9ba02d..a0a7dd4 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -494,6 +494,24 @@ def del_stamp(task, d, file_name = None):
     stamp = stamp_internal(task, d, file_name)
     bb.utils.remove(stamp)
 
+def write_taint(task, d, file_name = None):
+    """
+    Creates a "taint" file which will force the specified task and its
+    dependents to be re-run the next time by influencing the value of its
+    taskhash.
+    (d can be a data dict or dataCache)
+    """
+    import uuid
+    if file_name:
+        taintfn = d.stamp[file_name] + '.' + task + '.taint'
+    else:
+        taintfn = d.getVar('STAMP', True) + '.' + task + '.taint'
+    bb.utils.mkdirhier(os.path.dirname(taintfn))
+    # The specific content of the taint file is not really important,
+    # we just need it to be random, so a random UUID is used
+    with open(taintfn, 'w') as taintf:
+        taintf.write(str(uuid.uuid4()))
+
 def stampfile(taskname, d, file_name = None):
     """
     Return the stamp for a given task
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 928b600..9b8d4b2 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1066,10 +1066,10 @@ class BBCooker:
         self.status.rundeps[fn] = []
         self.status.runrecs[fn] = []
 
-        # Remove stamp for target if force mode active
+        # Invalidate task for target if force mode active
         if self.configuration.force:
-            logger.verbose("Remove stamp %s, %s", task, fn)
-            bb.build.del_stamp('do_%s' % task, self.status, fn)
+            logger.verbose("Invalidate task %s, %s", task, fn)
+            bb.parse.siggen.invalidate_task('do_%s' % task, self.status, fn)
 
         # Setup taskdata structure
         taskdata = bb.taskdata.TaskData(self.configuration.abort)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index d925b4c..28eb072 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -705,6 +705,12 @@ class RunQueueData:
                 continue
             self.runq_setscene.append(task)
 
+        # Invalidate task if force mode active
+        if self.cooker.configuration.force:
+            for (fn, target) in self.target_pairs:
+                logger.verbose("Invalidate task %s, %s", target, fn)
+                bb.parse.siggen.invalidate_task(target, self.dataCache, fn)
+
         # Interate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(range(len(self.runq_fnid)))
@@ -731,12 +737,6 @@ class RunQueueData:
                 deps.append(depidentifier)
             self.hash_deps[identifier] = deps
 
-        # Remove stamps for targets if force mode active
-        if self.cooker.configuration.force:
-            for (fn, target) in self.target_pairs:
-                logger.verbose("Remove stamp %s, %s", target, fn)
-                bb.build.del_stamp(target, self.dataCache, fn)
-
         return len(self.runq_fnid)
 
     def dump_data(self, taskQueue):
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index c4b7c39..0fb2642 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -50,6 +50,10 @@ class SignatureGenerator(object):
     def dump_sigtask(self, fn, task, stampbase, runtime):
         return
 
+    def invalidate_task(self, task, d, fn):
+        bb.build.del_stamp(task, d, fn)
+
+
 class SignatureGeneratorBasic(SignatureGenerator):
     """
     """
@@ -153,6 +157,15 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 return False
         return True
 
+    def read_taint(self, fn, task, stampbase):
+        taint = None
+        try:
+            with open(stampbase + '.' + task + '.taint', 'r') as taintf:
+                taint = taintf.read()
+        except IOError:
+            pass
+        return taint
+
     def get_taskhash(self, fn, task, deps, dataCache):
         k = fn + "." + task
         data = dataCache.basetaskhash[k]
@@ -173,6 +186,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
             for (f,cs) in checksums:
                self.file_checksum_values[k][f] = cs
                data = data + cs
+
+        taint = self.read_taint(fn, task, dataCache.stamp[fn])
+        if taint:
+            data = data + taint
+
         h = hashlib.md5(data).hexdigest()
         self.taskhash[k] = h
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
@@ -214,6 +232,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.taskhash[dep]
 
+        taint = self.read_taint(fn, task, stampbase)
+        if taint:
+            data['taint'] = taint
+
         with open(sigfile, "wb") as f:
             p = pickle.Pickler(f, -1)
             p.dump(data)
@@ -245,6 +267,9 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
             h = self.basehash[k]
         return ("%s.%s.%s.%s" % (stampbase, taskname, h, extrainfo)).rstrip('.')
 
+    def invalidate_task(self, task, d, fn):
+        bb.build.write_taint(task, d, fn)
+
 def dump_this_task(outfile, d):
     import bb.parse
     fn = d.getVar("BB_FILENAME", True)
@@ -357,6 +382,13 @@ def compare_sigfiles(a, b):
             for dep in changed:
                 print "Hash for dependent task %s changed from %s to %s" % (dep, a[dep], b[dep])
 
+
+    a_taint = a_data.get('taint', None)
+    b_taint = b_data.get('taint', None)
+    if a_taint != b_taint:
+        print "Taint (by forced/invalidated task) changed from %s to %s" % (a_taint, b_taint)
+
+
 def dump_sigfile(a):
     p1 = pickle.Unpickler(open(a, "rb"))
     a_data = p1.load()
@@ -384,3 +416,6 @@ def dump_sigfile(a):
     if 'runtaskhashes' in a_data:
         for dep in a_data['runtaskhashes']:
             print "Hash for dependent task %s is %s" % (dep, a_data['runtaskhashes'][dep])
+
+    if 'taint' in a_data:
+        print "Tainted (by forced/invalidated task): %s" % a_data['taint']
-- 
1.7.9.5



