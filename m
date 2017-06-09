Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 422AF7828A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 13:35:32 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	09 Jun 2017 06:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,317,1493708400"; d="scan'208";a="1180388569"
Received: from therfet-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.41.2])
	by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2017 06:35:31 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Jun 2017 15:34:45 +0200
Message-Id: <4d1eaac28ee66d743b231d291135f542d16ab72c.1497014984.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497014984.git.paul.eggleton@linux.intel.com>
References: <cover.1497014984.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/4] cooker: set config valid flags in initConfigurationData()
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
X-List-Received-Date: Fri, 09 Jun 2017 13:35:32 -0000

If we set these flags here then we can not only tidy up some of the code
that calls initConfigurationData() (and reset() which simply calls the
former), we also avoid calling initConfigurationData() an extra time
unnecessarily during startup (since setting baseconfig_valid = False in
updateConfigOpts() also resulted in initConfigurationData() being
called from updateCacheSync() at the end of the command.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 651b9c0..1283136 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -213,9 +213,6 @@ class BBCooker:
 
         self.configuration.server_register_idlecallback(_process_inotify_updates, [self.confignotifier, self.notifier])
 
-        self.baseconfig_valid = True
-        self.parsecache_valid = False
-
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
         if not self.lockBitbake():
@@ -375,6 +372,8 @@ class BBCooker:
         self.data.renameVar("__depends", "__base_depends")
         self.add_filewatch(self.data.getVar("__base_depends", False), self.configwatcher)
 
+        self.baseconfig_valid = True
+        self.parsecache_valid = False
 
     def enableDataTracking(self):
         self.configuration.tracking = True
@@ -568,7 +567,6 @@ class BBCooker:
                 clean = False
         if not clean:
             logger.debug(1, "Base environment change, triggering reparse")
-            self.baseconfig_valid = False        
             self.reset()
 
     def runCommands(self, server, data, abort):
@@ -1623,8 +1621,6 @@ class BBCooker:
         if not self.baseconfig_valid:
             logger.debug(1, "Reloading base configuration data")
             self.initConfigurationData()
-            self.baseconfig_valid = True
-            self.parsecache_valid = False
 
     # This is called for all async commands when self.state != running
     def updateCache(self):
-- 
2.9.4


