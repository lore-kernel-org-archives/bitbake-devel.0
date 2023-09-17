Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157EACD37B4
	for <webhook@archiver.kernel.org>; Sun, 17 Sep 2023 18:37:45 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.35299.1694975861890246034
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Sep 2023 11:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=U5f3WOR1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40475103519so34804715e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 17 Sep 2023 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694975860; x=1695580660; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fotzGO5bQkKJl5rJeczATqPS+k/qZaGUrjSJWsK5HvE=;
        b=U5f3WOR1vMCgP6jpx2Tqmg9/+VLBwccEsEW1WlzEeuksPhe6b+HhmOOPTB3jEdeqHY
         UzpCtn7TmdHhTWmjWI/ZQxJaNdD9Gjv/4mgKnB8PVpsLzHtlq/xgs/J0w42Xib1SdeTt
         oZ0VNee2+8WOcYR0bd6+Uj4rei3sl7KPl4Fmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694975860; x=1695580660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fotzGO5bQkKJl5rJeczATqPS+k/qZaGUrjSJWsK5HvE=;
        b=F8kEnpMgCtILc+gYpJzWntiqsWuCGNts464CkWm+ADuyTKfkY4BgFjGfQC/zmw8ipX
         Ox9Slr1MvZ/vPWibHr733REqx6UNpt4T7VB7Pu8+3R97fUeIjNyHwCgyv7P+rBfKALfl
         vtXf3zoGgagzivvVamsAfgGxLLFjQipI38S2NK/2t3sq318XomSIZSpmmUU0fgmKBkkf
         bXRefVgqinuXjkp78xOZZ0y12r7s/QLGMIpBaEmKwEEcE+rfivyuFLnIZ+0fk/0OKXvp
         Ys3Er8C0cy+ILwrLcVKNw9QZQZY7YRdoewMD+sPCo3hV6xZnFeIGNl+dUMeQxlQCnfQe
         JN/w==
X-Gm-Message-State: AOJu0YzOQf0n/Wb09fftYK3G3ghY/zZp19FILXaB/StWLdHuIHQBcbc5
	XM0eR/PMUbiI6UvOFSJ/wQt+vewNj9sgc+QvC88=
X-Google-Smtp-Source: AGHT+IEHJc1O1arVuyh224fT2IAli83sWhDkNZF0qqFimdF9CLu0pb0uqXGRU8KEZs381rDlZHgUDw==
X-Received: by 2002:a05:600c:21c1:b0:400:57d1:491b with SMTP id x1-20020a05600c21c100b0040057d1491bmr6430789wmj.2.1694975859812;
        Sun, 17 Sep 2023 11:37:39 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bff2:f038:1163:aa6c])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b00403038d7652sm10298697wml.39.2023.09.17.11.37.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 11:37:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] lib: Drop inotify support and replace with mtime checks
Date: Sun, 17 Sep 2023 19:37:38 +0100
Message-Id: <20230917183738.571435-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 17 Sep 2023 18:37:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15074

With the flush in serverlog() removed and a memory resident bitbake with a
60s timeout, the following could fail in strange ways:

rm bitbake-cookerdaemon.log
bitbake-layers add-layer ../meta-virtualization/
bitbake-layers add-layer ../meta-openembedded/meta-oe/
bitbake -m

specifically that it might error adding meta-oe with an error related to meta-virt.

This clearly shows that whilst bblayers.conf was modified, bitbake was not
recognising that. This would fit with the random autobuilder issues seen when
the serverlog flush() call was removed.

The issue appears to be that you have no way to "sync()" the inotify events with
the command stream coming over the socket. There is no way to know if there are
changes in the IO queue which bitbake needs to wait for before proceeding with
the next command.

I did experiment with os.sync() and fsync on the inotify fd, however nothing
addressed the issue. Since it is extremely important we have accurate cache data,
the only realistic thing to do is to switch to stat() calls and check mtime.

