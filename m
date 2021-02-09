Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web12.12301.1612885854736474633
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 07:50:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=RfEnP+H3;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id k10so15514607otl.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Feb 2021 07:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUJCt8BuWVNNkJrqcDTnfnSWfbEcFJQeYv41RuQMOQ4=;
        b=RfEnP+H3/mxU6D+0yI6W9VDhlJK67Jh8Wsb494WmPrIeQ4Je11+1p/wwA1BiDKu7SN
         ziWCc/C1lxoXJU8Bqf5hst2JsQCcqJmsn6SA6hBEm6MYhntPFczBdKVQCmT5oOce0Sjp
         lQcxsHqmODUIhfqL9vlqDmQXuiwofwyj4+GndGUeebxF9MJIFYsiOY11ZVm+foEoFZz4
         ge2poGSnb3xUXdxfxljZzqHYc1FPbkfuRcaGMLnRM53ZbXu1Tdcxfa6e+NshN8D4m6WG
         b/G55tcM1AzU/K0fBWb7HcyL6NjN9xsUV11Je87XTFO53EFeALEx5NH3w+tIB791VrDS
         vzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EUJCt8BuWVNNkJrqcDTnfnSWfbEcFJQeYv41RuQMOQ4=;
        b=UiEiPdkMe5wnXRS8PKp+GtAfRmYfg82AK3c1xGFbqUDtQHvq+lbEp5rKKo+7IzSbMW
         xstuQxHY5VS/bcmmGc+vGFghh4OCn74IIp0WPqCBt5K102N1pzi6ZKiCFkN/mkTJd/uN
         ALO7L5LHiIgiUGZGWx71LN7txmW6CnRjoZ1RLnX1Iw1W+Q2PcyMJlXHKs27hhwcWUf/E
         fSqje9rT8krqGMu8i1qV8AHPAivbUpqz+BOK5jvSRoKgPsvpfXtYPNYqTWazBUffOCV9
         HeciLJugSbziM46xD/Z3c3K7QKn4VHyQPZAe6SkMqhuQgPmBh1HKwH3KBlCWhgqT6edf
         6Nrg==
X-Gm-Message-State: AOAM531yx4v97d9IKOGLz5tJ7lJPvXdnBlsuNZBI60POMRqygfE1Cguh
	1daiTobVoTfM2TwZSyzHpNSp38KO2SI=
X-Google-Smtp-Source: ABdhPJxJwLNTxuTSlPlZLSylBXKSXjtXDoHYkAP3nSz/V7Ence4oxnraEtVhDNrFAIYDDlJQNdn1RQ==
X-Received: by 2002:a9d:19aa:: with SMTP id k39mr16187204otk.28.1612885852501;
        Tue, 09 Feb 2021 07:50:52 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id g14sm4343178oon.23.2021.02.09.07.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 07:50:51 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] logging: Make bitbake logger compatible with python logger
Date: Tue,  9 Feb 2021 09:50:21 -0600
Message-Id: <20210209155021.21709-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bitbake logger overrode the definition of the debug() logging call
to include a debug level, but this causes problems with code that may
be using standard python logging, since the extra argument is
interpreted differently.

Instead, change the bitbake loggers debug() call to match the python
logger call and add a debug2() and debug3() API to replace calls that
were logging to a different debug level.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-worker                   |  2 +-
 bitbake/lib/bb/__init__.py                   | 15 ++++-
 bitbake/lib/bb/build.py                      |  6 +-
 bitbake/lib/bb/cache.py                      | 52 ++++++++--------
 bitbake/lib/bb/cooker.py                     | 14 ++---
 bitbake/lib/bb/fetch2/__init__.py            | 38 ++++++------
 bitbake/lib/bb/fetch2/bzr.py                 |  8 +--
 bitbake/lib/bb/fetch2/clearcase.py           |  2 +-
 bitbake/lib/bb/fetch2/cvs.py                 |  4 +-
 bitbake/lib/bb/fetch2/gitsm.py               |  4 +-
 bitbake/lib/bb/fetch2/hg.py                  | 16 ++---
 bitbake/lib/bb/fetch2/local.py               |  4 +-
 bitbake/lib/bb/fetch2/osc.py                 |  6 +-
 bitbake/lib/bb/fetch2/perforce.py            | 10 +--
 bitbake/lib/bb/fetch2/repo.py                |  2 +-
 bitbake/lib/bb/fetch2/svn.py                 |  6 +-
 bitbake/lib/bb/fetch2/wget.py                |  6 +-
 bitbake/lib/bb/parse/__init__.py             |  2 +-
 bitbake/lib/bb/parse/ast.py                  |  4 +-
 bitbake/lib/bb/parse/parse_py/BBHandler.py   |  2 +-
 bitbake/lib/bb/parse/parse_py/ConfHandler.py |  2 +-
 bitbake/lib/bb/persist_data.py               |  2 +-
 bitbake/lib/bb/providers.py                  | 20 +++---
 bitbake/lib/bb/runqueue.py                   | 64 ++++++++++----------
 bitbake/lib/bb/siggen.py                     |  6 +-
 bitbake/lib/bb/taskdata.py                   | 42 ++++++-------
 bitbake/lib/bb/ui/buildinfohelper.py         | 10 +--
 bitbake/lib/bb/utils.py                      |  6 +-
 bitbake/lib/bblayers/layerindex.py           |  2 +-
 bitbake/lib/layerindexlib/__init__.py        | 48 +++++++--------
 bitbake/lib/layerindexlib/cooker.py          |  4 +-
 bitbake/lib/layerindexlib/restapi.py         | 32 +++++-----
 bitbake/lib/layerindexlib/tests/cooker.py    |  4 +-
 bitbake/lib/layerindexlib/tests/restapi.py   | 18 +++---
 34 files changed, 236 insertions(+), 227 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index 40da7a0c2b..6c37967513 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -169,7 +169,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
         fakedirs = (workerdata["fakerootdirs"][fn] or "").split()
         for p in fakedirs:
             bb.utils.mkdirhier(p)
