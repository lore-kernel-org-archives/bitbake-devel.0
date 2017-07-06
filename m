Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D4255778D8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jul 2017 15:48:10 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v66Fm9C1032628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 6 Jul 2017 16:48:10 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dT90j-0003PY-PH; Thu, 06 Jul 2017 16:48:09 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Jul 2017 16:48:05 +0100
Message-Id: <1499356087-13072-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 06 Jul 2017 16:48:10 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/3] bitbake: Add MultiConfigParsed event
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
X-List-Received-Date: Thu, 06 Jul 2017 15:48:11 -0000

There are some cases where the metadata needs to be aware a multiconfig build
is happening and have access to the multiconfig data stores to merge data into
the common build. This adds such an event allowing access to these datastores.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 ++
 lib/bb/event.py      | 6 ++++++
 lib/bb/ui/knotty.py  | 1 +
 3 files changed, 9 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 4d32aa0..644bb38 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -294,6 +294,8 @@ class CookerDataBuilder(object):
                 mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
                 self.mcdata[config] = mcdata
+            if multiconfig:
+                bb.event.fire(bb.event.MultiConfigParsed(self.mcdata), self.data)
 
         except (SyntaxError, bb.BBHandledException):
             raise bb.BBHandledException
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 6ccd4bdc..1462382 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -358,6 +358,12 @@ class OperationProgress(Event):
 class ConfigParsed(Event):
     """Configuration Parsing Complete"""
 
+class MultiConfigParsed(Event):
+    """Multi-Config Parsing Complete"""
+    def __init__(self, mcdata):
+        self.mcdata = mcdata
+        Event.__init__(self)
+
 class RecipeEvent(Event):
     def __init__(self, fn):
         self.fn = fn
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index a19c3b3..936d5a4 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -664,6 +664,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.event.MetadataEvent,
                                   bb.event.StampUpdate,
                                   bb.event.ConfigParsed,
+                                  bb.event.MultiConfigParsed,
                                   bb.event.RecipeParsed,
                                   bb.event.RecipePreFinalise,
                                   bb.runqueue.runQueueEvent,
-- 
2.7.4


