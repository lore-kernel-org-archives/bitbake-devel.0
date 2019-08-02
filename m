Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
	[209.85.128.47])
	by mail.openembedded.org (Postfix) with ESMTP id 3A1D57F318
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:21:02 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id s3so68322062wms.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=dGsVbZzEDHHvml8OiqnjbsHn5PK1iabfmSwam1S+Iys=;
	b=hJlwH8IWkj8psOBHVsdP0LXQBx/ry5KNLDar0wJpZ/HQT83fuycZOHFiywC+b8xwnq
	oexs9umnINYCFCB+lYsVBUHw+cnoStGfTJgZcfdoLjvUEP0O0muu8bKw0noBrr3myjGn
	FdYAXUFgA+28gDTyfcgcrh0xjKyhoylYbP4fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dGsVbZzEDHHvml8OiqnjbsHn5PK1iabfmSwam1S+Iys=;
	b=ANHe+UwxDdHEaFe5ToX8hKENWErrz9G7oxfbnxvrGoe0fPh2v0tl+SgSk3CgnEjjEh
	HH9yhtBgUJqtbySnpEh+ME0QMxVusaxhbRWbkjXN8vrJ76M2cMNdup1/kB67RwDVJnpY
	AKAsjBC01L3djrEesHY2gZHgJYfpZlgqxgQY7WFftNd9ZLylEqPvc4xBjihOXvqX4dPx
	CtA1oLo2I4MNRVSjBJ1knfZAvOzmXiOt46F7vbqBXKtu7exr2vbfTAaLuxwwuLit8hDc
	y2JC46lnOLJphsp/d7sluxukeoHa5mY5Yg90k/5US12slnCOfwUO+fWLHD8xlzmHPnaz
	FM1A==
X-Gm-Message-State: APjAAAWcLnH6R9WOSdd2agP/SzMCxt248sjkhRVB93bWZ+6UN6IBJA+s
	tmIwoviuw8F/YecDASNrmC5jywj8+jE=
X-Google-Smtp-Source: APXvYqx3fJo2MdK/GKa6fMDgGwNN19xy13FJpUVsBA0iS3mHC6KKLjveFZjTMuyDwV21XNlW2oJeHw==
X-Received: by 2002:a1c:f90f:: with SMTP id x15mr4805495wmh.69.1564759262200; 
	Fri, 02 Aug 2019 08:21:02 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.21.01
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:21:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:46 +0100
Message-Id: <20190802152049.16529-13-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 13/16] siggen: Clean up task reference formats
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
X-List-Received-Date: Fri, 02 Aug 2019 15:21:02 -0000
Content-Transfer-Encoding: 8bit

Currently siggen uses the format "<filename>.<taskname>" for referencing tasks
whilst runqueue uses "<filename>:<taskname>". This converts to use ":" as the
separator everywhere.

This is an API breaking change since the cache is affected, as are siginfo files
and any custom signature handlers such as those in OE-Core.

Ultimately this will let us clean up and the accessor functions from runqueue,
removing all the ".rsplit(".", 1)[0]" type code currently all over the place.
Once a standard is used everwhere we can update the code over time to be more
optimal.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py      |   2 +-
 lib/bb/data.py       |   2 +-
 lib/bb/runqueue.py   |  19 +++---
 lib/bb/siggen.py     | 152 ++++++++++++++++++++-----------------------
 lib/bb/tests/data.py |   2 +-
 5 files changed, 82 insertions(+), 95 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 233f994279..b6f7da5920 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -220,7 +220,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         cachedata.hashfn[fn] = self.hashfilename
         for task, taskhash in self.basetaskhashes.items():
-            identifier = '%s.%s' % (fn, task)
+            identifier = '%s:%s' % (fn, task)
             cachedata.basetaskhash[identifier] = taskhash
 
         cachedata.inherits[fn] = self.inherits
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 92ef405304..443615b977 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -422,7 +422,7 @@ def generate_dependency_hash(tasklist, gendeps, lookupcache, whitelist, fn):
             var = lookupcache[dep]
             if var is not None:
                 data = data + str(var)
-        k = fn + "." + task
+        k = fn + ":" + task
         basehash[k] = hashlib.sha256(data.encode("utf-8")).hexdigest()
         taskdeps[task] = alldeps
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 07dc5c0003..caa38b6dde 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1174,10 +1174,9 @@ class RunQueueData:
     def prepare_task_hash(self, tid):
         procdep = []
         for dep in self.runtaskentries[tid].depends:
-            procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
-        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
-        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(taskfn + "." + taskname)
+            procdep.append(dep)
+        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.dataCaches[mc_from_tid(tid)])
+        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
     def dump_data(self):
         """
@@ -1401,7 +1400,7 @@ class RunQueue:
                 sq_data['hashfn'][tid] = self.rqdata.dataCaches[mc].hashfn[taskfn]
                 sq_data['unihash'][tid] = self.rqdata.runtaskentries[tid].unihash
 
-            valid_ids = self.validate_hash(sq_data, data, siginfo, currentcount)
+            valid = self.validate_hash(sq_data, data, siginfo, currentcount)
 
         return valid
 
@@ -2152,8 +2151,7 @@ class RunQueueExecute:
         if unihash != self.rqdata.runtaskentries[tid].unihash:
             logger.info("Task %s unihash changed to %s" % (tid, unihash))
             self.rqdata.runtaskentries[tid].unihash = unihash
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-            bb.parse.siggen.set_unihash(taskfn + "." + taskname, unihash)
+            bb.parse.siggen.set_unihash(tid, unihash)
 
             # Work out all tasks which depend on this one
             total = set()
@@ -2177,12 +2175,11 @@ class RunQueueExecute:
                         continue
                     procdep = []
                     for dep in self.rqdata.runtaskentries[tid].depends:
-                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
-                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+                        procdep.append(dep)
                     orighash = self.rqdata.runtaskentries[tid].hash
-                    self.rqdata.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.rqdata.dataCaches[mc])
+                    self.rqdata.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
                     origuni = self.rqdata.runtaskentries[tid].unihash
-                    self.rqdata.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(taskfn + "." + taskname)
+                    self.rqdata.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
                     logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni, self.rqdata.runtaskentries[tid].unihash))
                     next |= self.rqdata.runtaskentries[tid].revdeps
                     changed.add(tid)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 368209807f..912c92c8be 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -46,13 +46,12 @@ class SignatureGenerator(object):
     def finalise(self, fn, d, varient):
         return
 
-    def get_unihash(self, task):
-        return self.taskhash[task]
+    def get_unihash(self, tid):
+        return self.taskhash[tid]
 
-    def get_taskhash(self, fn, task, deps, dataCache):
-        k = fn + "." + task
-        self.taskhash[k] = hashlib.sha256(k.encode("utf-8")).hexdigest()
-        return self.taskhash[k]
+    def get_taskhash(self, tid, deps, dataCache):
+        self.taskhash[tid] = hashlib.sha256(tid.encode("utf-8")).hexdigest()
+        return self.taskhash[tid]
 
     def writeout_file_checksum_cache(self):
         """Write/update the file checksum cache onto disk"""
@@ -106,7 +105,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.taints = {}
         self.gendeps = {}
         self.lookupcache = {}
-        self.pkgnameextract = re.compile(r"(?P<fn>.*)\..*")
         self.basewhitelist = set((data.getVar("BB_HASHBASE_WHITELIST") or "").split())
         self.taskwhitelist = None
         self.init_rundepcheck(data)
@@ -135,16 +133,16 @@ class SignatureGeneratorBasic(SignatureGenerator):
         taskdeps, basehash = bb.data.generate_dependency_hash(tasklist, gendeps, lookupcache, self.basewhitelist, fn)
 
         for task in tasklist:
-            k = fn + "." + task
-            if not ignore_mismatch and k in self.basehash and self.basehash[k] != basehash[k]:
-                bb.error("When reparsing %s, the basehash value changed from %s to %s. The metadata is not deterministic and this needs to be fixed." % (k, self.basehash[k], basehash[k]))
+            tid = fn + ":" + task
+            if not ignore_mismatch and tid in self.basehash and self.basehash[tid] != basehash[tid]:
+                bb.error("When reparsing %s, the basehash value changed from %s to %s. The metadata is not deterministic and this needs to be fixed." % (tid, self.basehash[tid], basehash[tid]))
                 bb.error("The following commands may help:")
                 cmd = "$ bitbake %s -c%s" % (d.getVar('PN'), task)
                 # Make sure sigdata is dumped before run printdiff
                 bb.error("%s -Snone" % cmd)
                 bb.error("Then:")
                 bb.error("%s -Sprintdiff\n" % cmd)
-            self.basehash[k] = basehash[k]
+            self.basehash[tid] = basehash[tid]
 
         self.taskdeps[fn] = taskdeps
         self.gendeps[fn] = gendeps
@@ -171,7 +169,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #    self.dump_sigtask(fn, task, d.getVar("STAMP"), False)
 
         for task in taskdeps:
-            d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + "." + task])
+            d.setVar("BB_BASEHASH_task-%s" % task, self.basehash[fn + ":" + task])
 
     def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
         # Return True if we should keep the dependency, False to drop it
@@ -191,33 +189,26 @@ class SignatureGeneratorBasic(SignatureGenerator):
             pass
         return taint
 
-    def get_taskhash(self, fn, task, deps, dataCache):
+    def get_taskhash(self, tid, deps, dataCache):
 
-        mc = ''
-        if fn.startswith('mc:'):
-            mc = fn.split(':')[1]
-        k = fn + "." + task
+        (mc, _, task, fn) = bb.runqueue.split_tid_mcfn(tid)
 
-        data = dataCache.basetaskhash[k]
-        self.basehash[k] = data
-        self.runtaskdeps[k] = []
-        self.file_checksum_values[k] = []
+        data = dataCache.basetaskhash[tid]
+        self.basehash[tid] = data
+        self.runtaskdeps[tid] = []
+        self.file_checksum_values[tid] = []
         recipename = dataCache.pkg_fn[fn]
         for dep in sorted(deps, key=clean_basepath):
-            pkgname = self.pkgnameextract.search(dep).group('fn')
-            if mc:
-                depmc = pkgname.split(':')[1]
-                if mc != depmc:
-                    continue
-            if dep.startswith("mc:") and not mc:
+            (depmc, _, deptaskname, depfn) = bb.runqueue.split_tid_mcfn(dep)
+            if mc != depmc:
                 continue
-            depname = dataCache.pkg_fn[pkgname]
+            depname = dataCache.pkg_fn[depfn]
             if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
             data = data + self.get_unihash(dep)
-            self.runtaskdeps[k].append(dep)
+            self.runtaskdeps[tid].append(dep)
 
         if task in dataCache.file_checksums[fn]:
             if self.checksum_cache:
@@ -225,7 +216,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             else:
                 checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
             for (f,cs) in checksums:
-                self.file_checksum_values[k].append((f,cs))
+                self.file_checksum_values[tid].append((f,cs))
                 if cs:
                     data = data + cs
 
@@ -235,16 +226,16 @@ class SignatureGeneratorBasic(SignatureGenerator):
             import uuid
             taint = str(uuid.uuid4())
             data = data + taint
-            self.taints[k] = "nostamp:" + taint
+            self.taints[tid] = "nostamp:" + taint
 
         taint = self.read_taint(fn, task, dataCache.stamp[fn])
         if taint:
             data = data + taint
-            self.taints[k] = taint
-            logger.warning("%s is tainted from a forced run" % k)
+            self.taints[tid] = taint
+            logger.warning("%s is tainted from a forced run" % tid)
 
         h = hashlib.sha256(data.encode("utf-8")).hexdigest()
-        self.taskhash[k] = h
+        self.taskhash[tid] = h
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
         return h
 
@@ -262,15 +253,15 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
     def dump_sigtask(self, fn, task, stampbase, runtime):
 
-        k = fn + "." + task
+        tid = fn + ":" + task
         referencestamp = stampbase
         if isinstance(runtime, str) and runtime.startswith("customfile"):
             sigfile = stampbase
             referencestamp = runtime[11:]
-        elif runtime and k in self.taskhash:
-            sigfile = stampbase + "." + task + ".sigdata" + "." + self.taskhash[k]
+        elif runtime and tid in self.taskhash:
+            sigfile = stampbase + "." + task + ".sigdata" + "." + self.taskhash[tid]
         else:
-            sigfile = stampbase + "." + task + ".sigbasedata" + "." + self.basehash[k]
+            sigfile = stampbase + "." + task + ".sigbasedata" + "." + self.basehash[tid]
 
         bb.utils.mkdirhier(os.path.dirname(sigfile))
 
@@ -279,7 +270,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         data['basewhitelist'] = self.basewhitelist
         data['taskwhitelist'] = self.taskwhitelist
         data['taskdeps'] = self.taskdeps[fn][task]
-        data['basehash'] = self.basehash[k]
+        data['basehash'] = self.basehash[tid]
         data['gendeps'] = {}
         data['varvals'] = {}
         data['varvals'][task] = self.lookupcache[fn][task]
@@ -289,30 +280,30 @@ class SignatureGeneratorBasic(SignatureGenerator):
             data['gendeps'][dep] = self.gendeps[fn][dep]
             data['varvals'][dep] = self.lookupcache[fn][dep]
 
-        if runtime and k in self.taskhash:
-            data['runtaskdeps'] = self.runtaskdeps[k]
-            data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[k]]
+        if runtime and tid in self.taskhash:
+            data['runtaskdeps'] = self.runtaskdeps[tid]
+            data['file_checksum_values'] = [(os.path.basename(f), cs) for f,cs in self.file_checksum_values[tid]]
             data['runtaskhashes'] = {}
             for dep in data['runtaskdeps']:
                 data['runtaskhashes'][dep] = self.get_unihash(dep)
-            data['taskhash'] = self.taskhash[k]
+            data['taskhash'] = self.taskhash[tid]
 
         taint = self.read_taint(fn, task, referencestamp)
         if taint:
             data['taint'] = taint
 
-        if runtime and k in self.taints:
-            if 'nostamp:' in self.taints[k]:
-                data['taint'] = self.taints[k]
+        if runtime and tid in self.taints:
+            if 'nostamp:' in self.taints[tid]:
+                data['taint'] = self.taints[tid]
 
         computed_basehash = calc_basehash(data)
-        if computed_basehash != self.basehash[k]:
-            bb.error("Basehash mismatch %s versus %s for %s" % (computed_basehash, self.basehash[k], k))
-        if runtime and k in self.taskhash:
+        if computed_basehash != self.basehash[tid]:
+            bb.error("Basehash mismatch %s versus %s for %s" % (computed_basehash, self.basehash[tid], tid))
+        if runtime and tid in self.taskhash:
             computed_taskhash = calc_taskhash(data)
-            if computed_taskhash != self.taskhash[k]:
-                bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[k], k))
-                sigfile = sigfile.replace(self.taskhash[k], computed_taskhash)
+            if computed_taskhash != self.taskhash[tid]:
+                bb.error("Taskhash mismatch %s versus %s for %s" % (computed_taskhash, self.taskhash[tid], tid))
+                sigfile = sigfile.replace(self.taskhash[tid], computed_taskhash)
 
         fd, tmpfile = tempfile.mkstemp(dir=os.path.dirname(sigfile), prefix="sigtask.")
         try:
@@ -332,34 +323,33 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if fn in self.taskdeps:
             for task in self.taskdeps[fn]:
                 tid = fn + ":" + task
-                (mc, _, _) = bb.runqueue.split_tid(tid)
-                k = fn + "." + task
-                if k not in self.taskhash:
+                mc = bb.runqueue.mc_from_tid(tid)
+                if tid not in self.taskhash:
                     continue
-                if dataCaches[mc].basetaskhash[k] != self.basehash[k]:
-                    bb.error("Bitbake's cached basehash does not match the one we just generated (%s)!" % k)
-                    bb.error("The mismatched hashes were %s and %s" % (dataCaches[mc].basetaskhash[k], self.basehash[k]))
+                if dataCaches[mc].basetaskhash[tid] != self.basehash[tid]:
+                    bb.error("Bitbake's cached basehash does not match the one we just generated (%s)!" % tid)
+                    bb.error("The mismatched hashes were %s and %s" % (dataCaches[mc].basetaskhash[tid], self.basehash[tid]))
                 self.dump_sigtask(fn, task, dataCaches[mc].stamp[fn], True)
 
 class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
     name = "basichash"
 
-    def get_stampfile_hash(self, task):
-        if task in self.taskhash:
-            return self.taskhash[task]
+    def get_stampfile_hash(self, tid):
+        if tid in self.taskhash:
+            return self.taskhash[tid]
 
         # If task is not in basehash, then error
-        return self.basehash[task]
+        return self.basehash[tid]
 
     def stampfile(self, stampbase, fn, taskname, extrainfo, clean=False):
         if taskname != "do_setscene" and taskname.endswith("_setscene"):
-            k = fn + "." + taskname[:-9]
+            tid = fn + ":" + taskname[:-9]
         else:
-            k = fn + "." + taskname
+            tid = fn + ":" + taskname
         if clean:
             h = "*"
         else:
-            h = self.get_stampfile_hash(k)
+            h = self.get_stampfile_hash(tid)
 
         return ("%s.%s.%s.%s" % (stampbase, taskname, h, extrainfo)).rstrip('.')
 
@@ -378,32 +368,32 @@ class SignatureGeneratorUniHashMixIn(object):
         self.server, self.method = data[:2]
         super().set_taskdata(data[2:])
 
-    def __get_task_unihash_key(self, task):
-        # TODO: The key only *needs* to be the taskhash, the task is just
+    def __get_task_unihash_key(self, tid):
+        # TODO: The key only *needs* to be the taskhash, the tid is just
         # convenient
-        return '%s:%s' % (task, self.taskhash[task])
+        return '%s:%s' % (tid, self.taskhash[tid])
 
-    def get_stampfile_hash(self, task):
-        if task in self.taskhash:
+    def get_stampfile_hash(self, tid):
+        if tid in self.taskhash:
             # If a unique hash is reported, use it as the stampfile hash. This
             # ensures that if a task won't be re-run if the taskhash changes,
             # but it would result in the same output hash
-            unihash = self.unitaskhashes.get(self.__get_task_unihash_key(task), None)
+            unihash = self.unitaskhashes.get(self.__get_task_unihash_key(tid), None)
             if unihash is not None:
                 return unihash
 
-        return super().get_stampfile_hash(task)
+        return super().get_stampfile_hash(tid)
 
-    def set_unihash(self, task, unihash):
-        self.unitaskhashes[self.__get_task_unihash_key(task)] = unihash
+    def set_unihash(self, tid, unihash):
+        self.unitaskhashes[self.__get_task_unihash_key(tid)] = unihash
 
-    def get_unihash(self, task):
+    def get_unihash(self, tid):
         import urllib
         import json
 
-        taskhash = self.taskhash[task]
+        taskhash = self.taskhash[tid]
 
-        key = self.__get_task_unihash_key(task)
+        key = self.__get_task_unihash_key(tid)
 
         # TODO: This cache can grow unbounded. It probably only needs to keep
         # for each task
@@ -428,7 +418,7 @@ class SignatureGeneratorUniHashMixIn(object):
 
         try:
             url = '%s/v1/equivalent?%s' % (self.server,
-                    urllib.parse.urlencode({'method': self.method, 'taskhash': self.taskhash[task]}))
+                    urllib.parse.urlencode({'method': self.method, 'taskhash': self.taskhash[tid]}))
 
             request = urllib.request.Request(url)
             response = urllib.request.urlopen(request)
@@ -441,9 +431,9 @@ class SignatureGeneratorUniHashMixIn(object):
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
-                bb.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, task, self.server))
+                bb.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
             else:
-                bb.debug(2, 'No reported unihash for %s:%s from %s' % (task, taskhash, self.server))
+                bb.debug(2, 'No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
         except urllib.error.URLError as e:
             bb.warn('Failure contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
         except (KeyError, json.JSONDecodeError) as e:
@@ -464,7 +454,7 @@ class SignatureGeneratorUniHashMixIn(object):
         report_taskdata = d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
         tempdir = d.getVar('T')
         fn = d.getVar('BB_FILENAME')
-        key = fn + '.do_' + task + ':' + taskhash
+        key = fn + ':do_' + task + ':' + taskhash
 
         # Sanity checks
         cache_unihash = self.unitaskhashes.get(key, None)
diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
index 3cf5abec70..a9b0bdb099 100644
--- a/lib/bb/tests/data.py
+++ b/lib/bb/tests/data.py
@@ -466,7 +466,7 @@ class TaskHash(unittest.TestCase):
             tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
             taskdeps, basehash = bb.data.generate_dependency_hash(tasklist, gendeps, lookupcache, set(), "somefile")
             bb.warn(str(lookupcache))
-            return basehash["somefile." + taskname]
+            return basehash["somefile:" + taskname]
 
         d = bb.data.init()
         d.setVar("__BBTASKS", ["mytask"])
-- 
2.20.1


