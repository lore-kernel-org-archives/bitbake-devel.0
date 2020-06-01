Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
 by mx.groups.io with SMTP id smtpd.web11.48808.1591048191131011502
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=eNgwZYiv;
 spf=pass (domain: gmail.com, ip: 209.85.215.194, mailfrom: jpewhacker@gmail.com)
Received: by mail-pg1-f194.google.com with SMTP id r10so4086026pgv.8
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ostAhn1CEs6igzUJP/amUToIMSJKhhEV2nisk5VToyI=;
        b=eNgwZYivKTenrM792+PqwamEX9j+UVrr3BrxZDUIhYedLapEJS5hQac6suHr76/fQv
         /0oUPas12YcNEtP/+aMOoYpDOmok9GLFXCTHxVpkZisTdv9iqjMONpbzyd2AuR5rqZZD
         x6vwQUms2xzgOOxloW1MwhBA0078q7jFE801zRjoembQo0/J83wEgeeSat75jO1RfLRR
         Yuf308YrlHi7UHQ+yIow0qLHGsnbeUgwvosGoItYz3GoFQWaDuhyNVTW7Ru/P7Rgp0zy
         WHdczxIc7Aflfx0BSE3QKrEF27EB3ivbkSzA55OU84C3+2q/iJbratDTTsBvH5uiuvfO
         f18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ostAhn1CEs6igzUJP/amUToIMSJKhhEV2nisk5VToyI=;
        b=sQjYVMb7KxU3NZEQ1ZL3QOi991sRF4zZJIeS+9WV01+JQaFVtdf8IW+aVb6ETfLzzI
         Cs8p6dQIXD5AuGU9DoxXhZbK9HCxrWhAVSagR3zsWae+2RdKO8BtfT6tR1hQnaQ9eIlV
         qzl90HjwLny/72WGENtv1LKjPbYBsCF7z4U2oeS4KblknNF3xAro9MwsK4gwgOAXREHT
         obnBOblN8lj4ohL+1bPcRVh/VoRV9ImrOZMZJLg1oixIy0YLCnogt9DMPlcG/wAo9rCk
         ez0oWDasg7dOL0H4NvJaHL8dqPOI+kjzcdOCJJRWZdvsuEGOphPkVgxqf5V7tZSa698F
         Z0gw==
X-Gm-Message-State: AOAM5327tCEPnlUvJQjJdlWGHq8VQEpCdcwDz1blxNb89nIWNsp4LjIT
	7bm0uIHcwsn2h6cQN6UhmXfoqiJn9Jc=
X-Google-Smtp-Source: ABdhPJw0G8XwTI/vodU22abb2hmKeIBabi5vUUJ1DMXelvP7GpkW0vCLaYmlv+lsleeokA8FDWsNhQ==
X-Received: by 2002:a62:e91a:: with SMTP id j26mr22321168pfh.61.1591048189909;
        Mon, 01 Jun 2020 14:49:49 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:49 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 1/8] bitbake: cooker: Split file collections per multiconfig
Date: Mon,  1 Jun 2020 16:49:38 -0500
Message-Id: <20200601214945.32481-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601214945.32481-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
 <20200601214945.32481-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splits the cooker to track a collection per multiconfig instead of a
single collection for all multiconfigs. Practically speaking, this
allows each multiconfigs to each have different BBMASKs that apply to it
instead of each one using the mask specified in the base configuration.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py       |   2 +-
 bitbake/lib/bb/command.py     |  31 ++++++--
 bitbake/lib/bb/cooker.py      | 139 ++++++++++++++++++++--------------
 bitbake/lib/bb/runqueue.py    |  11 +--
 bitbake/lib/bb/tinfoil.py     |  26 ++++---
 bitbake/lib/bblayers/query.py |   4 +-
 6 files changed, 129 insertions(+), 84 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index d1be83617b..aa5ec5b591 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -623,7 +623,7 @@ class Cache(NoCache):
                         self.remove(fn)
                         return False
 
