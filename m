Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T3sBZ-0001jx-BO
	for bitbake-devel@lists.openembedded.org;
	Tue, 21 Aug 2012 19:24:13 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by fmsmga102.fm.intel.com with ESMTP; 21 Aug 2012 10:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.77,803,1336374000"; d="scan'208";a="136563927"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.105])
	by AZSMGA002.ch.intel.com with ESMTP; 21 Aug 2012 10:12:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Aug 2012 18:11:45 +0100
Message-Id: <9cb54922dbc7fa0ff62065f64c000eba0eace0cf.1345568965.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1345568965.git.paul.eggleton@linux.intel.com>
References: <cover.1345568965.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1345568965.git.paul.eggleton@linux.intel.com>
References: <cover.1345568965.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] bitbake/cooker: minor refactor of parseConfiguration()
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
X-List-Received-Date: Tue, 21 Aug 2012 17:24:13 -0000

All calls to parseConfiguration set self.status and call
self.handleCollections() afterwards, so just do this inside
parseConfiguration() itself.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/cooker.py |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 23fffc9..1737e54 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -219,6 +219,12 @@ class BBCooker:
             nice = int(nice) - curnice
             buildlog.verbose("Renice to %s " % os.nice(nice))
 
+        if self.status:
+            del self.status
+        self.status = bb.cache.CacheData(self.caches_array)
+
+        self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
+
     def parseCommandLine(self):
         # Parse any commandline into actions
         self.commandlineAction = {'action':None, 'msg':None}
@@ -298,8 +304,6 @@ class BBCooker:
             # Parse the configuration here. We need to do it explicitly here since
             # this showEnvironment() code path doesn't use the cache
             self.parseConfiguration()
-            self.status = bb.cache.CacheData(self.caches_array)
-            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
 
             fn, cls = bb.cache.Cache.virtualfn2realfn(buildfile)
             fn = self.matchFile(fn)
@@ -1035,8 +1039,6 @@ class BBCooker:
         # Parse the configuration here. We need to do it explicitly here since
         # buildFile() doesn't use the cache
         self.parseConfiguration()
-        self.status = bb.cache.CacheData(self.caches_array)
-        self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
 
         # If we are told to do the None task then query the default task
         if (task == None):
@@ -1186,18 +1188,12 @@ class BBCooker:
         if self.state != state.parsing:
             self.parseConfiguration ()
 
-            if self.status:
-                del self.status
-            self.status = bb.cache.CacheData(self.caches_array)
-
             ignore = self.configuration.data.getVar("ASSUME_PROVIDED", True) or ""
             self.status.ignored_dependencies = set(ignore.split())
 
             for dep in self.configuration.extra_assume_provided:
                 self.status.ignored_dependencies.add(dep)
 
-            self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", True) )
-
             (filelist, masked) = self.collect_bbfiles()
             self.configuration.data.renameVar("__depends", "__base_depends")
 
-- 
1.7.9.5



