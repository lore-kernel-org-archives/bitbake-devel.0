Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 45CD477D1A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Aug 2017 22:48:57 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v79Mmuas031945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Wed, 9 Aug 2017 23:48:57 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dfZma-0007SH-0T; Wed, 09 Aug 2017 23:48:56 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Aug 2017 23:48:54 +0100
Message-Id: <1502318935-28608-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1502318935-28608-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1502318935-28608-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Wed, 09 Aug 2017 23:48:57 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 3/4] cooker: Improve inotify overflow handling
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
X-List-Received-Date: Wed, 09 Aug 2017 22:48:58 -0000

Add a proper function for clearing the mtime cache. Clean up the inotify
event overflow case to err on the side of caution and clear any potentially
now out of sync caches.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 5 ++++-
 lib/bb/parse/__init__.py | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 77b7f3d..b3d6cd9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -189,7 +189,7 @@ class BBCooker:
 
         # If being called by something like tinfoil, we need to clean cached data
         # which may now be invalid
-        bb.parse.__mtime_cache = {}
+        bb.parse.clear_cache()
         bb.parse.BBHandler.cached_statements = {}
 
         self.ui_cmdline = None
@@ -247,7 +247,9 @@ class BBCooker:
     def config_notifications(self, event):
         if event.maskname == "IN_Q_OVERFLOW":
             bb.warn("inotify event queue overflowed, invalidating caches.")
+            self.parsecache_valid = False
             self.baseconfig_valid = False
+            bb.parse.clear_cache()
             return
         if not event.pathname in self.configwatcher.bbwatchedfiles:
             return
@@ -259,6 +261,7 @@ class BBCooker:
         if event.maskname == "IN_Q_OVERFLOW":
             bb.warn("inotify event queue overflowed, invalidating caches.")
             self.parsecache_valid = False
+            bb.parse.clear_cache()
             return
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index a2952ec..2fc4002 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -84,6 +84,10 @@ def update_cache(f):
         logger.debug(1, "Updating mtime cache for %s" % f)
         update_mtime(f)
 
+def clear_cache():
+    global __mtime_cache
+    __mtime_cache = {}
+
 def mark_dependency(d, f):
     if f.startswith('./'):
         f = "%s/%s" % (os.getcwd(), f[2:])
-- 
2.7.4


