Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id F2C1C6B5F4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Aug 2013 14:18:44 +0000 (UTC)
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 13 Aug 2013 07:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,869,1367996400"; d="scan'208";a="281373222"
Received: from timevans-mobl.ger.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.122.187])
	by AZSMGA002.ch.intel.com with ESMTP; 13 Aug 2013 07:18:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Aug 2013 15:18:39 +0100
Message-Id: <34fc374892f84f804bef65fa25614fad2da64c36.1376403450.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1376403450.git.paul.eggleton@linux.intel.com>
References: <cover.1376403450.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1376403450.git.paul.eggleton@linux.intel.com>
References: <cover.1376403450.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] taskdata: report close matches with NoProvider errors
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
X-List-Received-Date: Tue, 13 Aug 2013 14:18:45 -0000

Assuming there is no known reason why an item is not provided, show
close matches on the assumption that it might have been a typo or
other mistake.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/event.py                  |  3 ++-
 bitbake/lib/bb/taskdata.py               | 13 ++++++++++++-
 bitbake/lib/bb/ui/crumbs/runningbuild.py | 10 ++++++++--
 bitbake/lib/bb/ui/knotty.py              |  9 +++++++--
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 9c134ee..ba25d38 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -341,12 +341,13 @@ class DiskFull(Event):
 class NoProvider(Event):
     """No Provider for an Event"""
 
-    def __init__(self, item, runtime=False, dependees=None, reasons=[]):
+    def __init__(self, item, runtime=False, dependees=None, reasons=[], close_matches=[]):
         Event.__init__(self)
         self._item = item
         self._runtime = runtime
         self._dependees = dependees
         self._reasons = reasons
+        self._close_matches = close_matches
 
     def getItem(self):
         return self._item
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index c08186a..58fe199 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -390,6 +390,17 @@ class TaskData:
                     reasons.append("%s PROVIDES %s but was skipped: %s" % (skipitem.pn, item, skipitem.skipreason))
         return reasons
 
+    def get_close_matches(self, item, provider_list):
+        import difflib
+        if self.skiplist:
+            skipped = []
+            for fn in self.skiplist:
+                skipped.append(self.skiplist[fn].pn)
+            full_list = provider_list + skipped
+        else:
+            full_list = provider_list
+        return difflib.get_close_matches(item, full_list, cutoff=0.7)
+
     def add_provider(self, cfgData, dataCache, item):
         try:
             self.add_provider_internal(cfgData, dataCache, item)
@@ -411,7 +422,7 @@ class TaskData:
             return
 
         if not item in dataCache.providers:
-            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=self.get_reasons(item)), cfgData)
+            bb.event.fire(bb.event.NoProvider(item, dependees=self.get_dependees_str(item), reasons=self.get_reasons(item), close_matches=self.get_close_matches(item, dataCache.providers.keys())), cfgData)
             raise bb.providers.NoProvider(item)
 
         if self.have_build_target(item):
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 78fa141..abd3300 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -375,10 +375,16 @@ class RunningBuild (gobject.GObject):
                 r = "R"
             else:
                 r = ""
+
+            extra = ''
+            if not event._reasons:
+                if event._close_matches:
+                    extra = ". Close matches:\n  %s" % '\n  '.join(event._close_matches)
+
             if event._dependees:
-                msg = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)\n" % (r, event._item, ", ".join(event._dependees), r)
+                msg = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s\n" % (r, event._item, ", ".join(event._dependees), r, extra)
             else:
-                msg = "Nothing %sPROVIDES '%s'\n" % (r, event._item)
+                msg = "Nothing %sPROVIDES '%s'%s\n" % (r, event._item, extra)
             if event._reasons:
                 for reason in event._reasons:
                     msg += ("%s\n" % reason)
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 2c8293d..09ad99e 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -416,10 +416,15 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 else:
                     r = ""
 
+                extra = ''
+                if not event._reasons:
+                    if event._close_matches:
+                        extra = ". Close matches:\n  %s" % '\n  '.join(event._close_matches)
+
                 if event._dependees:
-                    logger.error("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)", r, event._item, ", ".join(event._dependees), r)
+                    logger.error("Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)%s", r, event._item, ", ".join(event._dependees), r, extra)
                 else:
-                    logger.error("Nothing %sPROVIDES '%s'", r, event._item)
+                    logger.error("Nothing %sPROVIDES '%s'%s", r, event._item, extra)
                 if event._reasons:
                     for reason in event._reasons:
                         logger.error("%s", reason)
-- 
1.8.1.2


