Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 64E26732B1
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  7 Jun 2015 07:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5777SKN022006 for <bitbake-devel@lists.openembedded.org>;
	Sun, 7 Jun 2015 08:07:28 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hEYeJCCopeZH for <bitbake-devel@lists.openembedded.org>;
	Sun,  7 Jun 2015 08:07:28 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t5777DIf022002
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 7 Jun 2015 08:07:25 +0100
Message-ID: <1433660833.28975.50.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 07 Jun 2015 08:07:13 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] cooker/event: Add an event which lists all stamps reachable after parsing
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
X-List-Received-Date: Sun, 07 Jun 2015 07:07:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The metadata can potentially use such an event to clean up any
"unreachable" data, solving several problems we currently have
where obsolete data may continue to exist in the shared areas.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 577d808..d2b5ceb 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1477,6 +1477,11 @@ class BBCooker:
             self.handlePrefProviders()
             self.recipecache.bbfile_priority = self.collection.collection_priorities(self.recipecache.pkg_fn, self.data)
             self.state = state.running
+
+            # Send an event listing all stamps reachable after parsing
+            # which the metadata may use to clean up stale data
+            event = bb.event.ReachableStamps(self.recipecache.stamp)
+            bb.event.fire(event, self.expanded_data)
             return None
 
         return True
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index fec6a05..ba0de11 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -497,6 +497,16 @@ class TargetsTreeGenerated(Event):
         Event.__init__(self)
         self._model = model
 
+class ReachableStamps(Event):
+    """
+    An event listing all stamps reachable after parsing
+    which the metadata may use to clean up stale data
+    """
+
+    def __init__(self, stamps):
+        Event.__init__(self)
+        self.stamps = stamps
+
 class FilesMatchingFound(Event):
     """
     Event when a list of files matching the supplied pattern has



