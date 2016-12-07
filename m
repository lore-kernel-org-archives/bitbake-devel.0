Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DA21A606D0
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Dec 2016 14:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7EXKZg019026; Wed, 7 Dec 2016 14:33:20 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3k9IAl1VRdqe; Wed,  7 Dec 2016 14:33:20 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7EXE6h019002
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Dec 2016 14:33:15 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cEdHW-0001ZY-BP; Wed, 07 Dec 2016 14:33:14 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Dec 2016 14:33:10 +0000
Message-Id: <1481121190-6006-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] cooker: Handle inofity queue overflows more gracefully
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
X-List-Received-Date: Wed, 07 Dec 2016 14:33:21 -0000

If many files change and the inotify queue overflows, rather than print
a traceback, invalidate the caches and warn the user.

[YOCTO #10676]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cooker.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1fe693c..9999e58 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -252,6 +252,10 @@ class BBCooker:
         signal.signal(signal.SIGHUP, self.sigterm_exception)
 
     def config_notifications(self, event):
+        if event.maskname == "IN_Q_OVERFLOW":
+            bb.warn("inotify event queue overflowed, invalidating caches.")
+            self.baseconfig_valid = False
+            return
         if not event.pathname in self.configwatcher.bbwatchedfiles:
             return
         if not event.pathname in self.inotify_modified_files:
@@ -259,6 +263,10 @@ class BBCooker:
         self.baseconfig_valid = False
 
     def notifications(self, event):
+        if event.maskname == "IN_Q_OVERFLOW":
+            bb.warn("inotify event queue overflowed, invalidating caches.")
+            self.parsecache_valid = False
+            return
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
         self.parsecache_valid = False
-- 
2.7.4