For bitbake commands, this is straightforward since we can revalidate the cache
upon new connections/commands. For tinfoil this is problematic and we need to
introduce and explict command "revalidateCaches" that the code can use to force
bitbake to re-check it's cache validity. I've exposed this through tinfoil with
a new "modified_files" function.

So, this patch:

a) drops inotify support within bitbake's cooker/server and switch to using mtime
b) requires a new function call in tinfoil when metadata has been modified

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        |   8 +-
 lib/bb/cooker.py         | 179 +++++++++------------------------------
 lib/bb/parse/__init__.py |   8 ++
 lib/bb/server/process.py |   6 --
 lib/bb/tinfoil.py        |   6 ++
 lib/bblayers/action.py   |   6 ++
 6 files changed, 65 insertions(+), 148 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index b494f84a0a..8663eed933 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -85,8 +85,6 @@ class Command:
                 if not hasattr(command_method, 'readonly') or not getattr(command_method, 'readonly'):
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
-                if command != "ping":
-                    self.cooker.process_inotify_updates_apply()
                 if getattr(command_method, 'needconfig', True):
                     self.cooker.updateCacheSync()
                 result = command_method(self, commandline)
@@ -110,7 +108,6 @@ class Command:
 
     def runAsyncCommand(self, _, process_server, halt):
         try:
-            self.cooker.process_inotify_updates_apply()
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
                 # updateCache will trigger a shutdown of the parser
                 # and then raise BBHandledException triggering an exit
@@ -310,6 +307,11 @@ class CommandsSync:
         return ret
     getLayerPriorities.readonly = True
 
+    def revalidateCaches(self, command, params):
+        """Called by UI clients when metadata may have changed"""
+        command.cooker.revalidateCaches()
+    parseConfiguration.needconfig = False
+
     def getRecipes(self, command, params):
         try:
             mc = params[0]
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 064e3cae6e..bd2cd8d83f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -22,7 +22,6 @@ from bb import utils, data, parse, event, cache, providers, taskdata, runqueue,
 import queue
 import signal
 import prserv.serv
-import pyinotify
 import json
 import pickle
 import codecs
@@ -175,15 +174,8 @@ class BBCooker:
         bb.debug(1, "BBCooker starting %s" % time.time())
         sys.stdout.flush()
 
-        self.configwatcher = None
-        self.confignotifier = None
-
-        self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
-                         pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
-                         pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
-
-        self.watcher = None
-        self.notifier = None
+        self.configwatched = {}
+        self.parsewatched = {}
 
         # If being called by something like tinfoil, we need to clean cached data
         # which may now be invalid
@@ -194,8 +186,6 @@ class BBCooker:
         self.hashserv = None
         self.hashservaddr = None
 
-        self.inotify_modified_files = []
-
         # TOSTOP must not be set or our children will hang when they output
         try:
             fd = sys.stdout.fileno()
@@ -221,8 +211,6 @@ class BBCooker:
         bb.debug(1, "BBCooker startup complete %s" % time.time())
         sys.stdout.flush()
 
-        self.inotify_threadlock = threading.Lock()
-
     def init_configdata(self):
         if not hasattr(self, "data"):
             self.initConfigurationData()
@@ -230,42 +218,6 @@ class BBCooker:
             sys.stdout.flush()
             self.handlePRServ()
 
