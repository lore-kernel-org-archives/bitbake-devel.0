Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 50A5D71B45
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 16:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v06GlLnh030156; Fri, 6 Jan 2017 16:47:21 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cVN6qbKzhRVZ; Fri,  6 Jan 2017 16:47:21 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v06GlGAW030150
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Jan 2017 16:47:18 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cPXfg-0006Qg-R6; Fri, 06 Jan 2017 16:47:16 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2017 16:47:11 +0000
Message-Id: <1483721231-24672-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] event: Replace slightly elderly bbmake references!
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
X-List-Received-Date: Fri, 06 Jan 2017 16:47:24 -0000

bbmake hasn't existed for a while (a decade+) so we should
probably remove the references.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 5491914..e2ca33e 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -382,7 +382,7 @@ class StampUpdate(Event):
     targets = property(getTargets)
 
 class BuildBase(Event):
-    """Base class for bbmake run events"""
+    """Base class for bitbake build events"""
 
     def __init__(self, n, p, failures = 0):
         self._name = n
@@ -427,13 +427,13 @@ class BuildInit(BuildBase):
         BuildBase.__init__(self, name, p)
 
 class BuildStarted(BuildBase, OperationStarted):
-    """bbmake build run started"""
+    """Event when builds start"""
     def __init__(self, n, p, failures = 0):
         OperationStarted.__init__(self, "Building Started")
         BuildBase.__init__(self, n, p, failures)
 
 class BuildCompleted(BuildBase, OperationCompleted):
-    """bbmake build run completed"""
+    """Event when builds have completed"""
     def __init__(self, total, n, p, failures=0, interrupted=0):
         if not failures:
             OperationCompleted.__init__(self, total, "Building Succeeded")
-- 
2.7.4


