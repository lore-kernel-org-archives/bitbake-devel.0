Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 269C4724DC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 14:57:11 +0000 (UTC)
Received: by pdbnk13 with SMTP id nk13so25178394pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 07:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7Dy0voXkWq+7PpKPC3hxC+8b8ofBPLc/IHD2xMNviug=;
	b=FGs8C2CUhKmge9L18wC6XJ2jmm5BG9EXqWw86Udx19LjmkIYCw3vTtjfYoTMpnBsHT
	2g89ob8pquD5RsIpXbu2ZOMT3I19ys/tWCEcnTOJ5c9+1MVVjK4YLbJMj01lD1HMevrM
	d3ssiB0wgEjT8Vlox3If1692KQKNNProOp+yI/P5j2DraJblMEF/IXHM3kbr/eWlhJGv
	YxRwxIc33G0W8JYeWQEefL6geFYN/0BJon/0Op1bT8ffbchxOQIkjxTpsybmF5jZCSib
	whabbEGwl8VHIsD40cQbTWYDsIePksPyLH+W5q5RYYB2CxVz689sLVoatoWCCR9tqocS
	lp4Q==
X-Gm-Message-State: ALoCoQlheYeXi8f7WwgW9T9Ssa/H1PRIUhdGa006y7r4dQaNRIHSK3SJRc+zqpa3YjH8skzq3Ime
X-Received: by 10.68.131.225 with SMTP id op1mr3365941pbb.86.1428677832748;
	Fri, 10 Apr 2015 07:57:12 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id j1sm2528297pdj.94.2015.04.10.07.57.11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 07:57:12 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 835C6560FF7; Fri, 10 Apr 2015 15:57:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Apr 2015 15:57:02 +0100
Message-Id: <1428677827-12371-3-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: [dizzy 2/7] cooker/cache/parse: Implement pyinofity based reconfigure
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
X-List-Received-Date: Fri, 10 Apr 2015 14:57:12 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

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

(Bitbake rev: 0557d03c170fba8d7efe82be1b9641d0eb229213)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cache.py          |  5 ++++-
 lib/bb/cooker.py         | 44 ++++++++++++++++++++++++++++++++++++++++++--
 lib/bb/parse/__init__.py |  5 +++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 715da07..a1dde96 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
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
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8e6d91b..b5a5281 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
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
@@ -1292,6 +1316,18 @@ class BBCooker:
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
@@ -1306,9 +1342,13 @@ class BBCooker:
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
@@ -1870,7 +1910,7 @@ class CookerParser(object):
                 self.skipped += 1
                 self.cooker.skiplist[virtualfn] = SkippedPackage(info_array[0])
             self.bb_cache.add_info(virtualfn, info_array, self.cooker.recipecache,
-                                        parsed=parsed)
+                                        parsed=parsed, watcher = self.cooker.add_filewatch)
         return True
 
     def reparse(self, filename):
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 2303f15..25effc2 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
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
-- 
1.9.1


