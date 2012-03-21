Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFK-0003SX-3F
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:34 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 21 Mar 2012 05:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119980037"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 21 Mar 2012 05:57:36 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:10 +0800
Message-Id: <ca6a1dfc86c5e21e738c5b1d13b34753dd6963ae.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 06/17] command.py: Change parseConfigurationFiles API from async to sync
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:34 -0000

parseConfigurationFiles will not cost much time and move it to the
CommandSync class.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/command.py |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1799f1c..febc90f 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -186,6 +186,14 @@ class CommandsSync:
         event = params[0]
         bb.event.fire(eval(event), command.cooker.configuration.data)
 
+    def parseConfigurationFiles(self, command, params):
+        """
+        Parse the configuration files
+        """
+        prefiles = params[0]
+        postfiles = params[1]
+        command.cooker.parseConfigurationFiles(prefiles, postfiles)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
@@ -350,12 +358,3 @@ class CommandsAsync:
             command.finishAsyncCommand()
     compareRevisions.needcache = True
 
-    def parseConfigurationFiles(self, command, params):
-        """
-        Parse the configuration files
-        """
-        prefiles = params[0]
-        postfiles = params[1]
-        command.cooker.parseConfigurationFiles(prefiles, postfiles)
-        command.finishAsyncCommand()
-    parseConfigurationFiles.needcache = False
-- 
1.7.4.1



