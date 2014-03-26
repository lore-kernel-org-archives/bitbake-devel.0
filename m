Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 18E846F9D2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 15:08:15 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2QF8AD1023685 for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 15:08:11 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rAWb8dd6LRSP for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 15:08:10 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2QF85LZ023681
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Mar 2014 15:08:07 GMT
Message-ID: <1395846479.24890.99.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Mar 2014 15:07:59 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker/event: Overhaul sanity test mechanism
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
X-List-Received-Date: Wed, 26 Mar 2014 15:08:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Sanity tests are currently a pain as its hard to control when they run. This results
in issues where for example the bitbake -e output is not useful as the sanity tests
prevent it from executing. The sanity tests should run later than the base configuration.

This patch changes the sanity tests to always be event triggered with the option of
returning either events on the status, or raising errors. A new cooker feature is used
to change the behaviour depending on the controlling UI.

This does need a change to sanity.bbclass in the OE metadata but its worth the pain
for the increased flexibility and control this offers UIs and the improvement to the
user experience.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e4cff3a..e81d887 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -82,7 +82,7 @@ class SkippedPackage:
 
 
 class CookerFeatures(object):
-    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE, BASEDATASTORE_TRACKING] = range(3)
+    _feature_list = [HOB_EXTRA_CACHES, SEND_DEPENDS_TREE, BASEDATASTORE_TRACKING, SEND_SANITYEVENTS] = range(4)
 
     def __init__(self):
         self._features=set()
@@ -1268,6 +1268,8 @@ class BBCooker:
 
         if self.state != state.parsing:
             self.parseConfiguration ()
+            if CookerFeatures.SEND_SANITYEVENTS in self.featureset:
+                bb.event.fire(bb.event.SanityCheck(False), self.data)
 
             ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
             self.recipecache.ignored_dependencies = set(ignore.split())
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 10eae5f..e205043 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -601,8 +601,11 @@ class MetadataEvent(Event):
 
 class SanityCheck(Event):
     """
-    Event to issue sanity check
+    Event to runs sanity checks, either raise errors or generate events as return status.
     """
+    def __init__(self, generateevents = True):
+        Event.__init__(self)
+        self.generateevents = generateevents
 
 class SanityCheckPassed(Event):
     """
@@ -620,8 +623,11 @@ class SanityCheckFailed(Event):
 
 class NetworkTest(Event):
     """
-    Event to start network test
+    Event to run network connectivity tests, either raise errors or generate events as return status.
     """
+    def __init__(self, generateevents = True):
+        Event.__init__(self)
+        self.generateevents = generateevents
 
 class NetworkTestPassed(Event):
     """
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 55cf507..009653c 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -34,6 +34,8 @@ import copy
 import atexit
 from bb.ui import uihelper
 
+featureSet = [bb.cooker.CookerFeatures.SEND_SANITYEVENTS]
+
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 



