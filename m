Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoK83-0002Ie-A5
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 20:55:47 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Aug 2011 11:51:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="37170045"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2011 11:51:22 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 11:51:16 -0700
Message-Id: <af80966392a90bcfb1787ff419ade95a048b3b82.1312310554.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312310554.git.josh@linux.intel.com>
References: <cover.1312310554.git.josh@linux.intel.com>
In-Reply-To: <cover.1312310554.git.josh@linux.intel.com>
References: <cover.1312310554.git.josh@linux.intel.com>
Subject: [PATCH 2/2] bb/cooker: only emit ConfigFilePathFound for files which were parsed
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
X-List-Received-Date: Tue, 02 Aug 2011 18:55:47 -0000

When the requested configuration file is found on disk check the
configuration object to ensure the file was parsed before emitting the
ConfigFilePathFound event. If it wasn't just return (and don't emit).

Fixes [YOCTO #1246]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 025dfe4..a3456c3 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -609,9 +609,25 @@ class BBCooker:
                 collectlog.warn("No bb files matched BBFILE_PATTERN_%s '%s'" % (collection, pattern))
 
     def findConfigFilePath(self, configfile):
+        """
+        Find the location on disk of configfile and if it exists and was parsed by BitBake
+        emit the ConfigFilePathFound event with the path to the file.
+        """
         path = self._findConfigFile(configfile)
-        if path:
+        if not path:
+            return
+
+        parsed_confs = bb.data.getVar('__BB_PARSED_CONF', self.configuration.data) or []
+        if path and path in parsed_confs:
             bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
+        elif path:
+            _, conf, conffile = path.rpartition("conf/")
+            match = os.path.join(conf, conffile)
+            # Try and find matches for conf/conffilename.conf
+            for cfg in parsed_confs:
+                if cfg.endswith(match):
+                    bb.event.fire(bb.event.ConfigFilePathFound(path), self.configuration.data)
+                    break
 
     def findFilesMatchingInDir(self, filepattern, directory):
         """
-- 
1.7.6



