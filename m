Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 60AC378711
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Feb 2018 15:15:17 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w11FFFhY020326
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 1 Feb 2018 07:15:18 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 1 Feb 2018 07:15:13 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 1 Feb 2018 23:15:28 +0800
Message-ID: <83c30f41462e2f78738b61f7beaf32411949fd7a.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 7/8] bitbake: cooker: fix event notifications
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
X-List-Received-Date: Thu, 01 Feb 2018 15:15:17 -0000
Content-Type: text/plain

There are two kinds of events:
* directory
  We always need handle the event since we don't know what inside the
  directory, for example:
  $ bitbake --server-only -T -1
  $ bitbake -p
  $ mkdir ${TOPDIR}/classes
  $ cp /path/to/base.bbclass classes

  The "${TOPDIR}/classes" is a new directory, the event only reports that the
  directory is created, we don't know there is a base.bbclass unless the parser
  runs.

* file:
  Use bb.parse.supports() to check whether bitbake supports it or not.

And now the bbwatchedfiles is not needed anymore.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/cooker.py | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 3f113ae..ffda225 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -177,14 +177,12 @@ class BBCooker:
 
         self.configwatcher = pyinotify.WatchManager()
         self.configwatcher.bbseen = []
-        self.configwatcher.bbwatchedfiles = []
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
                          pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
                          pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO
         self.watcher = pyinotify.WatchManager()
         self.watcher.bbseen = []
-        self.watcher.bbwatchedfiles = []
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
         # If being called by something like tinfoil, we need to clean cached data
@@ -247,10 +245,15 @@ class BBCooker:
             self.baseconfig_valid = False
             bb.parse.clear_cache()
             return
-        if not event.pathname in self.configwatcher.bbwatchedfiles:
-            return
-        if not event.pathname in self.inotify_modified_files:
-            self.inotify_modified_files.append(event.pathname)
+
+        # Check whether it is a supported type when it is a file
+        if not event.dir:
+            if not bb.parse.supports(event.pathname, data):
+                return
+            if not event.pathname in self.inotify_modified_files:
+                self.inotify_modified_files.append(event.pathname)
+
+        bb.debug(1, "Get config inotify event: %s" % event)
         self.baseconfig_valid = False
 
     def notifications(self, event):
@@ -259,18 +262,21 @@ class BBCooker:
             self.parsecache_valid = False
             bb.parse.clear_cache()
             return
-        if event.pathname.endswith("bitbake-cookerdaemon.log") \
-                or event.pathname.endswith("bitbake.lock"):
-            return
-        if not event.pathname in self.inotify_modified_files:
-            self.inotify_modified_files.append(event.pathname)
+
+        # Check whether it is a supported type when it is a file
+        if not event.dir:
+            if not bb.parse.supports(event.pathname, data):
+                return
+            if not event.pathname in self.inotify_modified_files:
+                self.inotify_modified_files.append(event.pathname)
+
+        bb.debug(1, "Get inotify event: %s" % event)
         self.parsecache_valid = False
 
     def add_filewatch(self, deps, watcher=None, dirs=False):
         if not watcher:
             watcher = self.watcher
         for i in deps:
-            watcher.bbwatchedfiles.append(i[0])
             if dirs:
                 f = i[0]
             else:
@@ -278,19 +284,15 @@ class BBCooker:
             if f in watcher.bbseen:
                 continue
             watcher.bbseen.append(f)
-            watchtarget = None
             while True:
                 # We try and add watches for files that don't exist but if they did, would influence
                 # the parser. The parent directory of these files may not exist, in which case we need
                 # to watch any parent that does exist for changes.
                 try:
                     watcher.add_watch(f, self.watchmask, quiet=False)
-                    if watchtarget:
-                        watcher.bbwatchedfiles.append(watchtarget)
                     break
                 except pyinotify.WatchManagerError as e:
                     if 'ENOENT' in str(e):
-                        watchtarget = f
                         f = os.path.dirname(f)
                         if f in watcher.bbseen:
                             break
-- 
2.7.4