-        if appends != info_array[0].appends:
+        if tuple(appends) != tuple(info_array[0].appends):
             logger.debug(2, "Cache: appends for %s changed", fn)
             logger.debug(2, "%s to %s" % (str(appends), str(info_array[0].appends)))
             self.remove(fn)
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 6abf38668b..f45b6e5320 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -232,7 +232,11 @@ class CommandsSync:
 
     def matchFile(self, command, params):
         fMatch = params[0]
-        return command.cooker.matchFile(fMatch)
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return command.cooker.matchFile(fMatch, mc)
     matchFile.needconfig = False
 
     def getUIHandlerNum(self, command, params):
@@ -396,21 +400,33 @@ class CommandsSync:
         # Return list sorted by reverse priority order
         import bb.cache
         skipdict = OrderedDict(sorted(command.cooker.skiplist.items(),
-                                      key=lambda x: (-command.cooker.collection.calc_bbfile_priority(bb.cache.virtualfn2realfn(x[0])[0]), x[0])))
+                                      key=lambda x: (-command.cooker.collections[mc].calc_bbfile_priority(bb.cache.virtualfn2realfn(x[0])[0]), x[0])))
         return list(skipdict.items())
     getSkippedRecipes.readonly = True
 
     def getOverlayedRecipes(self, command, params):
-        return list(command.cooker.collection.overlayed.items())
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return list(command.cooker.collections[mc].overlayed.items())
     getOverlayedRecipes.readonly = True
 
     def getFileAppends(self, command, params):
         fn = params[0]
-        return command.cooker.collection.get_file_appends(fn)
+        try:
+            mc = params[1]
+        except IndexError:
+            mc = ''
+        return command.cooker.collections[mc].get_file_appends(fn)
     getFileAppends.readonly = True
 
     def getAllAppends(self, command, params):
-        return command.cooker.collection.bbappends
+        try:
+            mc = params[0]
+        except IndexError:
+            mc = ''
+        return command.cooker.collections[mc].bbappends
     getAllAppends.readonly = True
 
     def findProviders(self, command, params):
