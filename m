Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QqpA6-0000i2-FI
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 18:28:14 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 09 Aug 2011 09:23:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,344,1309762800"; 
   d="scan'208";a="5483987"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.204])
	by AZSMGA002.ch.intel.com with ESMTP; 09 Aug 2011 09:23:43 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  9 Aug 2011 09:23:36 -0700
Message-Id: <0b3cb48f888272873d1b94c8bf745ca0b767d63e.1312906927.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312906927.git.josh@linux.intel.com>
References: <cover.1312906927.git.josh@linux.intel.com>
In-Reply-To: <cover.1312906927.git.josh@linux.intel.com>
References: <cover.1312906927.git.josh@linux.intel.com>
Subject: [PATCH 1/1] bb/cooker: only emit ConfigFilePathFound for files which were parsed
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
X-List-Received-Date: Tue, 09 Aug 2011 16:28:14 -0000

When the requested configuration file is found on disk check the
against the configuration files in __depends/__base_depends to ensure the
file was parsed before emitting the ConfigFilePathFound event.
If the requested file wasn't parsed just return (and don't emit).

Fixes [YOCTO #1246]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6022192..a8edfe7 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -609,9 +609,33 @@ class BBCooker:
                 collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
     def findConfigFilePath(self, configfile):
+        """
+        Find the location on disk of configfile and if it exists and was parsed by BitBake
+        emit the ConfigFilePathFound event with the path to the file.
+        """
         path = self._findConfigFile(configfile)
-        if path:
-            bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
+        if not path:
+            return
+
+        # Generate a list of parsed configuration files by searching the files
+        # listed in the __depends and __base_depends variables with a .conf suffix.
+        conffiles = []
+        dep_files = bb.data.getVar('__depends', self.configuration.data) or set()
+        dep_files.union(bb.data.getVar('__base_depends', self.configuration.data) or set())
+
+        for f in dep_files:
+            if f[0].endswith(".conf"):
+                conffiles.append(f[0])
+
+        _, conf, conffile = path.rpartition("conf/")
+        match = os.path.join(conf, conffile)
+        # Try and find matches for conf/conffilename.conf as we don't always
+        # have the full path to the file.
+        for cfg in conffiles:
+            if cfg.endswith(match):
+                bb.event.fire(bb.event.ConfigFilePathFound(path),
+                              self.configuration.data)
+                break
 
     def findFilesMatchingInDir(self, filepattern, directory):
         """
-- 
1.7.6



