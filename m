Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvyu-0002e0-If
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:10 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 11 Dec 2011 18:43:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="95039249"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2011 18:43:07 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:20 +0800
Message-Id: <a58b9713d301a6cbca3372f031a015365a57f295.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
Subject: [PATCH 01/10] command.py: Modify needcache value for certain functions
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:10 -0000

for findConfigFiels() and findFilesMatchingInDir() functions, they
don't need to parse all the bb files, thus setting the needcache
value to be False.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 83907f6..5dec6a9 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -241,7 +241,7 @@ class CommandsAsync:
 
         command.cooker.findConfigFiles(varname)
         command.finishAsyncCommand()
-    findConfigFiles.needcache = True
+    findConfigFiles.needcache = False
 
     def findFilesMatchingInDir(self, command, params):
         """
@@ -253,7 +253,7 @@ class CommandsAsync:
 
         command.cooker.findFilesMatchingInDir(pattern, directory)
         command.finishAsyncCommand()
-    findFilesMatchingInDir.needcache = True
+    findFilesMatchingInDir.needcache = False
 
     def findConfigFilePath(self, command, params):
         """
-- 
1.7.0.4



