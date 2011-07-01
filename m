Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtS-0007r2-H4
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:58 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321716"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:06 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:52 -0700
Message-Id: <64c39c65483cd6f78e2b6a04c46616ffc8bac09b.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 06/10] cooker|command|event: add new command findFilesMatchingInDir
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
X-List-Received-Date: Fri, 01 Jul 2011 06:07:58 -0000

This command can be used to search each BBPATH for files in the passed
directory which have a filename matching the supplied pattern.

This is implemented for use from the GUI (to determine the available
PACKAGE_CLASSES) but has been written so as to be generically useful and
reusable.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/command.py |   12 ++++++++++++
 lib/bb/cooker.py  |   23 +++++++++++++++++++++++
 lib/bb/event.py   |   10 ++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 2f37938..a902da2 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -251,6 +251,18 @@ class CommandsAsync:
         command.finishAsyncCommand()
     findConfigFiles.needcache = True
 
+    def findFilesMatchingInDir(self, command, params):
+        """
+        Find implementation files matching the specified pattern
+        in the requested subdirectory of a BBPATH
+        """
+        pattern = params[0]
+        directory = params[1]
+
+        command.cooker.findFilesMatchingInDir(pattern, directory)
+        command.finishAsyncCommand()
+    findFilesMatchingInDir.needcache = True
+
     def findConfigFilePath(self, command, params):
         """
         Find the path of the requested configuration file
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 48c9e24..f0c94fa 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -517,6 +517,29 @@ class BBCooker:
         path = self._findConfigFile(configfile)
         bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
 
+    def findFilesMatchingInDir(self, filepattern, directory):
+        """
+        Searches for files matching the regex 'pattern' which are children of
+        'directory' in each BBPATH. i.e. to find all rootfs package classes available
+        to BitBake one could call findFilesMatchingInDir(self, 'rootfs_', 'classes')
+        or to find all machine configuration files on could call
+        findFilesMatchingInDir(self, 'conf/machines', 'conf')
+        """
+        import re
+
+        matches = []
+        p = re.compile(re.escape(filepattern))
+        bbpaths = bb.data.getVar('BBPATH', self.configuration.data, True).split(':')
+        for path in bbpaths:
+            dirpath = os.path.join(path, directory)
+            if os.path.exists(dirpath):
+                for root, dirs, files in os.walk(dirpath):
+                    for f in files:
+                        if p.search(f):
+                            matches.append(f)
+
+        bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.configuration.data)
+
     def findConfigFiles(self, varname):
         """
         Find config files which are appropriate values for varname.
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 7c49d46..c7252dd 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -390,6 +390,16 @@ class TargetsTreeGenerated(Event):
         Event.__init__(self)
         self._model = model
 
+class FilesMatchingFound(Event):
+    """
+    Event when a list of files matching the supplied pattern has
+    been generated
+    """
+    def __init__(self, pattern, matches):
+        Event.__init__(self)
+        self._pattern = pattern
+        self._matches = matches
+
 class ConfigFilesFound(Event):
     """
     Event when a list of appropriate config files has been generated
-- 
1.7.5.4



