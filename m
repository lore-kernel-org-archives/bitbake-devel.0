Return-Path: <cristiana.voicu@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 35A6D6077F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jun 2013 14:21:47 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 19 Jun 2013 07:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,896,1363158000"; d="scan'208";a="356092251"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2013 07:21:46 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jun 2013 17:23:28 +0300
Message-Id: <1371651808-11367-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: remove the function for reparse because it does nothing
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 19 Jun 2013 14:21:47 -0000

The command for reparse does nothing, so I have managed to remove it,
because it can be misleading. When a reparse is needed, it can be used
the parse function.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py |    8 --------
 bitbake/lib/bb/cooker.py  |    3 ---
 2 files changed, 11 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 9ddb96d..9f333ac 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -368,14 +368,6 @@ class CommandsAsync:
         command.finishAsyncCommand()
     parseFiles.needcache = True
 
-    def reparseFiles(self, command, params):
-        """
-        Reparse .bb files
-        """
-        command.cooker.reparseFiles()
-        command.finishAsyncCommand()
-    reparseFiles.needcache = True
-
     def compareRevisions(self, command, params):
         """
         Parse the .bb files
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index e1b33f1..c4c0dd8 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1199,9 +1199,6 @@ class BBCooker:
     def stop(self):
         self.state = state.stop
 
-    def reparseFiles(self):
-        return
-
     def initialize(self):
         self.state = state.initial
         self.initConfigurationData()
-- 
1.7.9.5


