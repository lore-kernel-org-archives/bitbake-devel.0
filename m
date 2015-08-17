Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DC7CB75F2A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564780"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:37 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:18 +0100
Message-Id: <04672714fa808eb292c4073ec22a43f76580f30b.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 03/13] cooker: further limit inotify watches
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:38 -0000

Unfortunately we were acting on inotify notifications about any files
changing within the watched directories, not just the ones we actually
care about. In OE the build directory is in BBPATH and hence it gets
watched, and we write things like bitbake.lock and
bitbake-cookerdaemon.log to that directory, hence effectively
notifications were being tripped on every bitbake invocation. To avoid
this, record which file/subdirectory we're interested in against each
watched directory so we can ignore any events for files/subdirectories
we don't care about.

Additionally, if we move up to the parent dir, ensure we haven't already
seen it before adding a watch on it (we were previously calling
watcher.add_watch() on the same directory multiple times before in a
typical OE configuration).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 84bf46b..f0f9c66 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -126,12 +126,14 @@ class BBCooker:
 
         self.configwatcher = pyinotify.WatchManager()
         self.configwatcher.bbseen = []
+        self.configwatcher.bbwatchedfiles = []
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
                          pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
                          pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO 
         self.watcher = pyinotify.WatchManager()
         self.watcher.bbseen = []
+        self.watcher.bbwatchedfiles = []
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
 
@@ -185,6 +187,8 @@ class BBCooker:
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
     def config_notifications(self, event):
+        if not event.pathname in self.configwatcher.bbwatchedfiles:
+            return
         if not event.path in self.inotify_modified_files:
             self.inotify_modified_files.append(event.path)
         self.baseconfig_valid = False
@@ -198,20 +202,27 @@ class BBCooker:
         if not watcher:
             watcher = self.watcher
         for i in deps:
+            watcher.bbwatchedfiles.append(i[0])
             f = os.path.dirname(i[0])
             if f in watcher.bbseen:
                 continue
             watcher.bbseen.append(f)
+            watchtarget = None
             while True:
                 # We try and add watches for files that don't exist but if they did, would influence
                 # the parser. The parent directory of these files may not exist, in which case we need 
                 # to watch any parent that does exist for changes.
                 try:
                     watcher.add_watch(f, self.watchmask, quiet=False)
+                    if watchtarget:
+                        watcher.bbwatchedfiles.append(watchtarget)
                     break
                 except pyinotify.WatchManagerError as e:
                     if 'ENOENT' in str(e):
+                        watchtarget = f
                         f = os.path.dirname(f)
+                        if f in watcher.bbseen:
+                            break
                         watcher.bbseen.append(f)
                         continue
                     if 'ENOSPC' in str(e):
-- 
2.1.0


