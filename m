Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rj5mK-0007N1-0C
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 10:08:00 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 06 Jan 2012 01:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="109380835"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2012 01:00:35 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2012 17:02:19 +0800
Message-Id: <296c68cf445ecc82e4927f752c87777a58114720.1325840050.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1325840050.git.dongxiao.xu@intel.com>
References: <cover.1325840050.git.dongxiao.xu@intel.com>
Subject: [PATCH 01/16] command.py: Modify needcache value for certain functions
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
X-List-Received-Date: Fri, 06 Jan 2012 09:08:00 -0000

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



