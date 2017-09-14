Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A617078568
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Sep 2017 04:10:43 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	13 Sep 2017 21:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,390,1500966000"; d="scan'208";a="128563963"
Received: from babarret-mobl1.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.71.243])
	by orsmga004.jf.intel.com with ESMTP; 13 Sep 2017 21:10:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Sep 2017 16:09:41 +1200
Message-Id: <1b209b6f3a50fa0ce79f3f568401c80f1a0d41ce.1505361992.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1505361992.git.paul.eggleton@linux.intel.com>
References: <cover.1505361992.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] cooker: fix watching empty directories
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
X-List-Received-Date: Thu, 14 Sep 2017 04:10:43 -0000

The code that was supposed to watch directories along BBFILES for
creation of new files wasn't working in the case where the directory did
not initially contain any matching files - since in updateCache() we are
passing the directory path to add_filewatch() and the latter function
calls os.path.dirname() on the path on the assumption that it is a file
path, and thus the parent of the directory got watched but not the
directory itself. (If the directory wasn't empty everything worked fine
since add_filewatch() was called elsewhere with the path to one of the
files in that directory, and thus the directory got watched). Add a
parameter to add_filewatch() to tell it we are passing it directory
path(s) rather than file path(s).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 8fe36eb..6de04fc 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -266,12 +266,15 @@ class BBCooker:
             self.inotify_modified_files.append(event.pathname)
         self.parsecache_valid = False
 
-    def add_filewatch(self, deps, watcher=None):
+    def add_filewatch(self, deps, watcher=None, dirs=False):
         if not watcher:
             watcher = self.watcher
         for i in deps:
             watcher.bbwatchedfiles.append(i[0])
-            f = os.path.dirname(i[0])
+            if dirs:
+                f = i[0]
+            else:
+                f = os.path.dirname(i[0])
             if f in watcher.bbseen:
                 continue
             watcher.bbseen.append(f)
@@ -1512,7 +1515,7 @@ class BBCooker:
 
             # Add inotify watches for directories searched for bb/bbappend files
             for dirent in searchdirs:
-                self.add_filewatch([[dirent]])
+                self.add_filewatch([[dirent]], dirs=True)
 
             self.parser = CookerParser(self, filelist, masked)
             self.parsecache_valid = True
-- 
2.9.5


