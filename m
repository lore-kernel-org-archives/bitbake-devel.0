Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAjpo-0003Lc-V8
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 16:21:53 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 22 Mar 2012 08:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132004228"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2012 08:12:53 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 23:38:03 +0800
Message-Id: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1332430442.git.shane.wang@intel.com>
References: <cover.1332430442.git.shane.wang@intel.com>
Subject: [PATCH 1/8] command.py: Change parseConfigurationFiles API from async to sync
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
X-List-Received-Date: Thu, 22 Mar 2012 15:21:53 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

parseConfigurationFiles will not cost much time and move it to the
CommandSync class.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/command.py |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 1799f1c..febc90f 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
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
1.7.6