-    def setupConfigWatcher(self):
-        with bb.utils.lock_timeout(self.inotify_threadlock):
-            if self.configwatcher:
-                self.configwatcher.close()
-                self.confignotifier = None
-                self.configwatcher = None
-            self.configwatcher = pyinotify.WatchManager()
-            self.configwatcher.bbseen = set()
-            self.configwatcher.bbwatchedfiles = set()
-            self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
-
-    def setupParserWatcher(self):
-        with bb.utils.lock_timeout(self.inotify_threadlock):
-            if self.watcher:
-                self.watcher.close()
-                self.notifier = None
-                self.watcher = None
-            self.watcher = pyinotify.WatchManager()
-            self.watcher.bbseen = set()
-            self.watcher.bbwatchedfiles = set()
-            self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
-
-    def process_inotify_updates(self):
-        with bb.utils.lock_timeout(self.inotify_threadlock):
-            for n in [self.confignotifier, self.notifier]:
-                if n and n.check_events(timeout=0):
-                    # read notified events and enqueue them
-                    n.read_events()
-
-    def process_inotify_updates_apply(self):
-        with bb.utils.lock_timeout(self.inotify_threadlock):
-            for n in [self.confignotifier, self.notifier]:
-                if n and n.check_events(timeout=0):
-                    n.read_events()
-                    n.process_events()
-
     def _baseconfig_set(self, value):
         if value and not self.baseconfig_valid:
             bb.server.process.serverlog("Base config valid")
@@ -280,88 +232,16 @@ class BBCooker:
             bb.server.process.serverlog("Parse cache invalidated")
         self.parsecache_valid = value
 
-    def config_notifications(self, event):
-        if event.maskname == "IN_Q_OVERFLOW":
-            bb.warn("inotify event queue overflowed, invalidating caches.")
-            self._parsecache_set(False)
-            self._baseconfig_set(False)
-            bb.parse.clear_cache()
-            return
-        if not event.pathname in self.configwatcher.bbwatchedfiles:
-            return
-        if "IN_ISDIR" in event.maskname:
-            if "IN_CREATE" in event.maskname or "IN_DELETE" in event.maskname:
-                if event.pathname in self.configwatcher.bbseen:
-                    self.configwatcher.bbseen.remove(event.pathname)
-                # Could remove all entries starting with the directory but for now...
-                bb.parse.clear_cache()
-        if not event.pathname in self.inotify_modified_files:
-            self.inotify_modified_files.append(event.pathname)
-        self._baseconfig_set(False)
-
-    def notifications(self, event):
-        if event.maskname == "IN_Q_OVERFLOW":
-            bb.warn("inotify event queue overflowed, invalidating caches.")
-            self._parsecache_set(False)
-            bb.parse.clear_cache()
-            return
-        if event.pathname.endswith("bitbake-cookerdaemon.log") \
-                or event.pathname.endswith("bitbake.lock"):
-            return
-        if "IN_ISDIR" in event.maskname:
-            if "IN_CREATE" in event.maskname or "IN_DELETE" in event.maskname:
-                if event.pathname in self.watcher.bbseen:
-                    self.watcher.bbseen.remove(event.pathname)
-                # Could remove all entries starting with the directory but for now...
-                bb.parse.clear_cache()
-        if not event.pathname in self.inotify_modified_files:
-            self.inotify_modified_files.append(event.pathname)
-        self._parsecache_set(False)
+    def add_filewatch(self, deps, configwatcher=False):
+        if configwatcher:
+            watcher = self.configwatched
+        else:
+            watcher = self.parsewatched
 
-    def add_filewatch(self, deps, watcher=None, dirs=False):
-        if not watcher:
-            watcher = self.watcher
         for i in deps:
