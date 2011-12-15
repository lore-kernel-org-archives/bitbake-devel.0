Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rb5cy-0001FS-Ij
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 08:21:16 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 14 Dec 2011 23:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="87545426"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga002.jf.intel.com with ESMTP; 14 Dec 2011 23:14:17 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Dec 2011 15:14:52 +0800
Message-Id: <83005167bdc0b5b030428ce7e87021b2d86c7510.1323933009.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Thu, 15 Dec 2011 07:21:16 -0000

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



