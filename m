Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0364871637
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:39:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0F9dlBp032391 for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:39:47 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BAmyEKbC_eck for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:39:47 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0F9dY30032387
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jan 2015 09:39:46 GMT
Message-ID: <1421314774.31262.44.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 15 Jan 2015 09:39:34 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Improve pyinotify performance
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
X-List-Received-Date: Thu, 15 Jan 2015 09:39:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Benchmarks show that the introduction of pyinotify regressed
performance. This patch ensures we only call the add_watch() function
for new entries, not ones we've already processed which does improve
performance as measured by "time bitbake -p".

This doesn't completely remove the overhead but it does substantially
reduce it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 594dbd5..61cc1b7 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -122,11 +122,13 @@ class BBCooker:
         self.configuration = configuration
 
         self.configwatcher = pyinotify.WatchManager()
+        self.configwatcher.bbseen = []
         self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
         self.watchmask = pyinotify.IN_CLOSE_WRITE | pyinotify.IN_CREATE | pyinotify.IN_DELETE | \
                          pyinotify.IN_DELETE_SELF | pyinotify.IN_MODIFY | pyinotify.IN_MOVE_SELF | \
                          pyinotify.IN_MOVED_FROM | pyinotify.IN_MOVED_TO 
         self.watcher = pyinotify.WatchManager()
+        self.watcher.bbseen = []
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
 
@@ -181,6 +183,9 @@ class BBCooker:
             watcher = self.watcher
         for i in deps:
             f = i[0]
+            if f in watcher.bbseen:
+                continue
+            watcher.bbseen.append(f)
             while True:
                 #bb.warn(f)
                 # We try and add watches for files that don't exist but if they did, would influence
@@ -192,6 +197,7 @@ class BBCooker:
                 except pyinotify.WatchManagerError as e:
                     if 'ENOENT' in str(e):
                         f = os.path.dirname(f)
+                        watcher.bbseen.append(f)
                         continue
                     raise
 



