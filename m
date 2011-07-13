Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qh21R-00024Z-1B
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Jul 2011 18:10:49 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 13 Jul 2011 09:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,526,1304319600"; d="scan'208";a="25434305"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.33])
	by orsmga002.jf.intel.com with ESMTP; 13 Jul 2011 09:06:48 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 13 Jul 2011 09:06:41 -0700
Message-Id: <85461785547744d0cdb9590532532ab6d53bd88a.1310573108.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1310573108.git.josh@linux.intel.com>
References: <cover.1310573108.git.josh@linux.intel.com>
In-Reply-To: <cover.1310573108.git.josh@linux.intel.com>
References: <cover.1310573108.git.josh@linux.intel.com>
Subject: [PATCH 1/1] cooker: only return *Found events if something was actually found
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
X-List-Received-Date: Wed, 13 Jul 2011 16:10:49 -0000

The cooker methods which fire FooBarFound style events should only fire the
event when an item was actually found, rather than each time the method
is called.

Fixes [YOCTO #1219]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7aa600f..23f2c76 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -546,14 +546,15 @@ class BBCooker:
 
     def findConfigFilePath(self, configfile):
         path = self._findConfigFile(configfile)
-        bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
+        if path:
+            bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
 
     def findFilesMatchingInDir(self, filepattern, directory):
         """
         Searches for files matching the regex 'pattern' which are children of
         'directory' in each BBPATH. i.e. to find all rootfs package classes available
         to BitBake one could call findFilesMatchingInDir(self, 'rootfs_', 'classes')
-        or to find all machine configuration files on could call
+        or to find all machine configuration files one could call:
         findFilesMatchingInDir(self, 'conf/machines', 'conf')
         """
         import re
@@ -569,7 +570,8 @@ class BBCooker:
                         if p.search(f):
                             matches.append(f)
 
-        bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.configuration.data)
+        if matches:
+            bb.event.fire(bb.event.FilesMatchingFound(filepattern, matches), self.configuration.data)
 
     def findConfigFiles(self, varname):
         """
@@ -592,7 +594,8 @@ class BBCooker:
                         if end == 'conf':
                             possible.append(val)
 
-        bb.event.fire(bb.event.ConfigFilesFound(var, possible), self.configuration.data)
+        if possible:
+            bb.event.fire(bb.event.ConfigFilesFound(var, possible), self.configuration.data)
 
     def findInheritsClass(self, klass):
         """
@@ -667,6 +670,7 @@ class BBCooker:
                 return confpath
 
             path, _ = os.path.split(path)
+        return None
 
     def _findLayerConf(self):
         return self._findConfigFile("bblayers.conf")
-- 
1.7.6



