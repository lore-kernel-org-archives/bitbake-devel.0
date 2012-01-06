Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5mY-0007SG-No
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:08:14 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 06 Jan 2012 01:00:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="93581647"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga001.jf.intel.com with ESMTP; 06 Jan 2012 01:00:52 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:32 +0800
Message-Id: <efb093371394fc61e1a639c8e93b245d64058d72.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
Subject: [PATCH 14/16] command.py: add a new API findCoreBaseFiles
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 06 Jan 2012 09:08:15 -0000

This new API is to find the available layers in server side.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |   11 +++++++++++
 lib/bb/cooker.py  |   12 ++++++++++++
 lib/bb/event.py   |    8 ++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index e52041d..141b51e 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -245,6 +245,17 @@ class CommandsAsync:
         command.finishAsyncCommand()
     generateTargetsTree.needcache = True
 
+    def findCoreBaseFiles(self, command, params):
+        """
+        Find certain files in COREBASE directory. i.e. Layers
+        """
+        subdir = params[0]
+        filename = params[1]
+
+        command.cooker.findCoreBaseFiles(subdir, filename)
+        command.finishAsyncCommand()
+    findCoreBaseFiles.needcache = False
+
     def findConfigFiles(self, command, params):
         """
         Find config files which provide appropriate values
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index bfd61a9..b02fdd7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -681,6 +681,18 @@ class BBCooker:
             if regex in unmatched:
                 collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
+    def findCoreBaseFiles(self, subdir, configfile):
+        corebase = self.configuration.data.getVar('COREBASE', True) or ""
+        paths = []
+        for root, dirs, files in os.walk(corebase + '/' + subdir):
+            for d in dirs:
+                configfilepath = os.path.join(root, d, configfile)
+                if os.path.exists(configfilepath):
+                    paths.append(os.path.join(root, d))
+
+        if paths:
+            bb.event.fire(bb.event.CoreBaseFilesFound(paths), self.configuration.data)
+
     def findConfigFilePath(self, configfile):
         """
         Find the location on disk of configfile and if it exists and was parsed by BitBake
diff --git a/lib/bb/event.py b/lib/bb/event.py
index d120ba5..ffd4213 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -439,6 +439,14 @@ class FilesMatchingFound(Event):
         self._pattern = pattern
         self._matches = matches
 
+class CoreBaseFilesFound(Event):
+    """
+    Event when a list of appropriate config files has been generated
+    """
+    def __init__(self, paths):
+        Event.__init__(self)
+        self._paths = paths
+
 class ConfigFilesFound(Event):
     """
     Event when a list of appropriate config files has been generated
-- 
1.7.0.4



