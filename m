Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id BA13F7FC9A
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2020 22:09:02 +0000 (UTC)
IronPort-SDR: FSrXjNbStxMokd1M/p4FDUYzvXGxE+dfKqptNLetMKW72EM+dQ8Rl9CLFe7qDgbchKpymTBvPK
	K6s31RE+OLQ5JZ88u7UNKbM2hzMfXQbiRAWHfQNo6NLwDtfo5NTfDHH02JFB+qeNAALAXD4+Ya
	Ft9afaoFwFIn/dv7TGThEoDG5zHswnv5OnPSNWSdvb9EacQM5kiVq0YpoB1I3drHHNhusS3ddB
	y57q8dE9oNy/ctmNGBjCTCTwIgG22yI65AFS9DzGYBc78US+FBad31cXwCHvjKVp2y7yYjxTWt
	Y3s=
X-IronPort-AV: E=Sophos;i="5.69,407,1571695200"; 
   d="scan'208";a="4034936"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jan 2020 23:08:57 +0100
Message-Id: <20200107220858.18057-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: [master][zeus][warrior][PATCHv2 1/2] cooker: Keep track of watched files using a set instead of a list
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
X-List-Received-Date: Tue, 07 Jan 2020 22:09:03 -0000
Content-Transfer-Encoding: 8bit

When there are many watched files, keeping track of them using lists
is suboptimal. Using sets improves the performance considerably.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cooker.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e6442bff93..b74affa7ec 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -169,8 +169,8 @@ class BBCooker:
         bb.debug(1, "BBCooker pyinotify1 %s" % time.time())
         sys.stdout.flush()
 
-        self.configwatcher.bbseen = []
-        self.configwatcher.bbwatchedfiles = []
+        self.configwatcher.bbseen = set()
+        self.configwatcher.bbwatchedfiles = set()
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         bb.debug(1, "BBCooker pyinotify2 %s" % time.time())
         sys.stdout.flush()
@@ -180,8 +180,8 @@ class BBCooker:
         self.watcher = pyinotify.WatchManager()
         bb.debug(1, "BBCooker pyinotify3 %s" % time.time())
         sys.stdout.flush()
-        self.watcher.bbseen = []
-        self.watcher.bbwatchedfiles = []
+        self.watcher.bbseen = set()
+        self.watcher.bbwatchedfiles = set()
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
         bb.debug(1, "BBCooker pyinotify complete %s" % time.time())
@@ -278,14 +278,14 @@ class BBCooker:
         if not watcher:
             watcher = self.watcher
         for i in deps:
-            watcher.bbwatchedfiles.append(i[0])
+            watcher.bbwatchedfiles.add(i[0])
             if dirs:
                 f = i[0]
             else:
                 f = os.path.dirname(i[0])
             if f in watcher.bbseen:
                 continue
-            watcher.bbseen.append(f)
+            watcher.bbseen.add(f)
             watchtarget = None
             while True:
                 # We try and add watches for files that don't exist but if they did, would influence
@@ -294,7 +294,7 @@ class BBCooker:
                 try:
                     watcher.add_watch(f, self.watchmask, quiet=False)
                     if watchtarget:
-                        watcher.bbwatchedfiles.append(watchtarget)
+                        watcher.bbwatchedfiles.add(watchtarget)
                     break
                 except pyinotify.WatchManagerError as e:
                     if 'ENOENT' in str(e):
@@ -302,7 +302,7 @@ class BBCooker:
                         f = os.path.dirname(f)
                         if f in watcher.bbseen:
                             break
-                        watcher.bbseen.append(f)
+                        watcher.bbseen.add(f)
                         continue
                     if 'ENOSPC' in str(e):
                         providerlog.error("No space left on device or exceeds fs.inotify.max_user_watches?")
-- 
2.21.1