@@ -496,6 +512,7 @@ class CommandsSync:
         for the recipe.
         """
         fn = params[0]
+        mc = bb.runqueue.mc_from_tid(fn)
         appends = params[1]
         appendlist = params[2]
         if len(params) > 3:
@@ -507,7 +524,7 @@ class CommandsSync:
             if appendlist is not None:
                 appendfiles = appendlist
             else:
-                appendfiles = command.cooker.collection.get_file_appends(fn)
+                appendfiles = command.cooker.collections[mc].get_file_appends(fn)
         else:
             appendfiles = []
         # We are calling bb.cache locally here rather than on the server,
@@ -517,7 +534,7 @@ class CommandsSync:
         if config_data:
             # We have to use a different function here if we're passing in a datastore
             # NOTE: we took a copy above, so we don't do it here again
-            envdata = bb.cache.parse_recipe(config_data, fn, appendfiles)['']
+            envdata = bb.cache.parse_recipe(config_data, fn, appendfiles, mc)['']
         else:
             # Use the standard path
             parser = bb.cache.NoCache(command.cooker.databuilder)
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e527e23114..8f45233c8d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -525,7 +525,7 @@ class BBCooker:
             self.parseConfiguration()
 
             fn, cls, mc = bb.cache.virtualfn2realfn(buildfile)
-            fn = self.matchFile(fn)
+            fn = self.matchFile(fn, mc)
             fn = bb.cache.realfn2virtual(fn, cls, mc)
         elif len(pkgs_to_build) == 1:
             mc = mc_base(pkgs_to_build[0])
@@ -542,7 +542,7 @@ class BBCooker:
         if fn:
             try:
                 bb_cache = bb.cache.Cache(self.databuilder, self.data_hash, self.caches_array)
-                envdata = bb_cache.loadDataFull(fn, self.collection.get_file_appends(fn))
+                envdata = bb_cache.loadDataFull(fn, self.collections[mc].get_file_appends(fn))
             except Exception as e:
                 parselog.exception("Unable to read %s", fn)
                 raise
@@ -929,26 +929,33 @@ class BBCooker:
         logger.info("Task dependencies saved to 'task-depends.dot'")
 
     def show_appends_with_no_recipes(self):
+        appends_without_recipes = {}
         # Determine which bbappends haven't been applied
-
-        # First get list of recipes, including skipped
-        recipefns = list(self.recipecaches[''].pkg_fn.keys())
-        recipefns.extend(self.skiplist.keys())
-
-        # Work out list of bbappends that have been applied
-        applied_appends = []
-        for fn in recipefns:
-            applied_appends.extend(self.collection.get_file_appends(fn))
-
-        appends_without_recipes = []
-        for _, appendfn in self.collection.bbappends:
-            if not appendfn in applied_appends:
-                appends_without_recipes.append(appendfn)
-
-        if appends_without_recipes:
-            msg = 'No recipes available for:\n  %s' % '\n  '.join(appends_without_recipes)
-            warn_only = self.data.getVar("BB_DANGLINGAPPENDS_WARNONLY", \
-                 False) or "no"
+        for mc in self.multiconfigs:
+            # First get list of recipes, including skipped
+            recipefns = list(self.recipecaches[mc].pkg_fn.keys())
+            recipefns.extend(self.skiplist.keys())
+
+            # Work out list of bbappends that have been applied
+            applied_appends = []
+            for fn in recipefns:
+                applied_appends.extend(self.collections[mc].get_file_appends(fn))
+
+            appends_without_recipes[mc] = []
+            for _, appendfn in self.collections[mc].bbappends:
+                if not appendfn in applied_appends:
+                    appends_without_recipes[mc].append(appendfn)
+
+        msgs = []
+        for mc in sorted(appends_without_recipes.keys()):
+            if appends_without_recipes[mc]:
+                msgs.append('No recipes in %s available for:\n  %s' % (mc if mc else 'default',
+                                                                        '\n  '.join(appends_without_recipes[mc])))
+
+        if msgs:
+            msg = "\n".join(msgs)
+            warn_only = self.databuilder.mcdata[mc].getVar("BB_DANGLINGAPPENDS_WARNONLY", \
+                False) or "no"
             if warn_only.lower() in ("1", "yes", "true"):
                 bb.warn(msg)
             else:
@@ -1249,15 +1256,15 @@ class BBCooker:
         if siggen_cache:
             bb.parse.siggen.checksum_cache.mtime_cache.clear()
 
-    def matchFiles(self, bf):
+    def matchFiles(self, bf, mc=''):
         """
         Find the .bb files which match the expression in 'buildfile'.
         """
         if bf.startswith("/") or bf.startswith("../"):
             bf = os.path.abspath(bf)
 
-        self.collection = CookerCollectFiles(self.bbfile_config_priorities)
-        filelist, masked, searchdirs = self.collection.collect_bbfiles(self.data, self.data)
+        self.collections = {mc: CookerCollectFiles(self.bbfile_config_priorities, mc)}
+        filelist, masked, searchdirs = self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -1270,12 +1277,12 @@ class BBCooker:
                     matches.append(f)
             return matches
 
-    def matchFile(self, buildfile):
+    def matchFile(self, buildfile, mc=''):
         """
         Find the .bb file which matches the expression in 'buildfile'.
         Raise an error if multiple files
         """
-        matches = self.matchFiles(buildfile)
+        matches = self.matchFiles(buildfile, mc)
         if len(matches) != 1:
             if matches:
                 msg = "Unable to match '%s' to a specific recipe file - %s matches found:" % (buildfile, len(matches))
@@ -1316,14 +1323,14 @@ class BBCooker:
             task = "do_%s" % task
 
         fn, cls, mc = bb.cache.virtualfn2realfn(buildfile)
-        fn = self.matchFile(fn)
+        fn = self.matchFile(fn, mc)
 
         self.buildSetVars()
         self.reset_mtime_caches()
 
         bb_cache = bb.cache.Cache(self.databuilder, self.data_hash, self.caches_array)
 
-        infos = bb_cache.parse(fn, self.collection.get_file_appends(fn))
+        infos = bb_cache.parse(fn, self.collections[mc].get_file_appends(fn))
         infos = dict(infos)
 
         fn = bb.cache.realfn2virtual(fn, cls, mc)
@@ -1552,14 +1559,24 @@ class BBCooker:
                 for dep in self.configuration.extra_assume_provided:
                     self.recipecaches[mc].ignored_dependencies.add(dep)
 
-            self.collection = CookerCollectFiles(self.bbfile_config_priorities)
-            (filelist, masked, searchdirs) = self.collection.collect_bbfiles(self.data, self.data)
+            self.collections = {}
+
+            mcfilelist = {}
+            total_masked = 0
+            searchdirs = set()
+            for mc in self.multiconfigs:
+                self.collections[mc] = CookerCollectFiles(self.bbfile_config_priorities, mc)
+                (filelist, masked, search) = self.collections[mc].collect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
+
+                mcfilelist[mc] = filelist
+                total_masked += masked
+                searchdirs |= set(search)
 
             # Add inotify watches for directories searched for bb/bbappend files
             for dirent in searchdirs:
                 self.add_filewatch([[dirent]], dirs=True)
 
-            self.parser = CookerParser(self, filelist, masked)
+            self.parser = CookerParser(self, mcfilelist, total_masked)
             self.parsecache_valid = True
 
         self.state = state.parsing
@@ -1571,7 +1588,7 @@ class BBCooker:
             self.show_appends_with_no_recipes()
             self.handlePrefProviders()
             for mc in self.multiconfigs:
-                self.recipecaches[mc].bbfile_priority = self.collection.collection_priorities(self.recipecaches[mc].pkg_fn, self.data)
+                self.recipecaches[mc].bbfile_priority = self.collections[mc].collection_priorities(self.recipecaches[mc].pkg_fn, self.data)
             self.state = state.running
 
             # Send an event listing all stamps reachable after parsing
@@ -1679,7 +1696,8 @@ class CookerExit(bb.event.Event):
 
 
 class CookerCollectFiles(object):
-    def __init__(self, priorities):
+    def __init__(self, priorities, mc=''):
+        self.mc = mc
         self.bbappends = []
         # Priorities is a list of tupples, with the second element as the pattern.
         # We need to sort the list with the longest pattern first, and so on to
@@ -1846,7 +1864,7 @@ class CookerCollectFiles(object):
             (bbappend, filename) = b
             if (bbappend == f) or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
                 filelist.append(filename)
-        return filelist
+        return tuple(filelist)
 
     def collection_priorities(self, pkgfns, d):
 
@@ -1882,7 +1900,8 @@ class CookerCollectFiles(object):
         for collection, pattern, regex, _ in self.bbfile_config_priorities:
             if regex in unmatched:
                 if d.getVar('BBFILE_PATTERN_IGNORE_EMPTY_%s' % collection) != '1':
-                    collectlog.warning("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
+                    collectlog.warning("No bb files in %s matched BBFILE_PATTERN_%s '%s'" % (self.mc if self.mc else 'default',
+                                                                                             collection, pattern))
 
         return priorities
 
@@ -1978,8 +1997,8 @@ class Parser(multiprocessing.Process):
             bb.event.LogHandler.filter = origfilter
 
 class CookerParser(object):
-    def __init__(self, cooker, filelist, masked):
-        self.filelist = filelist
+    def __init__(self, cooker, mcfilelist, masked):
+        self.mcfilelist = mcfilelist
         self.cooker = cooker
         self.cfgdata = cooker.data
         self.cfghash = cooker.data_hash
@@ -1993,25 +2012,27 @@ class CookerParser(object):
 
         self.skipped = 0
         self.virtuals = 0
-        self.total = len(filelist)
 
         self.current = 0
         self.process_names = []
 
         self.bb_cache = bb.cache.Cache(self.cfgbuilder, self.cfghash, cooker.caches_array)
-        self.fromcache = []
-        self.willparse = []
-        for filename in self.filelist:
-            appends = self.cooker.collection.get_file_appends(filename)
-            if not self.bb_cache.cacheValid(filename, appends):
-                self.willparse.append((filename, appends))
-            else:
-                self.fromcache.append((filename, appends))
-        self.toparse = self.total - len(self.fromcache)
+        self.fromcache = set()
+        self.willparse = set()
+        for mc in self.cooker.multiconfigs:
+            for filename in self.mcfilelist[mc]:
+                appends = self.cooker.collections[mc].get_file_appends(filename)
+                if not self.bb_cache.cacheValid(filename, appends):
+                    self.willparse.add((filename, appends))
+                else:
+                    self.fromcache.add((filename, appends))
+
+        self.total = len(self.fromcache) + len(self.willparse)
+        self.toparse = len(self.willparse)
         self.progress_chunk = int(max(self.toparse / 100, 1))
 
         self.num_processes = min(int(self.cfgdata.getVar("BB_NUMBER_PARSE_THREADS") or
-                                 multiprocessing.cpu_count()), len(self.willparse))
+                                 multiprocessing.cpu_count()), self.toparse)
 
         self.start()
         self.haveshutdown = False
@@ -2032,7 +2053,7 @@ class CookerParser(object):
 
             def chunkify(lst,n):
                 return [lst[i::n] for i in range(n)]
-            self.jobs = chunkify(self.willparse, self.num_processes)
+            self.jobs = chunkify(list(self.willparse), self.num_processes)
 
             for i in range(0, self.num_processes):
                 parser = Parser(self.jobs[i], self.result_queue, self.parser_quit, init, self.cooker.configuration.profile)
@@ -2095,9 +2116,9 @@ class CookerParser(object):
             print("Processed parsing statistics saved to %s" % (pout))
 
     def load_cached(self):
-        for filename, appends in self.fromcache:
-            cached, infos = self.bb_cache.load(filename, appends)
-            yield not cached, infos
+        for mc, filename, appends in self.fromcache:
+            cached, infos = self.bb_cache.load(mc, filename, appends)
+            yield not cached, mc, infos
 
     def parse_generator(self):
         while True:
@@ -2119,7 +2140,7 @@ class CookerParser(object):
         result = []
         parsed = None
         try:
-            parsed, result = next(self.results)
+            parsed, mc, result = next(self.results)
         except StopIteration:
             self.shutdown()
             return False
@@ -2181,7 +2202,11 @@ class CookerParser(object):
         return True
 
     def reparse(self, filename):
-        infos = self.bb_cache.parse(filename, self.cooker.collection.get_file_appends(filename))
-        for vfn, info_array in infos:
-            (fn, cls, mc) = bb.cache.virtualfn2realfn(vfn)
-            self.cooker.recipecaches[mc].add_from_recipeinfo(vfn, info_array)
+        to_reparse = set()
+        for mc in self.cooker.multiconfigs:
+            to_reparse.add((mc, filename, self.cooker.collections[mc].get_file_appends(filename)))
+
+        for mc, filename, appends in to_reparse:
+            infos = self.bb_cache.parse(filename, appends)
+            for vfn, info_array in infos:
+                self.cooker.recipecaches[mc].add_from_recipeinfo(vfn, info_array)
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 16f076f3b1..3d54c2b88a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1557,7 +1557,8 @@ class RunQueue:
 
     def rq_dump_sigfn(self, fn, options):
         bb_cache = bb.cache.NoCache(self.cooker.databuilder)
-        the_data = bb_cache.loadDataFull(fn, self.cooker.collection.get_file_appends(fn))
+        mc = bb.runqueue.mc_from_tid(fn)
+        the_data = bb_cache.loadDataFull(fn, self.cooker.collections[mc].get_file_appends(fn))
         siggen = bb.parse.siggen
         dataCaches = self.rqdata.dataCaches
         siggen.dump_sigfn(fn, dataCaches, options)
@@ -2042,10 +2043,10 @@ class RunQueueExecute:
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
                     self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2129,10 +2130,10 @@ class RunQueueExecute:
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collection.get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 8c9b6b8ca5..7e32dca092 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -117,15 +117,16 @@ class TinfoilCookerAdapter:
 
     class TinfoilCookerCollectionAdapter:
         """ cooker.collection adapter """
-        def __init__(self, tinfoil):
+        def __init__(self, tinfoil, mc=''):
             self.tinfoil = tinfoil
+            self.mc = mc
         def get_file_appends(self, fn):
-            return self.tinfoil.get_file_appends(fn)
+            return self.tinfoil.get_file_appends(fn, self.mc)
         def __getattr__(self, name):
             if name == 'overlayed':
-                return self.tinfoil.get_overlayed_recipes()
+                return self.tinfoil.get_overlayed_recipes(self.mc)
             elif name == 'bbappends':
-                return self.tinfoil.run_command('getAllAppends')
+                return self.tinfoil.run_command('getAllAppends', self.mc)
             else:
                 raise AttributeError("%s instance has no attribute '%s'" % (self.__class__.__name__, name))
 
@@ -185,10 +186,11 @@ class TinfoilCookerAdapter:
 
     def __init__(self, tinfoil):
         self.tinfoil = tinfoil
-        self.collection = self.TinfoilCookerCollectionAdapter(tinfoil)
+        self.collections = {}
         self.recipecaches = {}
         self.recipecaches[''] = self.TinfoilRecipeCacheAdapter(tinfoil)
         for mc in (tinfoil.config_data.getVar('BBMULTICONFIG') or '').split():
+            self.collections[mc] = self.TinfoilCookerCollectionAdapter(tinfoil)
             self.recipecaches[mc] = self.TinfoilRecipeCacheAdapter(tinfoil, mc)
         self._cache = {}
     def __getattr__(self, name):
@@ -196,7 +198,7 @@ class TinfoilCookerAdapter:
         if name in self._cache:
             return self._cache[name]
         elif name == 'skiplist':
-            attrvalue = self.tinfoil.get_skipped_recipes()
+            attrvalue = self.tinfoil.get_skipped_recipes(self.mc)
         elif name == 'bbfile_config_priorities':
             ret = self.tinfoil.run_command('getLayerPriorities')
             bbfile_config_priorities = []
@@ -492,18 +494,18 @@ class Tinfoil:
             raise Exception('Not connected to server (did you call .prepare()?)')
         return self.server_connection.events.waitEvent(timeout)
 
-    def get_overlayed_recipes(self):
+    def get_overlayed_recipes(self, mc=''):
         """
         Find recipes which are overlayed (i.e. where recipes exist in multiple layers)
         """
-        return defaultdict(list, self.run_command('getOverlayedRecipes'))
+        return defaultdict(list, self.run_command('getOverlayedRecipes', mc))
 
-    def get_skipped_recipes(self):
+    def get_skipped_recipes(self, mc=''):
         """
         Find recipes which were skipped (i.e. SkipRecipe was raised
         during parsing).
         """
-        return OrderedDict(self.run_command('getSkippedRecipes'))
+        return OrderedDict(self.run_command('getSkippedRecipes', mc))
 
     def get_all_providers(self, mc=''):
         return defaultdict(list, self.run_command('allProviders', mc))
@@ -534,11 +536,11 @@ class Tinfoil:
                 raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
         return best[3]
 
-    def get_file_appends(self, fn):
+    def get_file_appends(self, fn, mc=''):
         """
         Find the bbappends for a recipe file
         """
-        return self.run_command('getFileAppends', fn)
+        return self.run_command('getFileAppends', fn, mc)
 
     def all_recipes(self, mc='', sort=True):
         """
diff --git a/bitbake/lib/bblayers/query.py b/bitbake/lib/bblayers/query.py
index e2cc310532..ee2db0efed 100644
--- a/bitbake/lib/bblayers/query.py
+++ b/bitbake/lib/bblayers/query.py
@@ -320,12 +320,12 @@ Lists recipes with the bbappends that apply to them as subitems.
     def get_appends_for_files(self, filenames):
         appended, notappended = [], []
         for filename in filenames:
-            _, cls, _ = bb.cache.virtualfn2realfn(filename)
+            _, cls, mc = bb.cache.virtualfn2realfn(filename)
             if cls:
                 continue
 
             basename = os.path.basename(filename)
-            appends = self.tinfoil.cooker.collection.get_file_appends(basename)
+            appends = self.tinfoil.cooker.collections[mc].get_file_appends(basename)
             if appends:
                 appended.append((basename, list(appends)))
             else:
-- 
2.26.2

