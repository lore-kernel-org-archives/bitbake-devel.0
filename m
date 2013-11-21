Return-Path: <sgw@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id BC9646DA27
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Nov 2013 17:50:42 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 21 Nov 2013 09:50:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,746,1378882800"; d="scan'208";a="431629542"
Received: from unknown (HELO swold-linux.bigsur.com) ([10.255.15.149])
	by fmsmga001.fm.intel.com with ESMTP; 21 Nov 2013 09:50:41 -0800
From: Saul Wold <sgw@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Nov 2013 09:50:41 -0800
Message-Id: <1385056241-19978-1-git-send-email-sgw@linux.intel.com>
X-Mailer: git-send-email 1.8.3.1
Subject: [PATCH] cooker: add support for using % as a wildcard in bbappend filename
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
X-List-Received-Date: Thu, 21 Nov 2013 17:50:43 -0000

There has been a continuing call for supporting wildcard in bbappend
filenames. The wildcard is actually allow matching of the name and
version up to the point of encountering the %.  This approach will
allow for matching of the major or major.minor.

Exampes:

busybox_1.21.1.bb
busybox_1.21.%.bbappend will match
busybox_1.2%.bbappend will also match

if we update to busybox_1.3.0.bb the above won't match, but a busybox_1.%.bb
will.

[YOCTO #5411]

Signed-off-by: Saul Wold <sgw@linux.intel.com>
---
 lib/bb/cooker.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 3295f6c..64f286e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -706,14 +706,9 @@ class BBCooker:
         logger.info("Task dependencies saved to 'task-depends.dot'")
 
     def show_appends_with_no_recipes( self ):
-        recipes = set(os.path.basename(f)
-                      for f in self.recipecache.pkg_fn.iterkeys())
-        recipes |= set(os.path.basename(f)
-                      for f in self.skiplist.iterkeys())
-        appended_recipes = self.collection.appendlist.iterkeys()
         appends_without_recipes = [self.collection.appendlist[recipe]
-                                   for recipe in appended_recipes
-                                   if recipe not in recipes]
+                                   for recipe in self.collection.appendlist
+                                   if recipe not in self.collection.appliedappendlist]
         if appends_without_recipes:
             appendlines = ('  %s' % append
                            for appends in appends_without_recipes
@@ -1371,6 +1366,7 @@ class CookerExit(bb.event.Event):
 class CookerCollectFiles(object):
     def __init__(self, priorities):
         self.appendlist = {}
+        self.appliedappendlist = []
         self.bbfile_config_priorities = priorities
 
     def calc_bbfile_priority( self, filename, matched = None ):
@@ -1487,10 +1483,14 @@ class CookerCollectFiles(object):
         """
         Returns a list of .bbappend files to apply to fn
         """
+        filelist = []
         f = os.path.basename(fn)
-        if f in self.appendlist:
-            return self.appendlist[f]
-        return []
+        for bbappend in self.appendlist:
+            if bbappend in f or ('%' in bbappend and bbappend.startswith(f[:bbappend.index('%')])):
+                self.appliedappendlist.append(bbappend)
+                for filename in self.appendlist[bbappend]:
+                    filelist.append(filename)
+        return filelist
 
     def collection_priorities(self, pkgfns):
 
-- 
1.8.3.1


