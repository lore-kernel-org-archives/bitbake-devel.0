Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 70D5260670
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jan 2015 14:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0DEE7L8006603 for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jan 2015 14:14:07 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GS8MF3TAcF-w for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jan 2015 14:14:07 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0DEDr7B006594
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jan 2015 14:14:04 GMT
Message-ID: <1421158433.31262.20.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 13 Jan 2015 14:13:53 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker/cache/parse: Implement pyinofity based reconfigure
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
X-List-Received-Date: Tue, 13 Jan 2015 14:14:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Memory resident bitbake has one current flaw, changes in the base configuration
are not noticed by bitbake. The parsing cache is also refreshed on each invocation
of bitbake (although the mtime cache is not cleared so its pointless).

This change adds in pyinotify support and adds two different watchers, one
for the base configuration and one for the parsed recipes.

Changes in the latter will trigger a reparse (and an update of the mtime cache).
The former will trigger a complete reload of the configuration.

Note that this code will also correctly handle creation of new configuration files 
since the __depends and __base_depends variables already track these for cache 
correctness purposes.

We could be a little more clever about parsing cache invalidation, right now we just
invalidate the whole thing and recheck. For now, its better than what we have and doesn't
seem to perform that badly though.

For education and QA purposes I can document a workflow that illustrates this:

$ source oe-init-build-env-memres
$ time bitbake bash
[base configuration is loaded, recipes are parsed, bash builds]
$ time bitbake bash
[command returns quickly since all caches are valid]
$ touch ../meta/classes/gettext.bbclass
$ time bitbake bash
[reparse is triggered, time is longer than above]
$ echo 'FOO = "1"' >> conf/local.conf
$ time bitbake bash
[reparse is triggered, but with a base configuration reload too]

As far as changes go, I like this one a lot, it makes memory resident bitbake
truly usable and may be the tweak we need to make it the default.

The new pyinotify dependency is covered in the previous commit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 715da07..a1dde96 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -623,10 +623,13 @@ class Cache(object):
     def mtime(cachefile):
         return bb.parse.cached_mtime_noerror(cachefile)
 
-    def add_info(self, filename, info_array, cacheData, parsed=None):
+    def add_info(self, filename, info_array, cacheData, parsed=None, watcher=None):
         if isinstance(info_array[0], CoreRecipeInfo) and (not info_array[0].skipped):
             cacheData.add_from_recipeinfo(filename, info_array)
 
+            if watcher:
+                watcher(info_array[0].file_depends)
+
         if not self.has_cache:
             return
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 23e7abd..f14eb64 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -39,6 +39,7 @@ from bb import utils, data, parse, event, cache, providers, taskdata, runqueue
 import Queue
 import signal
 import prserv.serv
+import pyinotify
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
@@ -120,7 +121,18 @@ class BBCooker:
 
         self.configuration = configuration
 
+        self.configwatcher = pyinotify.WatchManager()
+        self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
+        self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
+                         pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
+                         pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO 
+        self.watcher = pyinotify.WatchManager()
+        self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
+
+
         self.initConfigurationData()
+        self.baseconfig_valid = True
+        self.parsecache_valid = False
 
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
@@ -156,6 +168,18 @@ class BBCooker:
         # Let SIGHUP exit as SIGTERM
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
+    def config_notifications(self, event):
+        bb.parse.update_cache(event.path)
+        self.baseconfig_valid = False
+
+    def notifications(self, event):
+        bb.parse.update_cache(event.path)
+        self.parsecache_valid = False
+
+    def add_filewatch(self, deps):
+        for i in deps:
+            self.watcher.add_watch(i[0], self.watchmask, rec=True)
+
     def sigterm_exception(self, signum, stackframe):
         if signum == signal.SIGTERM:
             bb.warn("Cooker recieved SIGTERM, shutting down...")
@@ -1361,6 +1385,18 @@ class BBCooker:
             raise bb.BBHandledException()
 
         if self.state != state.parsing:
+            for n in [self.confignotifier, self.notifier]:
+                if n.check_events(timeout=0):
+                    # read notified events and enqeue them
+                    n.read_events()
+                n.process_events()
+            if not self.baseconfig_valid:
+                logger.debug(1, "Reloading base configuration data")
+                self.initConfigurationData()
+                self.baseconfig_valid = True
+                self.parsecache_valid = False
+
+        if self.state != state.parsing and not self.parsecache_valid:
             self.parseConfiguration ()
             if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
                 bb.event.fire(bb.event.SanityCheck(False), self.data)
@@ -1375,9 +1411,13 @@ class BBCooker:
             (filelist, masked) = self.collection.collect_bbfiles(self.data, self.event_data)
 
             self.data.renameVar("__depends", "__base_depends")
+            for i in self.data.getVar("__base_depends"):
+                self.wdd = self.configwatcher.add_watch(i[0], self.watchmask, rec=True)
 
             self.parser = CookerParser(self, filelist, masked)
-            self.state = state.parsing
+            self.parsecache_valid = True
+
+        self.state = state.parsing
 
         if not self.parser.parse_next():
             collectlog.debug(1, "parsing complete")
@@ -1940,7 +1980,7 @@ class CookerParser(object):
                 self.skipped += 1
                 self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
             self.bb_cache.add_info(virtualfn, info_array, self.cooker.recipecache,
-                                        parsed=parsed)
+                                        parsed=parsed, watcher = self.cooker.add_filewatch)
         return True
 
     def reparse(self, filename):
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 2303f15..25effc2 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -73,6 +73,11 @@ def update_mtime(f):
     __mtime_cache[f] = os.stat(f)[stat.ST_MTIME]
     return __mtime_cache[f]
 
+def update_cache(f):
+    if f in __mtime_cache:
+        logger.debug(1, "Updating mtime cache for %s" % f)
+        update_mtime(f)
+
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])



