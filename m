Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QcWtR-0007r3-TE
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jul 2011 08:07:58 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 30 Jun 2011 23:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,456,1304319600"; d="scan'208";a="21321711"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.228])
	by azsmga001.ch.intel.com with ESMTP; 30 Jun 2011 23:03:06 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2011 23:02:51 -0700
Message-Id: <be2102d7d766004b7413c7472d16bfd3ca827d4a.1309499228.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
In-Reply-To: <cover.1309499227.git.josh@linux.intel.com>
References: <cover.1309499227.git.josh@linux.intel.com>
Subject: [PATCH 05/10] command|cooker|event: add findConfigFilePath command
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

This takes the name of a .conf file and returns the full path to it

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/command.py |   10 ++++++++++
 lib/bb/cooker.py  |    4 ++++
 lib/bb/event.py   |    8 ++++++++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index d597d1d..2f37938 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -251,6 +251,16 @@ class CommandsAsync:
         command.finishAsyncCommand()
     findConfigFiles.needcache = True
 
+    def findConfigFilePath(self, command, params):
+        """
+        Find the path of the requested configuration file
+        """
+        configfile = params[0]
+
+        command.cooker.findConfigFilePath(configfile)
+        command.finishAsyncCommand()
+    findConfigFilePath.needcache = False
+
     def showVersions(self, command, params):
         """
         Show the currently selected versions
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 94acce6..48c9e24 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -513,6 +513,10 @@ class BBCooker:
             if regex in unmatched:
                 collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
+    def findConfigFilePath(self, configfile):
+        path = self._findConfigFile(configfile)
+        bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
+
     def findConfigFiles(self, varname):
         """
         Find config files which are appropriate values for varname.
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 7d47edb..7c49d46 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -399,6 +399,14 @@ class ConfigFilesFound(Event):
         self._variable = variable
         self._values = values
 
+class ConfigFilePathFound(Event):
+    """
+    Event when a path for a config file has been found
+    """
+    def __init__(self, path):
+        Event.__init__(self)
+        self._path = path
+
 class MsgBase(Event):
     """Base class for messages"""
 
-- 
1.7.5.4