-        logger.debug(2, 'Running %s:%s under fakeroot, fakedirs: %s' %
+        logger.debug2('Running %s:%s under fakeroot, fakedirs: %s' %
                         (fn, taskname, ', '.join(fakedirs)))
     else:
         envvars = (workerdata["fakerootnoenv"][fn] or "").split()
diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index b217737347..15e9c4e789 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -21,8 +21,8 @@ class BBHandledException(Exception):
     The big dilemma for generic bitbake code is what information to give the user
     when an exception occurs. Any exception inheriting this base exception class
     has already provided information to the user via some 'fired' message type such as
-    an explicitly fired event using bb.fire, or a bb.error message. If bitbake 
-    encounters an exception derived from this class, no backtrace or other information 
+    an explicitly fired event using bb.fire, or a bb.error message. If bitbake
+    encounters an exception derived from this class, no backtrace or other information
     will be given to the user, its assumed the earlier event provided the relevant information.
     """
     pass
@@ -42,7 +42,16 @@ class BBLoggerMixin(object):
 
     def setup_bblogger(self, name):
         if name.split(".")[0] == "BitBake":
-            self.debug = self.bbdebug
+            self.debug = self._debug_helper
+
+    def _debug_helper(self, *args, **kwargs):
+        return self.bbdebug(1, *args, **kwargs)
+
+    def debug2(self, *args, **kwargs):
+        return self.bbdebug(2, *args, **kwargs)
+
+    def debug3(self, *args, **kwargs):
+        return self.bbdebug(3, *args, **kwargs)
 
     def bbdebug(self, level, msg, *args, **kwargs):
         loglevel = logging.DEBUG - level + 1
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 974d2ff065..f4f897e41a 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -583,7 +583,7 @@ def _exec_task(fn, task, d, quieterr):
         logger.error("No such task: %s" % task)
         return 1
 
-    logger.debug(1, "Executing task %s", task)
+    logger.debug("Executing task %s", task)
 
     localdata = _task_data(fn, task, d)
     tempdir = localdata.getVar('T')
@@ -596,7 +596,7 @@ def _exec_task(fn, task, d, quieterr):
         curnice = os.nice(0)
         nice = int(nice) - curnice
         newnice = os.nice(nice)
-        logger.debug(1, "Renice to %s " % newnice)
+        logger.debug("Renice to %s " % newnice)
     ionice = localdata.getVar("BB_TASK_IONICE_LEVEL")
     if ionice:
         try:
@@ -720,7 +720,7 @@ def _exec_task(fn, task, d, quieterr):
 
         logfile.close()
         if os.path.exists(logfn) and os.path.getsize(logfn) == 0:
-            logger.debug(2, "Zero size logfn %s, removing", logfn)
+            logger.debug2("Zero size logfn %s, removing", logfn)
             bb.utils.remove(logfn)
             bb.utils.remove(loglink)
     event.fire(TaskSucceeded(task, fn, logfn, localdata), localdata)
diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index c85effd6f0..aea2b8bc11 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -215,7 +215,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
         if not self.not_world:
             cachedata.possible_world.append(fn)
         #else:
-        #    logger.debug(2, "EXCLUDE FROM WORLD: %s", fn)
+        #    logger.debug2("EXCLUDE FROM WORLD: %s", fn)
 
         # create a collection of all targets for sanity checking
         # tasks, such as upstream versions, license, and tools for
@@ -323,7 +323,7 @@ class NoCache(object):
         Return a complete set of data for fn.
         To do this, we need to parse the file.
         """
-        logger.debug(1, "Parsing %s (full)" % virtualfn)
+        logger.debug("Parsing %s (full)" % virtualfn)
         (fn, virtual, mc) = virtualfn2realfn(virtualfn)
         bb_data = self.load_bbfile(virtualfn, appends, virtonly=True)
         return bb_data[virtual]
@@ -400,7 +400,7 @@ class Cache(NoCache):
 
         self.cachefile = self.getCacheFile("bb_cache.dat")
 
-        self.logger.debug(1, "Cache dir: %s", self.cachedir)
+        self.logger.debug("Cache dir: %s", self.cachedir)
         bb.utils.mkdirhier(self.cachedir)
 
         cache_ok = True
@@ -408,7 +408,7 @@ class Cache(NoCache):
             for cache_class in self.caches_array:
                 cachefile = self.getCacheFile(cache_class.cachefile)
                 cache_exists = os.path.exists(cachefile)
-                self.logger.debug(2, "Checking if %s exists: %r", cachefile, cache_exists)
+                self.logger.debug2("Checking if %s exists: %r", cachefile, cache_exists)
                 cache_ok = cache_ok and cache_exists
                 cache_class.init_cacheData(self)
         if cache_ok:
@@ -416,7 +416,7 @@ class Cache(NoCache):
         elif os.path.isfile(self.cachefile):
             self.logger.info("Out of date cache found, rebuilding...")
         else:
-            self.logger.debug(1, "Cache file %s not found, building..." % self.cachefile)
+            self.logger.debug("Cache file %s not found, building..." % self.cachefile)
 
         # We don't use the symlink, its just for debugging convinience
         if self.mc:
@@ -453,7 +453,7 @@ class Cache(NoCache):
 
         for cache_class in self.caches_array:
             cachefile = self.getCacheFile(cache_class.cachefile)
-            self.logger.debug(1, 'Loading cache file: %s' % cachefile)
+            self.logger.debug('Loading cache file: %s' % cachefile)
             with open(cachefile, "rb") as cachefile:
                 pickled = pickle.Unpickler(cachefile)
                 # Check cache version information
@@ -500,7 +500,7 @@ class Cache(NoCache):
 
     def parse(self, filename, appends):
         """Parse the specified filename, returning the recipe information"""
-        self.logger.debug(1, "Parsing %s", filename)
+        self.logger.debug("Parsing %s", filename)
         infos = []
         datastores = self.load_bbfile(filename, appends, mc=self.mc)
         depends = []
@@ -554,7 +554,7 @@ class Cache(NoCache):
         cached, infos = self.load(fn, appends)
         for virtualfn, info_array in infos:
             if info_array[0].skipped:
-                self.logger.debug(1, "Skipping %s: %s", virtualfn, info_array[0].skipreason)
+                self.logger.debug("Skipping %s: %s", virtualfn, info_array[0].skipreason)
                 skipped += 1
             else:
                 self.add_info(virtualfn, info_array, cacheData, not cached)
@@ -590,21 +590,21 @@ class Cache(NoCache):
 
         # File isn't in depends_cache
         if not fn in self.depends_cache:
-            self.logger.debug(2, "%s is not cached", fn)
+            self.logger.debug2("%s is not cached", fn)
             return False
 
         mtime = bb.parse.cached_mtime_noerror(fn)
 
         # Check file still exists
         if mtime == 0:
-            self.logger.debug(2, "%s no longer exists", fn)
+            self.logger.debug2("%s no longer exists", fn)
             self.remove(fn)
             return False
 
         info_array = self.depends_cache[fn]
         # Check the file's timestamp
         if mtime != info_array[0].timestamp:
-            self.logger.debug(2, "%s changed", fn)
+            self.logger.debug2("%s changed", fn)
             self.remove(fn)
             return False
 
@@ -615,13 +615,13 @@ class Cache(NoCache):
                 fmtime = bb.parse.cached_mtime_noerror(f)
                 # Check if file still exists
                 if old_mtime != 0 and fmtime == 0:
-                    self.logger.debug(2, "%s's dependency %s was removed",
+                    self.logger.debug2("%s's dependency %s was removed",
                                          fn, f)
                     self.remove(fn)
                     return False
 
                 if (fmtime != old_mtime):
-                    self.logger.debug(2, "%s's dependency %s changed",
+                    self.logger.debug2("%s's dependency %s changed",
                                          fn, f)
                     self.remove(fn)
                     return False
@@ -638,14 +638,14 @@ class Cache(NoCache):
                         continue
                     f, exist = f.split(":")
                     if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
-                        self.logger.debug(2, "%s's file checksum list file %s changed",
+                        self.logger.debug2("%s's file checksum list file %s changed",
                                              fn, f)
                         self.remove(fn)
                         return False
 
         if tuple(appends) != tuple(info_array[0].appends):
-            self.logger.debug(2, "appends for %s changed", fn)
-            self.logger.debug(2, "%s to %s" % (str(appends), str(info_array[0].appends)))
+            self.logger.debug2("appends for %s changed", fn)
+            self.logger.debug2("%s to %s" % (str(appends), str(info_array[0].appends)))
             self.remove(fn)
             return False
 
@@ -654,10 +654,10 @@ class Cache(NoCache):
             virtualfn = variant2virtual(fn, cls)
             self.clean.add(virtualfn)
             if virtualfn not in self.depends_cache:
-                self.logger.debug(2, "%s is not cached", virtualfn)
+                self.logger.debug2("%s is not cached", virtualfn)
                 invalid = True
             elif len(self.depends_cache[virtualfn]) != len(self.caches_array):
-                self.logger.debug(2, "Extra caches missing for %s?" % virtualfn)
+                self.logger.debug2("Extra caches missing for %s?" % virtualfn)
                 invalid = True
 
         # If any one of the variants is not present, mark as invalid for all
@@ -665,10 +665,10 @@ class Cache(NoCache):
             for cls in info_array[0].variants:
                 virtualfn = variant2virtual(fn, cls)
                 if virtualfn in self.clean:
-                    self.logger.debug(2, "Removing %s from cache", virtualfn)
+                    self.logger.debug2("Removing %s from cache", virtualfn)
                     self.clean.remove(virtualfn)
             if fn in self.clean:
-                self.logger.debug(2, "Marking %s as not clean", fn)
+                self.logger.debug2("Marking %s as not clean", fn)
                 self.clean.remove(fn)
             return False
 
@@ -681,10 +681,10 @@ class Cache(NoCache):
         Called from the parser in error cases
         """
         if fn in self.depends_cache:
-            self.logger.debug(1, "Removing %s from cache", fn)
+            self.logger.debug("Removing %s from cache", fn)
             del self.depends_cache[fn]
         if fn in self.clean:
-            self.logger.debug(1, "Marking %s as unclean", fn)
+            self.logger.debug("Marking %s as unclean", fn)
             self.clean.remove(fn)
 
     def sync(self):
@@ -697,13 +697,13 @@ class Cache(NoCache):
             return
 
         if self.cacheclean:
-            self.logger.debug(2, "Cache is clean, not saving.")
+            self.logger.debug2("Cache is clean, not saving.")
             return
 
         for cache_class in self.caches_array:
             cache_class_name = cache_class.__name__
             cachefile = self.getCacheFile(cache_class.cachefile)
-            self.logger.debug(2, "Writing %s", cachefile)
+            self.logger.debug2("Writing %s", cachefile)
             with open(cachefile, "wb") as f:
                 p = pickle.Pickler(f, pickle.HIGHEST_PROTOCOL)
                 p.dump(__cache_version__)
@@ -879,7 +879,7 @@ class MultiProcessCache(object):
         bb.utils.mkdirhier(cachedir)
         self.cachefile = os.path.join(cachedir,
                                       cache_file_name or self.__class__.cache_file_name)
-        logger.debug(1, "Using cache in '%s'", self.cachefile)
+        logger.debug("Using cache in '%s'", self.cachefile)
 
         glf = bb.utils.lockfile(self.cachefile + ".lock")
 
@@ -985,7 +985,7 @@ class SimpleCache(object):
         bb.utils.mkdirhier(cachedir)
         self.cachefile = os.path.join(cachedir,
                                       cache_file_name or self.__class__.cache_file_name)
-        logger.debug(1, "Using cache in '%s'", self.cachefile)
+        logger.debug("Using cache in '%s'", self.cachefile)
 
         glf = bb.utils.lockfile(self.cachefile + ".lock")
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4446addc77..6835c7e982 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -441,7 +441,7 @@ class BBCooker:
                         continue
                 except AttributeError:
                     pass
-                logger.debug(1, "Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
+                logger.debug("Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
                 print("Marking as dirty due to '%s' option change to '%s'" % (o, options[o]))
                 clean = False
             if hasattr(self.configuration, o):
@@ -468,17 +468,17 @@ class BBCooker:
 
         for k in bb.utils.approved_variables():
             if k in environment and k not in self.configuration.env:
-                logger.debug(1, "Updating new environment variable %s to %s" % (k, environment[k]))
+                logger.debug("Updating new environment variable %s to %s" % (k, environment[k]))
                 self.configuration.env[k] = environment[k]
                 clean = False
             if k in self.configuration.env and k not in environment:
-                logger.debug(1, "Updating environment variable %s (deleted)" % (k))
+                logger.debug("Updating environment variable %s (deleted)" % (k))
                 del self.configuration.env[k]
                 clean = False
             if k not in self.configuration.env and k not in environment:
                 continue
             if environment[k] != self.configuration.env[k]:
-                logger.debug(1, "Updating environment variable %s from %s to %s" % (k, self.configuration.env[k], environment[k]))
+                logger.debug("Updating environment variable %s from %s to %s" % (k, self.configuration.env[k], environment[k]))
                 self.configuration.env[k] = environment[k]
                 clean = False
 
@@ -486,7 +486,7 @@ class BBCooker:
         self.configuration.env = environment
 
         if not clean:
-            logger.debug(1, "Base environment change, triggering reparse")
+            logger.debug("Base environment change, triggering reparse")
             self.reset()
 
     def runCommands(self, server, data, abort):
@@ -697,7 +697,7 @@ class BBCooker:
                         if depmc not in self.multiconfigs:
                             bb.fatal("Multiconfig dependency %s depends on nonexistent multiconfig configuration named configuration %s" % (k,depmc))
                         else:
-                            logger.debug(1, "Adding providers for multiconfig dependency %s" % l[3])
+                            logger.debug("Adding providers for multiconfig dependency %s" % l[3])
                             taskdata[depmc].add_provider(localdata[depmc], self.recipecaches[depmc], l[3])
                             seen.add(k)
                             new = True
@@ -1553,7 +1553,7 @@ class BBCooker:
         self.inotify_modified_files = []
 
         if not self.baseconfig_valid:
-            logger.debug(1, "Reloading base configuration data")
+            logger.debug("Reloading base configuration data")
             self.initConfigurationData()
             self.handlePRServ()
 
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index ee3d7b1672..19169d780f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -428,7 +428,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     uri_decoded = list(decodeurl(ud.url))
     uri_find_decoded = list(decodeurl(uri_find))
     uri_replace_decoded = list(decodeurl(uri_replace))
-    logger.debug(2, "For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
+    logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
     result_decoded = ['', '', '', '', '', {}]
     for loc, i in enumerate(uri_find_decoded):
         result_decoded[loc] = uri_decoded[loc]
@@ -474,7 +474,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
     result = encodeurl(result_decoded)
     if result == ud.url:
         return None
-    logger.debug(2, "For url %s returning %s" % (ud.url, result))
+    logger.debug2("For url %s returning %s" % (ud.url, result))
     return result
 
 methods = []
@@ -499,9 +499,9 @@ def fetcher_init(d):
     # When to drop SCM head revisions controlled by user policy
     srcrev_policy = d.getVar('BB_SRCREV_POLICY') or "clear"
     if srcrev_policy == "cache":
-        logger.debug(1, "Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
+        logger.debug("Keeping SRCREV cache due to cache policy of: %s", srcrev_policy)
     elif srcrev_policy == "clear":
-        logger.debug(1, "Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
+        logger.debug("Clearing SRCREV cache due to cache policy of: %s", srcrev_policy)
         revs.clear()
     else:
         raise FetchError("Invalid SRCREV cache policy of: %s" % srcrev_policy)
@@ -857,9 +857,9 @@ def runfetchcmd(cmd, d, quiet=False, cleanup=None, log=None, workdir=None):
     cmd = 'export PSEUDO_DISABLED=1; ' + cmd
 
     if workdir:
-        logger.debug(1, "Running '%s' in %s" % (cmd, workdir))
+        logger.debug("Running '%s' in %s" % (cmd, workdir))
     else:
-        logger.debug(1, "Running %s", cmd)
+        logger.debug("Running %s", cmd)
 
     success = False
     error_message = ""
@@ -900,7 +900,7 @@ def check_network_access(d, info, url):
     elif not trusted_network(d, url):
         raise UntrustedUrl(url, info)
     else:
-        logger.debug(1, "Fetcher accessed the network with the command %s" % info)
+        logger.debug("Fetcher accessed the network with the command %s" % info)
 
 def build_mirroruris(origud, mirrors, ld):
     uris = []
@@ -926,7 +926,7 @@ def build_mirroruris(origud, mirrors, ld):
                     continue
 
                 if not trusted_network(ld, newuri):
-                    logger.debug(1, "Mirror %s not in the list of trusted networks, skipping" %  (newuri))
+                    logger.debug("Mirror %s not in the list of trusted networks, skipping" %  (newuri))
                     continue
 
                 # Create a local copy of the mirrors minus the current line
@@ -939,8 +939,8 @@ def build_mirroruris(origud, mirrors, ld):
                     newud = FetchData(newuri, ld)
                     newud.setup_localpath(ld)
                 except bb.fetch2.BBFetchException as e:
-                    logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
-                    logger.debug(1, str(e))
+                    logger.debug("Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
+                    logger.debug(str(e))
                     try:
                         # setup_localpath of file:// urls may fail, we should still see
                         # if mirrors of the url exist
@@ -1043,8 +1043,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         elif isinstance(e, NoChecksumError):
             raise
         else:
-            logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (ud.url, origud.url))
-            logger.debug(1, str(e))
+            logger.debug("Mirror fetch failure for url %s (original url: %s)" % (ud.url, origud.url))
+            logger.debug(str(e))
         try:
             ud.method.clean(ud, ld)
         except UnboundLocalError:
@@ -1688,7 +1688,7 @@ class Fetch(object):
                 if m.verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
                     done = True
                 elif m.try_premirror(ud, self.d):
-                    logger.debug(1, "Trying PREMIRRORS")
+                    logger.debug("Trying PREMIRRORS")
                     mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
                     done = m.try_mirrors(self, ud, self.d, mirrors)
                     if done:
@@ -1698,7 +1698,7 @@ class Fetch(object):
                             m.update_donestamp(ud, self.d)
                         except ChecksumError as e:
                             logger.warning("Checksum failure encountered with premirror download of %s - will attempt other sources." % u)
-                            logger.debug(1, str(e))
+                            logger.debug(str(e))
                             done = False
 
                 if premirroronly:
@@ -1710,7 +1710,7 @@ class Fetch(object):
                     try:
                         if not trusted_network(self.d, ud.url):
                             raise UntrustedUrl(ud.url)
-                        logger.debug(1, "Trying Upstream")
+                        logger.debug("Trying Upstream")
                         m.download(ud, self.d)
                         if hasattr(m, "build_mirror_data"):
                             m.build_mirror_data(ud, self.d)
@@ -1725,19 +1725,19 @@ class Fetch(object):
                     except BBFetchException as e:
                         if isinstance(e, ChecksumError):
                             logger.warning("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
-                            logger.debug(1, str(e))
+                            logger.debug(str(e))
                             if os.path.exists(ud.localpath):
                                 rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:
                             logger.warning('Failed to fetch URL %s, attempting MIRRORS if available' % u)
-                            logger.debug(1, str(e))
+                            logger.debug(str(e))
                         firsterr = e
                         # Remove any incomplete fetch
                         if not verified_stamp:
                             m.clean(ud, self.d)
-                        logger.debug(1, "Trying MIRRORS")
+                        logger.debug("Trying MIRRORS")
                         mirrors = mirror_from_string(self.d.getVar('MIRRORS'))
                         done = m.try_mirrors(self, ud, self.d, mirrors)
 
@@ -1774,7 +1774,7 @@ class Fetch(object):
             ud = self.ud[u]
             ud.setup_localpath(self.d)
             m = ud.method
-            logger.debug(1, "Testing URL %s", u)
+            logger.debug("Testing URL %s", u)
             # First try checking uri, u, from PREMIRRORS
             mirrors = mirror_from_string(self.d.getVar('PREMIRRORS'))
             ret = m.try_mirrors(self, ud, self.d, mirrors, True)
diff --git a/bitbake/lib/bb/fetch2/bzr.py b/bitbake/lib/bb/fetch2/bzr.py
index 566ace9f05..fc558f50b0 100644
--- a/bitbake/lib/bb/fetch2/bzr.py
+++ b/bitbake/lib/bb/fetch2/bzr.py
@@ -74,16 +74,16 @@ class Bzr(FetchMethod):
 
         if os.access(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir), '.bzr'), os.R_OK):
             bzrcmd = self._buildbzrcommand(ud, d, "update")
-            logger.debug(1, "BZR Update %s", ud.url)
+            logger.debug("BZR Update %s", ud.url)
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
             runfetchcmd(bzrcmd, d, workdir=os.path.join(ud.pkgdir, os.path.basename(ud.path)))
         else:
             bb.utils.remove(os.path.join(ud.pkgdir, os.path.basename(ud.pkgdir)), True)
             bzrcmd = self._buildbzrcommand(ud, d, "fetch")
             bb.fetch2.check_network_access(d, bzrcmd, ud.url)
-            logger.debug(1, "BZR Checkout %s", ud.url)
+            logger.debug("BZR Checkout %s", ud.url)
             bb.utils.mkdirhier(ud.pkgdir)
-            logger.debug(1, "Running %s", bzrcmd)
+            logger.debug("Running %s", bzrcmd)
             runfetchcmd(bzrcmd, d, workdir=ud.pkgdir)
 
         scmdata = ud.parm.get("scmdata", "")
@@ -109,7 +109,7 @@ class Bzr(FetchMethod):
         """
         Return the latest upstream revision number
         """
-        logger.debug(2, "BZR fetcher hitting network for %s", ud.url)
+        logger.debug2("BZR fetcher hitting network for %s", ud.url)
 
         bb.fetch2.check_network_access(d, self._buildbzrcommand(ud, d, "revno"), ud.url)
 
diff --git a/bitbake/lib/bb/fetch2/clearcase.py b/bitbake/lib/bb/fetch2/clearcase.py
index 49d7ae1b09..1a9c863769 100644
--- a/bitbake/lib/bb/fetch2/clearcase.py
+++ b/bitbake/lib/bb/fetch2/clearcase.py
@@ -70,7 +70,7 @@ class ClearCase(FetchMethod):
         return ud.type in ['ccrc']
 
     def debug(self, msg):
-        logger.debug(1, "ClearCase: %s", msg)
+        logger.debug("ClearCase: %s", msg)
 
     def urldata_init(self, ud, d):
         """
diff --git a/bitbake/lib/bb/fetch2/cvs.py b/bitbake/lib/bb/fetch2/cvs.py
index 22abdef792..01de5ff4ca 100644
--- a/bitbake/lib/bb/fetch2/cvs.py
+++ b/bitbake/lib/bb/fetch2/cvs.py
@@ -109,7 +109,7 @@ class Cvs(FetchMethod):
             cvsupdatecmd = "CVS_RSH=\"%s\" %s" % (cvs_rsh, cvsupdatecmd)
 
         # create module directory
-        logger.debug(2, "Fetch: checking for module directory")
+        logger.debug2("Fetch: checking for module directory")
         moddir = os.path.join(ud.pkgdir, localdir)
         workdir = None
         if os.access(os.path.join(moddir, 'CVS'), os.R_OK):
@@ -123,7 +123,7 @@ class Cvs(FetchMethod):
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
             workdir = ud.pkgdir
-            logger.debug(1, "Running %s", cvscmd)
+            logger.debug("Running %s", cvscmd)
             bb.fetch2.check_network_access(d, cvscmd, ud.url)
             cmd = cvscmd
 
diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index d6e5c5c050..a4527bf364 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -78,7 +78,7 @@ class GitSM(Git):
                     module_hash = ""
 
                 if not module_hash:
-                    logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", m)
+                    logger.debug("submodule %s is defined, but is not initialized in the repository. Skipping", m)
                     continue
 
                 submodules.append(m)
@@ -179,7 +179,7 @@ class GitSM(Git):
                             (ud.basecmd, ud.revisions[ud.names[0]]), d, workdir=ud.clonedir)
 
         if len(need_update_list) > 0:
-            logger.debug(1, 'gitsm: Submodules requiring update: %s' % (' '.join(need_update_list)))
+            logger.debug('gitsm: Submodules requiring update: %s' % (' '.join(need_update_list)))
             return True
 
         return False
diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
index 8f503701ed..063e13008a 100644
--- a/bitbake/lib/bb/fetch2/hg.py
+++ b/bitbake/lib/bb/fetch2/hg.py
@@ -150,7 +150,7 @@ class Hg(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
+        logger.debug2("Fetch: checking for module directory '" + ud.moddir + "'")
 
         # If the checkout doesn't exist and the mirror tarball does, extract it
         if not os.path.exists(ud.pkgdir) and os.path.exists(ud.fullmirror):
@@ -160,7 +160,7 @@ class Hg(FetchMethod):
         if os.access(os.path.join(ud.moddir, '.hg'), os.R_OK):
             # Found the source, check whether need pull
             updatecmd = self._buildhgcommand(ud, d, "update")
-            logger.debug(1, "Running %s", updatecmd)
+            logger.debug("Running %s", updatecmd)
             try:
                 runfetchcmd(updatecmd, d, workdir=ud.moddir)
             except bb.fetch2.FetchError:
@@ -168,7 +168,7 @@ class Hg(FetchMethod):
                 pullcmd = self._buildhgcommand(ud, d, "pull")
                 logger.info("Pulling " + ud.url)
                 # update sources there
-                logger.debug(1, "Running %s", pullcmd)
+                logger.debug("Running %s", pullcmd)
                 bb.fetch2.check_network_access(d, pullcmd, ud.url)
                 runfetchcmd(pullcmd, d, workdir=ud.moddir)
                 try:
@@ -183,14 +183,14 @@ class Hg(FetchMethod):
             logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            logger.debug(1, "Running %s", fetchcmd)
+            logger.debug("Running %s", fetchcmd)
             bb.fetch2.check_network_access(d, fetchcmd, ud.url)
             runfetchcmd(fetchcmd, d, workdir=ud.pkgdir)
 
         # Even when we clone (fetch), we still need to update as hg's clone
         # won't checkout the specified revision if its on a branch
         updatecmd = self._buildhgcommand(ud, d, "update")
-        logger.debug(1, "Running %s", updatecmd)
+        logger.debug("Running %s", updatecmd)
         runfetchcmd(updatecmd, d, workdir=ud.moddir)
 
     def clean(self, ud, d):
@@ -247,9 +247,9 @@ class Hg(FetchMethod):
         if scmdata != "nokeep":
             proto = ud.parm.get('protocol', 'http')
             if not os.access(os.path.join(codir, '.hg'), os.R_OK):
-                logger.debug(2, "Unpack: creating new hg repository in '" + codir + "'")
+                logger.debug2("Unpack: creating new hg repository in '" + codir + "'")
                 runfetchcmd("%s init %s" % (ud.basecmd, codir), d)
-            logger.debug(2, "Unpack: updating source in '" + codir + "'")
+            logger.debug2("Unpack: updating source in '" + codir + "'")
             if ud.user and ud.pswd:
                 runfetchcmd("%s --config auth.default.prefix=* --config auth.default.username=%s --config auth.default.password=%s --config \"auth.default.schemes=%s\" pull %s" % (ud.basecmd, ud.user, ud.pswd, proto, ud.moddir), d, workdir=codir)
             else:
@@ -259,5 +259,5 @@ class Hg(FetchMethod):
             else:
                 runfetchcmd("%s up -C %s" % (ud.basecmd, revflag), d, workdir=codir)
         else:
-            logger.debug(2, "Unpack: extracting source to '" + codir + "'")
+            logger.debug2("Unpack: extracting source to '" + codir + "'")
             runfetchcmd("%s archive -t files %s %s" % (ud.basecmd, revflag, codir), d, workdir=ud.moddir)
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 25d4557db6..e7d1c8c58f 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -54,12 +54,12 @@ class Local(FetchMethod):
             return [path]
         filespath = d.getVar('FILESPATH')
         if filespath:
-            logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
+            logger.debug2("Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
             newpath, hist = bb.utils.which(filespath, path, history=True)
             searched.extend(hist)
         if not os.path.exists(newpath):
             dldirfile = os.path.join(d.getVar("DL_DIR"), path)
-            logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
+            logger.debug2("Defaulting to %s for %s" % (dldirfile, path))
             bb.utils.mkdirhier(os.path.dirname(dldirfile))
             searched.append(dldirfile)
             return searched
diff --git a/bitbake/lib/bb/fetch2/osc.py b/bitbake/lib/bb/fetch2/osc.py
index 3a6cd29510..d9ce44390c 100644
--- a/bitbake/lib/bb/fetch2/osc.py
+++ b/bitbake/lib/bb/fetch2/osc.py
@@ -84,13 +84,13 @@ class Osc(FetchMethod):
         Fetch url
         """
 
-        logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
+        logger.debug2("Fetch: checking for module directory '" + ud.moddir + "'")
 
         if os.access(os.path.join(d.getVar('OSCDIR'), ud.path, ud.module), os.R_OK):
             oscupdatecmd = self._buildosccommand(ud, d, "update")
             logger.info("Update "+ ud.url)
             # update sources there
-            logger.debug(1, "Running %s", oscupdatecmd)
+            logger.debug("Running %s", oscupdatecmd)
             bb.fetch2.check_network_access(d, oscupdatecmd, ud.url)
             runfetchcmd(oscupdatecmd, d, workdir=ud.moddir)
         else:
@@ -98,7 +98,7 @@ class Osc(FetchMethod):
             logger.info("Fetch " + ud.url)
             # check out sources there
             bb.utils.mkdirhier(ud.pkgdir)
-            logger.debug(1, "Running %s", oscfetchcmd)
+            logger.debug("Running %s", oscfetchcmd)
             bb.fetch2.check_network_access(d, oscfetchcmd, ud.url)
             runfetchcmd(oscfetchcmd, d, workdir=ud.pkgdir)
 
diff --git a/bitbake/lib/bb/fetch2/perforce.py b/bitbake/lib/bb/fetch2/perforce.py
index da6d337461..e2a41a4a12 100644
--- a/bitbake/lib/bb/fetch2/perforce.py
+++ b/bitbake/lib/bb/fetch2/perforce.py
@@ -90,16 +90,16 @@ class Perforce(FetchMethod):
         p4port = d.getVar('P4PORT')
 
         if p4port:
-            logger.debug(1, 'Using recipe provided P4PORT: %s' % p4port)
+            logger.debug('Using recipe provided P4PORT: %s' % p4port)
             ud.host = p4port
         else:
-            logger.debug(1, 'Trying to use P4CONFIG to automatically set P4PORT...')
+            logger.debug('Trying to use P4CONFIG to automatically set P4PORT...')
             ud.usingp4config = True
             p4cmd = '%s info | grep "Server address"' % ud.basecmd
             bb.fetch2.check_network_access(d, p4cmd, ud.url)
             ud.host = runfetchcmd(p4cmd, d, True)
             ud.host = ud.host.split(': ')[1].strip()
-            logger.debug(1, 'Determined P4PORT to be: %s' % ud.host)
+            logger.debug('Determined P4PORT to be: %s' % ud.host)
             if not ud.host:
                 raise FetchError('Could not determine P4PORT from P4CONFIG')
 
@@ -208,7 +208,7 @@ class Perforce(FetchMethod):
         for filename in p4fileslist:
             item = filename.split(' - ')
             lastaction = item[1].split()
-            logger.debug(1, 'File: %s Last Action: %s' % (item[0], lastaction[0]))
+            logger.debug('File: %s Last Action: %s' % (item[0], lastaction[0]))
             if lastaction[0] == 'delete':
                 continue
             filelist.append(item[0])
@@ -255,7 +255,7 @@ class Perforce(FetchMethod):
             raise FetchError('Could not determine the latest perforce changelist')
 
         tipcset = tip.split(' ')[1]
-        logger.debug(1, 'p4 tip found to be changelist %s' % tipcset)
+        logger.debug('p4 tip found to be changelist %s' % tipcset)
         return tipcset
 
     def sortable_revision(self, ud, d, name):
diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
index 2bdbbd4097..fa4cb8149b 100644
--- a/bitbake/lib/bb/fetch2/repo.py
+++ b/bitbake/lib/bb/fetch2/repo.py
@@ -47,7 +47,7 @@ class Repo(FetchMethod):
         """Fetch url"""
 
         if os.access(os.path.join(d.getVar("DL_DIR"), ud.localfile), os.R_OK):
-            logger.debug(1, "%s already exists (or was stashed). Skipping repo init / sync.", ud.localpath)
+            logger.debug("%s already exists (or was stashed). Skipping repo init / sync.", ud.localpath)
             return
 
         repodir = d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo")
diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 971a5add4a..8856ef1c62 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -116,7 +116,7 @@ class Svn(FetchMethod):
     def download(self, ud, d):
         """Fetch url"""
 
-        logger.debug(2, "Fetch: checking for module directory '" + ud.moddir + "'")
+        logger.debug2("Fetch: checking for module directory '" + ud.moddir + "'")
 
         lf = bb.utils.lockfile(ud.svnlock)
 
@@ -129,7 +129,7 @@ class Svn(FetchMethod):
                     runfetchcmd(ud.basecmd + " upgrade", d, workdir=ud.moddir)
                 except FetchError:
                     pass
-                logger.debug(1, "Running %s", svncmd)
+                logger.debug("Running %s", svncmd)
                 bb.fetch2.check_network_access(d, svncmd, ud.url)
                 runfetchcmd(svncmd, d, workdir=ud.moddir)
             else:
@@ -137,7 +137,7 @@ class Svn(FetchMethod):
                 logger.info("Fetch " + ud.url)
                 # check out sources there
                 bb.utils.mkdirhier(ud.pkgdir)
-                logger.debug(1, "Running %s", svncmd)
+                logger.debug("Running %s", svncmd)
                 bb.fetch2.check_network_access(d, svncmd, ud.url)
                 runfetchcmd(svncmd, d, workdir=ud.pkgdir)
 
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index e952f411c7..78a49676fe 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -88,7 +88,7 @@ class Wget(FetchMethod):
 
         progresshandler = WgetProgressHandler(d)
 
-        logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
+        logger.debug2("Fetching %s using command '%s'" % (ud.url, command))
         bb.fetch2.check_network_access(d, command, ud.url)
         runfetchcmd(command + ' --progress=dot -v', d, quiet, log=progresshandler, workdir=workdir)
 
@@ -326,11 +326,11 @@ class Wget(FetchMethod):
                 pass
         except urllib.error.URLError as e:
             if try_again:
-                logger.debug(2, "checkstatus: trying again")
+                logger.debug2("checkstatus: trying again")
                 return self.checkstatus(fetch, ud, d, False)
             else:
                 # debug for now to avoid spamming the logs in e.g. remote sstate searches
-                logger.debug(2, "checkstatus() urlopen failed: %s" % e)
+                logger.debug2("checkstatus() urlopen failed: %s" % e)
                 return False
         return True
 
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 76e180b411..c01807ba87 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -71,7 +71,7 @@ def update_mtime(f):
 
 def update_cache(f):
     if f in __mtime_cache:
-        logger.debug(1, "Updating mtime cache for %s" % f)
+        logger.debug("Updating mtime cache for %s" % f)
         update_mtime(f)
 
 def clear_cache():
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 0714296af2..0596993d01 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -34,7 +34,7 @@ class IncludeNode(AstNode):
         Include the file and evaluate the statements
         """
         s = data.expand(self.what_file)
-        logger.debug(2, "CONF %s:%s: including %s", self.filename, self.lineno, s)
+        logger.debug2("CONF %s:%s: including %s", self.filename, self.lineno, s)
 
         # TODO: Cache those includes... maybe not here though
         if self.force:
@@ -376,7 +376,7 @@ def _create_variants(datastores, names, function, onlyfinalise):
 def multi_finalize(fn, d):
     appends = (d.getVar("__BBAPPEND") or "").split()
     for append in appends:
-        logger.debug(1, "Appending .bbappend file %s to %s", append, fn)
+        logger.debug("Appending .bbappend file %s to %s", append, fn)
         bb.parse.BBHandler.handle(append, d, True)
 
     onlyfinalise = d.getVar("__ONLYFINALISE", False)
diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index 8a520e3071..21537c80a3 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -60,7 +60,7 @@ def inherit(files, fn, lineno, d):
                 file = abs_fn
 
         if not file in __inherit_cache:
-            logger.debug(1, "Inheriting %s (from %s:%d)" % (file, fn, lineno))
+            logger.debug("Inheriting %s (from %s:%d)" % (file, fn, lineno))
             __inherit_cache.append( file )
             d.setVar('__inherit_cache', __inherit_cache)
             include(fn, file, lineno, d, "inherit")
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index af64d3446e..f171c5c932 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -95,7 +95,7 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
         if exc.errno == errno.ENOENT:
             if error_out:
                 raise ParseError("Could not %s file %s" % (error_out, fn), parentfn, lineno)
-            logger.debug(2, "CONF file '%s' not found", fn)
+            logger.debug2("CONF file '%s' not found", fn)
         else:
             if error_out:
                 raise ParseError("Could not %s file %s: %s" % (error_out, fn, exc.strerror), parentfn, lineno)
diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 5f4fbe3508..c6a209fb3f 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -248,7 +248,7 @@ class PersistData(object):
                       stacklevel=2)
 
         self.data = persist(d)
-        logger.debug(1, "Using '%s' as the persistent data cache",
+        logger.debug("Using '%s' as the persistent data cache",
                      self.data.filename)
 
     def addDomain(self, domain):
diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 3f66a3d99f..0c87dfd4bc 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -165,7 +165,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
                 available_vers.sort()
                 logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))
         else:
-            logger.debug(1, "selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
+            logger.debug("selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
 
     return (preferred_ver, preferred_file)
 
@@ -232,7 +232,7 @@ def _filterProviders(providers, item, cfgData, dataCache):
             pkg_pn[pn] = []
         pkg_pn[pn].append(p)
 
-    logger.debug(1, "providers for %s are: %s", item, list(sorted(pkg_pn.keys())))
+    logger.debug("providers for %s are: %s", item, list(sorted(pkg_pn.keys())))
 
     # First add PREFERRED_VERSIONS
     for pn in sorted(pkg_pn):
@@ -291,7 +291,7 @@ def filterProviders(providers, item, cfgData, dataCache):
                 foundUnique = True
                 break
 
-    logger.debug(1, "sorted providers for %s are: %s", item, eligible)
+    logger.debug("sorted providers for %s are: %s", item, eligible)
 
     return eligible, foundUnique
 
@@ -333,7 +333,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
             provides = dataCache.pn_provides[pn]
             for provide in provides:
                 prefervar = cfgData.getVar('PREFERRED_PROVIDER_%s' % provide)
-                #logger.debug(1, "checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
+                #logger.debug("checking PREFERRED_PROVIDER_%s (value %s) against %s", provide, prefervar, pns.keys())
                 if prefervar in pns and pns[prefervar] not in preferred:
                     var = "PREFERRED_PROVIDER_%s = %s" % (provide, prefervar)
                     logger.verbose("selecting %s to satisfy runtime %s due to %s", prefervar, item, var)
@@ -349,7 +349,7 @@ def filterProvidersRunTime(providers, item, cfgData, dataCache):
     if numberPreferred > 1:
         logger.error("Trying to resolve runtime dependency %s resulted in conflicting PREFERRED_PROVIDER entries being found.\nThe providers found were: %s\nThe PREFERRED_PROVIDER entries resulting in this conflict were: %s. You could set PREFERRED_RPROVIDER_%s" % (item, preferred, preferred_vars, item))
 
-    logger.debug(1, "sorted runtime providers for %s are: %s", item, eligible)
+    logger.debug("sorted runtime providers for %s are: %s", item, eligible)
 
     return eligible, numberPreferred
 
@@ -384,7 +384,7 @@ def getRuntimeProviders(dataCache, rdepend):
             regexp_cache[pattern] = regexp
         if regexp.match(rdepend):
             rproviders += dataCache.packages_dynamic[pattern]
-            logger.debug(1, "Assuming %s is a dynamic package, but it may not exist" % rdepend)
+            logger.debug("Assuming %s is a dynamic package, but it may not exist" % rdepend)
 
     return rproviders
 
@@ -396,22 +396,22 @@ def buildWorldTargetList(dataCache, task=None):
     if dataCache.world_target:
         return
 
-    logger.debug(1, "collating packages for \"world\"")
+    logger.debug("collating packages for \"world\"")
     for f in dataCache.possible_world:
         terminal = True
         pn = dataCache.pkg_fn[f]
         if task and task not in dataCache.task_deps[f]['tasks']:
-            logger.debug(2, "World build skipping %s as task %s doesn't exist", f, task)
+            logger.debug2("World build skipping %s as task %s doesn't exist", f, task)
             terminal = False
 
         for p in dataCache.pn_provides[pn]:
             if p.startswith('virtual/'):
-                logger.debug(2, "World build skipping %s due to %s provider starting with virtual/", f, p)
+                logger.debug2("World build skipping %s due to %s provider starting with virtual/", f, p)
                 terminal = False
                 break
             for pf in dataCache.providers[p]:
                 if dataCache.pkg_fn[pf] != pn:
-                    logger.debug(2, "World build skipping %s due to both us and %s providing %s", f, pf, p)
+                    logger.debug2("World build skipping %s due to both us and %s providing %s", f, pf, p)
                     terminal = False
                     break
         if terminal:
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 7d493eb402..2f521e5a14 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -544,8 +544,8 @@ class RunQueueData:
         for tid in self.runtaskentries:
             if task_done[tid] is False or deps_left[tid] != 0:
                 problem_tasks.append(tid)
-                logger.debug(2, "Task %s is not buildable", tid)
-                logger.debug(2, "(Complete marker was %s and the remaining dependency count was %s)\n", task_done[tid], deps_left[tid])
+                logger.debug2("Task %s is not buildable", tid)
+                logger.debug2("(Complete marker was %s and the remaining dependency count was %s)\n", task_done[tid], deps_left[tid])
             self.runtaskentries[tid].weight = weight[tid]
 
         if problem_tasks:
@@ -643,7 +643,7 @@ class RunQueueData:
                 (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
                 #runtid = build_tid(mc, fn, taskname)
 
-                #logger.debug(2, "Processing %s,%s:%s", mc, fn, taskname)
+                #logger.debug2("Processing %s,%s:%s", mc, fn, taskname)
 
                 depends = set()
                 task_deps = self.dataCaches[mc].task_deps[taskfn]
@@ -1199,9 +1199,9 @@ class RunQueueData:
         """
         Dump some debug information on the internal data structures
         """
-        logger.debug(3, "run_tasks:")
+        logger.debug3("run_tasks:")
         for tid in self.runtaskentries:
-            logger.debug(3, " %s: %s   Deps %s RevDeps %s", tid,
+            logger.debug3(" %s: %s   Deps %s RevDeps %s", tid,
                          self.runtaskentries[tid].weight,
                          self.runtaskentries[tid].depends,
                          self.runtaskentries[tid].revdeps)
@@ -1238,7 +1238,7 @@ class RunQueue:
         self.fakeworker = {}
 
     def _start_worker(self, mc, fakeroot = False, rqexec = None):
-        logger.debug(1, "Starting bitbake-worker")
+        logger.debug("Starting bitbake-worker")
         magic = "decafbad"
         if self.cooker.configuration.profile:
             magic = "decafbadbad"
@@ -1283,7 +1283,7 @@ class RunQueue:
     def _teardown_worker(self, worker):
         if not worker:
             return
-        logger.debug(1, "Teardown for bitbake-worker")
+        logger.debug("Teardown for bitbake-worker")
         try:
            worker.process.stdin.write(b"<quit></quit>")
            worker.process.stdin.flush()
@@ -1356,12 +1356,12 @@ class RunQueue:
 
         # If the stamp is missing, it's not current
         if not os.access(stampfile, os.F_OK):
-            logger.debug(2, "Stampfile %s not available", stampfile)
+            logger.debug2("Stampfile %s not available", stampfile)
             return False
         # If it's a 'nostamp' task, it's not current
         taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
         if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
-            logger.debug(2, "%s.%s is nostamp\n", fn, taskname)
+            logger.debug2("%s.%s is nostamp\n", fn, taskname)
             return False
 
         if taskname != "do_setscene" and taskname.endswith("_setscene"):
@@ -1385,18 +1385,18 @@ class RunQueue:
                     continue
                 if fn == fn2 or (fulldeptree and fn2 not in stampwhitelist):
                     if not t2:
-                        logger.debug(2, 'Stampfile %s does not exist', stampfile2)
+                        logger.debug2('Stampfile %s does not exist', stampfile2)
                         iscurrent = False
                         break
                     if t1 < t2:
-                        logger.debug(2, 'Stampfile %s < %s', stampfile, stampfile2)
+                        logger.debug2('Stampfile %s < %s', stampfile, stampfile2)
                         iscurrent = False
                         break
                     if recurse and iscurrent:
                         if dep in cache:
                             iscurrent = cache[dep]
                             if not iscurrent:
-                                logger.debug(2, 'Stampfile for dependency %s:%s invalid (cached)' % (fn2, taskname2))
+                                logger.debug2('Stampfile for dependency %s:%s invalid (cached)' % (fn2, taskname2))
                         else:
                             iscurrent = self.check_stamp_task(dep, recurse=True, cache=cache)
                             cache[dep] = iscurrent
@@ -1761,7 +1761,7 @@ class RunQueueExecute:
         for scheduler in schedulers:
             if self.scheduler == scheduler.name:
                 self.sched = scheduler(self, self.rqdata)
-                logger.debug(1, "Using runqueue scheduler '%s'", scheduler.name)
+                logger.debug("Using runqueue scheduler '%s'", scheduler.name)
                 break
         else:
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
@@ -1899,7 +1899,7 @@ class RunQueueExecute:
                     break
             if alldeps:
                 self.setbuildable(revdep)
-                logger.debug(1, "Marking task %s as buildable", revdep)
+                logger.debug("Marking task %s as buildable", revdep)
 
     def task_complete(self, task):
         self.stats.taskCompleted()
@@ -1929,7 +1929,7 @@ class RunQueueExecute:
     def summarise_scenequeue_errors(self):
         err = False
         if not self.sqdone:
-            logger.debug(1, 'We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
+            logger.debug('We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
             completeevent = sceneQueueComplete(self.sq_stats, self.rq)
             bb.event.fire(completeevent, self.cfgData)
         if self.sq_deferred:
@@ -1986,7 +1986,7 @@ class RunQueueExecute:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
                     if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
-                            logger.debug(2, "Skipping setscene for task %s" % nexttask)
+                            logger.debug2("Skipping setscene for task %s" % nexttask)
                             self.sq_task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             if nexttask in self.sq_deferred:
@@ -1999,28 +1999,28 @@ class RunQueueExecute:
                     if nexttask in self.sq_deferred:
                         if self.sq_deferred[nexttask] not in self.runq_complete:
                             continue
-                        logger.debug(1, "Task %s no longer deferred" % nexttask)
+                        logger.debug("Task %s no longer deferred" % nexttask)
                         del self.sq_deferred[nexttask]
                         valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, 0, False, summary=False)
                         if not valid:
-                            logger.debug(1, "%s didn't become valid, skipping setscene" % nexttask)
+                            logger.debug("%s didn't become valid, skipping setscene" % nexttask)
                             self.sq_task_failoutright(nexttask)
                             return True
                         else:
                             self.sqdata.outrightfail.remove(nexttask)
                     if nexttask in self.sqdata.outrightfail:
-                        logger.debug(2, 'No package found, so skipping setscene task %s', nexttask)
+                        logger.debug2('No package found, so skipping setscene task %s', nexttask)
                         self.sq_task_failoutright(nexttask)
                         return True
                     if nexttask in self.sqdata.unskippable:
-                        logger.debug(2, "Setscene task %s is unskippable" % nexttask)
+                        logger.debug2("Setscene task %s is unskippable" % nexttask)
                     task = nexttask
                     break
         if task is not None:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
             taskname = taskname + "_setscene"
             if self.rq.check_stamp_task(task, taskname_from_tid(task), recurse = True, cache=self.stampcache):
-                logger.debug(2, 'Stamp for underlying task %s is current, so skipping setscene variant', task)
+                logger.debug2('Stamp for underlying task %s is current, so skipping setscene variant', task)
                 self.sq_task_failoutright(task)
                 return True
 
@@ -2030,12 +2030,12 @@ class RunQueueExecute:
                     return True
 
             if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
-                logger.debug(2, 'Setscene stamp current task %s, so skip it and its dependencies', task)
+                logger.debug2('Setscene stamp current task %s, so skip it and its dependencies', task)
                 self.sq_task_skip(task)
                 return True
 
             if self.cooker.configuration.skipsetscene:
-                logger.debug(2, 'No setscene tasks should be executed. Skipping %s', task)
+                logger.debug2('No setscene tasks should be executed. Skipping %s', task)
                 self.sq_task_failoutright(task)
                 return True
 
@@ -2097,12 +2097,12 @@ class RunQueueExecute:
                     return True
 
             if task in self.tasks_covered:
-                logger.debug(2, "Setscene covered task %s", task)
+                logger.debug2("Setscene covered task %s", task)
                 self.task_skip(task, "covered")
                 return True
 
             if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
-                logger.debug(2, "Stamp current task %s", task)
+                logger.debug2("Stamp current task %s", task)
 
                 self.task_skip(task, "existing")
                 self.runq_tasksrun.add(task)
@@ -2322,7 +2322,7 @@ class RunQueueExecute:
                     remapped = True
 
                 if not remapped:
-                    #logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
+                    #logger.debug("Task %s hash changes: %s->%s %s->%s" % (tid, orighash, newhash, origuni, newuni))
                     self.rqdata.runtaskentries[tid].hash = newhash
                     self.rqdata.runtaskentries[tid].unihash = newuni
                     changed.add(tid)
@@ -2337,7 +2337,7 @@ class RunQueueExecute:
             for mc in self.rq.fakeworker:
                 self.rq.fakeworker[mc].process.stdin.write(b"<newtaskhashes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
 
-            hashequiv_logger.debug(1, pprint.pformat("Tasks changed:\n%s" % (changed)))
+            hashequiv_logger.debug(pprint.pformat("Tasks changed:\n%s" % (changed)))
 
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
@@ -2356,7 +2356,7 @@ class RunQueueExecute:
             # Check no tasks this covers are running
             for dep in self.sqdata.sq_covered_tasks[tid]:
                 if dep in self.runq_running and dep not in self.runq_complete:
-                    hashequiv_logger.debug(2, "Task %s is running which blocks setscene for %s from running" % (dep, tid))
+                    hashequiv_logger.debug2("Task %s is running which blocks setscene for %s from running" % (dep, tid))
                     valid = False
                     break
             if not valid:
@@ -2430,7 +2430,7 @@ class RunQueueExecute:
 
         for dep in sorted(self.sqdata.sq_deps[task]):
             if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
-                logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
+                logger.debug2("%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
             if self.sqdata.sq_revdeps[dep].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
@@ -2460,7 +2460,7 @@ class RunQueueExecute:
         completed dependencies as buildable
         """
 
-        logger.debug(1, 'Found task %s which could be accelerated', task)
+        logger.debug('Found task %s which could be accelerated', task)
         self.scenequeue_covered.add(task)
         self.scenequeue_updatecounters(task)
 
@@ -2775,13 +2775,13 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
             continue
 
         if rq.check_stamp_task(tid, taskname + "_setscene", cache=stampcache):
-            logger.debug(2, 'Setscene stamp current for task %s', tid)
+            logger.debug2('Setscene stamp current for task %s', tid)
             sqdata.stamppresent.add(tid)
             sqrq.sq_task_skip(tid)
             continue
 
         if rq.check_stamp_task(tid, taskname, recurse = True, cache=stampcache):
-            logger.debug(2, 'Normal stamp current for task %s', tid)
+            logger.debug2('Normal stamp current for task %s', tid)
             sqdata.stamppresent.add(tid)
             sqrq.sq_task_skip(tid)
             continue
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index e0e03318a6..0d88c6ec68 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -541,7 +541,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 # is much more interesting, so it is reported at debug level 1
                 hashequiv_logger.debug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
             else:
-                hashequiv_logger.debug(2, 'No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
+                hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
         except hashserv.client.HashConnectionError as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
@@ -615,12 +615,12 @@ class SignatureGeneratorUniHashMixIn(object):
                 new_unihash = data['unihash']
 
                 if new_unihash != unihash:
-                    hashequiv_logger.debug(1, 'Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
+                    hashequiv_logger.debug('Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(fn + ':do_' + task, new_unihash), d)
                     self.set_unihash(tid, new_unihash)
                     d.setVar('BB_UNIHASH', new_unihash)
                 else:
-                    hashequiv_logger.debug(1, 'Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
+                    hashequiv_logger.debug('Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
             except hashserv.client.HashConnectionError as e:
                 bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
         finally:
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index ffbaf362e8..47bad6d1fa 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -131,7 +131,7 @@ class TaskData:
             for depend in dataCache.deps[fn]:
                 dependids.add(depend)
             self.depids[fn] = list(dependids)
-            logger.debug(2, "Added dependencies %s for %s", str(dataCache.deps[fn]), fn)
+            logger.debug2("Added dependencies %s for %s", str(dataCache.deps[fn]), fn)
 
         # Work out runtime dependencies
         if not fn in self.rdepids:
@@ -149,9 +149,9 @@ class TaskData:
                     rreclist.append(rdepend)
                     rdependids.add(rdepend)
             if rdependlist:
-                logger.debug(2, "Added runtime dependencies %s for %s", str(rdependlist), fn)
+                logger.debug2("Added runtime dependencies %s for %s", str(rdependlist), fn)
             if rreclist:
-                logger.debug(2, "Added runtime recommendations %s for %s", str(rreclist), fn)
+                logger.debug2("Added runtime recommendations %s for %s", str(rreclist), fn)
             self.rdepids[fn] = list(rdependids)
 
         for dep in self.depids[fn]:
@@ -378,7 +378,7 @@ class TaskData:
         for fn in eligible:
             if fn in self.failed_fns:
                 continue
-            logger.debug(2, "adding %s to satisfy %s", fn, item)
+            logger.debug2("adding %s to satisfy %s", fn, item)
             self.add_build_target(fn, item)
             self.add_tasks(fn, dataCache)
 
@@ -431,7 +431,7 @@ class TaskData:
         for fn in eligible:
             if fn in self.failed_fns:
                 continue
-            logger.debug(2, "adding '%s' to satisfy runtime '%s'", fn, item)
+            logger.debug2("adding '%s' to satisfy runtime '%s'", fn, item)
             self.add_runtime_target(fn, item)
             self.add_tasks(fn, dataCache)
 
@@ -446,7 +446,7 @@ class TaskData:
             return
         if not missing_list:
             missing_list = []
-        logger.debug(1, "File '%s' is unbuildable, removing...", fn)
+        logger.debug("File '%s' is unbuildable, removing...", fn)
         self.failed_fns.append(fn)
         for target in self.build_targets:
             if fn in self.build_targets[target]:
@@ -526,7 +526,7 @@ class TaskData:
                     added = added + 1
                 except (bb.providers.NoRProvider, bb.providers.MultipleRProvider):
                     self.remove_runtarget(target)
-            logger.debug(1, "Resolved " + str(added) + " extra dependencies")
+            logger.debug("Resolved " + str(added) + " extra dependencies")
             if added == 0:
                 break
         # self.dump_data()
@@ -549,38 +549,38 @@ class TaskData:
         """
         Dump some debug information on the internal data structures
         """
-        logger.debug(3, "build_names:")
-        logger.debug(3, ", ".join(self.build_targets))
+        logger.debug3("build_names:")
+        logger.debug3(", ".join(self.build_targets))
 
-        logger.debug(3, "run_names:")
-        logger.debug(3, ", ".join(self.run_targets))
+        logger.debug3("run_names:")
+        logger.debug3(", ".join(self.run_targets))
 
-        logger.debug(3, "build_targets:")
+        logger.debug3("build_targets:")
         for target in self.build_targets:
             targets = "None"
             if target in self.build_targets:
                 targets = self.build_targets[target]
-            logger.debug(3, " %s: %s", target, targets)
+            logger.debug3(" %s: %s", target, targets)
 
-        logger.debug(3, "run_targets:")
+        logger.debug3("run_targets:")
         for target in self.run_targets:
             targets = "None"
             if target in self.run_targets:
                 targets = self.run_targets[target]
-            logger.debug(3, " %s: %s", target, targets)
+            logger.debug3(" %s: %s", target, targets)
 
-        logger.debug(3, "tasks:")
+        logger.debug3("tasks:")
         for tid in self.taskentries:
-            logger.debug(3, " %s: %s %s %s",
+            logger.debug3(" %s: %s %s %s",
                        tid,
                        self.taskentries[tid].idepends,
                        self.taskentries[tid].irdepends,
                        self.taskentries[tid].tdepends)
 
-        logger.debug(3, "dependency ids (per fn):")
+        logger.debug3("dependency ids (per fn):")
         for fn in self.depids:
-            logger.debug(3, " %s: %s", fn, self.depids[fn])
+            logger.debug3(" %s: %s", fn, self.depids[fn])
 
-        logger.debug(3, "runtime dependency ids (per fn):")
+        logger.debug3("runtime dependency ids (per fn):")
         for fn in self.rdepids:
-            logger.debug(3, " %s: %s", fn, self.rdepids[fn])
+            logger.debug3(" %s: %s", fn, self.rdepids[fn])
diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 82c62e3324..43aa592842 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -148,14 +148,14 @@ class ORMWrapper(object):
         buildrequest = None
         if brbe is not None:
             # Toaster-triggered build
-            logger.debug(1, "buildinfohelper: brbe is %s" % brbe)
+            logger.debug("buildinfohelper: brbe is %s" % brbe)
             br, _ = brbe.split(":")
             buildrequest = BuildRequest.objects.get(pk=br)
             prj = buildrequest.project
         else:
             # CLI build
             prj = Project.objects.get_or_create_default_project()
-            logger.debug(1, "buildinfohelper: project is not specified, defaulting to %s" % prj)
+            logger.debug("buildinfohelper: project is not specified, defaulting to %s" % prj)
 
         if buildrequest is not None:
             # reuse existing Build object
@@ -171,7 +171,7 @@ class ORMWrapper(object):
                 completed_on=now,
                 build_name='')
 
-        logger.debug(1, "buildinfohelper: build is created %s" % build)
+        logger.debug("buildinfohelper: build is created %s" % build)
 
         if buildrequest is not None:
             buildrequest.build = build
@@ -906,7 +906,7 @@ class BuildInfoHelper(object):
 
         self.project = None
 
-        logger.debug(1, "buildinfohelper: Build info helper inited %s" % vars(self))
+        logger.debug("buildinfohelper: Build info helper inited %s" % vars(self))
 
 
     ###################
@@ -1620,7 +1620,7 @@ class BuildInfoHelper(object):
             # if we have a backlog of events, do our best to save them here
             if len(self.internal_state['backlog']):
                 tempevent = self.internal_state['backlog'].pop()
-                logger.debug(1, "buildinfohelper: Saving stored event %s "
+                logger.debug("buildinfohelper: Saving stored event %s "
                              % tempevent)
                 self.store_log_event(tempevent,cli_backlog)
             else:
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 5c775bd8a8..b282d09abf 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -609,7 +609,7 @@ def filter_environment(good_vars):
     os.environ["LC_ALL"] = "en_US.UTF-8"
 
     if removed_vars:
-        logger.debug(1, "Removed the following variables from the environment: %s", ", ".join(removed_vars.keys()))
+        logger.debug("Removed the following variables from the environment: %s", ", ".join(removed_vars.keys()))
 
     return removed_vars
 
@@ -1613,12 +1613,12 @@ def export_proxies(d):
 
 def load_plugins(logger, plugins, pluginpath):
     def load_plugin(name):
-        logger.debug(1, 'Loading plugin %s' % name)
+        logger.debug('Loading plugin %s' % name)
         spec = importlib.machinery.PathFinder.find_spec(name, path=[pluginpath] )
         if spec:
             return spec.loader.load_module()
 
-    logger.debug(1, 'Loading plugins from %s...' % pluginpath)
+    logger.debug('Loading plugins from %s...' % pluginpath)
 
     expanded = (glob.glob(os.path.join(pluginpath, '*' + ext))
                 for ext in python_extensions)
diff --git a/bitbake/lib/bblayers/layerindex.py b/bitbake/lib/bblayers/layerindex.py
index 95b67a6621..b2f27b21ee 100644
--- a/bitbake/lib/bblayers/layerindex.py
+++ b/bitbake/lib/bblayers/layerindex.py
@@ -79,7 +79,7 @@ class LayerIndexPlugin(ActionPlugin):
             branches = [args.branch]
         else:
             branches = (self.tinfoil.config_data.getVar('LAYERSERIES_CORENAMES') or 'master').split()
-        logger.debug(1, 'Trying branches: %s' % branches)
+        logger.debug('Trying branches: %s' % branches)
 
         ignore_layers = []
         if args.ignore:
diff --git a/bitbake/lib/layerindexlib/__init__.py b/bitbake/lib/layerindexlib/__init__.py
index 45157b6681..9ca127b9df 100644
--- a/bitbake/lib/layerindexlib/__init__.py
+++ b/bitbake/lib/layerindexlib/__init__.py
@@ -94,7 +94,7 @@ class LayerIndex():
            if not param:
                continue
            item = param.split('=', 1)
-           logger.debug(1, item)
+           logger.debug(item)
            param_dict[item[0]] = item[1]
 
         return param_dict
@@ -123,7 +123,7 @@ class LayerIndex():
         up = urlparse(url)
 
         if username:
-            logger.debug(1, "Configuring authentication for %s..." % url)
+            logger.debug("Configuring authentication for %s..." % url)
             password_mgr = urllib.request.HTTPPasswordMgrWithDefaultRealm()
             password_mgr.add_password(None, "%s://%s" % (up.scheme, up.netloc), username, password)
             handler = urllib.request.HTTPBasicAuthHandler(password_mgr)
@@ -133,20 +133,20 @@ class LayerIndex():
 
         urllib.request.install_opener(opener)
 
-        logger.debug(1, "Fetching %s (%s)..." % (url, ["without authentication", "with authentication"][bool(username)]))
+        logger.debug("Fetching %s (%s)..." % (url, ["without authentication", "with authentication"][bool(username)]))
 
         try:
             res = urlopen(Request(url, headers={'User-Agent': 'Mozilla/5.0 (bitbake/lib/layerindex)'}, unverifiable=True))
         except urllib.error.HTTPError as e:
-            logger.debug(1, "HTTP Error: %s: %s" % (e.code, e.reason))
-            logger.debug(1, " Requested: %s" % (url))
-            logger.debug(1, " Actual:    %s" % (e.geturl()))
+            logger.debug("HTTP Error: %s: %s" % (e.code, e.reason))
+            logger.debug(" Requested: %s" % (url))
+            logger.debug(" Actual:    %s" % (e.geturl()))
 
             if e.code == 404:
-                logger.debug(1, "Request not found.")
+                logger.debug("Request not found.")
                 raise LayerIndexFetchError(url, e)
             else:
-                logger.debug(1, "Headers:\n%s" % (e.headers))
+                logger.debug("Headers:\n%s" % (e.headers))
                 raise LayerIndexFetchError(url, e)
         except OSError as e:
             error = 0
@@ -170,7 +170,7 @@ class LayerIndex():
                 raise LayerIndexFetchError(url, "Unable to fetch OSError exception: %s" % e)
 
         finally:
-            logger.debug(1, "...fetching %s (%s), done." % (url, ["without authentication", "with authentication"][bool(username)]))
+            logger.debug("...fetching %s (%s), done." % (url, ["without authentication", "with authentication"][bool(username)]))
 
         return res
 
@@ -205,14 +205,14 @@ The format of the indexURI:
         if reload:
             self.indexes = []
 
-        logger.debug(1, 'Loading: %s' % indexURI)
+        logger.debug('Loading: %s' % indexURI)
 
         if not self.plugins:
             raise LayerIndexException("No LayerIndex Plugins available")
 
         for plugin in self.plugins:
             # Check if the plugin was initialized
-            logger.debug(1, 'Trying %s' % plugin.__class__)
+            logger.debug('Trying %s' % plugin.__class__)
             if not hasattr(plugin, 'type') or not plugin.type:
                 continue
             try:
@@ -220,11 +220,11 @@ The format of the indexURI:
                 indexEnt = plugin.load_index(indexURI, load)
                 break
             except LayerIndexPluginUrlError as e:
-                logger.debug(1, "%s doesn't support %s" % (plugin.type, e.url))
+                logger.debug("%s doesn't support %s" % (plugin.type, e.url))
             except NotImplementedError:
                 pass
         else:
-            logger.debug(1, "No plugins support %s" % indexURI)
+            logger.debug("No plugins support %s" % indexURI)
             raise LayerIndexException("No plugins support %s" % indexURI)
 
         # Mark CONFIG data as something we've added...
@@ -255,19 +255,19 @@ will write out the individual elements split by layer and related components.
 
         for plugin in self.plugins:
             # Check if the plugin was initialized
-            logger.debug(1, 'Trying %s' % plugin.__class__)
+            logger.debug('Trying %s' % plugin.__class__)
             if not hasattr(plugin, 'type') or not plugin.type:
                 continue
             try:
                 plugin.store_index(indexURI, index)
                 break
             except LayerIndexPluginUrlError as e:
-                logger.debug(1, "%s doesn't support %s" % (plugin.type, e.url))
+                logger.debug("%s doesn't support %s" % (plugin.type, e.url))
             except NotImplementedError:
-                logger.debug(1, "Store not implemented in %s" % plugin.type)
+                logger.debug("Store not implemented in %s" % plugin.type)
                 pass
         else:
-            logger.debug(1, "No plugins support %s" % indexURI)
+            logger.debug("No plugins support %s" % indexURI)
             raise LayerIndexException("No plugins support %s" % indexURI)
 
 
@@ -292,7 +292,7 @@ layerBranches set.  If not, they are effectively blank.'''
            the default configuration until the first vcs_url/branch match.'''
 
         for index in self.indexes:
-            logger.debug(1, ' searching %s' % index.config['DESCRIPTION'])
+            logger.debug(' searching %s' % index.config['DESCRIPTION'])
             layerBranch = index.find_vcs_url(vcs_url, [branch])
             if layerBranch:
                 return layerBranch
@@ -304,7 +304,7 @@ layerBranches set.  If not, they are effectively blank.'''
            If a branch has not been specified, we will iterate over the branches in
            the default configuration until the first collection/branch match.'''
 
-        logger.debug(1, 'find_collection: %s (%s) %s' % (collection, version, branch))
+        logger.debug('find_collection: %s (%s) %s' % (collection, version, branch))
 
         if branch:
             branches = [branch]
@@ -312,12 +312,12 @@ layerBranches set.  If not, they are effectively blank.'''
             branches = None
 
         for index in self.indexes:
-            logger.debug(1, ' searching %s' % index.config['DESCRIPTION'])
+            logger.debug(' searching %s' % index.config['DESCRIPTION'])
             layerBranch = index.find_collection(collection, version, branches)
             if layerBranch:
                 return layerBranch
         else:
-            logger.debug(1, 'Collection %s (%s) not found for branch (%s)' % (collection, version, branch))
+            logger.debug('Collection %s (%s) not found for branch (%s)' % (collection, version, branch))
         return None
 
     def find_layerbranch(self, name, branch=None):
@@ -408,7 +408,7 @@ layerBranches set.  If not, they are effectively blank.'''
                                               version=deplayerbranch.version
                                           )
                         if rdeplayerbranch != deplayerbranch:
-                                logger.debug(1, 'Replaced %s:%s:%s with %s:%s:%s' % \
+                                logger.debug('Replaced %s:%s:%s with %s:%s:%s' % \
                                       (deplayerbranch.index.config['DESCRIPTION'],
                                        deplayerbranch.branch.name,
                                        deplayerbranch.layer.name,
@@ -1121,7 +1121,7 @@ class LayerBranch(LayerIndexItemObj):
     @property
     def branch(self):
         try:
-            logger.debug(1, "Get branch object from branches[%s]" % (self.branch_id))
+            logger.debug("Get branch object from branches[%s]" % (self.branch_id))
             return self.index.branches[self.branch_id]
         except KeyError:
             raise AttributeError('Unable to find branches in index to map branch_id %s' % self.branch_id)
@@ -1149,7 +1149,7 @@ class LayerBranch(LayerIndexItemObj):
 
     @actual_branch.setter
     def actual_branch(self, value):
-        logger.debug(1, "Set actual_branch to %s .. name is %s" % (value, self.branch.name))
+        logger.debug("Set actual_branch to %s .. name is %s" % (value, self.branch.name))
         if value != self.branch.name:
             self._setattr('actual_branch', value, prop=False)
         else:
diff --git a/bitbake/lib/layerindexlib/cooker.py b/bitbake/lib/layerindexlib/cooker.py
index 21ec438a22..2de6e5faa0 100644
--- a/bitbake/lib/layerindexlib/cooker.py
+++ b/bitbake/lib/layerindexlib/cooker.py
@@ -173,7 +173,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
         else:
             branches = ['HEAD']
 
-        logger.debug(1, "Loading cooker data branches %s" % branches)
+        logger.debug("Loading cooker data branches %s" % branches)
 
         index = self._load_bblayers(branches=branches)
 
@@ -220,7 +220,7 @@ class CookerPlugin(layerindexlib.plugin.IndexPlugin):
                                         required=required, layerbranch=layerBranchId,
                                         dependency=depLayerBranch.layer_id)
 
-                        logger.debug(1, '%s requires %s' % (layerDependency.layer.name, layerDependency.dependency.name))
+                        logger.debug('%s requires %s' % (layerDependency.layer.name, layerDependency.dependency.name))
                         index.add_element("layerDependencies", [layerDependency])
 
                     return layerDependencyId
diff --git a/bitbake/lib/layerindexlib/restapi.py b/bitbake/lib/layerindexlib/restapi.py
index 7023f42f20..26a1c9674e 100644
--- a/bitbake/lib/layerindexlib/restapi.py
+++ b/bitbake/lib/layerindexlib/restapi.py
@@ -82,7 +82,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
 
 
         def load_cache(path, index, branches=[]):
-            logger.debug(1, 'Loading json file %s' % path)
+            logger.debug('Loading json file %s' % path)
             with open(path, 'rt', encoding='utf-8') as f:
                 pindex = json.load(f)
 
@@ -102,7 +102,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
             if newpBranch:
                 index.add_raw_element('branches', layerindexlib.Branch, newpBranch)
             else:
-                logger.debug(1, 'No matching branches (%s) in index file(s)' % branches)
+                logger.debug('No matching branches (%s) in index file(s)' % branches)
                 # No matching branches.. return nothing...
                 return
 
@@ -120,7 +120,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
             load_cache(up.path, index, branches)
             return index
 
-        logger.debug(1, 'Loading from dir %s...' % (up.path))
+        logger.debug('Loading from dir %s...' % (up.path))
         for (dirpath, _, filenames) in os.walk(up.path):
             for filename in filenames:
                 if not filename.endswith('.json'):
@@ -144,7 +144,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
         def _get_json_response(apiurl=None, username=None, password=None, retry=True):
             assert apiurl is not None
 
-            logger.debug(1, "fetching %s" % apiurl)
+            logger.debug("fetching %s" % apiurl)
 
             up = urlparse(apiurl)
 
@@ -163,9 +163,9 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
                 parsed = json.loads(res.read().decode('utf-8'))
             except ConnectionResetError:
                 if retry:
-                    logger.debug(1, "%s: Connection reset by peer.  Retrying..." % url)
+                    logger.debug("%s: Connection reset by peer.  Retrying..." % url)
                     parsed = _get_json_response(apiurl=up_stripped.geturl(), username=username, password=password, retry=False)
-                    logger.debug(1, "%s: retry successful.")
+                    logger.debug("%s: retry successful.")
                 else:
                     raise layerindexlib.LayerIndexFetchError('%s: Connection reset by peer.  Is there a firewall blocking your connection?' % apiurl)
 
@@ -207,25 +207,25 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
         if "*" not in branches:
             filter = "?filter=name:%s" % "OR".join(branches)
 
-        logger.debug(1, "Loading %s from %s" % (branches, index.apilinks['branches']))
+        logger.debug("Loading %s from %s" % (branches, index.apilinks['branches']))
 
         # The link won't include username/password, so pull it from the original url
         pindex['branches'] = _get_json_response(index.apilinks['branches'] + filter,
                                                     username=up.username, password=up.password)
         if not pindex['branches']:
-            logger.debug(1, "No valid branches (%s) found at url %s." % (branch, url))
+            logger.debug("No valid branches (%s) found at url %s." % (branch, url))
             return index
         index.add_raw_element("branches", layerindexlib.Branch, pindex['branches'])
 
         # Load all of the layerItems (these can not be easily filtered)
-        logger.debug(1, "Loading %s from %s" % ('layerItems', index.apilinks['layerItems']))
+        logger.debug("Loading %s from %s" % ('layerItems', index.apilinks['layerItems']))
 
 
         # The link won't include username/password, so pull it from the original url
         pindex['layerItems'] = _get_json_response(index.apilinks['layerItems'],
                                                   username=up.username, password=up.password)
         if not pindex['layerItems']:
-            logger.debug(1, "No layers were found at url %s." % (url))
+            logger.debug("No layers were found at url %s." % (url))
             return index
         index.add_raw_element("layerItems", layerindexlib.LayerItem, pindex['layerItems'])
 
@@ -235,13 +235,13 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
         for branch in index.branches:
             filter = "?filter=branch__name:%s" % index.branches[branch].name
 
-            logger.debug(1, "Loading %s from %s" % ('layerBranches', index.apilinks['layerBranches']))
+            logger.debug("Loading %s from %s" % ('layerBranches', index.apilinks['layerBranches']))
 
             # The link won't include username/password, so pull it from the original url
             pindex['layerBranches'] = _get_json_response(index.apilinks['layerBranches'] + filter,
                                                   username=up.username, password=up.password)
             if not pindex['layerBranches']:
-                logger.debug(1, "No valid layer branches (%s) found at url %s." % (branches or "*", url))
+                logger.debug("No valid layer branches (%s) found at url %s." % (branches or "*", url))
                 return index
             index.add_raw_element("layerBranches", layerindexlib.LayerBranch, pindex['layerBranches'])
 
@@ -256,7 +256,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
                                    ("distros", layerindexlib.Distro)]:
                 if lName not in load:
                     continue
-                logger.debug(1, "Loading %s from %s" % (lName, index.apilinks[lName]))
+                logger.debug("Loading %s from %s" % (lName, index.apilinks[lName]))
 
                 # The link won't include username/password, so pull it from the original url
                 pindex[lName] = _get_json_response(index.apilinks[lName] + filter,
@@ -283,7 +283,7 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
         if up.scheme != 'file':
             raise layerindexlib.plugin.LayerIndexPluginUrlError(self.type, url)
 
-        logger.debug(1, "Storing to %s..." % up.path)
+        logger.debug("Storing to %s..." % up.path)
 
         try:
             layerbranches = index.layerBranches
@@ -299,12 +299,12 @@ class RestApiPlugin(layerindexlib.plugin.IndexPlugin):
                     if getattr(index, objects)[obj].layerbranch_id == layerbranchid:
                        filtered.append(getattr(index, objects)[obj]._data)
                 except AttributeError:
-                    logger.debug(1, 'No obj.layerbranch_id: %s' % objects)
+                    logger.debug('No obj.layerbranch_id: %s' % objects)
                     # No simple filter method, just include it...
                     try:
                         filtered.append(getattr(index, objects)[obj]._data)
                     except AttributeError:
-                        logger.debug(1, 'No obj._data: %s %s' % (objects, type(obj)))
+                        logger.debug('No obj._data: %s %s' % (objects, type(obj)))
                         filtered.append(obj)
             return filtered
 
diff --git a/bitbake/lib/layerindexlib/tests/cooker.py b/bitbake/lib/layerindexlib/tests/cooker.py
index 1d0685e099..5ddf89aa21 100644
--- a/bitbake/lib/layerindexlib/tests/cooker.py
+++ b/bitbake/lib/layerindexlib/tests/cooker.py
@@ -72,7 +72,7 @@ class LayerIndexCookerTest(LayersTest):
 
     def test_find_collection(self):
         def _check(collection, expected):
-            self.logger.debug(1, "Looking for collection %s..." % collection)
+            self.logger.debug("Looking for collection %s..." % collection)
             result = self.layerindex.find_collection(collection)
             if expected:
                 self.assertIsNotNone(result, msg="Did not find %s when it shouldn't be there" % collection)
@@ -91,7 +91,7 @@ class LayerIndexCookerTest(LayersTest):
 
     def test_find_layerbranch(self):
         def _check(name, expected):
-            self.logger.debug(1, "Looking for layerbranch %s..." % name)
+            self.logger.debug("Looking for layerbranch %s..." % name)
             result = self.layerindex.find_layerbranch(name)
             if expected:
                 self.assertIsNotNone(result, msg="Did not find %s when it shouldn't be there" % collection)
diff --git a/bitbake/lib/layerindexlib/tests/restapi.py b/bitbake/lib/layerindexlib/tests/restapi.py
index 4646d01f9f..33b5c1c4c8 100644
--- a/bitbake/lib/layerindexlib/tests/restapi.py
+++ b/bitbake/lib/layerindexlib/tests/restapi.py
@@ -57,11 +57,11 @@ class LayerIndexWebRestApiTest(LayersTest):
                type in self.layerindex.indexes[0].config['local']:
                 continue
             for id in getattr(self.layerindex.indexes[0], type):
-                self.logger.debug(1, "type %s" % (type))
+                self.logger.debug("type %s" % (type))
 
                 self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number not in reloaded index")
 
-                self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id]))
+                self.logger.debug("%s ? %s" % (getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id]))
 
                 self.assertEqual(getattr(self.layerindex.indexes[0], type)[id], getattr(reload.indexes[0], type)[id], msg="Reloaded contents different")
 
@@ -80,11 +80,11 @@ class LayerIndexWebRestApiTest(LayersTest):
                type in self.layerindex.indexes[0].config['local']:
                 continue
             for id in getattr(self.layerindex.indexes[0] ,type):
-                self.logger.debug(1, "type %s" % (type))
+                self.logger.debug("type %s" % (type))
 
                 self.assertTrue(id in getattr(reload.indexes[0], type), msg="Id number missing from reloaded data")
 
-                self.logger.debug(1, "%s ? %s" % (getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id]))
+                self.logger.debug("%s ? %s" % (getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id]))
 
                 self.assertEqual(getattr(self.layerindex.indexes[0] ,type)[id], getattr(reload.indexes[0], type)[id], msg="reloaded data does not match original")
 
@@ -111,14 +111,14 @@ class LayerIndexWebRestApiTest(LayersTest):
                 if dep.layer.name == 'meta-python':
                     break
             else:
-                self.logger.debug(1, "meta-python was not found")
+                self.logger.debug("meta-python was not found")
                 raise self.failureException
 
             # Only check the first element...
             break
         else:
             # Empty list, this is bad.
-            self.logger.debug(1, "Empty list of dependencies")
+            self.logger.debug("Empty list of dependencies")
             self.assertIsNotNone(first, msg="Empty list of dependencies")
 
             # Last dep should be the requested item
@@ -128,7 +128,7 @@ class LayerIndexWebRestApiTest(LayersTest):
     @skipIfNoNetwork()
     def test_find_collection(self):
         def _check(collection, expected):
-            self.logger.debug(1, "Looking for collection %s..." % collection)
+            self.logger.debug("Looking for collection %s..." % collection)
             result = self.layerindex.find_collection(collection)
             if expected:
                 self.assertIsNotNone(result, msg="Did not find %s when it should be there" % collection)
@@ -148,11 +148,11 @@ class LayerIndexWebRestApiTest(LayersTest):
     @skipIfNoNetwork()
     def test_find_layerbranch(self):
         def _check(name, expected):
-            self.logger.debug(1, "Looking for layerbranch %s..." % name)
+            self.logger.debug("Looking for layerbranch %s..." % name)
 
             for index in self.layerindex.indexes:
                 for layerbranchid in index.layerBranches:
-                    self.logger.debug(1, "Present: %s" % index.layerBranches[layerbranchid].layer.name)
+                    self.logger.debug("Present: %s" % index.layerBranches[layerbranchid].layer.name)
             result = self.layerindex.find_layerbranch(name)
             if expected:
                 self.assertIsNotNone(result, msg="Did not find %s when it should be there" % collection)
-- 
2.30.0

