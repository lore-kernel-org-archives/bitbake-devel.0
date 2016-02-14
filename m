Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 655327318D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 09:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1E9BQPX012206 for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 09:11:26 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9myM7KpJerGa for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 09:11:26 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1E9BOD0012203
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 14 Feb 2016 09:11:25 GMT
Message-ID: <1455441084.16142.375.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 14 Feb 2016 09:11:24 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Improve cache handling
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
X-List-Received-Date: Sun, 14 Feb 2016 09:11:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



We're seeing issues where the self test, which uses tinfoil doesn't
notice the changed contents of include files. The issue is
cached_statements in the parser being reused when the files have changed.

Whilst looking at this, I realised there were some other issues:

* We need to also invalidate the mtime cache when cooker restarts
* We should pass full filenames to the file invalidation code
* We should process cached_statements as part of inotify invalidation

With these fixes, the caching is more reliable for memory resident
bitbake too. It does raise some questions about cache validation and
lifecycles and indicates bitbake does need more work in the area,
preferably with the removal of the globals. This at least highlights
and works around some of the current issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index da8cc62..9d10943 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -144,6 +144,10 @@ class BBCooker:
         self.watcher.bbwatchedfiles = []
         self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
+        # If being called by something like tinfoil, we need to clean cached data 
+        # which may now be invalid
+        bb.parse.__mtime_cache = {}
+        bb.parse.BBHandler.cached_statements = {}
 
         self.initConfigurationData()
 
@@ -197,13 +201,13 @@ class BBCooker:
     def config_notifications(self, event):
         if not event.pathname in self.configwatcher.bbwatchedfiles:
             return
-        if not event.path in self.inotify_modified_files:
-            self.inotify_modified_files.append(event.path)
+        if not event.pathname in self.inotify_modified_files:
+            self.inotify_modified_files.append(event.pathname)
         self.baseconfig_valid = False
 
     def notifications(self, event):
-        if not event.path in self.inotify_modified_files:
-            self.inotify_modified_files.append(event.path)
+        if not event.pathname in self.inotify_modified_files:
+            self.inotify_modified_files.append(event.pathname)
         self.parsecache_valid = False
 
     def add_filewatch(self, deps, watcher=None):
@@ -1506,6 +1510,8 @@ class BBCooker:
         # reload files for which we got notifications
         for p in self.inotify_modified_files:
             bb.parse.update_cache(p)
+            if p in bb.parse.BBHandler.cached_statements:
+                del bb.parse.BBHandler.cached_statements[p]
         self.inotify_modified_files = []
 
         if not self.baseconfig_valid:



