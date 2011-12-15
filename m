Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rb5d1-0001FQ-88
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 08:21:19 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 14 Dec 2011 23:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85929839"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by azsmga001.ch.intel.com with ESMTP; 14 Dec 2011 23:14:22 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Dec 2011 15:14:56 +0800
Message-Id: <8e83df28de6dd4cb27667d37d89c94d9da26d2f8.1323933009.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
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
X-List-Received-Date: Thu, 15 Dec 2011 07:21:19 -0000

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



