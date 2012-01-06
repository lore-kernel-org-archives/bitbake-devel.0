Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RjCFT-0001J3-Iz
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 17:02:32 +0100
Received: by opal (Postfix, from userid 111)
	id 8164F10336; Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120106160257.8164F10336@opal>
Date: Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : cooker: remove command import in cooker.py
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
X-List-Received-Date: Fri, 06 Jan 2012 16:02:34 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: c353316b2efcc7a893d6b4aa9a9647d51a6f69e3
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=c353316b2efcc7a893d6b4aa9a9647d51a6f69e3

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:28 2012 +0800

cooker: remove command import in cooker.py

There is no direct use of command in cooker.py, and it is using
bb.command instead. Remove command in the import list.

This fixes a problem of embedded import between command.py and
cooker.py.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/command.py |   11 +++++++++++
 lib/bb/cooker.py  |   12 ++++++++++++
 lib/bb/event.py   |    8 ++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 701b286..bd41f54 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -238,6 +238,17 @@ class CommandsAsync:
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
index 102d40f..2032718 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -641,6 +641,18 @@ class BBCooker:
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
index 088cd7c..8d7f941 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -402,6 +402,14 @@ class FilesMatchingFound(Event):
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



