Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlw4o-0004Bm-RN
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:50:35 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 21:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="30529119"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 21:46:18 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 21:46:10 -0700
Message-Id: <5da7077c04723cb3672d07a142eaa9eea9fc4529.1311741742.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311741742.git.josh@linux.intel.com>
References: <cover.1311741742.git.josh@linux.intel.com>
In-Reply-To: <cover.1311741742.git.josh@linux.intel.com>
References: <cover.1311741742.git.josh@linux.intel.com>
Subject: [RFC PATCH 2/3] cooker|event: notify if pre/post file in ConfigFilePathFound event
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
X-List-Received-Date: Wed, 27 Jul 2011 04:50:35 -0000

When findConfigFilePath called the emitted ConfigFilePathFound event will
also include a boolean value indiciating whether the specified config file
was loaded using the prefile or postfile options to BitBake.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |    7 ++++++-
 lib/bb/event.py  |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 765c58d..f0c07b5 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -605,9 +605,14 @@ class BBCooker:
                 collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
     def findConfigFilePath(self, configfile):
+        additional = False
         path = self._findConfigFile(configfile)
         if path:
-            bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
+            for path in self.extraconf:
+                _, cf, _ = path.rpartition(configfile)
+                if cf:
+                    additional = True
+            bb.event.fire(bb.event.ConfigFilePathFound(path, additional), self.configuration.data)
 
     def findFilesMatchingInDir(self, filepattern, directory):
         """
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 93c04ba..01700dc 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -412,9 +412,10 @@ class ConfigFilePathFound(Event):
     """
     Event when a path for a config file has been found
     """
-    def __init__(self, path):
+    def __init__(self, path, extraconf):
         Event.__init__(self)
         self._path = path
+        self._extraconf = extraconf
 
 class MsgBase(Event):
     """Base class for messages"""
-- 
1.7.6