-            watcher.bbwatchedfiles.add(i[0])
-            if dirs:
-                f = i[0]
-            else:
-                f = os.path.dirname(i[0])
-            if f in watcher.bbseen:
-                continue
-            watcher.bbseen.add(f)
-            watchtarget = None
-            while True:
-                # We try and add watches for files that don't exist but if they did, would influence
-                # the parser. The parent directory of these files may not exist, in which case we need
-                # to watch any parent that does exist for changes.
-                try:
-                    watcher.add_watch(f, self.watchmask, quiet=False)
-                    if watchtarget:
-                        watcher.bbwatchedfiles.add(watchtarget)
-                    break
-                except pyinotify.WatchManagerError as e:
-                    if 'ENOENT' in str(e):
-                        watchtarget = f
-                        f = os.path.dirname(f)
-                        if f in watcher.bbseen:
-                            break
-                        watcher.bbseen.add(f)
-                        continue
-                    if 'ENOSPC' in str(e):
-                        providerlog.error("No space left on device or exceeds fs.inotify.max_user_watches?")
-                        providerlog.error("To check max_user_watches: sysctl -n fs.inotify.max_user_watches.")
-                        providerlog.error("To modify max_user_watches: sysctl -n -w fs.inotify.max_user_watches=<value>.")
-                        providerlog.error("Root privilege is required to modify max_user_watches.")
-                    raise
-
-    def handle_inotify_updates(self):
-        # reload files for which we got notifications
-        for p in self.inotify_modified_files:
-            bb.parse.update_cache(p)
-            if p in bb.parse.BBHandler.cached_statements:
-                del bb.parse.BBHandler.cached_statements[p]
-        self.inotify_modified_files = []
+            f = i[0]
+            mtime = i[1]
+            watcher[f] = mtime
 
     def sigterm_exception(self, signum, stackframe):
         if signum == signal.SIGTERM:
@@ -392,8 +272,8 @@ class BBCooker:
             if mod not in self.orig_sysmodules:
                 del sys.modules[mod]
 
-        self.handle_inotify_updates()
-        self.setupConfigWatcher()
+        self.configwatched = {}
+        self.parsewatched = {}
 
         # Need to preserve BB_CONSOLELOG over resets
         consolelog = None
@@ -436,7 +316,7 @@ class BBCooker:
             self.disableDataTracking()
 
         for mc in self.databuilder.mcdata.values():
-            self.add_filewatch(mc.getVar("__base_depends", False), self.configwatcher)
+            self.add_filewatch(mc.getVar("__base_depends", False), configwatcher=True)
 
         self._baseconfig_set(True)
         self._parsecache_set(False)
@@ -486,6 +366,29 @@ class BBCooker:
         if hasattr(self, "data"):
             self.data.disableTracking()
 
+    def revalidateCaches(self):
+        bb.parse.clear_cache()
+
+        clean = True
+        for f in self.configwatched:
+            if not bb.parse.check_mtime(f, self.configwatched[f]):
+                bb.server.process.serverlog("Found %s changed, invalid cache" % f)
+                self._baseconfig_set(False)
+                self._parsecache_set(False)
+                clean = False
+                break
+
+        if clean:
+            for f in self.parsewatched:
+                if not bb.parse.check_mtime(f, self.parsewatched[f]):
+                    bb.server.process.serverlog("Found %s changed, invalid cache" % f)
+                    self._parsecache_set(False)
+                    clean = False
+                    break
+
+        if not clean:
+            bb.parse.BBHandler.cached_statements = {}
+
     def parseConfiguration(self):
         self.updateCacheSync()
 
@@ -566,6 +469,7 @@ class BBCooker:
         # Now update all the variables not in the datastore to match
         self.configuration.env = environment
 
+        self.revalidateCaches()
         if not clean:
             logger.debug("Base environment change, triggering reparse")
             self.reset()
@@ -1644,8 +1548,6 @@ class BBCooker:
         if self.state == state.running:
             return
 
-        self.handle_inotify_updates()
-
         if not self.baseconfig_valid:
             logger.debug("Reloading base configuration data")
             self.initConfigurationData()
@@ -1667,7 +1569,6 @@ class BBCooker:
 
         if self.state != state.parsing and not self.parsecache_valid:
             bb.server.process.serverlog("Parsing started")
-            self.setupParserWatcher()
 
             bb.parse.siggen.reset(self.data)
             self.parseConfiguration ()
@@ -1692,9 +1593,9 @@ class BBCooker:
                 total_masked += masked
                 searchdirs |= set(search)
 
-            # Add inotify watches for directories searched for bb/bbappend files
+            # Add mtimes for directories searched for bb/bbappend files
             for dirent in searchdirs:
