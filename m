Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvyz-0002ea-By
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:13 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 11 Dec 2011 18:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="84619663"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by azsmga001.ch.intel.com with ESMTP; 11 Dec 2011 18:43:13 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:24 +0800
Message-Id: <5e6bb33f07469e4ee3925104c8ee4e3036a3cee4.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323656120.git.dongxiao.xu@intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
Subject: [PATCH 05/10] command.py: add parseConfigurationFiles API
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:13 -0000

The parseConfigurationFiles API calls the related function in
cooker.py to parse config files.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 701b286..6b4a598 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -326,3 +326,13 @@ class CommandsAsync:
         else:
             command.finishAsyncCommand()
     compareRevisions.needcache = True
+
+    def parseConfigurationFiles(self, command, params):
+        """
+        Parse the configuration files
+        """
+        prefiles = params[0]
+        postfiles = params[1]
+        command.cooker.parseConfigurationFiles(prefiles, postfiles)
+        command.finishAsyncCommand()
+    parseConfigurationFiles.needcache = False
-- 
1.7.0.4