-                self.add_filewatch([[dirent]], dirs=True)
+                self.add_filewatch([(dirent, bb.parse.cached_mtime_noerror(dirent))])
 
             self.parser = CookerParser(self, mcfilelist, total_masked)
             self._parsecache_set(True)
@@ -1881,7 +1782,7 @@ class CookerCollectFiles(object):
             collectlog.error("no recipe files to build, check your BBPATH and BBFILES?")
             bb.event.fire(CookerExit(), eventdata)
 
-        # We need to track where we look so that we can add inotify watches. There
+        # We need to track where we look so that we can know when the cache is invalid. There
         # is no nice way to do this, this is horrid. We intercept the os.listdir()
         # (or os.scandir() for python 3.6+) calls while we run glob().
         origlistdir = os.listdir
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 4cd82f115b..a4358f1374 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -60,6 +60,14 @@ def cached_mtime_noerror(f):
             return 0
     return __mtime_cache[f]
 
+def check_mtime(f, mtime):
+    try:
+        current_mtime = os.stat(f)[stat.ST_MTIME]
+        __mtime_cache[f] = current_mtime
+    except OSError:
+        current_mtime = 0
+    return current_mtime == mtime
+
 def update_mtime(f):
     try:
         __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 94e93bc3a6..5654f60f9e 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -411,12 +411,6 @@ class ProcessServer():
             nextsleep = 0.1
             fds = []
 
-            try:
-                self.cooker.process_inotify_updates()
-            except Exception as exc:
-                serverlog("Exception %s in inofify updates broke the idle_thread, exiting" % traceback.format_exc())
-                self.quit = True
-
             with bb.utils.lock_timeout(self._idlefuncsLock):
                 items = list(self._idlefuns.items())
 
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 91fbf1b13e..2200caa54c 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -449,6 +449,12 @@ class Tinfoil:
         self.run_actions(config_params)
         self.recipes_parsed = True
 
+    def modified_files(self):
+        """
+        Notify the server it needs to revalidate it's caches since the client has modified files
+        """
+        self.run_command("revalidateCaches")
+
     def run_command(self, command, *params, handle_events=True):
         """
         Run a command on the server (as implemented in bb.command).
diff --git a/lib/bblayers/action.py b/lib/bblayers/action.py
index 0d7fd6edd1..a8f2699335 100644
--- a/lib/bblayers/action.py
+++ b/lib/bblayers/action.py
@@ -50,12 +50,14 @@ class ActionPlugin(LayerPlugin):
 
         try:
             notadded, _ = bb.utils.edit_bblayers_conf(bblayers_conf, layerdirs, None)
+            self.tinfoil.modified_files()
             if not (args.force or notadded):
                 try:
                     self.tinfoil.run_command('parseConfiguration')
                 except (bb.tinfoil.TinfoilUIException, bb.BBHandledException):
                     # Restore the back up copy of bblayers.conf
                     shutil.copy2(backup, bblayers_conf)
+                    self.tinfoil.modified_files()
                     bb.fatal("Parse failure with the specified layer added, exiting.")
                 else:
                     for item in notadded:
@@ -81,6 +83,7 @@ class ActionPlugin(LayerPlugin):
                 layerdir = os.path.abspath(item)
             layerdirs.append(layerdir)
         (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdirs)
+        self.tinfoil.modified_files()
         if notremoved:
             for item in notremoved:
                 sys.stderr.write("No layers matching %s found in BBLAYERS\n" % item)
@@ -240,6 +243,9 @@ build results (as the layer priority order has effectively changed).
                             if not entry_found:
                                 logger.warning("File %s does not match the flattened layer's BBFILES setting, you may need to edit conf/layer.conf or move the file elsewhere" % f1full)
 
+        self.tinfoil.modified_files()
+
+
     def get_file_layer(self, filename):
         layerdir = self.get_file_layerdir(filename)
         if layerdir:
-- 
2.39.2


